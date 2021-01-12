Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503BC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682052310F
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404776AbhALKTy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:19:54 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:42912 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbhALKTx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:19:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id F0C9711FFA6;
        Tue, 12 Jan 2021 11:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446743;
        bh=bjpyQTvEm5ZGzQ9Nv0VdQYj9KXXlUMGSeYtlBQlNRSE=;
        h=Date:From:To:Subject:From;
        b=Fj7L9CIEcuVAVmZCy6tHIQdD+HLKKe42Cz8HymKADfOwP1oyLUVarzv6cOfXxTD9b
         Vw3vVOd4yYLNm8FJEhmJqfJXWkIKMdFgUCoyj2/UN7zZcNf2XtEzKLykKCHDZ+Pb+5
         IHXN0S+gBNblhjzRaT21yJiJ4tS4taIl6ZnJ0nBPG6fSatcQUXwo++Bb/siLRnT39d
         jP6ZRIbY2oh6Sk/Yr/pSmdW0uWyqz05jzrtU1gVpXys4ydmqKQd7UhOV+EBzqd/U2k
         XF7qB15s6wKgRs8FVs/m+AwBM5hBNzl3cXGdeD2fYydi83G0unGa9V6v1I+Qvn56ez
         kvk7HFOZYE7+w==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQ_vPiFdUp83; Tue, 12 Jan 2021 11:18:36 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id BDAEF11FFA3;
        Tue, 12 Jan 2021 11:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446716;
        bh=bjpyQTvEm5ZGzQ9Nv0VdQYj9KXXlUMGSeYtlBQlNRSE=;
        h=Date:From:To:Subject:From;
        b=kX0vaVIDM7vH+ovQd+q+vWvDBEMG8G0/Lq6IqcrzlFlHf9e19qSYNWtLAiEiocdYw
         v4eB0Y0kZthrSszyVYrSYvoW8eGMzIxLcP1VwRzhB2ylhdnsI3iejMuvq0Wea8NEI6
         WntB8528o7HfNuvn3y5qaeQtEzuFaCWCaiBp6thqecVAbZaKAtJuvUN/Ny5gQmGtst
         UWchwP5GyvutuTo9IZRsI5c3RU0gid2WIVmYzMa28wAcBWv635gARJOc9fQZVwSSMC
         0iSdbuLgNkUUbzQWvODkj3BBxIaR3X9twDV5U3XOcMmOTLj/jsNeEXSvvMs3M6L59U
         G03yxHtadhKVQ==
Date:   Tue, 12 Jan 2021 10:18:33 +0000
From:   Jozsef Horvath <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/2] Serial: silabs si4455 serial driver
Message-ID: <20210112101831.GA12483@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a serial port driver for
 Silicon Labs Si4455 Sub-GHz transciver.

The goal of this driver is to removing wires
 between central(linux) device and remote serial devices/sensors,
 but keeping the original user software.
 It represents regular serial interface for the user space.

Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf

Guide: Documentation/driver-api/serial/si4455.rst

Signed-off-by: Jozsef Horvath <info@ministro.hu>
---

changes v1:
 - fixed: drivers: serial: si4455: coding style
 - fixed: drivers: serial: si4455: error checking and order
 - fixed: drivers: serial: si4455: remove unnecessary compatibility
   strings from si4455_dt_ids

changes v2:
 - fixed: drivers: serial: si4455: coding style

changes v3:
 - fixed: drivers: serial: si4455: coding style
 - fixed: drivers: serial: si4455: replace device configuration procedure
   (SI4455_IOC_SEZC ioctl call) with request_firmware(...).
   The firmware name comes from dt (silabs,ez-config)
 - fixed: drivers: serial: si4455: replace transmit/receive channel
   select (SI4455_IOC_STXC/SI4455_IOC_SRXC ioctl calls)
   with sysfs entries (tx_channel, rx_channel).
   Initial values comes from dt (silabs,tx-channel and silabs,rx-channel)
 - fixed: drivers: serial: si4455: replace package size setting
   (SI4455_IOC_SSIZ ioctl call) with sysfs entry (package_size).
   Initial value comes from dt (silabs,package-size)
 - fixed: drivers: serial: si4455: replace getting last rssi
   (SI4455_IOC_GRSSI ioctl call) with sysfs entry (current_rssi)
 - fixed: drivers: serial: si4455: remove si4455_api.h
   and custom ioctl definitions

changes v5:
 - fixed: drivers: serial: si4455: coding style
 - fixed: drivers: serial: si4455: remove struct si4455_one,
   members moved to struct si4455_port
 - fixed: drivers: serial: si4455: fix line endings in dev_err and
   dev_dbg messages
 - fixed: drivers: serial: si4455: remove unnecessary else { ... }
 - fixed: drivers: serial: si4455: refactor si4455_do_work(...),
   xmit circular buffer handling and start tx moved to
   si4455_start_tx_xmit(...)
 - fixed: drivers: serial: si4455: refactor si4455_configure
 - fixed: drivers: serial: si4455: refactor interrupt handling,
   remove unnecessary wrapper
 - fixed: drivers: serial: si4455: modem line(si4455_get_mctrl)
   and tx buffer status(si4455_tx_empty) conditions and signaling
 - fixed: drivers: serial: si4455: remove unsafe int to pointer conversion

changes v6:
 - fixed: drivers: serial: si4455: illegal characters in
   MODULE_AUTHOR("...") Reported-by: kernel test robot <lkp@intel.com>

changes v7:
 - added: drivers: serial: si4455: variable packet length support
 - added: drivers: serial: si4455: extended error handling

changes v8:
 - fixed: drivers: serial: si4455: removed unnecessary error checking around debugfs
 - fixed: drivers: serial: si4455: removed unnecessary #ifdefs
 - fixed: drivers: serial: kconfig: add missing module name to help text
 - fixed: drivers: serial: si4455: device name ttySI changed to ttySSi
   because of collosion. The ttySI is allocated alredy in devices.txt
 - fixed: drivers: serial: si4455: revoved unnecessary administrative definitions
   (major, minor)
 - fixed: drivers: serial: si4455: definition PORT_SI4455 changed and moved to serial_core.h
 - fixed: drivers: serial: si4455: silabs,tx-timeout property name changed
   to silabs,tx-timeout-ms
---
 Documentation/driver-api/serial/index.rst  |    1 +
 Documentation/driver-api/serial/si4455.rst |  216 +++
 MAINTAINERS                                |    7 +
 drivers/tty/serial/Kconfig                 |   11 +
 drivers/tty/serial/Makefile                |    1 +
 drivers/tty/serial/si4455.c                | 1660 ++++++++++++++++++++
 include/uapi/linux/serial_core.h           |    3 +
 7 files changed, 1899 insertions(+)
 create mode 100644 Documentation/driver-api/serial/si4455.rst
 create mode 100644 drivers/tty/serial/si4455.c

diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
index 33ad10d05b26..2b71e87f1103 100644
--- a/Documentation/driver-api/serial/index.rst
+++ b/Documentation/driver-api/serial/index.rst
@@ -23,6 +23,7 @@ Serial drivers
     rocket
     serial-iso7816
     serial-rs485
