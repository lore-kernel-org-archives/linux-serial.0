Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099257;
	b=iFa1N5iJORmyNYtrmxdBAlbWk7eirWd4PW6IvqY51Pt3KpCT0+U2NmGID0M77AiTKOf3
	 bIpsdO8e1QAasX9crK1JtHuMaHef5wIrrg8lnGWAFhmzF+Fn5/2Jqt6ZabtWHrsdFVFAv
	 b3DcPRwcDJGJtvag3rohuialPU31Kf0O8gBOvp4ekiPGsMFTUw5wcOVIqhKtH/1sFLjim
	 f62d06VsX9QKx4lnSL28vIEdHhzBDTWEbjXokJedp64X6Ozm002Xs588c7KJaGGGaGwKD
	 vNgDsBm1gUX4NFsdOT5B7ORTljb58UmHwch0L1YS1OOPuvlYDZFTHTcpjEP0DA2ZSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099257;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VpmMdIvwnQoe2HdnLf294GLEd81vJFoGVbPS61G/Fx8=;
	b=aJd2VlqMD94S9VdZKQqdbY04P/Z4SMDN3hMBFtS8Z6D2iisSAxzuCUFz/hiOu54xTxIK
	 F/IBD7QrMdSUJmRX3gEM7YMqJ/P7Oduo5xbv+fcUQ7u1+DRW3KX6rwyhhrhMntFoHNErd
	 LmeG+G/Trkcwb43As4A4j6Ekt/ppHwmHSCYnk5GIK7quFpS2ANQVqsW9vtpXpm2Hd1rS2
	 BnzQCeS0xPv60kUQLTzgyytFnirsuP2akvVjcB+XGRvsFzg6CPtOp4rPh6oCOZA8tEqUh
	 3bAtHlGsLz/LrBG41zZ9WzVGlIk4GJYLjMOMzz3cjmM/f7lGMFBNhO0CT9F0SaF/MKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t7z8L8zx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA1606A98D;
	Tue, 27 Oct 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t7z8L8zx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F7F1F031E1;
	Tue, 27 Oct 2026 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099256;
	bh=VpmMdIvwnQoe2HdnLf294GLEd81vJFoGVbPS61G/Fx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=t7z8L8zxaftKQO/f2gGr/cDBBFGpfQrmyL1qrGx7eEHxaNEmlHBVLDx2Bgp+3PlrO
	 SvqhDsoyMvZ4w+4mkO3eXajJWGs6DzbwUkD6ZDbsKsvicbNjIz/ZwgdzQ/PHxnSPAX
	 T9NP6Usd4JMnteTuhw3RBiMYYBYbb7yVeTOT488o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:46 +0100
Subject: [PATCH 20/24] serial: rda: free the interrupt on shutdown
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
Message-Id: <20261027-tty-llm-v1-20-99b0202ae546@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=d/SIDOTsuf7hmDmQzmEO9zGBrAPvXK229O/Za0oLQz0=;
 b=kA0DAAIRMUfUDdst+ykByyZiAGrghb+jRsDMWn1KA10AVLCyS/TL7xgDJTlXudsYM70x1VH+q
 ohdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmrghb8ACgkQMUfUDdst+ymmxACgghYR
 mip0v+mWeATp4LIFLKtGw4oAn3K0FlzU2DX0Kz74Jve14XAP4Q8Y
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

rda_uart_startup() requests the interrupt, and nothing ever frees it.
It is not shared, so once the port has been closed, the next startup
fails with -EBUSY and the port cannot be opened any more.

Free it in rda_uart_shutdown().

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Cc: stable <stable@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/rda-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 87fa30d68687..9c1785771cbb 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -471,6 +471,8 @@ static void rda_uart_shutdown(struct uart_port *port)
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	free_irq(port->irq, port);
 }
 
 static const char *rda_uart_type(struct uart_port *port)

-- 
2.56.0

