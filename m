Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05BBE40;
	Tue, 28 Jan 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074087; cv=none; b=bgFcKIm7FYqLYcSSokbt4BXp4h8XYhoNTaJENwuFT+NZ53Id8V5WggjsC0YHKvCFin/j0XO4yzG8kTjxPsgso6k647YRuHQmn4JCIxHmdu3l7z35v38QvnskvhUpS057hC/u8sUWg8tvLG18YY224piTjxs9MPNTCW1bm9OpQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074087; c=relaxed/simple;
	bh=fxw41tcVhdqYR06ThXCAz4/Ju4HXjWw4W2ozlqWi3sc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gXlN4CMQOFOmGGd34pjVQHo9WmY8aEWxl0isSwuoY9qHexPGw8x4F0gj8nvEl3SCHSJmXIv8HATkrqR9usEvsVlZuc35hHslUCPxsVYlz28mSLPTM5PbAlEDmzwYfPg2cZmwVdwEe3IMwRZxCK+kPW6rchL1F5sHv//htz1qQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0k3DIz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0k3DIz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2965C4CED3;
	Tue, 28 Jan 2025 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738074087;
	bh=fxw41tcVhdqYR06ThXCAz4/Ju4HXjWw4W2ozlqWi3sc=;
	h=Date:From:To:Cc:Subject:From;
	b=h0k3DIz1M1nefV5c/NTjpenWXgaUsxZjHJB4iQF25sYyattcJTzWDXwNiC+EyTwpr
	 DwReadRdrtqOlvyPkj+zfLatfd6zsWR++ec1OMaS6Y9QX8LCtG74+IUi2wmjta6P0E
	 Yww0xmI+tH5ip6OZ/CzCwf0ff90/+U42d8iHKE4o=
