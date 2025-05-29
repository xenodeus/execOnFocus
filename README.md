## execOnFocus

This small addon filters commands to ensure they are only executed when the game window is in focus.

It was designed for setups that involve certain input devices—ones whose inputs are detected by **all** running instances of the game, not just the focused one. Without filtering, a single input could trigger commands in multiple instances.

With this addon, commands will only be triggered if the game is currently focused.

**Example devices:** [Windower Binder-compatible devices](https://docs.windower.net/plugins/binder/)

### How to Use

To use this addon, prefix your command with `exof` (short for `execOnFocus`). This ensures the command runs **only when the game is focused**.

**Example:**

```bash
alias g600_M1G9 exof input /echo Key M1G9 Pressed.;
```

In this example, the command `/echo Key M1G9 Pressed.` will only be executed if the game window is currently active.
