# Lane Detection FPGA Project

![Project Logo](logo.jpg)

This repository contains the Quartus project for lane detection using a Sobel-like filter on an FPGA, specifically implemented on the Altera DE1-SoC development board. The project utilizes an OV7670 camera for video input and incorporates FuseSoC to streamline the continuous integration and deployment (CICD) processes.

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Directory Structure](#directory-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Lane detection is a fundamental task in computer vision, particularly for autonomous vehicles and advanced driver assistance systems (ADAS). This project focuses on implementing a Sobel-like filter on an FPGA to detect lanes in real-time. The Altera DE1-SoC development board serves as the hardware platform, while the OV7670 camera provides the video input.

To facilitate seamless integration and automation, the project incorporates FuseSoC. FuseSoC simplifies the management of IP cores and libraries, enabling an efficient and scalable development workflow. Additionally, the project leverages Git version control and GitHub tools like issues to facilitate collaboration among team members.

## Getting Started

To get started with the project, follow the instructions below.

### Prerequisites

- Quartus Prime software (version X.X or later): [Download](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)
- DE1-SoC Board Support Package (BSP): [Download](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=836)
- Git version control system: [Download](https://git-scm.com/downloads)
- FuseSoC: [Installation Guide](https://github.com/olofk/fusesoc)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ayusufsirin/ele432_project/
```

2. Install Quartus Prime software according to the instructions provided by Intel.

3. Download and install the DE1-SoC BSP package from the Terasic website.

4. Install Git and configure your global settings (if not already done).

5. Install FuseSoC by following the installation guide provided in the FuseSoC repository.


## Directory Structure

The workspace for this project follows the following directory structure:

- **workspace:** This directory contains the compiled project files for Quartus, including the generated output files, such as the programming files and project configuration files.

- **hdl:** The `hdl` directory contains the generic IP core files. These files define the hardware design components used in the project, such as modules, interfaces, and entities.

- **ip:** The `ip` directory contains the IP cores specifically developed for Quartus. These cores are reusable hardware components that can be integrated into the project design. Examples of IP cores include processors, memory modules, and communication interfaces.

- **report:** The `report` directory contains the project report, which provides detailed information about the design, implementation, and results of the lane detection FPGA project. It may include performance analysis, optimization strategies, and other relevant documentation.

Please refer to the specific directories for more details on their contents and organization. Ensure that you maintain the directory structure when working with the project to ensure proper file references and ease of navigation.


## Usage

1. Connect the Altera DE1-SoC development board to your computer.

2. Open the Quartus Prime software and load the Quartus project file (`digital_cam_impl1.qpf`) located in the project sub-directory `workspace`.

3. Configure the project settings as needed.

4. Build the project by selecting the appropriate build configuration and clicking on the "Start Compilation" button.

5. Once the compilation is complete, program the FPGA using Quartus Prime.

6. Connect the OV7670 camera to the appropriate interface on the DE1-SoC board.

7. Power on the board and execute the lane detection application.

8. Monitor the output on the display or via the UART interface, as specified in your design.

For more detailed information or troubleshooting, refer to the project documentation.

## Contributing

Contributions to this project are welcome. To contribute, please follow these steps:

1. Fork the repository.

2. Create a new branch for your feature or bug fix.

3. Make the necessary changes in your branch.

4. Test your changes thoroughly.

5. Commit your changes and push the branch to your fork.

6. Submit a pull request to the main repository.

Please ensure that your contributions adhere to the coding standards, and include appropriate documentation where necessary.

## License

This project is licensed under the [MIT License](LICENSE). You are free to modify, distribute, and use the code in this project for personal or commercial purposes. See the [LICENSE](LICENSE) file for more details.

---

Feel free to customize this README.md file based on your project's specific requirements. Include information about any additional tools, configurations, or setup procedures that may be necessary for the successful execution of your project.
