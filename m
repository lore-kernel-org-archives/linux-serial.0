Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099254;
	b=Qwy5RLyXwr79MvVuSrve8uSxHXbrx6rhSO3UH7bgwnFkZ7PIVMkGwBH2nScxTnmM5S9i
	 TGA5OpTHBDCyYA6vV/76irWqlZI58pyVRUHSPOsn3iUFHkgRbsoOmAihefCSLxRfHLESm
	 eKPWVIl6HZ4Y3zMj7dW3aAh1mIvKue/l8womHlyn2ien9Lw2Ni8fefRk+Pbj0XtUYY0uq
	 4HS3B4d7+RDJayKxqlej7DAMDG8snAZe+9XJ673g1M0VFDFzK6nvkIT8AkpImFlaBhuxz
	 gkTEGYM7fpwHwqMTrU7yHIz/SF+fupgtkzTtb7tzs7VrKt5pyglh/wPPbKoOwBpmw9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099254;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Y3NfxHiZyYJSczHJRqb5QvqcqLOC7DXI3QRTL5E0Wgw=;
	b=EyBT023Wf3C2adW+b7pMkrY7ouQ605zLX89+lHENZwIuv0VT+fNLVgiX97Lq7XX/5qZR
	 eZkKADRtQJ9xRyzVBbfIbq+5pZ/wIHE8lgap2562qMyzN74P/xmrMNWM1/MVQJOlVoUJe
	 JFJfPw/OfRmcV4BZ75+6Iu1scKb/VMmN/YZ3tkeGlmO4gxmMJ06gndxTJgsgJyYv2lCVj
	 vjoXCBa+1pl2oR/oxEmV16X6ffhXXgEsDj89bSvArpR5Uq6j6///2TpvoYl+OhyqRbe2T
	 5IsHajZM55nEJRo2CYbcijMFEkXL2D9+qA8tjzJk3I/Nbjp8oBwbeN2LPwEl1gtxOAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7qYgM00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6C60A6F56;
	Tue, 27 Oct 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7qYgM00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6611F031E0;
	Tue, 27 Oct 2026 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099254;
	bh=Y3NfxHiZyYJSczHJRqb5QvqcqLOC7DXI3QRTL5E0Wgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=v7qYgM00TWYDSOshToVYiLYjgMdR5UEQOAnaBYVn+s0Dddeyq8aZOhKppL9sm7xmx
	 s/XVR5m5Z13QBwtLebeZACWKnjOch+S1pmBpFas3rtx5N4RUsmXipNUFg9hVa2MufU
	 hRBBDC79227OeYJRnbnIeiId2RpV3uURDhrevGoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:45 +0100
Subject: [PATCH 19/24] serial: imx: fix the tty reference of the wakeup
 event
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
Message-Id: <20261027-tty-llm-v1-19-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
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
 Robin Gong <yibin.gong@nxp.com>, Petr Mladek <pmladek@suse.com>, 
 John Ogness <john.ogness@linutronix.de>, Pan Chuang <panchuang@vivo.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=ZhRpmwK/FffQvTWxOSDv/s3I7szVkF9/aLsMXevC0rs=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvenK6dfnvpde05r0sYf/1p3SbL1X1rBu6N+1aZEn
 qiISsnQjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIrw/DHL4ysffXre8E83xN
 3PL5wnxXtznl3Ayz2aWad70+82fb1M0N2r1ma5o2PQwoBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

To report a wakeup event, imx_uart_enable_wakeup() gets the tty with
tty_port_tty_get() and never puts it: each wakeup by the UART leaks a
reference, and the tty is not freed when it is closed.

Fixes: 0cfadf4bcd28 ("tty: serial: imx: Add missing wakeup event reporting")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Pan Chuang <panchuang@vivo.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 986fefb45c63..18892fc4a35b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2742,8 +2742,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 
-	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
-		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
+	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq))) {
+		struct tty_struct *tty = tty_port_tty_get(port);
+
+		if (tty) {
+			pm_wakeup_event(tty->dev, 0);
+			tty_kref_put(tty);
+		}
+	}
 
 	uart_port_unlock_irq(&sport->port);
 }

-- 
2.56.0

