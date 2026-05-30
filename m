Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5430FC1C;
	Sat, 30 May 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140619; cv=none; b=RUvSYYBTCtqPHQWSnZPPYVyEQpcrIT17EXvRtSuWu5ffafE9R5lZoL2Jyex9wKyrCO01DFm/ot/Ft1Jlv82nMFEKI/tS4+nmlB/rnStwGD78VhJhJPmDChLzx8qe9IrBAzPm4hdUNC3aNxsJckYN/8ADpLRF/4nYmEVbciWUuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140619; c=relaxed/simple;
	bh=7HRYOYPxDM7j1kWcXAui8q5mcCpIFm8acKjiuwLtkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p72pM+VIyqEu4wJ2kv9HTQf2W2OJH7C934KcV7OgiilruTjnS8Z7sg21rkBQxpF3+D7+W9vf7i3v2mYhbrLvQvafpcgO8pbFI6xDQ7XIoHFD7BhIMDDAk0WDgqqcPdx3ws8rqSB0x6DXoKD0jqESilTbqhVLRQT3Z/UEZ6m371g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zzFjlfo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zzFjlfo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0481F00893;
	Sat, 30 May 2026 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780140618;
	bh=lHxASgQmM9Knrt6CK0sxo6WG/MJes8qAM9NakiCgwLU=;
	h=Date:From:To:Cc:Subject;
	b=zzFjlfo1P8WdKPgF4mXLa8NzXCeJ0YQxKm6gok5wqMdhFSIvHshI1kezoW3DyHTli
	 c20InZHe/gXDgciKMPR/uc3RPGa9YuSwMv/Csxl95x4AJ8P/BM2sWZz5QB8jpG4Bmo
	 L2dMfSOSaeUcbCzpE0THtSUBrIsrHF70cwSdVR/Y=
Date: Sat, 30 May 2026 13:29:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.1-rc6
Message-ID: <ahrKEkbnYwF5TrRT@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc6

for you to fetch changes up to e4240d8845445d58b4b96f7066adfe175a61bd0c:

  serial: dz: Enable modular build (2026-05-22 11:52:34 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 7.1-rc6

Here are some small serial driver fixes for 7.1-rc6.  Included in here
are:
  - mips serial driver fixes to resolve some long-standing issues with
    how they interacted with the console.  That's the "majority" of the
    changes in this merge request
  - sh-sci driver regression fix
  - 8250 driver regression fixes
  - other small serial driver fixes for reported problems.

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Hongling Zeng (1):
      serial: sh-sci: fix memory region release in error path

Jacques Nilo (3):
      serial: core: introduce guard(uart_port_lock_check_sysrq_irqsave)
      serial: 8250: dispatch SysRq character in serial8250_handle_irq()
      serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()

Johan Hovold (1):
      tty: add missing tty_driver include to tty_port.h

Maciej W. Rozycki (8):
      serial: zs: Fix swapped RI/DSR modem line transition counting
      serial: dz: Fix bootconsole message clobbering at chip reset
      serial: dz: Fix bootconsole handover lockup
      serial: zs: Fix bootconsole handover lockup
      serial: zs: Switch to using channel reset
      serial: dz: Convert to use a platform device
      serial: zs: Convert to use a platform device
      serial: dz: Enable modular build

Myeonghun Pak (1):
      serial: altera_jtaguart: handle uart_add_one_port() failures

Prasanna S (1):
      serial: qcom-geni: fix UART_RX_PAR_EN bit position

Shitalkumar Gandhi (1):
      serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma

Tudor Ambarus (1):
      tty: serial: samsung: Remove redundant port lock acquisition in rx helpers

Viken Dadhaniya (1):
      serial: qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ

Zhaoyang Yu (1):
      tty: serial: pch_uart: add check for dma_alloc_coherent()

 arch/mips/dec/platform.c              | 109 ++++++++++++++++-
 drivers/tty/serial/8250/8250_dw.c     |   2 +-
 drivers/tty/serial/8250/8250_port.c   |   7 +-
 drivers/tty/serial/Kconfig            |   2 +-
 drivers/tty/serial/altera_jtaguart.c  |   7 +-
 drivers/tty/serial/dz.c               | 171 +++++++++++++-------------
 drivers/tty/serial/fsl_lpuart.c       |  15 ++-
 drivers/tty/serial/pch_uart.c         |  19 ++-
 drivers/tty/serial/qcom_geni_serial.c |  16 ++-
 drivers/tty/serial/samsung_tty.c      |   8 --
 drivers/tty/serial/sh-sci.c           |   2 +-
 drivers/tty/serial/zs.c               | 218 ++++++++++++----------------------
 drivers/tty/serial/zs.h               |   1 -
 include/linux/serial_core.h           |  12 ++
 include/linux/tty_port.h              |   2 +-
 15 files changed, 341 insertions(+), 250 deletions(-)
