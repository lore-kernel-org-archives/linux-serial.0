Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72D38330A;
	Mon, 22 Jun 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135244; cv=none; b=S3aE76rp5IHW0Z6ou9tFV5yaoVPQ9wuveh3LhjMy+KwRze215AgzsNZZz4F5/1jQqxVpT1HCp8z0SiqksOrTfm36xq9oVIj6+IId9ia9AQuoIToFSTRj6pqj4uRLMSjiW2ujhsYbr60yQEIOUz6lz9B5d6Z1UMWCA+UT8nwL04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135244; c=relaxed/simple;
	bh=Ypwzn9pgKOg2W8YndKRq/0nK52RNBJLV9nx5YrKKb88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fU+XTIgZRpf62RwFCgvWOFWQci1ZN7wVlZnoIPd8AvYnFzREwqSFl1ta6j8Gj0IYGtK6APyrwdeRETcR8smiBC6K796LNtUQ54VVH2HkVdwUTVJQxjvvNCPhFiWsdynQTyY00VBehNJZC7amfpuPjH72QtwFZD1WqjPsePDqkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OzHp5hIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OzHp5hIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F51F000E9;
	Mon, 22 Jun 2026 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782135242;
	bh=vZqEo84B3WcnL0bcoWMRAfG1DzXLsFux97jLV/5oR7s=;
	h=Date:From:To:Cc:Subject;
	b=OzHp5hIz3ksD8fpzsCS2Izj+1tEx3GKHzazOSmqBP56Q5NMGOH8eaWRpMFUWHpq4U
	 Uo+920mwalHArtOOz7zTooOOjJz9IRiY3BFEDe5uMpKpgs/7But6J3BjsRLAbQXps7
	 Dzjl8iImTbJ6NdFiIVybXTG4unGSfUAbaQvaJ0UM=
Date: Mon, 22 Jun 2026 15:34:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 7.2-rc1
Message-ID: <ajk5yWaG2fa05hcZ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc1

for you to fetch changes up to 426e83cab1f5d53069ac7030cb03e2d7c6367ef1:

  serial: 8250_pci: Don't specify conflicting values to pci_device_id members (2026-06-12 11:55:41 +0200)

----------------------------------------------------------------
TTY / Serial driver update for 7.2-rc1

Here is the big set of TTY and Serial driver updates for 7.2-rc1.
Overall we end up removing more code than added, due to an obsolete
synclink_gt driver being removed from the tree, always a nice thing to
see happen.

Other than that driver removal, major things included in here are:
  - max310x serial driver updates and fixes
  - 8250 driver updates and rework in places to make it more "modern"
  - dts file updates
  - serial driver core tweaks and updates
  - vt code cleanups
  - vc_screen crash fixes
  - other minor driver updates and cleanups

All of these have been in linux-next for well over a week with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akash Sukhavasi (1):
      dt-bindings: serial: rs485: remove deprecated .txt binding stub

Aniket Randive (1):
      serial: qcom-geni: Avoid probing debug console UART without console support

Deepti Jaggi (1):
      dt-bindings: serial: Add compatible for Qualcomm SA8797P SoC

Ethan Nelson-Moore (1):
      tty: synclink_gt: remove broken driver

Geert Uytterhoeven (1):
      serial: sh-sci: Remove plat_sci_port.flags

Greg Kroah-Hartman (1):
      Merge tag 'v7.1-rc6' into tty-next

Hugo Villeneuve (16):
      serial: icom: remove check for zero baud rate from uart_get_baud_rate()
      serial: apbuart: remove check for zero baud rate from uart_get_baud_rate()
      serial: core: update uart_get_baud_rate() obsolete comments
      serial: core: simplify clipping logic in uart_get_baud_rate()
      serial: core: prevent division by zero by always returning non-zero baud rate
      serial: max310x: uniformize clock/freq types
      serial: max310x: simplify max310x_update_best_err()
      serial: max310x: change return type of max310x_set_ref_clk()
      serial: max310x: update baudrate comments for err calculation
      serial: max310x: improve max310x_set_ref_clk() efficiency
      serial: max310x: use regmap_read_poll_timeout() for busy wait
      serial: max310x: use FIELD_PREP macro to set PLL bitfields
      serial: max310x: allow driver to be built with SPI or I2C
      serial: max310x: move variables to while() scope
      serial: max310x: add comments for PLL limits
      serial: max310x: fix compile errors if CONFIG_SPI_MASTER is disabled

Jia Wang (4):
      serial: 8250_dwlib: move DesignWare register definitions to header
      serial: 8250_dw: build Renesas RZN1 CPR value from DW_UART_CPR_* definitions
      dt-bindings: serial: snps-dw-apb-uart: Add UltraRISC DP1000 UART
      serial: 8250_dw: Use a fixed CPR value for UltraRISC DP1000 UART

John Ogness (5):
      serial: core: Add dedicated uart_port field for console flow
      serial: Replace driver usage of UPF_CONS_FLOW
      serial: 8250: Set cons_flow on port registration
      serial: 8250: Check LSR timeout on console flow control
      serial: 8250: Add support for console flow control

