# Clean Windows - Simple Cleanup Script 🧹

This batch script performs safe and basic Windows cleanup operations without the need for third-party cleaning software.  
It focuses on removing temporary files, caches, and other non-essential data to help reclaim disk space and protect privacy.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yanpenalva/clean-windows.git
   ```

2. **Run as Administrator**:
   ```bash
   .\clean.bat
   ```

3. **Review Before Running**:
   - The script does not prompt for confirmation by default — it runs all enabled cleanup steps automatically.
   - It's strongly recommended to open the script in a text editor and review the actions it performs.

## Features

- **Privacy**: Clears recent files, browser caches, and Windows Error Reporting data.
- **Performance**: Removes temporary files, system temp data, and unused update downloads; optimizes drives.
- **Safety**: Avoids deleting essential system files; only cleans safe-to-remove locations.
- **Customizable**: Feature flags allow you to enable or disable specific cleanup actions.
- **Transparent**: Fully open-source; you can inspect and modify before running.

## Important Notes

- This script **does not** remove telemetry or disable Windows services/tasks.  
- It **does not** create a restore point automatically. If you want a restore point, create one manually before running:
  ```powershell
  powershell -NoProfile -Command "Checkpoint-Computer -Description 'Before Clean Windows'"
  ```
- For maximum safety, review the code and make sure all cleanup targets are suitable for your system.

## Disclaimer

This script is provided as-is, without any warranty. The author is not responsible for any issues that may occur. Always review the code before executing it on your system.

## License

Licensed under the GNU General Public License — see the [LICENSE](LICENSE) file for details.
