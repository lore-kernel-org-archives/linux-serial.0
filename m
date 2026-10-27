Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099260;
	b=4wmMekPWHMi48kyd35mzQL8hwbI2INUp6MaiVSlSJ3fCyoil7AmPli/7K59o0prSkngi
	 aA7b9uLiiyg72sJ6xzWwDDQHY1DQ0hPA6yMSPGdp83wAywf2MXQVTD+WKTipkwOrjdVJi
	 MnbQO2ZQ8wNM8GJ9meXD1qfuXYsUMumPTgzUapP0rCJqWZ4LPdv2r7ZcnWXHvr88/bGjm
	 VcGp8ZNuM6AcbsFJrM/CauWyBh9P7zVRyQ+Emw+WWFMPI1dSLWdoqM/wKA2DCdyUaQkrR
	 Q1B/JCaXDxPVl3DIQfbOSAasxBsMW77UbbzWiIsUcKV+BjVSGpGWw/KZKLJqR9brKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099260;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dNl5ic2amd4z3lkcUUtwLKZNHP6Pu6cXCxhMSbp50xA=;
	b=Ev0OlvXIFdDr7aSoA9CvTNYiqEN31JWmAyOExUDAEk7Wb8znVGFLMpkFRcRiw3KDFHLL
	 RoN7yZu3XkzAjVxtwB9LKJerNPTj1Q479Uy4yMOW2thSNGkqO7gZapXxrHajpqYlZ0SRc
	 hyeXDUU1pzu8Dpl8Z2hmYYtzDk6x5hKwWoEuGBz6RfxQGUeT0R162tjw3n1rbsI4juMdO
	 9W9ap8KGaq2qw+yms1LGyphEju85ROIxYXxLZ+Bfq0/OqtnhRZlb4IDYBXeJFUOsz0zWY
	 OTClVOY296zICYHIywGig4Ce9vd79EoTQWefNd8hqusDcxU6HZ0I/XGHOS0VejaMCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hX5C9xuN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A890606A9AF;
	Tue, 27 Oct 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hX5C9xuN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B0C1F01825;
	Tue, 27 Oct 2026 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099259;
	bh=dNl5ic2amd4z3lkcUUtwLKZNHP6Pu6cXCxhMSbp50xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hX5C9xuNNaw47Cy0z1djiAIOS+OFgwDnL1OJHunbqFE/BuzztaruLk+por6gAM3my
	 OUR7K+uAS3dPDwAh9YS+v2BB9tc/TnpiwchCHV4LKvu16vIn4o7miiPWMzxJILLM6A
	 QgrmrG67SNZH6c35+ULo3PKMikw6RwQ/M+3H7Nm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:47 +0100
Subject: [PATCH 21/24] serial: samsung: don't leak the tty on an RX IRQ
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
Message-Id: <20261027-tty-llm-v1-21-99b0202ae546@linuxfoundation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=zUTDnaRvGyw7vfTWdI9Bk89WKI6qR559yEa3wVXeQvw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvcnlftdszL/emBOwLMpS30kDr1rPzFX1eKQhMUSj
 xWBDpk1HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRvDiGBTcKlzFP5n39h0ch
 NrhdkMOmYeb5IoZ5mn2cG2/ULBb5M+X7yp5q3cseGg/cAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

s3c24xx_serial_rx_chars_dma() starts by taking a reference to the tty.
If the interrupt is not a receive timeout, it switches the port from PIO
back to DMA and leaves through the "finish" label, which does not drop
the reference.

A port with RX DMA changes to PIO on every receive timeout, that is at
the end of every burst of data, and comes back this way when the next
burst starts.  So each burst takes a reference which is never dropped,
and the tty structure is not freed when the port is closed for the last
time.

Drop the reference on both paths.

Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
Cc: stable <stable@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636..c9a870a8d155 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -736,14 +736,13 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(struct s3c24xx_uart_port *ourport
 
 	s3c24xx_serial_rx_drain_fifo(ourport);
 
-	if (tty) {
+	if (tty)
 		tty_flip_buffer_push(t);
-		tty_kref_put(tty);
-	}
 
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
+	tty_kref_put(tty);
 	uart_port_unlock(port);
 
 	return IRQ_HANDLED;

-- 
2.56.0

