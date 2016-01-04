From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 0/6] 8250: AMD Carrizo UART PL300 DMA enablement
Date: Mon, 4 Jan 2016 13:31:35 +0800
Message-ID: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

Hi, all

As AMD carrizo UART device is compatible with 8250 and has pl330 DMA
IP, our uart driver is serial:8250 and DMA engine is registered by
driver/dma/pl330. The following patches are made, in order to enable
DMA.

V1:
http://lkml.kernel.org/g/1449199466-6081-1-git-send-email-annie.wang@amd.com

Major changes from V1->V2:
- Create an amba device in driver/acpi/acpi_apd.c, as the DMA device
  relies on UART device and it can only be used by UART device, they
  are not siblings. UART device should be the parent of DMA device.
- base_request_line and num are added to acpi dma controller register

Thanks,
Hongcheng (Annie)

Wang Hongcheng (6):
  8250/Kconfig: add config option CONFIG_SERIAL_8250_AMD
  ACPI: create setup_quirk in acpi_apd
  ACPI: add 2 parameters to function acpi dma controller register
  dmaengine: pl330: add new items for pl330 private data
  dmaengine: pl330: provide ACPI dmaengine interface
  Serial:8250: New Port Type PORT_AMD_8250

 drivers/acpi/acpi_apd.c               | 175 ++++++++++++++++++++++++++++++++--
 drivers/dma/acpi-dma.c                |  25 ++++-
 drivers/dma/dw/platform.c             |   2 +-
 drivers/dma/pl330.c                   |  36 ++++++-
 drivers/tty/serial/8250/8250_dw.c     |  15 +++
 drivers/tty/serial/8250/8250_port.c   |   9 ++
 drivers/tty/serial/8250/Kconfig       |   8 ++
 include/linux/acpi_dma.h              |   6 ++
 include/linux/amba/pl330.h            |   6 ++
 include/linux/platform_data/8250-dw.h |   8 ++
 include/uapi/linux/serial_core.h      |   3 +-
 include/uapi/linux/serial_reg.h       |   1 +
 12 files changed, 276 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/platform_data/8250-dw.h

-- 
1.9.1

