Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90341D22C;
	Sat,  3 Oct 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791027505; cv=none; b=kQKp86oeXCmiBrL+0STzslaXZGWKAQYCt2RXyPLdDUyWPgbcMNj8URuHuhmNPqXn4Pnsmcf4AY1qQm9YbICl8JyG1Qi95EBQKlHLGOpxSE8Zz0CGoiae4bKrpbPKEwXh6hN9Qn+Mh8EhDg8S9y4ijU9Kryg0Y114nOV1ymKElGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791027505; c=relaxed/simple;
	bh=StFkqrc5IqwFNUW4WadP/+g0tKHJ4pprOwhM4gaoVdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PL36JmaHD3ir0XJJ9Wi4e66Fh5SKxzj85f2ClenEYZ/NS4rOdhSwFBbkb99A5zz+CNTGQTFTKyaN3GKDox/X0sI2H3ZojKYWp0Zh0mzbO4WKZH4h7Fv+7camQdyg2vPYUMz6w1+pXrZT7UAdRae3NELxf5nsQYIU5xJYPMfcjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwWr1h0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwWr1h0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB831F0089B;
	Sat,  3 Oct 2026 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791027503;
	bh=CeEO0mDvkeajrqdtznZXeKNZkf81XM4vMOdqSxEuJ88=;
	h=Date:From:To:Cc:Subject;
	b=KwWr1h0ZAYVfP5BOkVjVTkS0uqNOOE3dI9dEFikJsvFiMm2ANAnVlKAnIUZq037sP
	 aMdOw149ycpOjnxrtg7fFOR+2BMQXDBWbiVJKR3GmUlcjYO1XiHQRZ+aZ0ERI4fTtK
	 jE9e37FWjtxOIpIG3T58jp0nUuowdgsA7Kj+Pz+U=
Date: Sat, 3 Oct 2026 13:38:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 7.3-rc6
Message-ID: <asDpLAJTXzOrUdCX@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc6

for you to fetch changes up to 6c95ca52f27855dd2fb74131c8d4e8325d2af7de:

  tty: add missing driver flag kernel-doc colon (2026-10-02 11:15:22 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 7.3-rc6

Here are some small tty/serial driver fixes for 7.3-rc6.  Nothing major
here, just lots of small fixes for reported issues, some of them very
long-standing:
  - tty hangup fixes that have been there since the BKL days and kept
    tripping people up over time.
  - vt selection bugfix
  - other vt bugfixes (memory leaks and screen update fixes)
  - n_gsm bugfix
  - qcom-geni serial driver bugfix
  - 8250 serial driver bugfixes
  - other tiny serial driver fixes

All of these have been in linux-next, the last few only a few days but
testing here seems solid (this pull request was generated on that tree)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (1):
      serial: qcom-geni: Fix unbalanced runtime PM resume for no_console_suspend

Arnd Bergmann (1):
      serial: qcom-geni: avoid unused-function warning

Daniel Starke (1):
      tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2

Fan Wu (2):
      serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()
      tty: serial: max3100: shut down timer before freeing port

Hui Peng (1):
      vt: selection: Fix unsigned underflow and slab-out-of-bounds read in paste_selection()

Johan Hovold (11):
      tty: abort break signalling on hangup
      tty: tty_port: restore TTY_IO_ERROR on activation failure
      tty: port: fix tty_port_tty_vhangup() race
      serial: revert guards in uart_wait_modem_status()
      serial: fix ioctl hangup race
      serial: fix TIOCMIWAIT race
      serial: abort TIOCMIWAIT on hangup
      tty: amiserial: fix broken TIOCMIWAIT
      tty: add break_wait kernel-doc
      tty: fix saved termios reset race
      tty: add missing driver flag kernel-doc colon

John Ogness (1):
      serial: 8250: Change console_msr_work to IRQ_WORK_LAZY

Joshua Rogers (2):
      tty: vcc: zero-initialize control packet in vcc_send_ctl()
      tty: vcc: hold port lock when clearing tty pointer in vcc_cleanup

Kendall Willis (1):
      serial: 8250_omap: fix wake irq cleared during suspend

Konrad Dybcio (1):
      serial: qcom-geni: keep registered console runtime active

Maciej W. Rozycki (1):
      MAINTAINERS: Add self for the sb1250-duart serial driver

Mingyu Wang (1):
      tty: vt: fix memory leak in vc_allocate()

Paul Mbewe (3):
      serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
      serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL
      serial: sc16is7xx: reduce TX refill rate with half-FIFO trigger

Rosen Penev (1):
      tty: serial: mpc52xx_uart: move static declarations up.

Ruslan Valiyev (1):
      serial: core: fix NULL pointer dereference in serial_core_unregister_port()

Simon Gassner (1):
      serial: tegra: don't clear the Tx FIFO on an Rx-only reset

Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

Wentao Liang (3):
      serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()
      kgdboc: Fix tty driver reference leak in configure_kgdboc()
      serial: vt8500: Fix clock reference leak in vt8500_serial_probe()

Yi Yang (1):
      vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF

Zizhi Wo (1):
      vt: skip screen update for DEC alignment test on backgroup consoles

 MAINTAINERS                            |   5 +
 drivers/staging/greybus/uart.c         |   3 +-
 drivers/tty/amiserial.c                |   9 +-
 drivers/tty/n_gsm.c                    |  47 ++-----
 drivers/tty/serial/8250/8250_bcm7271.c |   2 +-
 drivers/tty/serial/8250/8250_omap.c    |  15 ++-
 drivers/tty/serial/8250/8250_port.c    |   2 +-
 drivers/tty/serial/kgdboc.c            |   9 ++
 drivers/tty/serial/ma35d1_serial.c     |   6 +-
 drivers/tty/serial/max3100.c           |  13 +-
 drivers/tty/serial/mpc52xx_uart.c      |   6 +-
 drivers/tty/serial/qcom_geni_serial.c  | 229 ++++++++++++++++++---------------
 drivers/tty/serial/sc16is7xx.c         |  53 ++++++--
 drivers/tty/serial/serial-tegra.c      |  18 ++-
 drivers/tty/serial/serial_core.c       |  76 ++++++++---
 drivers/tty/serial/vt8500_serial.c     |   1 +
 drivers/tty/tty_io.c                   |  54 +++++---
 drivers/tty/tty_port.c                 |  91 ++++++++-----
 drivers/tty/vcc.c                      |   5 +-
 drivers/tty/vt/selection.c             |   4 +-
 drivers/tty/vt/vc_screen.c             |  23 ++--
 drivers/tty/vt/vt.c                    |   5 +-
 drivers/usb/class/cdc-acm.c            |   2 +-
 drivers/usb/serial/usb-serial.c        |   3 +-
 include/linux/soc/qcom/geni-se.h       |  15 +--
 include/linux/tty.h                    |   2 +
 include/linux/tty_driver.h             |   6 +
 include/linux/tty_port.h               |  22 +---
 28 files changed, 442 insertions(+), 284 deletions(-)
