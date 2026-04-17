Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8033F369;
	Fri, 17 Apr 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440036; cv=none; b=UiyyWpRWvT/wSlFqfKui1CS+YjVhataO7AMEU9WqDEhY6Et6qBjEPdEqirDeOPS0M3pG25VBH1zWsQfR8VrabYuir27PKUu1xrzXT6KGWYe3pfJEsGQK3G23thYPkE+vY2EY9qZx9vgkpZKaIBEQJXLcuZxdFFsJzAB3w+z7sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440036; c=relaxed/simple;
	bh=9M/m7/iEXerd05V7b7L2yr85SujnxzgnSV/Dt86WMZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZ1umJFTchyYMMixV1BsOMv4Soh6NWbIvxmWtmoEpl8+K+swMjOwjM56Fxou644ZlsZuNkg3om0rBoU2HOuID/Ov97ug7dv8xpxMwYUre4O8nXflPJAiYmtEoQOvvsZ7QzD5u3IfKVaBMafwLjBBygreZNRGGFD4xaXny/jxlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ShuAP7V0; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ShuAP7V0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=PVatuzDeuSgICP14v/Pc8l1OJ0TJ78LckqcaMkywL2k=; b=ShuAP7V00gyviTsINZtyrd2MbW
	PkdjyDnOAqDpnAhi/WtWykxwbSg7duTjostU0MONe1nbBOV4/KAyef0loXJO/I/mEVVIhqsmBElWg
	XFvbEj7UDCbZlOIvaRS1fTimp+zHoxlLictXNEHFoMQGAx5+f27BAzd7a4mGV174lN5Q=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZk-000000006G1-26ah;
	Fri, 17 Apr 2026 10:53:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:29 -0400
Subject: [PATCH 02/10] serial: max310x: simplify max310x_update_best_err()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-2-b424e105ecac@dimonoff.com>
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

besterr was defined as a signed type was to make sure that the first call
to max310x_update_best_err() would always set besterr. Also there is no
need for it to be a long. By changing its type to unsigned int and initial
value to UINT_MAX, max310x_update_best_err() can be simplified and be more
efficient while achieving the same initial result.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 7c1c3696f5684d6dcaf1149e54bfa96c202c7b26..b68a17ebd10b84fa2ecfc521efa454cb248f90b5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -545,12 +545,12 @@ static int max310x_set_baud(struct uart_port *port, int baud)
 	return (16*port->uartclk) / (c*(16*div + frac));
 }
 
-static int max310x_update_best_err(unsigned int f, long *besterr)
+static int max310x_update_best_err(unsigned int f, unsigned int *besterr)
 {
 	/* Use baudrate 115200 for calculate error */
-	long err = f % (460800 * 16);
+	unsigned int err = f % (460800 * 16);
 
-	if ((*besterr < 0) || (*besterr > err)) {
+	if (*besterr > err) {
 		*besterr = err;
 		return 0;
 	}
@@ -562,7 +562,7 @@ static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned int freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
-	long besterr = -1;
+	unsigned int besterr = UINT_MAX;
 	unsigned int fdiv, fmul, bestfreq = freq;
 
 	/* First, update error without PLL */

-- 
2.47.3

