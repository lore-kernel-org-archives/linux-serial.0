Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67A1E0DCB;
	Sat, 28 Jun 2025 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093052; cv=none; b=n+qOkzoWkov4prchvriXe1SeGBy4x85oluPlK30GEme8tHJRQrVRygQyUnT9cNqhyZP8D+A1XH+Qu8+lP/nDyw7eDgQlc9CZJ3+G57YXmSKIkahCjz5EQEvh3d1Dh6W+3xZXIRJAXv1ATmC5kJ4aBqeWED7Sc4HWjK5d5GtOqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093052; c=relaxed/simple;
	bh=erXgMqYkh/mznY1woHP4iuOIs8t0m36MYRjWM78nq8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfBYQ1bQzxK1LmbYTWPK4lhcVOMlkfB+gITzv2YSUUklyJ6qyAbxAw7J4Z1Bz+1R8dZecbVPoFRBgqxVtnqYJreSKt4b+MCClkedok1kwlEM9gbePsZC68cYoRfP0HbRgy7h97v3/mEw9+fDbie89Ye1wLHU1qJRKTIECAHo5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OxlWbcQz; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OxlWbcQz"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id VP9buQTOfyAmSVP9buD7tA; Sat, 28 Jun 2025 08:35:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751092511;
	bh=zB9IR/YV4f2yvCg2359n/nATor4vKQ2HEV57YgUZgzY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OxlWbcQzvS/5dttQ6e8xv5VkEpitgxUVJ5vCByRZRkZZPCVRg+ehQerRaSQnMyWO8
	 hZOUVDgt/KO3QmpF9+5k29z2QExs1UNwTSgOP2Gwvf3MVTGtrbRScx3F2LLSFhTNX6
	 s/pmuznzEwueJ9a4GWpzi+1vUkte8wBU3SvGR0/8V8XWBK/2d1n4j3Coexh30QEyy8
	 Dfd59eqTXajtxvToQEkbpmbKDQnPbtH3OCTKnWyoGzK7kyMX6mI1atDjHR0IgUh/4q
	 XS7wCOWD7yyM3U1eKM5BZcvbaYwNaQqQjeQbMkmjpTbm0Ic5nvKcRuQR1qqv1vz+BU
	 H2w6jL7XaoSPg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Jun 2025 08:35:11 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: fsl_lpuart: Constify struct lpuart_soc_data
Date: Sat, 28 Jun 2025 08:35:06 +0200
Message-ID: <93dc860a06f92236db283c71be0640cc477b7291.1751092467.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct lpuart_soc_data' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security.

This also makes the code more consistent.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 172668	  23470	    128	 196266	  2feaa	drivers/tty/serial/fsl_lpuart.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 172924	  23214	    128	 196266	  2feaa	drivers/tty/serial/fsl_lpuart.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2790b4078e7e..c9519e649e82 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -318,27 +318,27 @@ static const struct lpuart_soc_data ls1028a_data = {
 	.rx_watermark = 0,
 };
 
-static struct lpuart_soc_data imx7ulp_data = {
+static const struct lpuart_soc_data imx7ulp_data = {
 	.devtype = IMX7ULP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 	.rx_watermark = 1,
 };
 
-static struct lpuart_soc_data imx8ulp_data = {
+static const struct lpuart_soc_data imx8ulp_data = {
 	.devtype = IMX8ULP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 	.rx_watermark = 3,
 };
 
-static struct lpuart_soc_data imx8qxp_data = {
+static const struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 	.rx_watermark = 7, /* A lower watermark is ideal for low baud rates. */
 };
-static struct lpuart_soc_data imxrt1050_data = {
+static const struct lpuart_soc_data imxrt1050_data = {
 	.devtype = IMXRT1050_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
-- 
2.50.0

