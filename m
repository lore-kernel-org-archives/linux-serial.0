Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627A37A83D
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874136; cv=none; b=K2iTj7qBuR9nW3L062wu4VQ2fBte9z65JY53nta2wkmyrdUHiuPojmJbD1yXooosqEH2QBGPEPRw4dP6/VT5cO/S/kqEZQn4RJvJFOW1NZ0IJ8zxuWx2+2oT7iRCQrh29Dwcj2VcjK0CM0jnTCrliQwAdJgNV/OROtpE8KoaW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874136; c=relaxed/simple;
	bh=lZwVx9oBWFSuMCyyi9nzP4RJwEvT44kXBPxvtrCiye8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFXJATpo7SLYBrIUk5YPO7e6Ua2I7xRSha1rdhcaqU/VDwExr5/ulmFsgpEl16tuegd00+9jq4nEd/Xo812ZaDmmlu+ZHl3XnUp5dLMH5ytm3oWPf7ao0Bvu0/qZv4jfx2yyr9BVFddozLOIG1CD9koa1b2HbP4L8cRTKFO8dSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikoTxFII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikoTxFII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EE51F000FF;
	Tue, 13 Oct 2026 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874134;
	bh=gj7qtohQjlYmHqI4WcP7OTioESFxMFRaeXxZMawj0U0=;
	h=From:To:Cc:Subject:Date;
	b=ikoTxFIIjeT4VshN+ey6woxNaWYBi/yaQ7GOtEwnM0Z4SQ4zWs5YUgvNNMSXQYF6S
	 Y3YOsf/OlKzSTtwhFw6fX17ePmP/sx75XmK2fvGBJQhHvTzOHE6PDQR+LKhq+/aowN
	 BB+Mz9e+mTO41wNzsR9NNKVHyrjh+RPluvBBWcj9dgHKyegzl/QFO/ACGtGYl5qKpR
	 Kc/dStpOoXrY7kwlJGF74+HWDeI/eZHnkv3gpTZL7Grw9jFQ05+BqCVT+3Vyb+wap2
	 jL5R9pswsrckLXSaCllF+39W59IV74we0w3YaqJKK6YqDLfTkXeQViBLMXIzj1y0az
	 3ITfg9ZoBsgyA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 0/6] serial: 8250: make port operations work on struct uart_8250_port
Date: Tue, 13 Oct 2026 08:48:45 +0200
Message-ID: <cover.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

the 8250 port operations work on line numbers.
serial8250_register_8250_port() returns a line, and drivers pass it back
to serial8250_unregister_port(), serial8250_suspend_port() and
serial8250_resume_port(). Many drivers also convert it back to the port
using serial8250_get_port() whenever they need the port itself.

The last patch switches this interface to struct uart_8250_port.
serial8250_register_8250_port() now returns the port (or an ERR_PTR()),
and the other operations take it. All users are converted, and
serial8250_get_port() is no longer exported.

The first patch is a preparatory cleanup. It splits
serial8250_register_8250_port() into a helper, so that the function no
longer mixes guard() with goto-based error handling -- Sashiko.

The second patch is a trivial exar cleanup.

While doing the conversion, we (me, Claude and Sashiko) found three bugs
in how drivers handle a line that is not set (yet). Patches 3-5 fix them
separately, so that they can go to stable:
 
 * 8250_exar: pci_xr17v35x_exit() looks up the GPIO platform device via
   port 0, which need not exist when its registration failed. The GPIO
   device is now stored in struct exar8250.
 * 8250_lpss: the probe error path calls ehl_serial_exit(), which clears
   the dma pointer of serial8250_ports[0] (usually the console) when no
   port was registered.
 * 8250_omap: the IRQ handler can run before probe stores priv->line,
   and then it uses serial8250_get_port(-ENODEV).

The conversion also fixes two latent issues: CIR ports (registration
used to return 0, so callers operated on ttyS0) and 8250_acorn (a port
on line 0 was never unregistered).

[v2]
 * new patch 1: drop the err label from serial8250_register_8250_port()
 * new patches 2-3: exar cleanup and fix of the GPIO device lookup
   (reported by Sashiko)
 * 8250_lpss: no declaration in the middle of a function (Ilpo)
 * conversion: include err.h (Ilpo)

Link to v1: https://lore.kernel.org/all/ef47d676a44346e058f29a00c8701484db722831.1791524724.git.jirislaby@kernel.org/

Jiri Slaby (SUSE) (6):
  serial: 8250: drop err label from serial8250_register_8250_port()
  serial: 8250_exar: remove useless void * casts
  serial: 8250_exar: store the GPIO platform device in struct exar8250
  serial: 8250_lpss: do not touch uninitialized line in
    ehl_serial_exit()
  serial: 8250_omap: set priv->line before enabling the IRQ
  serial: 8250: make port operations work on struct uart_8250_port

 drivers/ptp/ptp_ocp.c                       |  36 +++---
 drivers/tty/serial/8250/8250_acorn.c        |   5 +-
 drivers/tty/serial/8250/8250_airoha.c       |  23 ++--
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  13 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  20 +--
 drivers/tty/serial/8250/8250_bcm7271.c      |  33 +++--
 drivers/tty/serial/8250/8250_core.c         | 128 ++++++++++----------
 drivers/tty/serial/8250/8250_dfl.c          |  22 ++--
 drivers/tty/serial/8250/8250_dw.c           |  13 +-
 drivers/tty/serial/8250/8250_dwlib.h        |   2 +-
 drivers/tty/serial/8250/8250_em.c           |  26 ++--
 drivers/tty/serial/8250/8250_exar.c         |  59 +++++----
 drivers/tty/serial/8250/8250_fsl.c          |  24 ++--
 drivers/tty/serial/8250/8250_hp300.c        |  27 ++---
 drivers/tty/serial/8250/8250_ingenic.c      |  11 +-
 drivers/tty/serial/8250/8250_ioc3.c         |  26 ++--
 drivers/tty/serial/8250/8250_keba.c         |  13 +-
 drivers/tty/serial/8250/8250_loongson.c     |  20 +--
 drivers/tty/serial/8250/8250_lpc18xx.c      |  11 +-
 drivers/tty/serial/8250/8250_lpss.c         |  17 +--
 drivers/tty/serial/8250/8250_men_mcb.c      |  14 +--
 drivers/tty/serial/8250/8250_mid.c          |  13 +-
 drivers/tty/serial/8250/8250_mtk.c          |  19 +--
 drivers/tty/serial/8250/8250_mxpcie.c       |  13 +-
 drivers/tty/serial/8250/8250_ni.c           |  12 +-
 drivers/tty/serial/8250/8250_of.c           |  25 ++--
 drivers/tty/serial/8250/8250_omap.c         |  41 +++----
 drivers/tty/serial/8250/8250_parisc.c       |  14 +--
 drivers/tty/serial/8250/8250_pci.c          |  21 ++--
 drivers/tty/serial/8250/8250_pci1xxxx.c     |  41 +++----
 drivers/tty/serial/8250/8250_pericom.c      |  15 +--
 drivers/tty/serial/8250/8250_platform.c     |  23 ++--
 drivers/tty/serial/8250/8250_pnp.c          |  21 ++--
 drivers/tty/serial/8250/8250_pxa.c          |  17 +--
 drivers/tty/serial/8250/8250_tegra.c        |  20 +--
 drivers/tty/serial/8250/8250_uniphier.c     |  21 ++--
 drivers/tty/serial/8250/serial_cs.c         |  15 ++-
 include/linux/serial_8250.h                 |   8 +-
 38 files changed, 417 insertions(+), 465 deletions(-)

-- 
2.56.0

