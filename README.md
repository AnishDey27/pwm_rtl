Parameterizable PWM Module in Verilog
A robust and reusable Pulse Width Modulation (PWM) generator IP designed in Verilog, suitable for applications like motor control, LED dimming, and power electronics. This project focuses on creating a reliable, synthesizable, and industry-aware hardware module.

Key Features:
⚙️ Fully Parameterizable: The data width is configurable, allowing the module to be easily adapted for different precision needs.

⚡ Glitch-Free Updates: Implements double-buffering (shadow registers) on div and duty inputs. This allows for safe, on-the-fly changes to the period and duty cycle without causing any hazardous glitches on the output signal.

🛡️ Robust and Safe: Includes critical safety logic to reject invalid period values (div=0), preventing system stalls and ensuring predictable behavior.

🤝 Standard Handshake Protocol: Uses a simple ready signal to indicate when the module can accept new values, making it easy to integrate with other system components.

This repository includes the synthesizable RTL code and a comprehensive Verilog testbench for full feature validation.
