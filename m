Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099202;
	b=b3cSFUmKFEuJWhKgLaF2buaqrsqaih3rojBGqDgGLejlkr4SWN25TXuLWOeoDS38ar1f
	 +yFewX5gxaG4uHsn1XMz85dKjoXVuDb3Jf8CQAA5aXDnUY+pKNQmHgDO08VsEbSKcm0Ga
	 vBhLgsnceGtDp3h4OV1IY2hI9veqIIAtpK3QdRARQJLaq9odfkmfem+/686ywZ5sl++v+
	 6p6R2FSYY76y799UpnnO6LhXEGy5PHRyeJud5fZU+kXcdbCiTATfWyniCN14Mt5mhzU0F
	 Y+skkZ313TE3lYqfn8einbipHkoao0wPKmZDInIC0xjE+NyrS5Tt/rqlYocBqMoSx3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099202;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RE9r+EPMkqG9JguqfT6dRXgxJfABqUOB47pSYdQBeWc=;
	b=kpeIRpjvVPRd01+22MpOmxcf/zhcZmhYtHiqXG+pyzjV48a1xJzF+9Qh9G8BzqkMPKTm
	 4PDdxif5zXVlQR07N3FcFFyYkPEEVTB0+J3S3Y0MnvMySZTofi+Fx/hCepz90+ISERc+6
	 uDq9+Tsllv/pUgrnGq/oKiVaQBPzcqme6S6yFe+E98mqrr6EFNISyUDu1ATf/dh192NDk
	 r+Focu31ULKR9KB/vHClVl042n9Q/PzDN5DG1q/8BAFyERnzkia3mW60VNAq39n284TUz
	 YivH1sqW+QRGn928IWVtGcW8ffM4+GasbsBrIaKH85JBVT1Gpnx9JNfA4qhhnraGqLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sWfLEp3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CF606A31A;
	Tue, 27 Oct 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sWfLEp3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F33F1F01825;
	Tue, 27 Oct 2026 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099201;
	bh=RE9r+EPMkqG9JguqfT6dRXgxJfABqUOB47pSYdQBeWc=;
	h=From:Subject:Date:To:Cc;
	b=sWfLEp3VRf/4WrJfPYQKOCw4b8lRjdJvSfBzkqGLfFKO9rYddYseBi8+0wEqIdm1m
	 PHL7tT+Qdn3ieb5HsAVGedrNBO88lc7nPHr1RiQMftIwIWdSGI6eaJ+ndcEMfCVWnc
	 uREEHYWxettJYQ+sv/fEWRae2leB1hxzkdv72qDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/24] tty/serial: a bunch of llm-found fixes
Date: Tue, 27 Oct 2026 12:06:26 +0100
Message-Id: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3ZKSSt2cnFxdCyNzI9PEJNMkyyRjJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAHBsGbhrAAAA
X-Change-ID: 20261027-tty-llm-82725ab5b9b3
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Nicolas Pitre <npitre@baylibre.com>, Kees Cook <kees+treewide@kernel.org>, 
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
 Randy Dunlap <rdunlap@infradead.org>, Ronan Pigott <ronan@rjp.ie>, 
 Liav Mordouch <liavmordouch@gmail.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Johan Hovold <johan@kernel.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Tony Lindgren <tony.lindgren@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Tate Whiteberg <whiteberg@arista.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Fushuai Wang <wangfushuai@baidu.com>, Petr Mladek <pmladek@suse.com>, 
 Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
 Marnix Rijnart <marnix.rijnart@iwell.eu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Linmao Li <lilinmao@kylinos.cn>, 
 Peng Fan <peng.fan@nxp.com>, Shitalkumar Gandhi <shital.gandhi45@gmail.com>, 
 Robin Gong <yibin.gong@nxp.com>, Pan Chuang <panchuang@vivo.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=u1AOWKaeLw/J637Ut3krjBC+w7zgOqNgLCTwHfBX2wM=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvc2R7ty8nT7uovFiHv7bouUfuV5sJHZgT8sZFZQT
 8tfx0UdsSwMgkwMsmKKLF+28RzdX3FI0cvQ9jTMHFYmkCEMXJwCMJGzCxgWzNwc3tl9Rtfm1uMe
 9zIt6x6rJaF7GOZwLTi5uXFXbUW86ZT5W/ub+3SFPhgAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Here's a series of some small llm-found fixes that have been sent to me
