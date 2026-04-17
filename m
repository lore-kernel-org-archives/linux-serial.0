Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB9355F22;
	Fri, 17 Apr 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440045; cv=none; b=B/srIRR0PGvFMWuBXBFfoz0z4sY3Bz/w4DxJpawEPdzKGgKX8IBj6qSA4cNcir5+xLQH55UZi3OifF5EfiRhNIKXTK/PWBgTYhmlrN2glla7keP8Am4YXPW204uw2ym/nbi5++y4gBX6oDbYgHefk0Ggq1RENh/jX3KDbqwo3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440045; c=relaxed/simple;
	bh=5fwFWD64q/284R3V91Vc+AQbiReL+DimReCrmgsVQik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pynj9pPnxgZOJAw+xKvjJqwIhbtrcMDjchLFMKTFnyLcrOWx9mitp2FfV252Ci4b6LL9ezfvPMkm7wHoFJe43/8j1/WA0P28Tzd8/5Pgm9bwJI/jBq8DzaEeFssiBwTAIzOhZ0MWFehoN1huVSjwtUMLiSapPXLO/byuAbWkLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=FEZRosRI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="FEZRosRI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=tJI+cGERKhwRtiKOq4c7VXzLEXcvXpKZtt7AuIqICpY=; b=FEZRosRIcMJOh6ACnP14sSgxp2
	Gl0tWoJBL02ReTE5MX0cDQ8st9R9wq46yqm5DC+pI8SNZVQg9C4YdIJluIY9zV39dCGwv4P32m/3j
	YaDdHP1iZN3arUZMLvSaR9yEJlkEfbhr6+4vEE+/2GI4U6OlCG/P1/WSprADL20+oqjw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZk-000000006G1-0Bsw;
	Fri, 17 Apr 2026 10:53:44 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:28 -0400
Subject: [PATCH 01/10] serial: max310x: uniformize clock/freq types
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-1-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

max310x_set_ref_clk() returns a 32-bits clock value, so there is no need
to have parameters and intermediate values defined as long. Change
clock and freq types to int.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ac7d3f197c3a5ce3531d5607f48e21a807314021..7c1c3696f5684d6dcaf1149e54bfa96c202c7b26 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -545,7 +545,7 @@ static int max310x_set_baud(struct uart_port *port, int baud)
 	return (16*port->uartclk) / (c*(16*div + frac));
 }
 
-static int max310x_update_best_err(unsigned long f, long *besterr)
+static int max310x_update_best_err(unsigned int f, long *besterr)
 {
 	/* Use baudrate 115200 for calculate error */
 	long err = f % (460800 * 16);
@@ -559,11 +559,11 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 }
 
 static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
-			       unsigned long freq, bool xtal)
+			       unsigned int freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
 	long besterr = -1;
-	unsigned long fdiv, fmul, bestfreq = freq;
+	unsigned int fdiv, fmul, bestfreq = freq;
 
 	/* First, update error without PLL */
 	max310x_update_best_err(freq, &besterr);
@@ -1268,7 +1268,8 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 			 const struct max310x_if_cfg *if_cfg,
 			 struct regmap *regmaps[], int irq)
 {
-	int i, ret, fmin, fmax, freq;
+	unsigned int fmin, fmax, freq;
+	int i, ret;
 	struct max310x_port *s;
 	s32 uartclk = 0;
 	bool xtal;

-- 
2.47.3

