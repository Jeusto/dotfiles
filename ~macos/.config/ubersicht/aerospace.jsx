import { run, styled } from "uebersicht";

const refreshFrequency = 500;

// Use an absolute path: Uebersicht runs commands outside a login shell, so
// PATH doesn't include /opt/homebrew/bin the way your Terminal's does.
const aerospace = "/opt/homebrew/bin/aerospace";
const FIELDS =
  "%{monitor-id} %{workspace} %{workspace-is-focused} %{workspace-is-visible}";

const sortWorkspaces = (a, b) => {
  const aNum = /^\d+$/.test(a);
  const bNum = /^\d+$/.test(b);
  if (aNum && bNum) return Number(a) - Number(b);
  if (aNum) return -1;
  if (bNum) return 1;
  return a.localeCompare(b);
};

const command = async (dispatch) => {
  let rows;
  try {
    const [nonEmptyRaw, visibleRaw] = await Promise.all([
      run(
        `${aerospace} list-workspaces --monitor all --empty no --json --format "${FIELDS}"`,
      ),
      run(
        `${aerospace} list-workspaces --monitor all --visible --json --format "${FIELDS}"`,
      ),
    ]);
    const nonEmpty = JSON.parse(nonEmptyRaw);
    const visible = JSON.parse(visibleRaw);

    // Union by workspace name (a workspace only ever lives on one monitor at a time).
    // 'visible' is included so a workspace you just switched to still shows even
    // if it's currently empty.
    const byName = new Map();
    for (const w of [...nonEmpty, ...visible]) byName.set(w.workspace, w);
    rows = [...byName.values()];
  } catch {
    // AeroSpace.app isn't running, or its socket isn't up yet
    dispatch({ type: "WORKSPACES_DATA", data: { groups: [] } });
    return;
  }

  const byMonitor = new Map();
  for (const w of rows) {
    const id = w["monitor-id"];
    if (!byMonitor.has(id)) byMonitor.set(id, []);
    byMonitor.get(id).push(w);
  }

  const groups = [...byMonitor.entries()]
    .sort(([a], [b]) => a - b)
    .map(([monitorId, workspaces]) => ({
      monitorId,
      workspaces: workspaces.sort((a, b) =>
        sortWorkspaces(a.workspace, b.workspace),
      ),
    }));

  dispatch({ type: "WORKSPACES_DATA", data: { groups } });
};

const Container = styled("div")`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end;
  gap: 8px;
`;

const Capsule = styled("div")`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 4px;
  padding: 4px;
  border-radius: 5px;
  background: rgba(20, 20, 20, 0.45);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.25);
`;

const Workspace = styled("div")`
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 18px;
  height: 18px;
  padding: 0 5px;
  border-radius: 3px;
  font-size: 11px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.15s ease;

  background: ${(props) =>
    props.focused
      ? "linear-gradient(180deg, #ffffff, #dcdcdc)"
      : props.visible
        ? "rgba(255, 255, 255, 0.28)"
        : "transparent"};
  color: ${(props) => (props.focused ? "#000000cc" : "#ffffffb3")};

  &:hover {
    background: ${(props) =>
      props.focused ? "#ffffff" : "rgba(255, 255, 255, 0.4)"};
    color: #ffffffee;
    ${(props) => (props.focused ? "color: #000000cc;" : "")}
    transform: scale(1.12);
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
        <Capsule key={group.monitorId}>
          {group.workspaces.map((w) => (
            <Workspace
              key={w.workspace}
              focused={w["workspace-is-focused"]}
              visible={w["workspace-is-visible"]}
              onClick={() => switchToWorkspace(w.workspace)}
            >
              {w.workspace}
            </Workspace>
          ))}
        </Capsule>
      ))}
    </Container>
  );
};

const className = `
  bottom: 15px;
  right: 15px;
  font-family: -apple-system, sans-serif;
  user-select: none;
`;

export {
  refreshFrequency,
  command,
  initialState,
  updateState,
  className,
  render,
};