recently.  Most of them are just minor bugfixes and locking cleanups,
but they are good to have from what I can tell.

Submitting them here to get a solid Sashiko run and some second eyes on
them before merging if all goes well.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Chris Mason (1):
      vt: serialise the producers of the flip buffer

Josef Bacik (12):
      serial: core: respect runtime PM when sending x_char
      serial: 8250: don't wait for the em485 timers locked
      serial: 8250: don't report a wakeup to a closed tty
      serial: 8250_lpss: don't divide by 0 above 6.25 Mbaud
      serial: 8250_mxpcie: handle hangup during break
      serial: fsl_lpuart: fix tty ref of wakeup event
      serial: imx: fix the tty reference of the wakeup event
      serial: rda: free the interrupt on shutdown
      serial: samsung: don't leak the tty on an RX IRQ
      serial: samsung: put the previous baud clock
      serial: st-asc: don't report a wakeup to a closed tty
      serial: stm32: don't report a wakeup to a closed tty

Joshua Rogers (11):
      serial: 8250: clear subdriver state on port unregister
      serial: 8250: add bounds check for line array in setup_serial()
      serial: 8250: hold hash_mutex across irq_info lookup and linking
      serial: 8250: cancel overrun backoff work on port shutdown and unregister
      serial: 8250: 8250_bcm7271: fix DMA address truncation to 32 bits
      serial: 8250: pericom: validate port offset against BAR length
      serial: 8250: cap OxSemi Tornado UART count against BAR size
      serial: 8250: dfl: add bounds check for device-provided regshift
      serial: 8250: dfl: validate MMIO resource size and regshift
      serial: 8250: ioc3: store registered line number in driver data
      serial: 8250: omap: acquire rx_dma_lock in DMA completion callback

 drivers/tty/serial/8250/8250.h         |  1 +
 drivers/tty/serial/8250/8250_bcm7271.c |  2 +-
 drivers/tty/serial/8250/8250_core.c    | 41 ++++++++++++++++---
 drivers/tty/serial/8250/8250_dfl.c     | 16 ++++++++
 drivers/tty/serial/8250/8250_ioc3.c    |  1 +
 drivers/tty/serial/8250/8250_lpss.c    |  3 ++
 drivers/tty/serial/8250/8250_mxpcie.c  | 13 ++++--
 drivers/tty/serial/8250/8250_omap.c    |  5 +++
 drivers/tty/serial/8250/8250_pci.c     | 10 +++++
 drivers/tty/serial/8250/8250_pericom.c |  3 ++
 drivers/tty/serial/8250/8250_port.c    | 74 ++++++++++++++++++++++++++++------
 drivers/tty/serial/8250/serial_cs.c    |  5 +++
 drivers/tty/serial/fsl_lpuart.c        | 10 ++++-
 drivers/tty/serial/imx.c               | 10 ++++-
 drivers/tty/serial/rda-uart.c          |  2 +
 drivers/tty/serial/samsung_tty.c       |  8 ++--
 drivers/tty/serial/serial_core.c       | 25 +++++++-----
 drivers/tty/serial/serial_port.c       |  4 +-
 drivers/tty/serial/st-asc.c            | 11 ++++-
 drivers/tty/serial/stm32-usart.c       | 11 ++++-
 drivers/tty/vt/keyboard.c              |  6 +++
 drivers/tty/vt/vt.c                    |  2 +
 include/linux/serial_8250.h            |  1 +
 23 files changed, 217 insertions(+), 47 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261027-tty-llm-82725ab5b9b3

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

