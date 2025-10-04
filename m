Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A314F125;
	Sat,  4 Oct 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586606; cv=none; b=r/8JfcUNE3jQQnm/0KYFOqDqmwesZkKxZ/wF8AZR+uUnJ29cSN/UTAiSXJfWkU1PGsDBubw7A0u8ed0DG2Q/g8PA/J+WXwHjWk/M8bCkbq76JDN/vaBpvqDWSDi41n7jAI3jfQ/mPvXCaoY6hU9PpIKOQdiGctTQ442bmjg3If8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586606; c=relaxed/simple;
	bh=+QvMtYzkJOq8DFgrCgDwf7fjKD7OmjxHVHvjcE1opww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JBc1PgjSFw8tpO+fVliVDd1TQHq/uopKFxhP4fPPoXPZCXKMDoQjY9tYIvPK7Yn8IlU3hlBvaH6YVFxMt48UiSuyLQRFuZEhlC6ajNJile4IZN29htMdnGrn+uyz8UusiHGDB4hsCFtug3q3eqqfRH7qq3IyIFpmrgOD1Oigpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ungi3K70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ungi3K70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50733C4CEF1;
	Sat,  4 Oct 2025 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759586605;
	bh=+QvMtYzkJOq8DFgrCgDwf7fjKD7OmjxHVHvjcE1opww=;
	h=Date:From:To:Cc:Subject:From;
	b=Ungi3K70VZulouw6Xtx7BnGf6MPZi0awnTzM/8LsXuwwRY3x2h3b8HrLqbvPTdQuT
	 ZYR1uZMkgIU9of28W+d/XAKP0ZTfBA1EwNF23l4QKaHi+diRNC9SRzfbekcnG1Uvju
	 +K/znxD/PMNojDxZG+NjQZQfvc3/enbgTU0/Wvps=
Date: Sat, 4 Oct 2025 16:03:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver changes for 6.18-rc1
Message-ID: <aOEpKp9lSCgoCiId@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1

for you to fetch changes up to f4abab350840d58d69814c6993736f03ac27df83:

  tty: serial: fix help message for SERIAL_CPM (2025-09-17 13:11:30 +0200)

----------------------------------------------------------------
TTY/Serial update for 6.18-rc1

Here are some small updates for tty/serial drivers for 6.18-rc1.

Not many changes overall, just the usual:
  - abi cleanups and reworking of the tty functions by Jiri by adding
    console lock guard logic
  - 8250_platform driver updates
  - qcom-geni driver updates
  - other minor serial driver updates
  - some more vt escape codes added

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abinash Singh (2):
      serial: 8250_platform: Reduce stack usage in serial8250_probe_acpi()
      serial: 8250_platform: Reduce stack usage in serial8250_probe_platform()

Arturs Artamonovs (1):
      tty: serial: fix help message for SERIAL_CPM

Brian Masney (1):
      tty: serial: mvebu-uart: convert from round_rate() to determine_rate()

Calixte Pernot (1):
      vt: add support for smput/rmput escape codes

Claudiu Beznea (1):
      serdev: Drop dev_pm_domain_detach() call

Dan Carpenter (2):
      tty: sysrq: delete unnecessary check
      serial: max310x: Add error checking in probe()

Edward Adam Davis (1):
      vt: move vc_saved_screen to within tty allocated judgment

Greg Kroah-Hartman (2):
      Revert "m68k: make HPDCA and HPAPCI bools"
      Merge 6.17-rc6 into tty-next

Jiri Slaby (SUSE) (17):
      console: introduce console_lock guard()s
      tty: introduce tty_port_tty guard()
      serial: introduce uart_port_lock() guard()s
      serial: 8250: introduce RPM guard()s
      tty: tty_port: use guard()s
      mxser: use tty_port_tty guard() in mxser_port_isr()
      mxser: use guard()s
      serial: serial_core: use guard()s
      serial: 8250: use guard()s
      serial: 8250_core: use guard() in serial_unlink_irq_chain()
      serial: 8250_omap: extract omap_8250_set_termios_atomic()
      serial: 8250_omap: use guard()s
      serial: 8250_rsa: use guard()s
      tty/vt: use guard()s in con_font_set/get() and con_{set,get}_unimap()
      tty/vt: use guard()s
      s390/char/con3270: use tty_port_tty guard()
      m68k: make HPDCA and HPAPCI bools

