Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129875808;
	Fri, 19 Jul 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391931; cv=none; b=FRy9WaR3NH8rPaxJgk6hPncDZksfOjkazDRfAr+xNhXI7TXpG0YBCzDt6Ssl4yGg7379CmubzimeS30z9BrOssA20Pw2PGXTU3QtQNDAwtVW7zJVSJkXxWnGQ5aJqwv4TD8SS40aPapeKgXPc1nu3Jnj+xrXVeyL6+yv5TKgTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391931; c=relaxed/simple;
	bh=Xk2qDeqcxb0wEjPMTrR4IbGZzakWRpKrs+ppoypfJC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hh7A0Zk27ApB4scTKQfN6wnOAYe9+sbtv7PArhy8P78qxWTMvqPp1BLw9tTJZrdNmr48LWDDzQ/SzLVdraK97wVgMpMOeDt1pRdtSoQrWNiiGHkG/kg1/4Li41AyMHDYpj+bX6KsJvG2fC56usucNl6GBsKGSvbOLyx7X3ABbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2JVZkk+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2JVZkk+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A475C32782;
	Fri, 19 Jul 2024 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721391931;
	bh=Xk2qDeqcxb0wEjPMTrR4IbGZzakWRpKrs+ppoypfJC4=;
	h=Date:From:To:Cc:Subject:From;
	b=2JVZkk+piCr5Hy4lQiBRgeqPkoY99eX8V5TXgz4wxqzt4Uy893czBUW1pfZMSxhk2
	 lszD11sEvIu9K+82u5ho3kOLsDHjVCwuQ2EKQRRxwQ9sHUbRNsLznS6P1jAJZGsEIZ
	 Ww0emMdGy3ICEvrnjM0JZvYyh+BmRoONumhmFX2U=
Date: Fri, 19 Jul 2024 14:25:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver changes for 6.11-rc1
Message-ID: <ZppbNwwYDV4y0Leg@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc1

for you to fetch changes up to 17199dfccd4b7f7e0c059ef43bef6e0078423476:

  Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports (2024-07-04 15:41:44 +0200)

----------------------------------------------------------------
TTY/Serial updates for 6.11-rc1

Here is a small set of tty and serial driver updates for 6.11-rc1.  Not
much happened this cycle, unlike the previous kernel release which had
lots of "excitement" in this part of the kernel.  Included in here are
the following changes:
  - dt binding updates for new platforms
  - 8250 driver updates
  - various small serial driver fixes and updates
  - printk/console naming and matching attempt #2 (was reverted for
    6.10-final, should be good to go this time around, acked by the
    relevant maintainers).

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (3):
      serial: 8250: Extract RSA bits
      serial: 8250: Extract platform driver
      serial: 8250_platform: Explicitly show we initialise ISA ports only once

Greg Kroah-Hartman (2):
      Merge tag 'v6.10-rc4' into tty-next
      Merge 6.10-rc6 into tty-next

Hal Feng (3):
      dt-bindings: serial: snps-dw-apb-uart: Add one more reset signal for StarFive JH7110 SoC
      serial: 8250_dw: Use reset array API to get resets
      riscv: dts: starfive: jh7110: Add the core reset and jh7110 compatible for uarts

Hans de Goede (1):
      vt: keyboard: Use led_set_brightness() in LED trigger activate() callback

Hui Wang (2):
      dt-bindings: serial: sc16is7xx: add reset-gpios
      serial: sc16is7xx: hardware reset chip if reset-gpios is defined in DT

Jeff Johnson (1):
      tty: add missing MODULE_DESCRIPTION() macros

Kanak Shilledar (1):
      dt-bindings: serial: vt8500-uart: convert to json-schema

Lad Prabhakar (5):
      dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
      dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
      dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as required
      dt-bindings: serial: Add documentation for Renesas RZ/V2H(P) (R9A09G057) SCIF support
      serial: sh-sci: Add support for RZ/V2H(P) SoC

Rafał Miłecki (1):
      dt-bindings: serial: mediatek,uart: add MT7988

Rasmus Villemoes (1):
      serial: imx: stop casting struct uart_port to struct imx_port

Shresth Prasad (1):
      tty: sunsu: Simplify device_node cleanup by using __free

Tony Lindgren (3):
      printk: Add match_devname_and_update_preferred_console()
      serial: core: Add serial_base_match_and_update_preferred_console()
      Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports

 Documentation/admin-guide/kernel-parameters.txt    |  19 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml  |   5 +
 .../devicetree/bindings/serial/renesas,scif.yaml   | 136 ++++--
 .../bindings/serial/snps-dw-apb-uart.yaml          |  18 +-
 .../bindings/serial/via,vt8500-uart.yaml           |  46 +++
 .../devicetree/bindings/serial/vt8500-uart.txt     |  27 --
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |  30 +-
 drivers/tty/amiserial.c                            |   1 +
 drivers/tty/goldfish.c                             |   1 +
 drivers/tty/n_gsm.c                                |   1 +
 drivers/tty/n_hdlc.c                               |   1 +
 drivers/tty/serial/8250/8250.h                     |  29 +-
 drivers/tty/serial/8250/8250_core.c                | 460 +--------------------
 drivers/tty/serial/8250/8250_dw.c                  |   2 +-
 drivers/tty/serial/8250/8250_parisc.c              |   1 +
 drivers/tty/serial/8250/8250_pcilib.c              |   1 +
 drivers/tty/serial/8250/8250_platform.c            | 337 +++++++++++++++
 drivers/tty/serial/8250/8250_port.c                |   1 +
 drivers/tty/serial/8250/8250_pxa.c                 |   1 +
 drivers/tty/serial/8250/8250_rsa.c                 | 133 ++++++
 drivers/tty/serial/8250/Makefile                   |   6 +-
 drivers/tty/serial/8250/serial_cs.c                |   1 +
 drivers/tty/serial/esp32_acm.c                     |   1 +
 drivers/tty/serial/esp32_uart.c                    |   1 +
 drivers/tty/serial/imx.c                           |  41 +-
 drivers/tty/serial/owl-uart.c                      |   1 +
 drivers/tty/serial/sc16is7xx.c                     |  31 +-
 drivers/tty/serial/serial_base.h                   |  16 +
 drivers/tty/serial/serial_base_bus.c               |  37 ++
 drivers/tty/serial/serial_core.c                   |   4 +
 drivers/tty/serial/serial_mctrl_gpio.c             |   1 +
 drivers/tty/serial/sh-sci.c                        |  55 ++-
 drivers/tty/serial/sunsu.c                         |  37 +-
 drivers/tty/synclink_gt.c                          |   1 +
 drivers/tty/ttynull.c                              |   1 +
 drivers/tty/vt/keyboard.c                          |   4 +-
 include/linux/printk.h                             |   4 +
 include/linux/serial_sci.h                         |   1 +
 kernel/printk/console_cmdline.h                    |   1 +
 kernel/printk/printk.c                             | 103 ++++-
 41 files changed, 1000 insertions(+), 598 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_platform.c
 create mode 100644 drivers/tty/serial/8250/8250_rsa.c