Krzysztof Kozlowski (1):
      serial: qcom: Unify user-visible "Qualcomm" name

Manuel Lauss (1):
      serial: 8250_port: recognize UPIO_AU

Marco Felsch (1):
      serial: 8250: fix possible ISR soft lockup

Nicolas Pitre (1):
      vt: merge ucs_is_zero_width()/ucs_is_double_width() into ucs_get_width()

Nikola Z. Ivanov (1):
      serial: mxs-auart: replace hardcoded 1 with predefined macro GPIO_LINE_DIRECTION_IN

Praveen Talari (1):
      serial: qcom-geni: trace: Add tracepoint support for Qualcomm GENI serial

Stefan Dösinger (1):
      amba/serial: amba-pl011: Bring back zx29 UART support

Stepan Ionichev (3):
      tty: serial: 8250: protect against NULL uart->port.dev in register
      serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
      serial: 8250_dw: remove clock-notifier infrastructure

Uwe Kleine-König (The Capable Hub) (4):
      serial: 8250_pci: Consistently define pci_device_ids using named initializers
      serial: jsm: Drop unused driver_data assigment and redundant zeros
      tty: serial: Use named initializers for arrays of i2c_device_data
      serial: 8250_pci: Don't specify conflicting values to pci_device_id members

Viken Dadhaniya (1):
      serial: qcom_geni: Fix RX DMA stall when SE_DMA_RX_LEN_IN is zero

Xianwei Zhao (2):
      dt-bindings: arm: amlogic: add A311Y3 support
      arm64: dts: add support for A9 based Amlogic BY401

Yi Yang (1):
      vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write

Zhiyong Tao (1):
      serial: 8250_mtk: Add ACPI support

 Documentation/devicetree/bindings/arm/amlogic.yaml |    6 +
 .../bindings/serial/qcom,sa8255p-geni-uart.yaml    |   13 +-
 Documentation/devicetree/bindings/serial/rs485.txt |    1 -
 .../bindings/serial/snps-dw-apb-uart.yaml          |    1 +
 Documentation/driver-api/serial/serial-rs485.rst   |    2 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 arch/arm64/boot/dts/amlogic/Makefile               |    1 +
 .../boot/dts/amlogic/amlogic-a9-a311y3-by401.dts   |   40 +
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        |  128 +
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 drivers/net/ppp/Kconfig                            |    4 +-
 drivers/tty/Kconfig                                |   11 +-
 drivers/tty/Makefile                               |    1 -
 drivers/tty/n_hdlc.c                               |    7 -
 drivers/tty/serial/8250/8250_core.c                |    8 +-
 drivers/tty/serial/8250/8250_dw.c                  |  110 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   49 -
 drivers/tty/serial/8250/8250_dwlib.h               |   73 +
 drivers/tty/serial/8250/8250_mtk.c                 |   23 +-
 drivers/tty/serial/8250/8250_pci.c                 | 3120 ++++++------
 drivers/tty/serial/8250/8250_port.c                |   30 +-
 drivers/tty/serial/Kconfig                         |    6 +-
 drivers/tty/serial/amba-pl011.c                    |   42 +
 drivers/tty/serial/apbuart.c                       |    2 -
 drivers/tty/serial/bcm63xx_uart.c                  |    2 +-
 drivers/tty/serial/icom.c                          |    2 -
 drivers/tty/serial/jsm/jsm_driver.c                |   38 +-
 drivers/tty/serial/max310x.c                       |  235 +-
 drivers/tty/serial/mxs-auart.c                     |    2 +-
 drivers/tty/serial/omap-serial.c                   |    2 +-
 drivers/tty/serial/pch_uart.c                      |    2 +-
 drivers/tty/serial/pxa.c                           |    2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   29 +-
 drivers/tty/serial/samsung_tty.c                   |    8 +-
 drivers/tty/serial/sc16is7xx_i2c.c                 |   14 +-
 drivers/tty/serial/serial_core.c                   |   57 +-
 drivers/tty/serial/serial_txx9.c                   |    4 +-
 drivers/tty/serial/sh-sci.c                        |    2 +-
 drivers/tty/serial/sunsu.c                         |    2 +-
 drivers/tty/synclink_gt.c                          | 5038 --------------------
 drivers/tty/vt/gen_ucs_width_table.py              |  119 +-
 drivers/tty/vt/ucs.c                               |  174 +-
 drivers/tty/vt/ucs_width_table.h_shipped           |  919 ++--
 drivers/tty/vt/vc_screen.c                         |    2 +-
 drivers/tty/vt/vt.c                                |   11 +-
 include/linux/consolemap.h                         |   12 +-
 include/linux/serial_core.h                        |   20 +
 include/linux/serial_sci.h                         |    1 -
 include/linux/synclink.h                           |   37 -
 include/trace/events/qcom_geni_serial.h            |  164 +
 include/uapi/linux/synclink.h                      |  301 --
 51 files changed, 3027 insertions(+), 7852 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
 delete mode 100644 drivers/tty/synclink_gt.c
 delete mode 100644 include/linux/synclink.h
 create mode 100644 include/trace/events/qcom_geni_serial.h
 delete mode 100644 include/uapi/linux/synclink.h
