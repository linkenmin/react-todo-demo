import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [input, setInput] = useState('');
  const [todos, setTodos] = useState([]);

  useEffect(() => {
    console.log('React Todo App loaded at', new Date().toISOString());
  }, []);

  const addTodo = () => {
    if (input.trim() === '') {
      console.log('[addTodo] skip empty input');
      return;
    }
    console.log('[addTodo]', input);
    setTodos([...todos, { text: input, completed: false }]);
    setInput('');
  };

  const toggleTodo = (index) => {
    const newTodos = [...todos];
    newTodos[index].completed = !newTodos[index].completed;
    console.log(
      '[toggleTodo]', newTodos[index].text,
      newTodos[index].completed ? 'completed' : 'not completed'
    );
    setTodos(newTodos);
  };

  const deleteTodo = (index) => {
    const newTodos = [...todos];
    console.log('[deleteTodo]', newTodos[index].text);
    newTodos.splice(index, 1);
    setTodos(newTodos);
  };

  return (
    <div className="App">
      <h1>Todo List</h1>
      <input
        data-testid="todo-input"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Add new task"
      />
      <button data-testid="add-button" onClick={addTodo}>
        Add
      </button>
      <ul data-testid="todo-list">
        {todos.map((todo, index) => (
          <li key={index}>
            <span
              data-testid={`todo-text-${index}`}
              className={todo.completed ? 'completed' : ''}
              onClick={() => toggleTodo(index)}
            >
              {todo.text}
            </span>
            <button
              data-testid={`delete-button-${index}`}
              onClick={() => deleteTodo(index)}
            >
              X
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
