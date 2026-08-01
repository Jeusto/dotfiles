import { run, styled } from "uebersicht";

const refreshFrequency = 500;

// Use an absolute path: Uebersicht runs commands outside a login shell, so
// PATH doesn't include /opt/homebrew/bin the way your Terminal's does.
const aerospace = "/opt/homebrew/bin/aerospace";
const AEROSPACE_TOML = "$HOME/.config/aerospace/aerospace.toml";
const FIELDS =
  "%{monitor-id} %{monitor-is-main} %{workspace} %{workspace-is-focused} %{workspace-is-visible}";

// Fallback ordering for any workspace not declared in persistent-workspaces
// (e.g. one AeroSpace auto-created for an extra monitor)
const fallbackSort = (a, b) => {
  const aNum = /^\d+$/.test(a);
  const bNum = /^\d+$/.test(b);
  if (aNum && bNum) return Number(a) - Number(b);
  if (aNum) return -1;
  if (bNum) return 1;
  return a.localeCompare(b);
};

const makeSortWorkspaces = (order) => (a, b) => {
  const ia = order.indexOf(a);
  const ib = order.indexOf(b);
  if (ia !== -1 && ib !== -1) return ia - ib;
  if (ia !== -1) return -1;
  if (ib !== -1) return 1;
  return fallbackSort(a, b);
};

const command = async (dispatch) => {
  let rows, occupied, sortWorkspaces;
  try {
    // No --empty filter here: list every available (persistent) workspace,
    // not just ones currently holding a window.
    const [allRaw, occupiedRaw, configLine] = await Promise.all([
      run(
        `${aerospace} list-workspaces --monitor all --json --format "${FIELDS}"`,
      ),
      run(
        `${aerospace} list-workspaces --monitor all --empty no --json --format "%{workspace}"`,
      ),
      run(`grep -m1 '^persistent-workspaces' "${AEROSPACE_TOML}"`),
    ]);
    rows = JSON.parse(allRaw);
    occupied = new Set(JSON.parse(occupiedRaw).map((w) => w.workspace));

    // Pull the declared order straight out of the config so the widget always
    // matches what you actually wrote there (e.g. "Q", "W", "E", "R", not
    // alphabetical "E", "Q", "R", "W")
    const configOrder = [...configLine.matchAll(/"([^"]+)"/g)].map((m) => m[1]);
    sortWorkspaces = makeSortWorkspaces(configOrder);
  } catch {
    // AeroSpace.app isn't running, or its socket isn't up yet
    dispatch({ type: "WORKSPACES_DATA", data: { groups: [] } });
    return;
  }

  const byMonitor = new Map();
  for (const w of rows) {
    const id = w["monitor-id"];
    if (!byMonitor.has(id))
      byMonitor.set(id, { isMain: w["monitor-is-main"], workspaces: [] });
    byMonitor.get(id).workspaces.push(w);
  }

  const groups = [...byMonitor.entries()]
    // Main monitor's row first, then by monitor id
    .sort(
      ([idA, a], [idB, b]) =>
        (b.isMain ? 1 : 0) - (a.isMain ? 1 : 0) || idA - idB,
    )
    .map(([monitorId, { isMain, workspaces }]) => ({
      monitorId,
      isMain,
      workspaces: workspaces
        .sort((a, b) => sortWorkspaces(a.workspace, b.workspace))
        .map((w) => ({ ...w, occupied: occupied.has(w.workspace) })),
    }));

  dispatch({ type: "WORKSPACES_DATA", data: { groups } });
};

const Container = styled("div")`
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 5px;
`;

const Row = styled("div")`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end;
  gap: 5px;
`;

const MonitorLabel = styled("div")`
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.4);
  margin-right: 2px;
  min-width: 24px;
  text-align: right;
`;

const Workspace = styled("div")`
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 20px;
  padding: 0 5px;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 600;
  font-variant-numeric: tabular-nums;
  cursor: pointer;
  box-sizing: border-box;
  transition:
    background 0.15s ease,
    transform 0.15s ease,
    opacity 0.15s ease,
    box-shadow 0.15s ease;
  opacity: ${(props) => (props.occupied || props.focused ? 1 : 0.45)};

  background: ${(props) =>
    props.focused
      ? "#ffffff"
      : props.visible
        ? "rgba(255, 255, 255, 0.22)"
        : "rgba(255, 255, 255, 0.08)"};
  color: ${(props) => (props.focused ? "#111" : "#fff")};
  box-shadow: ${(props) =>
    props.focused
      ? "0 1px 4px rgba(0, 0, 0, 0.35)"
      : props.visible
        ? "inset 0 0 0 1px rgba(255, 255, 255, 0.45)"
        : "none"};

  &:hover {
    background: ${(props) =>
      props.focused ? "#ffffff" : "rgba(255, 255, 255, 0.4)"};
    opacity: 1;
    transform: translateY(-1px);
  }
`;

const initialState = { groups: [] };

const updateState = (event, previousState) => {
  if (event.type === "WORKSPACES_DATA") {
    return { ...previousState, ...event.data };
  }
  return previousState;
};

const switchToWorkspace = async (name) => {
  await run(`${aerospace} workspace "${name}"`);
};

const render = (data) => {
  if (!data.groups || data.groups.length === 0) {
    return <div></div>;
  }

  return (
    <Container>
      {data.groups.map((group) => (
        <Row key={group.monitorId}>
          {/* <MonitorLabel>{group.isMain ? "Main" : "Sec."}</MonitorLabel> */}
          {group.workspaces.map((w) => (
            <Workspace
              key={w.workspace}
              focused={w["workspace-is-focused"]}
              visible={w["workspace-is-visible"]}
              occupied={w.occupied}
              onClick={() => switchToWorkspace(w.workspace)}
              title={w.occupied ? "has windows" : "empty"}
            >
              {w.workspace}
            </Workspace>
          ))}
        </Row>
      ))}
    </Container>
  );
};

const className = `
  bottom: 15px;
  right: 15px;
  font-family: -apple-system, sans-serif;
  user-select: none;
  text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.4);
`;

export {
  refreshFrequency,
  command,
  initialState,
  updateState,
  className,
  render,
};
