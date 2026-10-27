Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099219;
	b=oAo2w31a8EcUE9OQv24LFsrgq71IorinTy4YzJ1mBg1qtkp26icfh0yk/RgKyZiB2IPH
	 E2RQH7Ir2SzxJBVDQlSWHEBF5ctB1Zb9u6UxBqW89yEaXiu5IzPeijolbCOFSQmLLCOCy
	 ozoWYa5o7aaHJ2hx9nCuRH0vZSE/0GNb8tr2gL++i2AuuBjJPdxhGhlTU3yTp/fOH9R6O
	 gJAoYySg4PYS5wOGGL7cCjQkplni4QThXHIxJWXIUjhwSzEONOiFxKZ0aF1wW38JZqb5D
	 1pm85pPXkc1TmMw4PozSaEqqbpgtxVMGWxP8w9A9ZmsOvC5vDb5Gs+EE/wUocnJDEDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099219;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=807vVk1Em6DmnTdIAZ39Jr5T9z6xCDFeE3y4cfBZDYA=;
	b=b2tGD5PEl+cMGKGUkfj+Cm3qW4h4x3WnmXSyJSLG5N8HuMcyl+9rmH5mncdBboTpd02i
	 eraIiWrOkSFUla7Odi5Vp9jAi0GjsTk5xfbmBvzcyBeIiYoVGK5Gq5LYUb2j7SzHhiNNA
	 eBgjAwVnL3iP6bWM4ARkd1CXnobftGHbYKvnyHTSXhsihIdH+fIJbgunVdmTICwfOSwKV
	 5KDpkyrfpbSyxkf7rRldMViQY5y+Xwrv6ooihOiFVLOGD+E+piShWB1x1zc4NFvPdZWVu
	 G0RXhFLUlaQwsCiH8VaR3JZAyxD/5IKlCHIA8BgTaPD4z0pEX2Tg+5oEzUWpx1vteOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=crQTGDUj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2060A262D;
	Tue, 27 Oct 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=crQTGDUj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB831F01825;
	Tue, 27 Oct 2026 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099218;
	bh=807vVk1Em6DmnTdIAZ39Jr5T9z6xCDFeE3y4cfBZDYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=crQTGDUjdfLUJ4xCja81GhOAbGVCi0dmviLViqkHbIhfw8mwobXWS+h5lMCU2zlwe
	 xgdrN+nTDoMB7QbA+/2zdk/NLYcZc7xnLZg6duvX9XJyr+8NGHf9NXEM/KoMqJj2Tb
	 7WPm2b+ERD/NHbmhhoMuDa7OQFGsx2uwEGez7ICE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:32 +0100
Subject: [PATCH 06/24] serial: 8250: add bounds check for line array in
 setup_serial()
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
Message-Id: <20261027-tty-llm-v1-6-99b0202ae546@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=uFMpIpem0yn/U2ZVTv2senN+dTEV+Lanv8xcnEbXLQs=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWveuOvVSeF/UiUdlFfdly5bFHOoNv1XF3GOgHr/vl
 c/sOnaejlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjInRkM8x3ydryJmzDt0SSb
 U2qm0maqXxOYNBnmp7Ec27QsxNXN47rg5LPLZ16L5toVAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

setup_serial() writes to info->line[info->ndev] without verifying that
ndev is within the array bounds. A malformed PCMCIA card with a large
I/O window can cause info->multi to exceed 4, leading to out-of-bounds
writes past the line[4] array and corruption of adjacent struct members.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/serial_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 5dcd1544e478..8bd88f3d6d86 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -349,6 +349,11 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
 {
 	struct uart_8250_port uart;
 
+	if (info->ndev >= ARRAY_SIZE(info->line)) {
+		dev_err(&handle->dev, "no room for more serial ports\n");
+		return -EINVAL;
+	}
+
 	memset(&uart, 0, sizeof(uart));
 	uart.port.iobase = iobase;
 	uart.port.irq = irq;

-- 
2.56.0