Date: Tue, 28 Jan 2025 15:21:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver updates for 6.14-rc1
Message-ID: <Z5jn5M5bdV5u21GB@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 5bc55a333a2f7316b58edc7573e8e893f7acb532:

  Linux 6.13-rc7 (2025-01-12 14:37:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc1

for you to fetch changes up to f79b163c42314a1f46f4bcc40a19c8a75cf1e7a3:

  Revert "serial: 8250: Switch to nbcon console" (2025-01-22 10:35:56 +0100)

----------------------------------------------------------------
TTY / Serial driver updates for 6.14-rc1

Here is the tty/serial driver set of changes for 6.14-rc1.  Nothing
major in here, it was delayed a bit due to a regression found in
linux-next which has now been reverted and verified that it is fixed.
Other than the reverts, highlights include:
  - 8250 work to get the nbcon mode working (partially reverted)
  - altera_jtaguart minor fixes
  - fsl_lpuart minor updates
  - sh-sci driver minor updatesa
  - other tiny driver updates and cleanups

All of these have been in linux-next for a while, and now with no
reports of problems (thanks to the reverts.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andre Werner (2):
      dt-bindings: serial: sc16is7xx: Add description for polling mode
      serial: sc16is7xx: Add polling mode if no IRQ pin is available

Andy Shevchenko (3):
      serial: 8250_port: Assign UPIO_UNKNOWN instead of its direct value
      serial: 8250_pci: Resolve WCH vendor ID ambiguity
      serial: 8250_pci: Share WCH IDs with parport_serial driver

Biju Das (1):
      dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif

Claudiu Beznea (5):
      serial: sh-sci: Drop __initdata macro for port_cfg
      serial: sh-sci: Move runtime PM enable to sci_probe_single()
      serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit
      serial: sh-sci: Increment the runtime usage counter for the earlycon device

Dr. David Alan Gilbert (1):
      serial: kgdb_nmi: Remove unused knock code

Geert Uytterhoeven (1):
      serial: sh-sci: Use plain struct copy in early_console_setup()

Greg Kroah-Hartman (4):
      Merge 6.13-rc3 into tty-next
      Merge 6.13-rc7 into tty-next
      Revert "serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()""
      Revert "serial: 8250: Switch to nbcon console"

Günther Noack (1):
      tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN

Ivaylo Dimitrov (2):
      tty: n_gsm: wait until channel 0 is ready
      tty: n_gsm: Fix control dlci ADM mode processing

Jiri Slaby (SUSE) (4):
      tty: serial_core: use more guard(mutex)
      tty: serial: get rid of exit label from uart_set_info()
      tty: serial: extract uart_change_port() from uart_set_info()
      tty: mips_ejtag_fdc: fix one more u8 warning

John Ogness (10):
      serial: 8250: Use @ier bits to determine if Rx is stopped
      serial: 8250: Do not set UART_LSR_THRE in @read_status_mask
      serial: 8250: Never adjust UART_LSR_DR in @read_status_mask
      serial: 8250: Explain the role of @read_status_mask
      serial: 8250: Adjust the timeout for FIFO mode
      serial: 8250: Use frame time to determine timeout
      serial: 8250: Use high-level writing function for FIFO
      serial: 8250: Provide flag for IER toggling for RS485
      serial: 8250: Switch to nbcon console
      serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"

Miroslav Ondra (1):
      serial: amba-pl011: Fix RTS handling in RS485 mode

Rengarajan S (1):
      8250: microchip: pci1xxxx: Add workaround for RTS bit toggle

Ricardo B. Marliere (1):
      tty: Make sysctl table const

Rob Herring (Arm) (1):
      tty: atmel_serial: Use of_property_present() for non-boolean properties

Robert Marko (1):
      tty: serial: atmel: make it selectable for ARCH_LAN969X

Sean Anderson (1):
      tty: xilinx_uartps: split sysrq handling

Sherry Sun (2):
      tty: serial: fsl_lpuart: increase maximum uart_nr to 12
      tty: serial: fsl_lpuart: flush RX and TX FIFO when lpuart shutdown

Tobias Klauser (3):
      serial: altera_jtaguart: Use device name when requesting IRQ
      serial: altera_jtaguart: Use KBUILD_MODNAME
      serial: altera_uart: Use KBUILD_MODNAME

Zhu Jun (1):
      serial: mpc52xx: Fix typo in mpc52xx_uart.c

 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml  |   3 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |   5 +
 drivers/parport/parport_serial.c                   |  12 +-
 drivers/tty/mips_ejtag_fdc.c                       |   4 +-
 drivers/tty/n_gsm.c                                |  39 ++-
 drivers/tty/serial/8250/8250.h                     |   4 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   4 +-
 drivers/tty/serial/8250/8250_core.c                |   1 -
 drivers/tty/serial/8250/8250_omap.c                |  11 +-
 drivers/tty/serial/8250/8250_pci.c                 |  76 +++---
 drivers/tty/serial/8250/8250_pci1xxxx.c            |  60 ++++-
 drivers/tty/serial/8250/8250_port.c                |  97 +++++---
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/altera_jtaguart.c               |  10 +-
 drivers/tty/serial/altera_uart.c                   |   7 +-
 drivers/tty/serial/amba-pl011.c                    | 126 +++++++---
 drivers/tty/serial/atmel_serial.c                  |  18 +-
 drivers/tty/serial/fsl_lpuart.c                    |   7 +-
 drivers/tty/serial/kgdb_nmi.c                      | 101 --------
 drivers/tty/serial/mpc52xx_uart.c                  |   2 +-
 drivers/tty/serial/sc16is7xx.c                     |  37 +++
 drivers/tty/serial/serial_core.c                   | 263 +++++++++------------
 drivers/tty/serial/sh-sci.c                        |  95 ++++++--
 drivers/tty/serial/xilinx_uartps.c                 |   8 +-
 drivers/tty/tty_io.c                               |   2 +-
 drivers/tty/vt/selection.c                         |  14 ++
 drivers/tty/vt/vt.c                                |   2 -
 include/linux/kgdb.h                               |   2 -
 include/linux/pci_ids.h                            |  11 +
 include/linux/serial_8250.h                        |   4 +-
 30 files changed, 593 insertions(+), 434 deletions(-)
