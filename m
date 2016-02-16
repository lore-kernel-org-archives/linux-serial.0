From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V3 0/4] Transform Fintek PCIE driver from 8250 to MFD
Date: Tue, 16 Feb 2016 14:55:06 +0800
Message-ID: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The Fintek F81504/508/512 is a multi-function PCIE devices.
IC function list:
    F81504: Max 2x8 GPIOs and max 4 serial ports
        port2/3 are multi-function
    F81508: Max 6x8 GPIOs and max 8 serial ports
        port2/3 are multi-function, port8/9/10/11 are gpio only
    F81512: Max 6x8 GPIOs and max 12 serial ports
        port2/3/8/9/10/11 are multi-function

It had implemented in 8250_pci.c with basic serial port function.
We want to complete it. Alan & Andy recommend us to rewrite and
spilt our driver with MFD architecture.
https://lkml.org/lkml/2016/1/19/288

Paul recommed us do less code deletion to avoid confusing problem when
bisect.
https://lkml.org/lkml/2016/1/18/646

So we'll do this with following patches.
    1. Add MFD core driver.
    2. Add GPIOLIB driver.
    3. Add serial port driver.
    4. Remove old driver in 8250_pci.c and add it to blacklist

It can be workable when applied patches 1~3. After apply patch 4,
the device will control by F81504 MFD core driver.

Changelog:
V3:
    1. Refactoring gpio-f81504.c with new API
       (Suggested by Linus Walleij).
    2. Fix wrong kfree in gpio-f81504.c (Suggested by Andy Shevchenko).
    3. Get PCI resource by pci_resource_start() instead of getting PCI
       resource from BAR of PCI configuration space (Suggested by Alan).

V2:
    1. Split F81504/508/512 from 8250_pci.c to MFD, It'll add 3 new files
       1. drivers/mfd/f81504-core.c
       2. drivers/gpio/gpio-f81504.c
       3. drivers/tty/serial/8250/8250_f81504.c

V1:
    1. Split F81504/508/512 from 8250_pci.c to 8250_fintek_pci.c.
       Alan & Andy recommend me to rewrite as MFD architecture.

Peter Hung (4):
  mfd: f81504-core: Add Fintek F81504/508/512 PCIE-to-UART/GPIO core
    support
  gpio: gpio-f81504: Add Fintek F81504/508/512 PCIE-to-UART/GPIO GPIOLIB
    support
  8250: 8250_f81504: Add Fintek F81504/508/512 PCIE-to-UART/GPIO UART
    support
  serial: 8250_pci: Remove Fintek F81504/508/512 UART driver

 drivers/gpio/Kconfig                  |  10 +
 drivers/gpio/Makefile                 |   1 +
 drivers/gpio/gpio-f81504.c            | 241 ++++++++++++++++++++++++
 drivers/mfd/Kconfig                   |  12 ++
 drivers/mfd/Makefile                  |   2 +
 drivers/mfd/f81504-core.c             | 336 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_f81504.c | 254 +++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 206 +--------------------
 drivers/tty/serial/8250/Kconfig       |  11 ++
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/mfd/f81504.h            |  52 ++++++
 11 files changed, 925 insertions(+), 201 deletions(-)
 create mode 100644 drivers/gpio/gpio-f81504.c
 create mode 100644 drivers/mfd/f81504-core.c
 create mode 100644 drivers/tty/serial/8250/8250_f81504.c
 create mode 100644 include/linux/mfd/f81504.h

-- 
1.9.1

