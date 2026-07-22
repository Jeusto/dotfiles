import { run, styled, React } from "uebersicht";

export const refreshFrequency = 2000;

export const initialState = { task: "" };

// Lit uniquement la première ligne du fichier focus
export const command = async (dispatch) => {
  try {
    const output = await run(
      `touch ~/.ubersicht_focus.txt && head -n 1 ~/.ubersicht_focus.txt`,
    );
    dispatch({ type: "UPDATE_TASK", data: output.trim() });
  } catch (e) {
    console.error(e);
  }
};

export const updateState = (event, previousState) => {
  if (event.type === "UPDATE_TASK") {
    return { ...previousState, task: event.data };
  }
  return previousState;
};

// Garde la même position en bas à droite
export const className = `
  cursor: default;
  user-select: none;
  text-shadow: 0px 1px 4px #000000;
  font-family: -apple-system, sans-serif;
  bottom: 24px;
  right: 15px;
  color: #fff;
`;

const Container = styled("div")`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end; /* Aligne le contenu à droite */
  transition: opacity 0.3s ease;
`;

const Checkbox = styled("div")`
  width: 12px;
  height: 12px;
  border: 2px solid white;
  border-radius: 4px;
  margin-right: 7px;
  cursor: pointer;
  box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.5);
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  line-height: 1;

  background-color: ${(props) => (props.checked ? "white" : "transparent")};
  color: ${(props) => (props.checked ? "#000" : "transparent")};

  &:hover {
    background-color: ${(props) =>
      props.checked ? "white" : "rgba(255, 255, 255, 0.5)"};
  }
`;

const TaskText = styled("div")`
  font-size: 18px;
  cursor: text;
  transition: all 0.2s;
  text-decoration: ${(props) => (props.checked ? "line-through" : "none")};

  &:hover {
    opacity: ${(props) => (props.checked ? 1 : 0.7)};
  }
`;

const InvisibleInput = styled("input")`
  background: transparent;
  border: none;
  color: white;
  text-align: right;
  outline: none;
  font-size: 18px;
  padding: 0;
  margin: 0;
  text-shadow: 0px 1px 4px #000000;
  font-family: inherit;
  width: 350px;

  &::placeholder {
    color: rgba(255, 255, 255, 0.4);
  }
`;

const CountdownDisplay = styled("div")`
  font-size: 16px;
  font-variant-numeric: tabular-nums; /* Keeps numbers from shifting horizontally */
  letter-spacing: 0.5px;
  opacity: 0.9;
`;

// Helper for exact countdown math
const calculateTimeLeft = () => {
  const now = new Date();
  const target = new Date("2075-01-01T00:00:00");

  let years = target.getFullYear() - now.getFullYear();
  let months = target.getMonth() - now.getMonth();
  let days = target.getDate() - now.getDate();
  let hours = target.getHours() - now.getHours();
  let minutes = target.getMinutes() - now.getMinutes();
  let seconds = target.getSeconds() - now.getSeconds();

  if (seconds < 0) {
    seconds += 60;
    minutes--;
  }
  if (minutes < 0) {
    minutes += 60;
    hours--;
  }
  if (hours < 0) {
    hours += 24;
    days--;
  }
  if (days < 0) {
    const prevMonth = new Date(target.getFullYear(), target.getMonth(), 0);
    days += prevMonth.getDate();
    months--;
  }
  if (months < 0) {
    months += 12;
    years--;
  }

  return { years, months, days, hours, minutes, seconds };
};

const pad = (num) => num.toString().padStart(2, "0");

// Sous-composant React pour gérer l'état d'édition et l'animation de complétion
const FocusApp = ({ task, dispatch }) => {
  const [mode, setMode] = React.useState("todo"); // 'todo' ou 'countdown'
  const [timeLeft, setTimeLeft] = React.useState(calculateTimeLeft());

  const [isEditing, setIsEditing] = React.useState(false);
  const [localTask, setLocalTask] = React.useState(task);
  const [isCompleted, setIsCompleted] = React.useState(false);
  const inputRef = React.useRef(null);

  // Gère la mise à jour du chronomètre toutes les secondes
  React.useEffect(() => {
    if (mode === "countdown") {
      const timer = setInterval(() => {
        setTimeLeft(calculateTimeLeft());
      }, 1000);
      return () => clearInterval(timer);
    }
  }, [mode]);

  // Synchronise le state local si le fichier externe change
  React.useEffect(() => {
    if (!isEditing && !isCompleted) {
      setLocalTask(task);
    }
  }, [task, isEditing, isCompleted]);

  // Donne le focus à l'input automatiquement quand on passe en mode édition
  React.useEffect(() => {
    if (isEditing && inputRef.current) {
      inputRef.current.focus();
    }
  }, [isEditing]);

  const saveTask = async (val) => {
    const newTask = val.trim().replace(/"/g, '\\"');
    await run(`echo "${newTask}" > ~/.ubersicht_focus.txt`);
    command(dispatch);
    setIsEditing(false);
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter") {
      saveTask(e.target.value);
    } else if (e.key === "Escape") {
      setIsEditing(false);
      setLocalTask(task);
    }
  };

  const completeTask = () => {
    setIsCompleted(!isCompleted);
  };

  const handleRightClick = (e) => {
    e.preventDefault(); // Empêche le menu natif du Mac d'apparaître
    setMode(mode === "todo" ? "countdown" : "todo");
  };

  return (
    <Container
      style={{ opacity: isCompleted && mode === "todo" ? 0.4 : 1 }}
      onContextMenu={handleRightClick}
    >
      {mode === "countdown" ? (
        <CountdownDisplay title="Right-click to return to tasks">
          😊️✨ Memento Mori : {timeLeft.years}y {timeLeft.months}m{" "}
          {timeLeft.days}d {timeLeft.hours}h {timeLeft.minutes}m{" "}
        </CountdownDisplay>
      ) : isEditing ? (
        <InvisibleInput
          ref={inputRef}
          type="text"
          value={localTask}
          onChange={(e) => setLocalTask(e.target.value)}
          onKeyDown={handleKeyDown}
          onBlur={(e) => saveTask(e.target.value)}
          placeholder="Set current focus..."
        />
      ) : task ? (
        <>
          <Checkbox
            checked={isCompleted}
            onClick={completeTask}
            title="Complete task"
          >
            ✓
          </Checkbox>
          <TaskText
            checked={isCompleted}
            onClick={() => !isCompleted && setIsEditing(true)}
            title="Edit task (Right-click for countdown)"
          >
            {task}
          </TaskText>
        </>
      ) : (
        <TaskText
          onClick={() => setIsEditing(true)}
          style={{ opacity: 0.5 }}
          title="Right-click for countdown"
        >
          Set current focus...
        </TaskText>
      )}
    </Container>
  );
};

export const render = ({ task }, dispatch) => {
  return <FocusApp task={task} dispatch={dispatch} />;
};
