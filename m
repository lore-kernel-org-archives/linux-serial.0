From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 0/9] 8250: AMD Carrizo UART PL300 DMA enablement
Date: Fri, 4 Dec 2015 11:24:17 +0800
Message-ID: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

Hi all,

As AMD carrizo UART device is compatible with 8250 and has pl330 DMA
IP, our uart driver is serial:8250 and DMA engines are registered by
driver/dma/pl330. The following patches are made, in order to enable
DMA.

Firstly, we add an universal ACPI amba glue layer to create an amba
device based on ACPI table. Then we alter 8250/Kconfig to support
AMD 8250 device and add quirk for AMD specific request.
Secondly, since pl330 driver only provides dma engine for platform
devices, we add an acpi dma engine interface.
Then we add a new port type for AMD carrizo and set UART registers
and dma rx size as hardware requirement.
In the end, we make our IOMMU driver to support non-pci device, so
UART DMA really works.

Thanks,
Hongcheng

Huang Rui (1):
  ACPI: Add support for AMBA bus type

Wan Zongshun (2):
  Documentation: Add ivrs_acpihid kernel parameter description
  iommu/amd: Add ACPI HID named devices IOMMU driver support

Wang Hongcheng (6):
  8250/Kconfig: add config option CONFIG_SERIAL_8250_AMD
  ACPI: add struct acpi_amba_quirk for AMD pl330 specific device config
  dmaengine: pl330: add new items for pl330 private data
  dmaengine: pl330: provide ACPI dmaengine interface
  dmaengine:pl330: set segment_boundary_mask = 0cffffffff
  Serial:8250: New Port Type PORT_AMD_8250

 Documentation/kernel-parameters.txt |   7 ++
 drivers/acpi/Makefile               |   1 +
 drivers/acpi/acpi_amba.c            | 180 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpi_apd.c             |  89 +++++++++++++++---
 drivers/dma/pl330.c                 |  61 ++++++++++--
 drivers/iommu/amd_iommu.c           | 165 +++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_init.c      | 123 +++++++++++++++++++++++-
 drivers/iommu/amd_iommu_types.h     |  11 +++
 drivers/tty/serial/8250/8250_dw.c   |  16 ++++
 drivers/tty/serial/8250/8250_port.c |   9 ++
 drivers/tty/serial/8250/Kconfig     |   8 ++
 include/linux/acpi.h                |  30 ++++++
 include/linux/amba/pl330.h          |   4 +
 include/linux/serial_8250.h         |   4 +
 include/uapi/linux/serial_core.h    |   3 +-
 include/uapi/linux/serial_reg.h     |   2 +
 16 files changed, 673 insertions(+), 40 deletions(-)
 create mode 100644 drivers/acpi/acpi_amba.c

-- 
1.9.1
