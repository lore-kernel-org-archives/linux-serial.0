Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F92149E1D;
	Sun, 30 Jun 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756731; cv=none; b=nanDI37iS5up5AfkXU4PQz4JhxfghZbfDH9W7K6Ff0CzESxLtMhEcqGVJoef3JpvDs2SlexZjxvGfoTociPpl3I4BtVGsrVUkzK4BmzJ6KEtKB48FEAzS0VxgTdaLAXhO6H+PXtLoMMu+otYDd4O55q3pKcXx8cxFT4w9yEKNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756731; c=relaxed/simple;
	bh=Sw7Xxp9857TGCrUX14kXY/yWAwS58JTrKb5Jy7LKf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=txlDfiknKJYceKuSydlb4cUND7Vd0vwRGtxCNiV+nJo+/Ika5DtaeoXSNC49RQKjXAf/gZSvVU2DT4jj38ZgiCpbrkFJy865jf3JCEuEFycCYVYCTyGx58R9Ep4pMd6nc2sWFs3N35XtLWGipdPWRfPZR/4JEDuQxsi2r9eBduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWgGAAqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWgGAAqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19387C2BD10;
	Sun, 30 Jun 2024 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719756729;
	bh=Sw7Xxp9857TGCrUX14kXY/yWAwS58JTrKb5Jy7LKf0A=;
	h=Date:From:To:Cc:Subject:From;
	b=MWgGAAqc/sPp2gTV5pO5MUXochNZJbyUlBwQe3LJvlBHco5vqGmY56f4hGzrvqG/n
	 DZ4Rn1dgsry2cy5gh0eCKubpxY/xYWeZ1ASkcKr8vxwPGmEQI/7it4fkbQi6HSoINg
	 3ppyxZI34c7WHXIBrFpruwlxlQmshPzKj+ynnbqE=
Date: Sun, 30 Jun 2024 16:12:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.10-rc6
Message-ID: <ZoFnsuNJy_Fz8_qE@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc6

for you to fetch changes up to cc8d5a2f09a54405321769abfd6ec3395482336a:

  Revert "printk: Save console options for add_preferred_console_match()" (2024-06-25 07:58:10 +0200)

----------------------------------------------------------------
TTY/Serial/Console fixes for 6.10-rc6

Here are a bunch of fixes/reverts for 6.10-rc6.  Include in here are:
  - revert the bunch of tty/serial/console changes that landed in -rc1
    that didn't quite work properly yet.  Everyone agreed to just revert
    them for now and will work on making them better for a future
    release instead of trying to quick fix the existing changes this
    late in the release cycle
  - 8250 driver port count bugfix
  - Other tiny serial port bugfixes for reported issues

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Crescent Hsieh (1):
      tty: serial: 8250: Fix port count mismatch with the device

Doug Brown (1):
      Revert "serial: core: only stop transmit when HW fifo is empty"

Greg Kroah-Hartman (9):
      Revert "serial: core: Fix ifdef for serial base console functions"
      Revert "serial: 8250: Fix add preferred console for serial8250_isa_init_ports()"
      Revert "Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports"
      Revert "serial: 8250: Add preferred console in serial8250_isa_init_ports()"
      Revert "serial: core: Handle serial console options"
      Revert "serial: core: Add support for DEVNAME:0.0 style naming for kernel console"
      Revert "printk: Flag register_console() if console is set on command line"
      Revert "printk: Don't try to parse DEVNAME:0.0 console options"
      Revert "printk: Save console options for add_preferred_console_match()"

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jonas Gorski (2):
      serial: core: introduce uart_port_tx_limited_flags()
      serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited()

Stefan Eichenberger (1):
      serial: imx: set receiver level before starting uart

Udit Kumar (1):
      serial: 8250_omap: Implementation of Errata i2310

 Documentation/admin-guide/kernel-parameters.txt |  19 ---
 drivers/tty/serial/8250/8250_core.c             |   5 -
 drivers/tty/serial/8250/8250_omap.c             |  25 +++-
 drivers/tty/serial/8250/8250_pci.c              |  13 ++-
 drivers/tty/serial/bcm63xx_uart.c               |   7 +-
 drivers/tty/serial/imx.c                        |   4 +-
 drivers/tty/serial/mcf.c                        |   2 +-
 drivers/tty/serial/serial_base.h                |  30 -----
 drivers/tty/serial/serial_base_bus.c            | 129 ---------------------
 drivers/tty/serial/serial_core.c                |   4 -
 include/linux/printk.h                          |   3 -
 include/linux/serial_core.h                     |  21 +++-
 kernel/printk/Makefile                          |   2 +-
 kernel/printk/conopt.c                          | 146 ------------------------
 kernel/printk/console_cmdline.h                 |   6 -
 kernel/printk/printk.c                          |  23 +---
 16 files changed, 65 insertions(+), 374 deletions(-)
 delete mode 100644 kernel/printk/conopt.c
