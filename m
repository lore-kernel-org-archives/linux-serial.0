Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099268;
	b=Tve7iU/uEfcjF2vmMYIPVFDPzKMUjPJgidtDlvlIj2fnRqsMFpsaMQsTsyfjgVhtA3d7
	 5VcoLmL6MS0Y1P4GWm9hHHPC8xb0JKV8OsmiH/aC+8PwfXJOB9+ktSyZDS0d7BKSR4F2R
	 v0hrLu/ytn7aYUpCbKYi3iQOYygRZQx4N5lOayDDPGOu7D7LkbqGYHmrdEMz8A1+ibnuu
	 d8JUOJc4Qrix2HXNM+XIfxusZU9ydwsUiqg8FX3UmjIJlIPYrboDIL0wnl1cpUrUtWwoH
	 1Ib5ViOOkcoq6xgb0J20JKbskIuyTRBl0QRWs7Vbcj+tHcXk3a9H0zitVOhhPrUFkpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099268;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TTg1Yw7oDYioZjTrpOrhlF2Ny/pG8qkEKJ4JDIywBus=;
	b=0oco2Zg85FWRh5E/v92HtMQeNI8c5gBLEzmKBH/jMKndJQ0w0vGb2M9QJOvAoA25Rttz
	 TM69Cwszic0SaW6UcqL8yrl8b0AQhaHipiVSFFDccDYHJcvU4MBq8jMqo4+UwlBHQ3Xxt
	 Cs9cjFEJH6ls2IQF8zRbvDspf28hX1YNFeMZHzZM86tyHjL2NJcZA9m0hKWRGA1pIuc6R
	 7w5UO/JOufyjXeCzwJxQpwYYEToIHFFkNe751HQhAv7a/k8m1EcLhWEw2eTxnPpdxFH1+
	 r7CbGARWk3PzkMV5d6jnaGkiiItMoFQqwWsRvvNqq8kIi20vY4+OdqI5DnQVPGiTvHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U+LrCsl8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810C606B553;
	Tue, 27 Oct 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U+LrCsl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657651F01825;
	Tue, 27 Oct 2026 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099268;
	bh=TTg1Yw7oDYioZjTrpOrhlF2Ny/pG8qkEKJ4JDIywBus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U+LrCsl8ZZs4m5oQCTtRPMvvZYPjhzNBvcwFeZs/b3Fk6+3gTonHzywev9mLhMRr8
	 6PGbvo2//lZxu16ka+XPXz/VcXW6SpA8umrH73hreoNpxRUSgnDT6rKPPHE3gVE+d0
	 jy3x/ahztRofZTloWm4MK6vokAWXDPObvZrumiJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:50 +0100
Subject: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed tty
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
Message-Id: <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=EIMsWgGTJxJVsmjQvEM7+7wgUHgzqQtmp+TOkkwPZfQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWveftTtcdH9Hx4Eoxwk7VoXem7v2ib/rIn0zs+TTr
 2eYfWgT74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJHD3PsGDh2hi/tXdsxetO
 bDDnnqb2eIVH7FaGBZMbEoPP6RlqScyvblludMrH++d1JQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

stm32_usart_interrupt() reports a wakeup interrupt as a wakeup event of
tport->tty->dev.  That pointer is only set while the port is open.  The
port of a console is not shut down by the last close: it stays
initialized, so the wakeup interrupt is still enabled on suspend.  If
the system is then woken up by the console, the handler dereferences a
NULL pointer.

Take a reference to the tty, and leave the event out if there is none.

Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ad06b760cfca..3bc2ce877585 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -872,8 +872,15 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		writel_relaxed(USART_ICR_WUCF,
 			       port->membase + ofs->icr);
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
-			pm_wakeup_event(tport->tty->dev, 0);
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
+			struct tty_struct *tty = tty_port_tty_get(tport);
+
+			/* A console stays set up after the last close */
+			if (tty) {
+				pm_wakeup_event(tty->dev, 0);
+				tty_kref_put(tty);
+			}
+		}
 		ret = IRQ_HANDLED;
 	}
 

-- 
2.56.0