Markus Schneider-Pargmann (2):
      dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
      serial: 8250: omap: Support wakeup pinctrl state on suspend

Osama Abdelkader (1):
      serial: 8250_core: fix coding style issue

Raphael Gallais-Pou (1):
      serial: stm32: allow selecting console when the driver is module

Seppo Takalo (1):
      tty: n_gsm: Don't block input queue by waiting MSC

Tapio Reijonen (1):
      serial: max310x: improve interrupt handling

Thomas Bogendoerfer (1):
      tty: serial: ip22zilog: Use platform device for probing

Viken Dadhaniya (1):
      serial: qcom-geni: Add DFS clock mode support to GENI UART driver

Wang Liang (1):
      vt: remove redundant check on vc_mode in con_font_set()

Xichao Zhao (3):
      tty: serial: Modify the use of dev_err_probe()
      serial: sc16is7xx: drop redundant conversion to bool
      tty: remove redundant condition checks

Zizhi Wo (1):
      tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()

Zong Jiang (3):
      serial: qcom-geni: Dynamically allocate UART ports
      serial: qcom-geni: Make UART port count configurable via Kconfig
      serial: qcom-geni: Fix off-by-one error in ida_alloc_range()

 .../devicetree/bindings/serial/8250_omap.yaml      |  16 +
 arch/mips/sgi-ip22/ip22-platform.c                 |  32 ++
 drivers/s390/char/con3270.c                        |  18 +-
 drivers/tty/hvc/hvc_console.c                      |   2 +-
 drivers/tty/mxser.c                                | 265 ++++++---------
 drivers/tty/n_gsm.c                                |  25 +-
 drivers/tty/serdev/core.c                          |  11 +-
 drivers/tty/serial/8250/8250.h                     |   5 +
 drivers/tty/serial/8250/8250_core.c                |  93 +++---
 drivers/tty/serial/8250/8250_omap.c                | 183 ++++++-----
 drivers/tty/serial/8250/8250_platform.c            |  87 ++---
 drivers/tty/serial/8250/8250_port.c                | 300 +++++++----------
 drivers/tty/serial/8250/8250_rsa.c                 |   7 +-
 drivers/tty/serial/Kconfig                         |  12 +-
 drivers/tty/serial/ip22zilog.c                     | 360 +++++++++------------
 drivers/tty/serial/max3100.c                       |   2 +-
 drivers/tty/serial/max310x.c                       |  28 +-
 drivers/tty/serial/msm_serial.c                    |   2 +-
 drivers/tty/serial/mvebu-uart.c                    |  10 +-
 drivers/tty/serial/qcom_geni_serial.c              | 147 +++------
 drivers/tty/serial/sc16is7xx.c                     |   2 +-
 drivers/tty/serial/serial_core.c                   | 143 ++++----
 drivers/tty/sysrq.c                                |   3 +-
 drivers/tty/tty_port.c                             | 168 +++++-----
 drivers/tty/vt/consolemap.c                        | 116 +++----
 drivers/tty/vt/selection.c                         |  20 +-
 drivers/tty/vt/vc_screen.c                         |  74 ++---
 drivers/tty/vt/vt.c                                | 247 +++++++-------
 drivers/tty/vt/vt_ioctl.c                          | 194 +++++------
 include/linux/console.h                            |   2 +
 include/linux/console_struct.h                     |   3 +
 include/linux/serial_core.h                        |  13 +
 include/linux/tty_port.h                           |  14 +
 33 files changed, 1201 insertions(+), 1403 deletions(-)
