Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099243;
	b=pEz8dcspmhiHDXnCFEY7WPc83v3POSJ+ptCpeKcbX0FjTMuRDISL4h7aUsWJaAJDj4mj
	 Lvt1aFI4nquuzr5a+EINP+0lssimYppkxa2M7m8pqu1DPWzG9I7E/PZjf58FBDmxoxCwZ
	 DwLimq4Va+9j0+PqhlCnMD0qH5ETs3CwfDHhrVGdriH6YuuM2STvVfA+nz6tPi+NZOUzh
	 pW7U/dV7YJptkM8pabgZXEXdw5eEkBYL76LZgMm8R1KsaSe2D1Dhtaqwe0tTUOrOE72y4
	 PXjR9fa7ukFbgVbkMY9GNjaaxmBrFsqNXbA8wDCF0OxHn84wrm5cw9qU+96d8ImjZnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099243;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rfgTqOaNw3826i0VaS1Qa3IwpOdenBIQdfBwT32lnrs=;
	b=0UIWAlJAisKsaDFL4B08BBPYtbrLpo1Pa55t3iLUr1Op8vHZa2O7SCAfa7Ga4Bwz6o/s
	 I1zrbml87wEeHGXdAUrIa2O2Wq+FVV26Buk7BxjwtLK9Kjz73wAvFybVEylvq4/qgVzve
	 n+8U6oArhiR5rOS9mU0qll56ZF2pZr2lf6XV7LHYdI6CWd26CMS1LdlF479aDyKIrzuQL
	 VW5idhlYb1ZRXs5bsSNA+ZcoVNXEZFhVjbO42hiRzqLGYydm4rsEqvuYNh9C7P3cyM4jS
	 gZh93oIGJtnYdk9+2URPADJKozI9/PhWVgNRSQ6tIOZevipJPcOlrt7UCns/sRSe2ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PmpwvjiQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ECC60A263A;
	Tue, 27 Oct 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PmpwvjiQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F951F01287;
	Tue, 27 Oct 2026 11:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099242;
	bh=rfgTqOaNw3826i0VaS1Qa3IwpOdenBIQdfBwT32lnrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PmpwvjiQeAHvPrnILR2uRXYFVy66Y3dw+bk6KwpD8Wr5YdAAooPc9UGoRI4ZEZx35
	 hJAgvLXV4AzNSAtR865fyFaqz1I57Lgvww3EfQ8P9SgQw9ZaX1WkOsj1cZ2dGo43n5
	 69R4JpoA1WAUBvWxKf3UZEpY0m5VvJhYc0nOcHIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:41 +0100
Subject: [PATCH 15/24] serial: 8250: omap: acquire rx_dma_lock in DMA
 completion callback
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
Message-Id: <20261027-tty-llm-v1-15-99b0202ae546@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Moteen Shah <m-shah@ti.com>, Kendall Willis <k-willis@ti.com>, 
 stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=7dlGvGO54Ra670tmxqdD2cDzG05O2464Fe8r8EsloYk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvdlvdnzVzYg6cGmd4anIzpm9yRs+rLnxXrHajGxj
 gplbfW6jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIKjeGBQv/Fdy6u34/87VZ
 SvZv+YzzdX9UPmZYsPJi85zPxQcVdjWs2sClyLFb70CCEQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The __dma_rx_do_complete() helper requires priv->rx_dma_lock to be held,
but the DMA completion callback __dma_rx_complete() calls it without
that lock, only holding the UART port lock. This allows a race between
the callback and omap_8250_rx_dma_flush() which properly holds
rx_dma_lock, leading to concurrent tty_insert_flip_string() calls that
can corrupt flip-buffer state. Acquire rx_dma_lock around the call,
matching the established lock ordering (port lock then rx_dma_lock).

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Moteen Shah <m-shah@ti.com>
Cc: Kendall Willis <k-willis@ti.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 07ebed6ac6c9..0afd648733da 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -975,7 +975,9 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
+	spin_lock(&priv->rx_dma_lock);
 	__dma_rx_do_complete(p);
+	spin_unlock(&priv->rx_dma_lock);
 	if (priv->throttled)
 		return;
 

-- 
2.56.0