+    si4455
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/serial/si4455.rst b/Documentation/driver-api/serial/si4455.rst
new file mode 100644
index 000000000000..f81c35c18067
--- /dev/null
+++ b/Documentation/driver-api/serial/si4455.rst
@@ -0,0 +1,216 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+======================================
+Silicon Labs Si4455 serial port driver
+======================================
+
+This is a serial port driver for Silicon Labs Si4455 Sub-GHz transciver.
+
+The goal of this driver is to removing wires between central(linux) device and remote serial devices/sensors,
+but keeping the original user software.
+It represents regular serial interface for the user space.
+
+[0] - Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
+
+Additional readings:
+
+* [1] - AN 692 Si4355/Si4455 PROGRAMMING GUIDE (https://www.silabs.com/documents/public/application-notes/AN692.pdf)
+* [2] - AN796 WIRELESS DEVELOPMENT SUITE GENERAL DESCRIPTION (https://www.silabs.com/documents/public/application-notes/AN796.pdf)
+* [3] - EZRadio REVB1A API (https://www.silabs.com/documents/public/application-notes/EZRadio_REVB1_API.zip)
+* [4] - EZRadio REVC2A API (https://www.silabs.com/documents/public/application-notes/EZRadio_REVC2_API.zip)
+* [5] - Using PART_INFO command to identify EZRadio/PRO part number (https://www.silabs.com/community/wireless/proprietary/knowledge-base.entry.html/2017/04/04/using_part_info_comm-XwP9)
+
+1. Device tree bindings
+=======================
+You can see the required parameters in silabs,si4455.yaml (Documentation/devicetree/bindings/serial/silabs,si4455.yaml)
+
+2. Device configuration(firmware)
+=================================
+
+2.1. Prerequirements
+^^^^^^^^^^^^^^^^^^^^
+
+To generate radio configuration, the Silicon Labs Wireless Development Suite
+(https://www.silabs.com/documents/login/software/WDS3-Setup.exe) is required.
+
+2.2. Generate
+^^^^^^^^^^^^^
+
+Before you start, see ref: [2]
+
+1. Start WDS
+2. Select *Simulate radio* option on startup screen
+3. Select *Si4455* and revision you have in *Select Radio* dialog
+4. Select *Radio Configuration Application* in *Application Manager*
+5. Select *Bidirectional packet* project in *Radio Configuration Application* dialog.
+6. Make your project specific configuration.
+7. Click *Generate source* than choose *Export custom project for third party IDE*
+
+2.3. Compile
+^^^^^^^^^^^^
+
+1. create ``radio_config/main.c`` with the following code::
+
+    #include <stdlib.h>
+    #include <stdio.h>
+    #include <stdint.h>
+    #include <unistd.h>
+    #include "radio.h"
+    #include "radio_config.h"
+    uint8_t Radio_Configuration_Data_Array[] = RADIO_CONFIGURATION_DATA_ARRAY;
+    int main (int argc, char ** argv)
+    {
+        write(1, Radio_Configuration_Data_Array, sizeof(Radio_Configuration_Data_Array));
+    }
+
+2. create ``radio_config/radio.h`` with the following code::
+
+    #ifndef RADIO_H_
+    #define RADIO_H_
+
+    #define RADIO_MAX_PACKET_LENGTH     64u
+
+    typedef struct
+    {
+      uint8_t   *Radio_ConfigurationArray;
+
+      uint8_t   Radio_ChannelNumber;
+      uint8_t   Radio_PacketLength;
+      uint8_t   Radio_State_After_Power_Up;
+
+      uint16_t  Radio_Delay_Cnt_After_Reset;
+
+      uint8_t   Radio_CustomPayload[RADIO_MAX_PACKET_LENGTH];
+    } tRadioConfiguration;
+    #endif /* RADIO_H_ */
+
+3. in case of **Chip revision C2** copy ``src\drivers\radio\Si4455\si4455_patch.h`` from project directory generated by WDS to ``radio_config/si4455_patch.h``
+4. copy ``src\application\radio_config.h`` from project directory generated by WDS to ``radio_config/radio_config.h``
+5. in case of **Chip revision C2** change the content of ``radio_config/radio_config.h``::
+
+    - #include "..\drivers\radio\Si4455\si4455_patch.h"
+    + #include "si4455_patch.h"
+
+6. compile
+
+    gcc radio_config/main.c -o radio_config/fwc
+
+7. run
+
+    radio_config/fwc > /lib/firmware/$(firmware-name)
+
+3. Device
+=========
+
+The driver instances are comes up under ``/dev`` as
+
+    /dev/ttySLX
+
+, where ``X`` is the index of instance.
+
+The driver supports only:
+
+* Char size: 8 bits
+* Handshake: None or RTSCTS.
+    RTSCTS preferred
+
+4. sysfs
+========
+
+The si4455 driver uses configuration parameters and maintains statistics inside sysfs filesystem.
+
+**current_rssi**:
+
+    Path:
+        /sys/class/tty/ttySLX/device/current_rssi
+
+    Description:
+        Shows the latest rssi value measured by chip.
+        To convert the value to dBm. See chapter *3.2.1. Received Signal Strength Indicator* in [0]
+
+**package_size**:
+
+    Path:
+        /sys/class/tty/ttySLX/device/package_size
+
+    Description:
+        Shows or stores the package size.
+        The new value applied immediately.
+        Variable package size (package_size = 0)
+
+**rx_channel**:
+
+    Path:
+        /sys/class/tty/ttySLX/device/rx_channel
+
+    Description:
+        Shows or stores the receive channel index.
+        The new value applied immediately.
+
+**tx_channel**:
+
+    Path:
+        /sys/class/tty/ttySLX/device/tx_channel
+
+    Description:
+        Shows or stores transmit channel index.
+        The new value will be used on next data transmit.
+
+**tx_timeout**:
+
+    Path:
+        /sys/class/tty/ttySLX/device/tx_timeout
+
+    Description:
+        Shows or stores the transmit timeout.
+        The new value will be used on next data transmit.
+
+5. debugfs
+^^^^^^^^^^
+
+The si4455 driver maintains statistics inside debugfs filesystem.
+
+**cts_error_count**:
+
+    Path:
+        /sys/kernel/debug/spiX.Y/si4455/cts_error_count
+
+    Description:
+        The numer of cts timeouts. In case of cts timeout, the driver reinitialize the chip.
+
+**tx_error_count**:
+
+    Path:
+        /sys/kernel/debug/spiX.Y/si4455/tx_error_count
+
+    Description:
+        The number of tx timeouts. In case of tx timeout, the driver restarts the last data transmission.
+
+**chip_rev**:
+
+    Path:
+        /sys/kernel/debug/spiX.Y/si4455/partinfo/chip_rev
+
+    Description:
+        The value of CHIPREV field in PART_INFO structure.
+        See *PART_INFO* command details in [3] or in [4]
+
+**rom_id**:
+
+    Path:
+        /sys/kernel/debug/spiX.Y/si4455/partinfo/rom_id
+
+    Description:
+        The value of ROMID field in PART_INFO structure.
+        See *PART_INFO* command details in [3] or in [4]
+        See ref [5]
+
+**part**:
+
+    Path:
+        /sys/kernel/debug/spiX.Y/si4455/partinfo/part
+
+    Description:
+        The value of PART field in PART_INFO structure.
+        See *PART_INFO* command details in [3] or in [4]
+        See ref [5]
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70f3c16..e6e9f2b1aecc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15952,6 +15952,13 @@ M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
 F:	drivers/staging/wfx/
 
+SILICON LABS SI4455 SERIAL DRIVER
+M:	Jozsef Horvath <info@ministro.hu>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/silabs,si4455.yaml
+F:	Documentation/driver-api/serial/si4455.rst
+F:	drivers/tty/serial/si4455.c
+
 SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c..e91cce1074df 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1583,6 +1583,17 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_SI4455
+	tristate "Si4455 support"
+	depends on SPI
+	select SERIAL_CORE
+	help
+	  This driver is for Silicon Labs's Si4455 Sub-GHz transciver.
+	  Say 'Y' here if you wish to use it as serial port.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called si4455.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index caf167f0c10a..f01ff43db1d6 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
 obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
+obj-$(CONFIG_SERIAL_SI4455)	+= si4455.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 
 # GPIOLIB helpers for modem control lines
diff --git a/drivers/tty/serial/si4455.c b/drivers/tty/serial/si4455.c
new file mode 100644
index 000000000000..98f80fce3486
--- /dev/null
+++ b/drivers/tty/serial/si4455.c
@@ -0,0 +1,1660 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Jozsef Horvath <info@ministro.hu>
+ *
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/spi/spi.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
+#include <linux/firmware.h>
+#include <linux/timer.h>
+#include <linux/debugfs.h>
+
+#define SI4455_NAME						"Si4455"
+#define SI4455_DEV_NAME						"ttySSi"
+#define SI4455_UART_NRMAX					16
+#define SI4455_FIFO_SIZE					64
+
+#define SI4455_CMD_ID_EZCONFIG_CHECK				0x19
+#define SI4455_CMD_ID_PART_INFO					0x01
+#define SI4455_CMD_REPLY_COUNT_PART_INFO			9
+#define SI4455_CMD_ID_GET_INT_STATUS				0x20
+#define SI4455_CMD_REPLY_COUNT_GET_INT_STATUS			8
+#define SI4455_CMD_ID_FIFO_INFO					0x15
+#define SI4455_CMD_ARG_COUNT_FIFO_INFO				2
+#define SI4455_CMD_REPLY_COUNT_FIFO_INFO			2
+#define SI4455_CMD_FIFO_INFO_ARG_TX_BIT				0x01
+#define SI4455_CMD_FIFO_INFO_ARG_RX_BIT				0x02
+#define SI4455_CMD_ID_READ_CMD_BUFF				0x44
+#define SI4455_CMD_ID_READ_RX_FIFO				0x77
+#define SI4455_CMD_ID_WRITE_TX_FIFO				0x66
+#define SI4455_CMD_ID_START_RX					0x32
+#define SI4455_CMD_ARG_COUNT_START_RX				8
+#define SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX			8
+#define SI4455_CMD_START_RX_RXVALID_STATE_SLEEP			1
+#define SI4455_CMD_START_RX_RXVALID_STATE_RX			8
+#define SI4455_CMD_START_RX_RXINVALID_STATE_RX			8
+#define SI4455_CMD_ID_START_TX					0x31
+#define SI4455_CMD_ARG_COUNT_START_TX				5
+#define SI4455_CMD_ID_CHANGE_STATE				0x34
+#define SI4455_CMD_ARG_COUNT_CHANGE_STATE			2
+#define SI4455_CMD_CHANGE_STATE_STATE_SLEEP			1
+#define SI4455_CMD_CHANGE_STATE_STATE_READY			3
+#define SI4455_CMD_CHANGE_STATE_STATE_RX			8
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK		0x08
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT		0x08
+#define SI4455_CMD_GET_INT_STATUS_RX_FIFO_AF_BIT		0x01
+#define SI4455_CMD_GET_INT_STATUS_TX_FIFO_AE_BIT		0x02
+#define SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT		0x20
+#define SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT		0x10
+#define SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT			0x08
+#define SI4455_CMD_GET_INT_STATUS_CHIP_RDY_BIT			0x04
+#define SI4455_CMD_GET_INT_STATUS_CMD_ERROR_BIT			0x08
+#define SI4455_CMD_GET_INT_STATUS_ST_CHANGED_BIT		0x10
+#define SI4455_CMD_GET_INT_STATUS_FIFO_UO_BIT			0x20
+#define SI4455_CMD_ID_GET_MODEM_STATUS				0x22
+#define SI4455_CMD_ARG_COUNT_GET_MODEM_STATUS			2
+#define SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS			8
+
+struct si4455_part_info {
+	u8 chip_rev;
+	u16 part;
+	u8 pbuild;
+	u16 id;
+	u8 customer;
+	u8 rom_id;
+	u8 bond;
+};
+
+struct si4455_int_status {
+	u8 int_pend;
+	u8 int_status;
+	u8 ph_pend;
+	u8 ph_status;
+	u8 modem_pend;
+	u8 modem_status;
+	u8 chip_pend;
+	u8 chip_status;
+};
+
+struct si4455_modem_status {
+	u8 modem_pend;
+	u8 modem_status;
+	u8 curr_rssi;
+	u8 latch_rssi;
+	u8 ant1_rssi;
+	u8 ant2_rssi;
+	u16 afc_freq_offset;
+};
+
+struct si4455_fifo_info {
+	u8 rx_fifo_count;
+	u8 tx_fifo_space;
+};
+
+struct si4455_port {
+	struct uart_port port;
+	struct dentry *dbgfs_dir;
+	struct work_struct tx_work;
+	struct work_struct tx_wd_work;
+	struct work_struct cts_wd_work;
+	struct timer_list tx_wd_timer;
+	struct timer_list cts_wd_timer;
+	struct mutex mutex; /* For syncing access to device */
+	struct gpio_desc *shdn_gpio;
+	struct si4455_part_info part_info;
+	struct si4455_modem_status modem_status;
+	u32 tx_channel;
+	u32 rx_channel;
+	u32 package_size;
+	u32 current_rssi;
+	u32 cts_error_count;
+	u32 tx_error_count;
+	int power_count;
+	u32 tx_wd_timeout;
+	u32 tx_pending_size;
+	char ez_fw_name[255];
+	bool connected;
+	bool suspended;
+	bool configured;
+	bool cts_error;
+	bool tx_pending;
+	bool rx_pending;
+	bool tx_stopped;
+	bool rx_stopped;
+};
+
+static struct uart_driver si4455_uart = {
+	.owner			= THIS_MODULE,
+	.driver_name		= SI4455_NAME,
+	.dev_name		= SI4455_DEV_NAME,
+	.nr			= SI4455_UART_NRMAX,
+};
+
+static DEFINE_MUTEX(si4455_ports_lock);			/* race on probe */
+static DECLARE_BITMAP(si4455_port_lines, SI4455_UART_NRMAX);
+
+static int si4455_get_response(struct uart_port *port, int length, u8 *data)
+{
+	int ret;
+	u8 data_out[] = { SI4455_CMD_ID_READ_CMD_BUFF };
+	u8 *data_in;
+	struct spi_transfer xfer[2];
+	int timeout = 100;
+
+	if (length > 0 && !data)
+		return -EINVAL;
+
+	data_in = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_in)
+		return -ENOMEM;
+
+	memset(&xfer, 0x00, sizeof(xfer));
+	xfer[0].tx_buf = data_out;
+	xfer[0].len = sizeof(data_out);
+	xfer[1].rx_buf = data_in;
+	xfer[1].len = 1 + length;
+
+	while (--timeout > 0) {
+		data_out[0] = SI4455_CMD_ID_READ_CMD_BUFF;
+		ret = spi_sync_transfer(to_spi_device(port->dev), xfer,
+					ARRAY_SIZE(xfer));
+		if (ret) {
+			dev_err(port->dev, "%s: spi_sync_transfer error (%i)\n", __func__, ret);
+			break;
+		}
+
+		if (data_in[0] == 0xFF) {
+			if (length > 0 && data)
+				memcpy(data, &data_in[1], length);
+
+			break;
+		}
+		usleep_range(100, 200);
+	}
+	if (!ret && timeout == 0) {
+		dev_err(port->dev, "%s: timeout\n", __func__);
+		ret = -EIO;
+	}
+	kfree(data_in);
+	return ret;
+}
+
+static int si4455_poll_cts(struct uart_port *port)
+{
+	int ret;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	ret = si4455_get_response(port, 0, NULL);
+	if (ret == -EIO) {
+		s->cts_error_count++;
+		s->cts_error = true;
+	}
+	return ret;
+}
+
+static int si4455_send_command(struct uart_port *port, int length, u8 *data)
+{
+	int ret;
+
+	ret = si4455_poll_cts(port);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_poll_cts error (%i)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = spi_write(to_spi_device(port->dev), data, length);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_write error (%i)\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+static int si4455_send_command_get_response(struct uart_port *port,
+					    int out_length, u8 *data_out,
+					    int in_length, u8 *data_in)
+{
+	int ret;
+
+	ret = si4455_send_command(port, out_length, data_out);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command error (%i)\n", __func__, ret);
+		return ret;
+	}
+
+	return si4455_get_response(port, in_length, data_in);
+}
+
+static int si4455_read_data(struct uart_port *port, u8 command, bool poll,
+			    int length, u8 *data)
+{
+	int ret = 0;
+	u8 data_out[] = { command };
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = data_out,
+			.len = sizeof(data_out),
+		}, {
+			.rx_buf = data,
+			.len = length,
+		}
+	};
+
+	if (poll) {
+		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
+
+	ret = spi_sync_transfer(to_spi_device(port->dev),
+				xfer,
+				ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_sync_transfer error (%i)\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+static int si4455_write_data(struct uart_port *port, u8 command, bool poll,
+			     int length, const u8 *data)
+{
+	int ret = 0;
+	u8 *data_out;
+
+	if (poll) {
+		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
+
+	data_out = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_out)
+		return -ENOMEM;
+
+	data_out[0] = command;
+	memcpy(&data_out[1], data, length);
+	ret = spi_write(to_spi_device(port->dev), data_out, 1 + length);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_write error (%i)\n", __func__, ret);
+	}
+
+	kfree(data_out);
+
+	return ret;
+}
+
+static void si4455_set_power(struct si4455_port *priv, bool on)
+{
+	if (!priv->shdn_gpio)
+		return;
+
+	gpiod_direction_output(priv->shdn_gpio, 0);
+	if (on) {
+		usleep_range(14000, 15000);
+		gpiod_set_value(priv->shdn_gpio, 1);
+		usleep_range(14000, 15000);
+	}
+}
+
+static int si4455_s_power(struct device *dev, bool on)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	if (s->power_count == !on)
+		si4455_set_power(s, on);
+	s->power_count += on ? 1 : -1;
+	WARN_ON(s->power_count < 0);
+
+	return 0;
+}
+
+static int si4455_get_part_info(struct uart_port *port,
+				struct si4455_part_info *result)
+{
+	int ret;
+	u8 data_out[] = { SI4455_CMD_ID_PART_INFO };
+	u8 data_in[SI4455_CMD_REPLY_COUNT_PART_INFO];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	result->chip_rev = data_in[0];
+	memcpy(&result->part, &data_in[1], sizeof(result->part));
+	result->pbuild = data_in[3];
+	memcpy(&result->id, &data_in[4], sizeof(result->id));
+	result->customer = data_in[6];
+	result->rom_id = data_in[7];
+	result->bond = data_in[8];
+
+	return 0;
+}
+
+static int si4455_get_int_status(struct uart_port *port, u8 ph_clear,
+				 u8 modem_clear, u8 chip_clear,
+				 struct si4455_int_status *result)
+{
+	int ret;
+	u8 data_out[] = {
+		SI4455_CMD_ID_GET_INT_STATUS,
+		ph_clear,
+		modem_clear,
+		chip_clear
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_INT_STATUS];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	result->int_pend       = data_in[0];
+	result->int_status     = data_in[1];
+	result->ph_pend        = data_in[2];
+	result->ph_status      = data_in[3];
+	result->modem_pend     = data_in[4];
+	result->modem_status   = data_in[5];
+	result->chip_pend      = data_in[6];
+	result->chip_status    = data_in[7];
+
+	return 0;
+}
+
+static int si4455_get_modem_status(struct uart_port *port, u8 modem_clear,
+				   struct si4455_modem_status *result)
+{
+	int ret;
+	u8 data_out[] = {
+		SI4455_CMD_ID_GET_MODEM_STATUS,
+		modem_clear,
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	result->modem_pend      = data_in[0];
+	result->modem_status    = data_in[1];
+	result->curr_rssi       = data_in[2];
+	result->latch_rssi      = data_in[3];
+	result->ant1_rssi       = data_in[4];
+	result->ant2_rssi       = data_in[5];
+	memcpy(&result->afc_freq_offset, &data_in[6],
+	       sizeof(result->afc_freq_offset));
+
+	return 0;
+}
+
+static int si4455_fifo_info(struct uart_port *port, u8 fifo,
+			    struct si4455_fifo_info *result)
+{
+	int ret;
+	u8 data_out[SI4455_CMD_ARG_COUNT_FIFO_INFO] = {
+		SI4455_CMD_ID_FIFO_INFO, fifo
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_FIFO_INFO] = { 0 };
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	result->rx_fifo_count  = data_in[0];
+	result->tx_fifo_space  = data_in[1];
+
+	return 0;
+}
+
+static int si4455_read_rx_fifo(struct uart_port *port, int length, u8 *data)
+{
+	return si4455_read_data(port, SI4455_CMD_ID_READ_RX_FIFO, false,
+				length, data);
+}
+
+static int si4455_write_tx_fifo(struct uart_port *port, int length, u8 *data)
+{
+	return si4455_write_data(port, SI4455_CMD_ID_WRITE_TX_FIFO, false,
+				 length, data);
+}
+
+static int si4455_rx(struct uart_port *port, u32 channel, u8 condition,
+		     u16 length, u8 next_state1, u8 next_state2,
+		     u8 next_state3)
+{
+	u8 data_out[SI4455_CMD_ARG_COUNT_START_RX];
+
+	data_out[0] = SI4455_CMD_ID_START_RX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	data_out[5] = next_state1;
+	data_out[6] = next_state2;
+	data_out[7] = next_state3;
+
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_START_RX,
+				   data_out);
+}
+
+static int si4455_tx(struct uart_port *port, u8 channel, u8 condition,
+		     u16 length)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	u8 data_out[SI4455_CMD_ARG_COUNT_START_TX + 1];
+	u8 out_length = SI4455_CMD_ARG_COUNT_START_TX;
+
+	if (s->part_info.rom_id == 6)
+		out_length += 1;
+
+	data_out[0] = SI4455_CMD_ID_START_TX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	if (s->part_info.rom_id == 6)
+		data_out[5] = 0x44;
+
+	return si4455_send_command(port, out_length, data_out);
+}
+
+static int si4455_change_state(struct uart_port *port, u8 next_state1)
+{
+	u8 data_out[SI4455_CMD_ARG_COUNT_CHANGE_STATE];
+
+	data_out[0] = SI4455_CMD_ID_CHANGE_STATE;
+	data_out[1] = (u8)next_state1;
+
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_CHANGE_STATE,
+				   data_out);
+}
+
+static int si4455_begin_tx(struct uart_port *port, u32 channel, int length,
+			   u8 *data)
+{
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+
+	if (length > SI4455_FIFO_SIZE || length < 0)
+		return -EINVAL;
+
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = si4455_fifo_info(port, SI4455_CMD_FIFO_INFO_ARG_TX_BIT,
+			       &fifo_info);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_fifo_info error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = si4455_write_tx_fifo(port, (u16)length, data);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_write_tx_fifo error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = si4455_tx(port, channel, 0x10, length);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_tx error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int si4455_end_tx(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int si4455_begin_rx(struct uart_port *port, u32 channel, u32 length)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = si4455_fifo_info(port, SI4455_CMD_FIFO_INFO_ARG_RX_BIT,
+			       &fifo_info);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_fifo_info error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	if (s->rx_stopped)
+		return 0;
+
+	ret = si4455_rx(port, channel, 0x00, length,
+			SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX,
+			SI4455_CMD_START_RX_RXVALID_STATE_RX,
+			SI4455_CMD_START_RX_RXINVALID_STATE_RX);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_rx error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int si4455_end_rx(struct uart_port *port, u32 length, u8 *data)
+{
+	return si4455_read_rx_fifo(port, length, data);
+}
+
+static int si4455_configure(struct uart_port *port, const u8 *configuration_data)
+{
+	int ret = 0;
+	u8 col;
+	u8 response;
+	u8 count;
+	u8 cmd;
+	struct si4455_int_status int_status = { 0 };
+	u8 radio_cmd[16];
+
+	/*
+	 * While cycle as far as the pointer points to a command
+	 */
+	while (*configuration_data != 0x00) {
+		/*
+		 * Commands structure in the array:
+		 * --------------------------------
+		 * LEN | <LEN length of data>
+		 */
+		count = *configuration_data++;
+		cmd = *configuration_data;
+		dev_dbg(port->dev, "%s: count (%u), cmd (%u)\n",
+			__func__, count, cmd);
+
+		if (count > 16 && count <= 128 && cmd == SI4455_CMD_ID_WRITE_TX_FIFO) {
+			/*
+			 * Load array to the device
+			 */
+			configuration_data++;
+			ret = si4455_write_data(port, SI4455_CMD_ID_WRITE_TX_FIFO,
+						true, count - 1, configuration_data);
+			if (ret) {
+				dev_err(port->dev, "%s: si4455_write_data error (%i)\n",
+					__func__, ret);
+				break;
+			}
+
+			/*
+			 * Point to the next command
+			 */
+			configuration_data += count - 1;
+
+			/*
+			 * Continue command interpreter
+			 */
+			continue;
+		} else if (count > 16) {
+			/*
+			 * Number of command bytes exceeds
+			 * maximal allowable length
+			 */
+			ret = -EINVAL;
+			break;
+		}
+
+		for (col = 0u; col < count; col++) {
+			radio_cmd[col] = *configuration_data;
+			configuration_data++;
+		}
+
+		dev_dbg(port->dev, "%s: radio_cmd[0] (%u)\n", __func__, radio_cmd[0]);
+		ret = si4455_send_command_get_response(port, count, radio_cmd,
+						       1, &response);
+		if (ret) {
+			dev_err(port->dev,
+				"%s: si4455_send_command_get_response error (%i)\n",
+				__func__, ret);
+			break;
+		}
+
+		/*
+		 * Check response byte of EZCONFIG_CHECK command
+		 */
+		if (radio_cmd[0] == SI4455_CMD_ID_EZCONFIG_CHECK) {
+			if (response) {
+				/*
+				 * Number of command bytes exceeds
+				 * maximal allowable length
+				 */
+				ret = -EIO;
+				dev_err(port->dev, "%s: EZConfig check error (%i)\n",
+					__func__, radio_cmd[0]);
+				break;
+			}
+		}
+
+		/*
+		 * Get and clear all interrupts.  An error has occurred...
+		 */
+		si4455_get_int_status(port, 0, 0, 0, &int_status);
+		if (int_status.chip_pend
+		    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK) {
+			ret = -EIO;
+			dev_err(port->dev, "%s: chip error (%i)\n",
+				__func__, int_status.chip_pend);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int si4455_re_configure(struct uart_port *port, const struct firmware *configuration)
+{
+	int ret = 0;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	s->configured = 0;
+	if (s->power_count == 0)
+		si4455_s_power(port->dev, true);
+
+	ret = si4455_configure(port, configuration->data);
+	if (ret == 0) {
+		s->configured = true;
+		s->cts_error = false;
+	}
+	return ret;
+}
+
+static int si4455_start_tx_xmit(struct uart_port *port)
+{
+	int ret;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	struct circ_buf *xmit = &port->state->xmit;
+	u32 tx_pending;
+	u32 tx_to_end;
+	u8 *data;
+	u8 *payload;
+	u32 max_length;
+
+	if (s->tx_stopped)
+		return 0;
+
+	tx_pending = uart_circ_chars_pending(xmit);
+	if (tx_pending == 0 || tx_pending < s->package_size)
+		return 0;
+
+	max_length = (s->package_size == 0) ? SI4455_FIFO_SIZE - 3 : s->package_size;
+	tx_pending = (tx_pending > max_length) ? max_length : tx_pending;
+	if (s->package_size == 0)
+		data = kzalloc(tx_pending + 1, GFP_KERNEL);
+	else
+		data = kzalloc(tx_pending, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (s->package_size == 0) {
+		data[0] = tx_pending;
+		payload = &data[1];
+	} else {
+		payload = data;
+	}
+
+	tx_to_end = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	if (tx_to_end < tx_pending) {
+		memcpy(payload, xmit->buf + xmit->tail, tx_to_end);
+		memcpy(&payload[tx_to_end], xmit->buf, tx_pending - tx_to_end);
+	} else {
+		memcpy(payload, xmit->buf + xmit->tail, tx_pending);
+	}
+
+	if (s->package_size == 0)
+		ret = si4455_begin_tx(port, s->tx_channel, tx_pending + 1, data);
+	else
+		ret = si4455_begin_tx(port, s->tx_channel, tx_pending, data);
+	if (!ret) {
+		s->tx_pending = true;
+		s->tx_pending_size = tx_pending;
+		uart_handle_cts_change(&s->port, 0);
+		mod_timer(&s->tx_wd_timer, jiffies + msecs_to_jiffies(s->tx_wd_timeout));
+	}
+
+	kfree(data);
+
+	return ret;
+}
+
+static int si4455_cancel_tx(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	if (s->tx_pending) {
+		si4455_end_tx(port);
+		s->tx_pending = false;
+		s->tx_pending_size = 0;
+		uart_handle_cts_change(&s->port, TIOCM_CTS);
+		ret = si4455_change_state(port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+	}
+	return ret;
+}
+
+static int si4455_do_work(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	struct circ_buf *xmit = &port->state->xmit;
+
+	mutex_lock(&s->mutex);
+	if (!s->suspended && s->connected && s->configured && s->power_count > 0) {
+		if (!(uart_circ_empty(xmit) || uart_tx_stopped(port) || s->tx_pending))
+			ret = si4455_start_tx_xmit(port);
+
+		if (!ret && !s->tx_pending)
+			ret = si4455_begin_rx(port, s->rx_channel, s->package_size);
+	}
+	mutex_unlock(&s->mutex);
+	return ret;
+}
+
+static void si4455_handle_rx_pend(struct si4455_port *s, struct si4455_fifo_info *fifo_info)
+{
+	struct uart_port *port = &s->port;
+	u8 *data;
+	int sret = 0;
+	int i = 0;
+	u32 length;
+
+	length = (s->package_size == 0) ? fifo_info->rx_fifo_count : s->package_size;
+
+	data = kzalloc(length, GFP_KERNEL);
+	if (!data)
+		return;
+
+	sret = si4455_end_rx(port, length, data);
+	if (sret) {
+		dev_err(port->dev, "%s: si4455_end_rx error (%i)\n",
+			__func__, sret);
+	} else {
+		if (!s->rx_stopped) {
+			for (i = 0; i < length; i++) {
+				uart_insert_char(port, 0, 0, data[i], TTY_NORMAL);
+				port->icount.rx++;
+			}
+			tty_flip_buffer_push(&port->state->port);
+		}
+	}
+	kfree(data);
+}
+
+static void si4455_handle_tx_pend(struct si4455_port *s)
+{
+	struct uart_port *port = &s->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	u32 sent;
+
+	if (s->tx_pending) {
+		sent = (s->package_size == 0) ? s->tx_pending_size
+			: s->package_size;
+		port->icount.tx += sent;
+		xmit->tail = (xmit->tail + sent) & (UART_XMIT_SIZE - 1);
+		si4455_end_tx(port);
+		s->tx_pending = 0;
+		s->tx_pending_size = 0;
+		uart_handle_cts_change(&s->port, TIOCM_CTS);
+	}
+}
+
+static irqreturn_t si4455_ist(int irq, void *dev_id)
+{
+	struct si4455_port *s = (struct si4455_port *)dev_id;
+	struct uart_port *port = &s->port;
+	int ret;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+	bool have_to_do = false;
+
+	if (s->suspended || !s->connected || !s->configured || s->power_count == 0)
+		return IRQ_NONE;
+
+	mutex_lock(&s->mutex);
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		mutex_unlock(&s->mutex);
+		return IRQ_NONE;
+	}
+
+	dev_dbg(port->dev, "%s: int_pend: 0x%x\n", __func__, int_status.int_pend);
+	dev_dbg(port->dev, "%s: int_status: 0x%x\n", __func__, int_status.int_status);
+	dev_dbg(port->dev, "%s: ph_pend: 0x%x\n", __func__, int_status.ph_pend);
+	dev_dbg(port->dev, "%s: ph_status: 0x%x\n", __func__, int_status.ph_status);
+	dev_dbg(port->dev, "%s: modem_pend: 0x%x\n", __func__, int_status.modem_pend);
+	dev_dbg(port->dev, "%s: modem_status: 0x%x\n", __func__, int_status.modem_status);
+	dev_dbg(port->dev, "%s: chip_pend: 0x%x\n", __func__, int_status.chip_pend);
+	dev_dbg(port->dev, "%s: chip_status: 0x%x\n", __func__, int_status.chip_status);
+
+	if (int_status.chip_pend & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT) {
+		dev_err(port->dev, "%s: chip_pend:CMD_ERROR_PEND\n", __func__);
+		si4455_change_state(port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+		si4455_fifo_info(&s->port, SI4455_CMD_FIFO_INFO_ARG_RX_BIT,
+				 &fifo_info);
+		have_to_do = true;
+	} else if (int_status.ph_pend & SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT) {
+		dev_dbg(port->dev, "%s: ph_pend:PACKET_SENT_PEND\n", __func__);
+		si4455_change_state(port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+		si4455_handle_tx_pend(s);
+		have_to_do = true;
+	} else if (int_status.ph_pend & SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT) {
+		dev_dbg(port->dev, "%s: ph_pend:PACKET_RX_PEND\n", __func__);
+		si4455_get_modem_status(port, 0, &s->modem_status);
+		s->current_rssi = s->modem_status.curr_rssi;
+		si4455_change_state(port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+		si4455_fifo_info(port, 0, &fifo_info);
+		si4455_handle_rx_pend(s, &fifo_info);
+		have_to_do = true;
+	} else if (int_status.ph_pend & SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT) {
+		dev_dbg(port->dev, "%s: ph_pend:CRC_ERROR_PEND\n", __func__);
+		si4455_change_state(port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+		si4455_fifo_info(&s->port, SI4455_CMD_FIFO_INFO_ARG_RX_BIT,
+				 &fifo_info);
+		have_to_do = true;
+	}
+	mutex_unlock(&s->mutex);
+	if (have_to_do)
+		si4455_do_work(port);
+	return IRQ_HANDLED;
+}
+
+static void si4455_tx_wd_event(struct timer_list *t)
+{
+	struct si4455_port *s = from_timer(s, t, tx_wd_timer);
+
+	if (s->tx_pending)
+		schedule_work(&s->tx_wd_work);
+}
+
+static void si4455_tx_wd_proc(struct work_struct *ws)
+{
+	struct si4455_port *s = container_of(ws, struct si4455_port, tx_wd_work);
+	bool have_to_work = false;
+
+	mutex_lock(&s->mutex);
+	if (s->connected && s->tx_pending) {
+		si4455_cancel_tx(&s->port);
+		s->tx_error_count++;
+		have_to_work = true;
+		dev_err(s->port.dev,
+			"%s: curent transmit operation interrupted by wd timeout\n",
+			__func__);
+	}
+	mutex_unlock(&s->mutex);
+
+	if (have_to_work)
+		si4455_do_work(&s->port);
+}
+
+static void si4455_cts_wd_event(struct timer_list *t)
+{
+	struct si4455_port *s = from_timer(s, t, cts_wd_timer);
+
+	if (s->cts_error)
+		schedule_work(&s->cts_wd_work);
+	else
+		mod_timer(&s->cts_wd_timer, jiffies + msecs_to_jiffies(100));
+}
+
+static void si4455_cts_wd_proc(struct work_struct *ws)
+{
+	struct si4455_port *s = container_of(ws, struct si4455_port, cts_wd_work);
+	const struct firmware *ez_fw = NULL;
+	bool have_to_work = false;
+	int ret;
+
+	mutex_lock(&s->mutex);
+	if (s->cts_error) {
+		dev_err(s->port.dev, "%s: interface recovery\n", __func__);
+		ret = request_firmware(&ez_fw, s->ez_fw_name, s->port.dev);
+		if (ret) {
+			dev_err(s->port.dev, "%s: firmware(%s) request error (%i)\n",
+				__func__, s->ez_fw_name, ret);
+		} else {
+			si4455_s_power(s->port.dev, false);
+			ret = si4455_re_configure(&s->port, ez_fw);
+			release_firmware(ez_fw);
+			if (ret) {
+				dev_err(s->port.dev, "%s: device configuration error (%i)\n",
+					__func__, ret);
+			}
+		}
+		have_to_work = !ret;
+	}
+	if (s->connected)
+		mod_timer(&s->cts_wd_timer, jiffies + msecs_to_jiffies(100));
+	mutex_unlock(&s->mutex);
+
+	if (have_to_work)
+		si4455_do_work(&s->port);
+}
+
+static void si4455_tx_proc(struct work_struct *ws)
+{
+	struct si4455_port *s = container_of(ws, struct si4455_port, tx_work);
+
+	si4455_do_work(&s->port);
+}
+
+static unsigned int si4455_tx_empty(struct uart_port *port)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	return s->tx_pending ? 0 : TIOCSER_TEMT;
+}
+
+static unsigned int si4455_get_mctrl(struct uart_port *port)
+{
+	int ret;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	/*
+	 * there is no a continuous real "carrier" like on phone line,
+	 * but after configuration, the interface is ready to use the physical
+	 * transport channel
+	 */
+	ret = s->configured ? TIOCM_CAR | TIOCM_DSR : 0;
+	ret |= s->tx_pending ? 0 : TIOCM_CTS;
+
+	return ret;
+}
+
+static void si4455_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static void si4455_set_termios(struct uart_port *port, struct ktermios *termios,
+			       struct ktermios *old)
+{
+	dev_dbg(port->dev, "termios->c_iflag = 0x%x", termios->c_iflag);
+	dev_dbg(port->dev, "termios->c_oflag = 0x%x", termios->c_oflag);
+	dev_dbg(port->dev, "termios->c_cflag = 0x%x", termios->c_cflag);
+	dev_dbg(port->dev, "termios->c_lflag = 0x%x", termios->c_lflag);
+	dev_dbg(port->dev, "termios->c_ispeed = %u", termios->c_ispeed);
+	dev_dbg(port->dev, "termios->c_ospeed = %u", termios->c_ospeed);
+	if ((termios->c_cflag & CSIZE) != CS8)
+		dev_err(port->dev, "%s: CSIZE must be CS8\n", __func__);
+}
+
+static int si4455_startup(struct uart_port *port)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	mutex_lock(&s->mutex);
+	s->tx_pending = false;
+	s->tx_stopped = false;
+	s->rx_stopped = false;
+	s->connected = true;
+	mod_timer(&s->cts_wd_timer, jiffies + msecs_to_jiffies(100));
+	mutex_unlock(&s->mutex);
+	return si4455_do_work(port);
+}
+
+static void si4455_shutdown(struct uart_port *port)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	mutex_lock(&s->mutex);
+	del_timer_sync(&s->tx_wd_timer);
+	del_timer_sync(&s->cts_wd_timer);
+	s->connected = false;
+	si4455_change_state(&s->port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+	mutex_unlock(&s->mutex);
+}
+
+static const char *si4455_type(struct uart_port *port)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	if (port->type != PORT_SI4455)
+		return NULL;
+	if (s->part_info.rom_id == 3)
+		return "SI4455-B1A";
+	else if (s->part_info.rom_id == 6)
+		return "SI4455-C2A";
+
+	return "SI4455(UNKNOWN-REV)";
+}
+
+static void si4455_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_SI4455;
+}
+
+static int si4455_verify_port(struct uart_port *port, struct serial_struct *s)
+{
+	if (s->type != PORT_UNKNOWN && s->type != PORT_SI4455)
+		return -EINVAL;
+
+	if (s->irq != port->irq)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void si4455_start_tx(struct uart_port *port)
+{
+	struct si4455_port *s = container_of(port, struct si4455_port, port);
+
+	s->tx_stopped = false;
+	schedule_work(&s->tx_work);
+}
+
+static void si4455_stop_tx(struct uart_port *port)
+{
+	struct si4455_port *s = container_of(port, struct si4455_port, port);
+
+	s->tx_stopped = true;
+}
+
+static void si4455_stop_rx(struct uart_port *port)
+{
+	struct si4455_port *s = container_of(port, struct si4455_port, port);
+
+	mutex_lock(&s->mutex);
+	s->rx_stopped = true;
+	si4455_change_state(&s->port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+	mutex_unlock(&s->mutex);
+}
+
+static const struct uart_ops si4455_ops = {
+	.tx_empty		= si4455_tx_empty,
+	/*
+	 * set_mctrl: required by serial_core, but not used
+	 */
+	.set_mctrl		= si4455_set_mctrl,
+	.get_mctrl		= si4455_get_mctrl,
+	.stop_tx		= si4455_stop_tx,
+	.start_tx		= si4455_start_tx,
+	.stop_rx		= si4455_stop_rx,
+	.startup		= si4455_startup,
+	.shutdown		= si4455_shutdown,
+	.set_termios		= si4455_set_termios,
+	.type			= si4455_type,
+	.config_port		= si4455_config_port,
+	.verify_port		= si4455_verify_port,
+};
+
+static void si4455_debugfs_init(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	struct dentry *dbgfs_si_dir;
+	struct dentry *dbgfs_partinfo_dir;
+
+	s->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
+
+	dbgfs_si_dir = debugfs_create_dir("si4455", s->dbgfs_dir);
+
+	debugfs_create_u32("cts_error_count", 0444, dbgfs_si_dir,
+			   &s->cts_error_count);
+
+	debugfs_create_u32("tx_error_count", 0444, dbgfs_si_dir,
+			   &s->tx_error_count);
+
+	dbgfs_partinfo_dir = debugfs_create_dir("partinfo", dbgfs_si_dir);
+
+	debugfs_create_u8("chip_rev", 0444, dbgfs_partinfo_dir,
+			  &s->part_info.chip_rev);
+
+	debugfs_create_u8("rom_id", 0444, dbgfs_partinfo_dir,
+			  &s->part_info.rom_id);
+
+	debugfs_create_u16("part", 0444, dbgfs_partinfo_dir,
+			   &s->part_info.part);
+}
+
+static void si4455_debugfs_clear(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	debugfs_remove_recursive(s->dbgfs_dir);
+}
+
+static int __maybe_unused si4455_suspend(struct device *dev)
+{
+	int ret;
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	mutex_lock(&s->mutex);
+	ret = si4455_cancel_tx(&s->port);
+	if (ret) {
+		mutex_unlock(&s->mutex);
+		dev_err(dev, "%s: si4455_cancel_tx error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = si4455_change_state(&s->port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+	s->suspended = !ret;
+	mutex_unlock(&s->mutex);
+
+	if (ret) {
+		dev_err(dev, "%s: si4455_change_state error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return uart_suspend_port(&si4455_uart, &s->port);
+}
+
+static int __maybe_unused si4455_resume(struct device *dev)
+{
+	int ret;
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	ret = uart_resume_port(&si4455_uart, &s->port);
+	if (ret) {
+		dev_err(dev, "%s: uart_resume_port error (%i)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	s->suspended = false;
+	s->rx_stopped = false;
+
+	return si4455_do_work(&s->port);
+}
+
+static SIMPLE_DEV_PM_OPS(si4455_pm_ops, si4455_suspend, si4455_resume);
+
+static ssize_t package_size_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", s->package_size);
+}
+
+static ssize_t package_size_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > SI4455_FIFO_SIZE)
+		return -EINVAL;
+
+	s->package_size = val;
+	ret = si4455_do_work(&s->port);
+
+	return ret ? ret : count;
+}
+
+/*
+ * package_size: rw sysfs entry.
+ * Sets or returns the package size.
+ * The new value applied immediately.
+ * Variable package size (package_size == 0)
+ * currently not supported by driver.
+ */
+static DEVICE_ATTR_RW(package_size);
+
+static ssize_t rx_channel_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", s->rx_channel);
+}
+
+static ssize_t rx_channel_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	s->rx_channel = val;
+	ret = si4455_do_work(&s->port);
+
+	return ret ? ret : count;
+}
+
+/*
+ * rx_channel: rw sysfs entry.
+ * Sets or returns the receive channel index.
+ * The new value applied immediately.
+ */
+static DEVICE_ATTR_RW(rx_channel);
+
+static ssize_t tx_channel_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", s->tx_channel);
+}
+
+static ssize_t tx_channel_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	s->tx_channel = val;
+	ret = si4455_do_work(&s->port);
+
+	return ret ? ret : count;
+}
+
+/*
+ * tx_channel: rw sysfs entry.
+ * Sets or returns the transmit channel index.
+ * The new value will be used on next data transmit.
+ */
+static DEVICE_ATTR_RW(tx_channel);
+
+static ssize_t tx_timeout_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", s->tx_wd_timeout);
+}
+
+static ssize_t tx_timeout_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	s->tx_wd_timeout = val;
+	ret = si4455_do_work(&s->port);
+
+	return ret ? ret : count;
+}
+
+/*
+ * tx_timeout: rw sysfs entry.
+ * Sets or returns the transmit timeout.
+ * The new value will be used on next data transmit.
+ */
+static DEVICE_ATTR_RW(tx_timeout);
+
+static ssize_t current_rssi_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", s->current_rssi);
+}
+
+/*
+ * current_rssi: ro sysfs entry.
+ * Returns the latest rssi value measured by chip.
+ */
+static DEVICE_ATTR_RO(current_rssi);
+
+static struct attribute *si4455_attributes[] = {
+	&dev_attr_package_size.attr,
+	&dev_attr_rx_channel.attr,
+	&dev_attr_tx_channel.attr,
+	&dev_attr_tx_timeout.attr,
+	&dev_attr_current_rssi.attr,
+	NULL
+};
+
+static const struct attribute_group si4455_attr_group = {
+	.attrs = si4455_attributes,
+};
+
+static int si4455_probe(struct device *dev,
+			int irq)
+{
+	int ret;
+	struct si4455_port *s;
+	const void *of_ptr;
+	const struct firmware *ez_fw = NULL;
+	int line;
+
+	/* Alloc port structure */
+	s = devm_kzalloc(dev, sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, s);
+	mutex_init(&s->mutex);
+
+	/* Alloc port line */
+	line = find_first_zero_bit(si4455_port_lines, SI4455_UART_NRMAX);
+	if (line == SI4455_UART_NRMAX) {
+		dev_err(dev, "Unable to reguest port line index\n");
+		ret = -ERANGE;
+		goto out_generic;
+	}
+
+	s->shdn_gpio = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(s->shdn_gpio)) {
+		dev_err(dev, "Unable to reguest shdn gpio\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+
+	of_ptr = of_get_property(dev->of_node, "silabs,package-size", NULL);
+	if (IS_ERR_OR_NULL(of_ptr)) {
+		dev_err(dev, "dt silabs,package-size property not present\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+	s->package_size = be32_to_cpup(of_ptr);
+	if (s->package_size > SI4455_FIFO_SIZE) {
+		dev_err(dev, "dt silabs,package-size property maximum is %i\n", SI4455_FIFO_SIZE);
+		ret = -EINVAL;
+		goto out_generic;
+	}
+
+	of_ptr = of_get_property(dev->of_node, "silabs,tx-channel", NULL);
+	if (IS_ERR_OR_NULL(of_ptr)) {
+		dev_err(dev, "dt silabs,tx-channel property not present\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+	s->tx_channel = be32_to_cpup(of_ptr);
+
+	of_ptr = of_get_property(dev->of_node, "silabs,rx-channel", NULL);
+	if (IS_ERR_OR_NULL(of_ptr)) {
+		dev_err(dev, "dt silabs,rx-channel property not present\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+	s->rx_channel = be32_to_cpup(of_ptr);
+
+	of_ptr = of_get_property(dev->of_node, "silabs,tx-timeout-ms", NULL);
+	if (IS_ERR_OR_NULL(of_ptr)) {
+		s->tx_wd_timeout = 100;
+		dev_warn(dev, "dt silabs,tx-timeout-ms property not present\n");
+	} else {
+		s->tx_wd_timeout = be32_to_cpup(of_ptr);
+	}
+
+	of_ptr = of_get_property(dev->of_node, "firmware-name", NULL);
+	if (IS_ERR_OR_NULL(of_ptr)) {
+		dev_err(dev, "dt firmware-name property not present\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+	strncpy(s->ez_fw_name, of_ptr, sizeof(s->ez_fw_name) - 1);
+
+	/* Initialize port data */
+	s->port.dev		= dev;
+	s->port.line		= line;
+	s->port.irq		= irq;
+	s->port.type		= PORT_SI4455;
+	s->port.fifosize	= SI4455_FIFO_SIZE;
+	s->port.flags		= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	s->port.iotype		= UPIO_PORT;
+	s->port.iobase		= 1;
+	s->port.ops		= &si4455_ops;
+
+	si4455_s_power(dev, true);
+
+	ret = si4455_get_part_info(&s->port, &s->part_info);
+	dev_dbg(dev, "si4455_get_part_info() = %i\n", ret);
+	if (ret == 0) {
+		dev_info(dev, "partInfo.chip_rev = %u\n", s->part_info.chip_rev);
+		dev_info(dev, "partInfo.part = %u\n", s->part_info.part);
+		dev_info(dev, "partInfo.pbuild = %u\n", s->part_info.pbuild);
+		dev_info(dev, "partInfo.id = %u\n", s->part_info.id);
+		dev_info(dev, "partInfo.customer = %u\n", s->part_info.customer);
+		dev_info(dev, "partInfo.rom_id = %u\n", s->part_info.rom_id);
+		dev_info(dev, "partInfo.bond = %u\n", s->part_info.bond);
+		if (s->part_info.part != 0x5544) {
+			dev_err(dev, "unknown part(%u) error\n", s->part_info.part);
+			ret = -ENODEV;
+		}
+	}
+
+	if (ret)
+		goto out_generic;
+
+	ret = request_firmware(&ez_fw, s->ez_fw_name, dev);
+	if (ret) {
+		dev_err(dev, "firmware(%s) request error (%i)\n", s->ez_fw_name, ret);
+		ret = -EINVAL;
+		goto out_generic;
+	}
+
+	ret = si4455_re_configure(&s->port, ez_fw);
+	release_firmware(ez_fw);
+	if (ret) {
+		dev_err(dev, "device configuration error (%i)\n", ret);
+		ret = -EINVAL;
+		goto out_generic;
+	}
+
+	ret = si4455_change_state(&s->port, SI4455_CMD_CHANGE_STATE_STATE_SLEEP);
+	if (ret) {
+		dev_err(dev, "device change state error (%i)\n", ret);
+		goto out_generic;
+	}
+
+	/* Initialize queue for start TX */
+	INIT_WORK(&s->tx_work, si4455_tx_proc);
+	/* Initialize queue for start TX watchdog */
+	INIT_WORK(&s->tx_wd_work, si4455_tx_wd_proc);
+	/* Initialize queue for cts watchdog */
+	INIT_WORK(&s->cts_wd_work, si4455_cts_wd_proc);
+	/* Initialize timer for protecting and recovering tx_pending */
+	timer_setup(&s->tx_wd_timer, si4455_tx_wd_event, 0);
+	/* Initialize timer for recovering interface */
+	timer_setup(&s->cts_wd_timer, si4455_cts_wd_event, 0);
+
+	/* Register port */
+	ret = uart_add_one_port(&si4455_uart, &s->port);
+	if (ret) {
+		s->port.dev = NULL;
+		goto out_uart;
+	}
+
+	set_bit(line, si4455_port_lines);
+	s->port.line = line;
+
+	ret = sysfs_create_group(&dev->kobj, &si4455_attr_group);
+	if (ret) {
+		dev_err(dev, "sysfs_create_group error (%i)\n", ret);
+		goto out_uart;
+	}
+
+	si4455_debugfs_init(dev);
+
+	/* Setup interrupt */
+	ret = devm_request_threaded_irq(dev, irq, NULL, si4455_ist,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(dev), s);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	sysfs_remove_group(&dev->kobj, &si4455_attr_group);
+
+out_uart:
+	uart_remove_one_port(&si4455_uart, &s->port);
+	clear_bit(line, si4455_port_lines);
+out_generic:
+	mutex_destroy(&s->mutex);
+	si4455_s_power(dev, false);
+
+	return ret;
+}
+
+static int si4455_remove(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+	int line = s->port.line;
+
+	cancel_work_sync(&s->tx_work);
+	sysfs_remove_group(&dev->kobj, &si4455_attr_group);
+	si4455_debugfs_clear(dev);
+	uart_remove_one_port(&si4455_uart, &s->port);
+	mutex_destroy(&s->mutex);
+	clear_bit(line, si4455_port_lines);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused si4455_dt_ids[] = {
+	{ .compatible = "silabs,si4455" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, si4455_dt_ids);
+
+static int si4455_spi_probe(struct spi_device *spi)
+{
+	int ret;
+	const struct of_device_id *of_id;
+
+	/* Setup SPI bus */
+	spi->bits_per_word	= 8;
+	spi->mode		= SPI_MODE_0;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	if (spi->dev.of_node) {
+		of_id = of_match_device(si4455_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
+	}
+
+	mutex_lock(&si4455_ports_lock);
+	ret = si4455_probe(&spi->dev, spi->irq);
+	mutex_unlock(&si4455_ports_lock);
+	return ret;
+}
+
+static int si4455_spi_remove(struct spi_device *spi)
+{
+	int ret;
+
+	mutex_lock(&si4455_ports_lock);
+	ret = si4455_remove(&spi->dev);
+	mutex_unlock(&si4455_ports_lock);
+	return ret;
+}
+
+static struct spi_driver si4455_spi_driver = {
+	.driver = {
+		.name		= SI4455_NAME,
+		.of_match_table	= of_match_ptr(si4455_dt_ids),
+		.pm		= &si4455_pm_ops,
+	},
+	.probe			= si4455_spi_probe,
+	.remove			= si4455_spi_remove,
+};
+
+static int __init si4455_uart_init(void)
+{
+	int ret;
+
+	bitmap_zero(si4455_port_lines, SI4455_UART_NRMAX);
+
+	ret = uart_register_driver(&si4455_uart);
+	if (ret)
+		return ret;
+
+	return spi_register_driver(&si4455_spi_driver);
+}
+module_init(si4455_uart_init);
+
+static void __exit si4455_uart_exit(void)
+{
+	spi_unregister_driver(&si4455_spi_driver);
+	uart_unregister_driver(&si4455_uart);
+}
+module_exit(si4455_uart_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
+MODULE_DESCRIPTION("Si4455 serial driver");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 851b982f8c4b..943c5e2e27fc 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -279,4 +279,7 @@
 /* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
+/* Silicon Labs SI4455 */
+#define PORT_SI4455     123
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.17.1

