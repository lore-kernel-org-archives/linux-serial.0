Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099246;
	b=LvOegpBsvuu/hl8T6RkBdW9TDaaQ3Lp82pmjbdqBAi86Pcynf028iAoZVyEeMLOJPMw0
	 6Nu2apzc//V2LEADY59jDWpMDeShs4oMKz0U49+u5/SLmBl6LLBU5fiexQB/w4GnjkcV3
	 FDE0CWy1Yv3lRwBf27WOVQr827zU06uStfsIH1J43WZ9fgKTLbEpFjvcOfk7YKH2BedRN
	 feDLrj8pDOh4vwAMotpdNmpS45XGjH+6VCwbzJTR15FOaljFUFpDLmMgqcc8rpZAsnBnf
	 pSZMPaSJp3FKd2kJCYz4FBLfEW0FR1i6fZG34KDBuyB4L3O6TzBiRINOHk3rCrQ3xWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099246;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wIurQG5CL8pfILwQzYuCqZXgCzYRK8kBT+Y7gR8unCE=;
	b=RPhgYBJ5Q08g1abnFbW8mUc9ZWPaPo0auoR2qjTOFy/GhnEuzpZdqx1f6hTfegTF22X7
	 RauRkv7tUDU9nTX4SiQRYvs4yegY9mb3W5y86ml6TQBRqccei5jHyfPn/xxt7IWCYHo/o
	 cTylEDTJ/Id50XnVQMDY2MvmdKLHyriUuX+9Ah9A+RmF8j5ySXjIdH7qpAcvI6FVU/G7y
	 Yqn573PXVHZnC0egC/Hs49H9YrgpO2wNEdXjGmrI2n7Haa0CDoqIaQSbJ+vU5WpUBldTh
	 Ob0Bw3VrWc8orcebw4EJsITjPtVgAUPtNV8HzDsKF619/WiapHBe7GRgfMCOvfhzO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ek8qYkgh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4860A3810;
	Tue, 27 Oct 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ek8qYkgh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198301F01289;
	Tue, 27 Oct 2026 11:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099245;
	bh=wIurQG5CL8pfILwQzYuCqZXgCzYRK8kBT+Y7gR8unCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ek8qYkghVAyS3dcPCEG2ifqOH5uz17uQKYxcNVs+mLdB5a7ESEM5MMPtUn8TYHsOa
	 89XwMQChHIu9rQAFNRB5Px+Pa06tfA/rtCxvubsxoAVo5FAvhh5ZCHkns46kIRwqbr
	 P3eb0OwX9tpG1otpPhPfhnLRAdTfpId2LcvU2poA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:42 +0100
Subject: [PATCH 16/24] serial: 8250_lpss: don't divide by 0 above 6.25
 Mbaud
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-tty-llm-v1-16-99b0202ae546@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=cAm9rzf2IQbswg0KNvU+2bU/r1ydYsREDFlJsexgviM=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvdNkNWfuyFTof5VxiPHzdf55RTK3tfUVcVLpT59p
 +PcmO/QEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABMpmMuwYFmRhdf2LWb8Xm1J
 XX1cM6LqA9q/MMyP9xbKZPq+k6Get9J1a/aWbI2jJxMB
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

byt_set_termios() derives the clock of the UART from the baud rate in
the termios, which nobody has looked at yet:

	fuart = baud * 16;
	...
	fuart *= rounddown_pow_of_two(fref / fuart);
	...
	p->uartclk = fuart;

fref is 100 MHz. For a baud rate above 6250000, which BOTHER allows,
fref / fuart is 0, and rounddown_pow_of_two(0) shifts 1UL by -1. On x86
that is 1UL << 63, the product with a multiple of 16 is 0, and so is
uartclk. serial8250_get_baud_rate() then passes 0 for both limits,
uart_get_baud_rate() finds no rate which fits, WARNs and returns 0, and
uart_get_divisor() or dw8250_get_divisor() divide by 16 * 0.

Everybody who may open the tty can oops the kernel with one TCSETS2.

Don't ask for more than fref. The limits are those of a 100 MHz clock
then, and uart_get_baud_rate() falls back to the old rate as for any
other rate that the port cannot do. 8250_mid, which has the same
formula, treats this case separately.

Fixes: 21947ba654a6 ("serial: 8250_pci: replace switch-case by formula")
Cc: stable <stable@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_lpss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index f1b4b975571a..7e88f2b793b5 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -83,6 +83,9 @@ static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
 	/* Gracefully handle the B0 case: fall back to B9600 */
 	fuart = fuart ? fuart : 9600 * 16;
 
+	/* Fuart <= Fref: leave it to the core to refuse a higher baud rate */
+	fuart = min(fuart, fref);
+
 	/* Get Fuart closer to Fref */
 	fuart *= rounddown_pow_of_two(fref / fuart);
 

-- 
2.56.0

