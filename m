Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE7327C13;
	Fri, 17 Apr 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440030; cv=none; b=C5HXyYqRek83A0ZSnR1Phk3ILQp/KcjfEOG70h3Di7cKY729fWRFUf0vgyn/uzShOFGq8n0QNX4KC+/Tj7hLxh17p/D3u0P1LEEV7O2ldEyoXkd99eQGhcrKAm0bDTTTgMsZ8qShphbSFCwWjwv4ulir9flovGSwRP8A6RPQb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440030; c=relaxed/simple;
	bh=4U0P3A5wrxly9jIJ5YkfKdkeyY9my7q2UQ4LbHi4KRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSD6BDiMnJqADAUeZ3bkcMZJTlbr6vCnkoquOV0nPOXqT6i03RxKL6bLDmU6qVY52jW6glsi1tR2Fo5/ttoCA9wi6AAMY2a6sV3mtatQHOLwmNspTJWRNgKzOd5AJgQnadOe5fWfDDyMmq/yrn671ZAzV8hTFGYOOtpIcC0L6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=dXdaAToO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="dXdaAToO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=YEeGNMfEveyhN4xQnnwYA24tkEbgabYnkwZa9juJ0IU=; b=dXdaAToO2hn0m+5occo9gUDnvs
	tv6GrUD+A45l5eQgpWp5/lUOpNitVUfo0Gq4JjKizVMWeZGul3dLNq1hq4tjsmJ9I7o1MFGLKcbYj
	reYnNi7IyB6XlkjLlw/qe0bIyp/z3Y+ac57ypN5k3Gz3W8dCe2RbwZHU9vYXDckqYs8o=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZl-000000006G1-13NJ;
	Fri, 17 Apr 2026 10:53:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:30 -0400
Subject: [PATCH 03/10] serial: max310x: change return type of
 max310x_set_ref_clk()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-3-b424e105ecac@dimonoff.com>
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

Having max310x_set_ref_clk() return an s32 as both an error code
and a frequency value is ambiguous. Fix by passing a pointer to the
frequency value that will then be updated, and simply return a status.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index b68a17ebd10b84fa2ecfc521efa454cb248f90b5..cf27e597ea41541331c8786fe4b4ded39b53d291 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -558,8 +558,8 @@ static int max310x_update_best_err(unsigned int f, unsigned int *besterr)
 	return 1;
 }
 
-static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
-			       unsigned int freq, bool xtal)
+static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+			       unsigned int freq, unsigned int *fref, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
 	unsigned int besterr = UINT_MAX;
@@ -632,7 +632,9 @@ static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 					     "clock is not stable\n");
 	}
 
-	return bestfreq;
+	*fref = bestfreq;
+
+	return 0;
 }
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
@@ -1271,7 +1273,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	unsigned int fmin, fmax, freq;
 	int i, ret;
 	struct max310x_port *s;
-	s32 uartclk = 0;
+	unsigned int uartclk = 0;
 	bool xtal;
 
 	for (i = 0; i < devtype->nr; i++)
@@ -1357,11 +1359,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
 
-	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
-	if (uartclk < 0) {
-		ret = uartclk;
+	ret = max310x_set_ref_clk(dev, s, freq, &uartclk, xtal);
+	if (ret < 0)
 		goto out_uart;
-	}
 
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 

-- 
2.47.3

