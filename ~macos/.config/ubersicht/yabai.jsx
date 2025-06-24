import { run, styled } from "uebersicht";

const refreshFrequency = 500;

const command = async (dispatch) => {
  const spaces = await run("yabai -m query --spaces");
  const displays = await run("yabai -m query --displays");

  dispatch({
    type: "SPACES_DATA",
    data: {
      spaces: JSON.parse(spaces).slice(0, 5), // Limit to 5 spaces
      displays: JSON.parse(displays),
    },
  });
};

const Container = styled("div")`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 8px;
`;

const Space = styled("div")`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;

  background: ${(props) =>
    props.focused ? "rgba(255, 255, 255, 0.7)" : "rgba(255, 255, 255, 0.2)"};
  color: ${(props) => (props.focused ? "#000000cc" : "#ffffffcc")};
  border: ${(props) =>
    props.visible
      ? "1px solid rgba(255, 255, 255, 0.5)"
      : "1px solid transparent"};

  &:hover {
    background: ${(props) =>
      props.focused ? "rgba(255, 255, 255, 0.9)" : "rgba(255, 255, 255, 0.4)"};
    transform: scale(1.1);
  }
`;

const initialState = { spaces: [], displays: [] };

const updateState = (event, previousState) => {
  if (event.type === "SPACES_DATA") {
    return {
      ...previousState,
      ...event.data,
    };
  }
  return previousState;
};

const switchToSpace = async (spaceIndex) => {
  await run(`yabai -m space --focus ${spaceIndex}`);
};

const render = (data) => {
  if (!data.spaces || data.spaces.length === 0) {
    return <div></div>;
  }

  return (
    <Container>
      {data.spaces.map((space) => (
        <Space
          key={space.index}
          focused={space["has-focus"]}
          visible={space.visible}
          onClick={() => switchToSpace(space.index)}
        >
          {space.index}
        </Space>
      ))}
    </Container>
  );
};

const className = `
  bottom: 10px;
  right: 10px;
  margin-right: 4px;
    margin-bottom: 10px;
  font-family: -apple-system, sans-serif;
  user-select: none;
  text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5);
`;

// export {
//   refreshFrequency,
//   command,
//   initialState,
//   updateState,
//   className,
//   render,
// };
