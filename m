Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A8C4725E
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F9A20735
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="coadFIRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgEFIC4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 04:02:56 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10399 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgEFIC4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 04:02:56 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200506080252epoutp02bf9de548f8da74b5e233990ad74132fa~MYa8BDjqi1633816338epoutp02O
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 08:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200506080252epoutp02bf9de548f8da74b5e233990ad74132fa~MYa8BDjqi1633816338epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588752172;
        bh=61ODT2axQe06P744CgMbtbc7G+bDFc+joNgyQO0iE/s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=coadFIRYeUNxm70IITseII25rSWdpOK4kXrf//DNTxmpoEN2zvLBOt4nSrKsY+Z4C
         FxsvGkmgX+tRbw2952e9i0V2K02iO2aBaAX6BhSMcj6NUt8OrjAC0uxjwODzPb7xPi
         2ggeV1WRgJeqFdtnoIpOGHEod7eoN+7PDPHYBBoQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200506080252epcas2p117981e14e0c7a488168620682c3baf82~MYa7jhNhh3197431974epcas2p1a;
        Wed,  6 May 2020 08:02:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49H8GL3YBCzMqYlv; Wed,  6 May
        2020 08:02:50 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.BF.04704.92F62BE5; Wed,  6 May 2020 17:02:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200506080249epcas2p47ffb915f9c469d208224cbdecb2d723d~MYa4kc-im0699206992epcas2p4T;
        Wed,  6 May 2020 08:02:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506080249epsmtrp159e0a1e16e48a5225d1a76281a66b97f~MYa4jveoI2932429324epsmtrp1g;
        Wed,  6 May 2020 08:02:49 +0000 (GMT)
X-AuditID: b6c32a46-811ff70000001260-72-5eb26f292560
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.3F.18461.82F62BE5; Wed,  6 May 2020 17:02:48 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200506080248epsmtip1a031014909f7a3b4dd3d552a37229dcb~MYa4UoFHN2841028410epsmtip1C;
        Wed,  6 May 2020 08:02:48 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH v10 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Date:   Wed,  6 May 2020 17:02:38 +0900
Message-Id: <20200506080242.18623-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmma5m/qY4g8uTpCyaF69ns1i19Aaz
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGhgV6xYm5
        xaV56XrJ+blWhgYGRqZAlQk5GWc+Kxc8kqpYdvYUYwPjQbEuRg4OCQETiU+trF2MXBxCAjsY
        JRrf/GbpYuQEcj4xSsy4YgqR+MYocX3OVEaQBEjDvOdnWCASexkllnz8zQjR8YNR4uhOKRCb
        TUBb4s33mcwgRSICS5gkpp9/AjaWWUBT4seBG6wgtrBAmMTS30fYQGwWAVWJNSengsV5BWwl
        2p++YoPYpixx4d0SVgj7ELtE92Y+CNtF4tq/y1AXCUu8Or6FHcKWknjZ3wZl10vsa5vIDnKE
        hEAPo8TPD0+hBhlLzHrWzgjyP8hB63fpQ4JCWeLILagz+SQ6Dv9lhwjzSnS0CUE0qkms+/aC
        CcKWkVjzdBfUJg+JL+8fsoKUCwnESrw94TWBUXYWwvgFjIyrGMVSC4pz01OLjQqMkCNoEyM4
        kWm57WBccs7nEKMAB6MSD6+B+8Y4IdbEsuLK3EOMEhzMSiK8PD+AQrwpiZVVqUX58UWlOanF
        hxhNgUE3kVlKNDkfmGTzSuINTY3MzAwsTS1MzYwslMR5N3HfjBESSE8sSc1OTS1ILYLpY+Lg
        lGpgNPgm7mWT5mijr9r4bmez37pzT65nr2P2Zfa7dFVZW75f5ZdXWOyK0G06s9//sbj/Z07a
        60bNotsGLCzKDQeNb4Vbffi9Xu7f++7dbOYf8sTOTFOZ13jT22xvOUtc/Qzno+d23M7dsvDd
        9TsMEsfmNHFkJ5o69dZnBnIJdq/T+p9a2GKzc7+nEktxRqKhFnNRcSIAsWbnVHoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTlcjf1OcweJLNhbNi9ezWaxaeoPZ
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8aZz8oFj6Qqlp09xdjAeFCsi5GTQ0LA
        RGLe8zMsXYxcHEICuxklbl59wQyRkJGY8GIJlC0scb/lCCtE0TdGiVeLJ7KBJNgEtCXefJ/J
        DJIQEVjFJHH9wBImkASzgKbEjwM3WEFsYYEQiVMtDxhBbBYBVYk1J6eCxXkFbCXan75ig9ig
        LHHh3RLWCYw8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIeYluYOxu2rPugd
        YmTiYDzEKMHBrCTCy/NjY5wQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1ML
        UotgskwcnFINTNrJ/vs/+2VlXX1QsCxi3ovTtpG5jNwS++NfPg/8va9ewjZloTunyKF35V0v
        zwWabkhY//yeHrP1qwLDggVV52qLxLPPTs36b224rY9NXflr5gsexoDJLdzTRBgSPt5Vqsrd
        tlCF4Xh4jcfF083zj0gtfNos5uIRn3M7YU37kTm7Z3k7m9ZLTX746XANy7lD8w7LO2Vnfeir
        /sAfwBwiE/lH/12RpFyBj7qXuCCT3ALFctnU/9/r/kn+f72RkQnouNr9L7NkM0R51zNMNt6a
        +FaZaYXh5cOvvs8UM5GODxL35JjPffV7091da4LN1myveiXXP+nbvI5zCXzzvppYv3nOy/pP
        d3aQGLvazO9KLMUZiYZazEXFiQAV9SOUoAIAAA==
X-CMS-MailID: 20200506080249epcas2p47ffb915f9c469d208224cbdecb2d723d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506080249epcas2p47ffb915f9c469d208224cbdecb2d723d
References: <CGME20200506080249epcas2p47ffb915f9c469d208224cbdecb2d723d@epcas2p4.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch change the name of macro for general usage.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid HC1 (Exynos5422):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 73f951d65b93..326b0164609c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -154,10 +154,10 @@ struct s3c24xx_uart_port {
 #define portaddrl(port, reg) \
 	((unsigned long *)(unsigned long)((port)->membase + (reg)))
 
-#define rd_regb(port, reg) (readb_relaxed(portaddr(port, reg)))
+#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
 #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
 
-#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
+#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
 /* Byte-order aware bit setting/clearing functions. */
@@ -714,7 +714,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		fifocnt--;
 
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
-		ch = rd_regb(port, S3C2410_URXH);
+		ch = rd_reg(port, S3C2410_URXH);
 
 		if (port->flags & UPF_CONS_FLOW) {
 			int txe = s3c24xx_serial_txempty_nofifo(port);
@@ -826,7 +826,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	}
 
 	if (port->x_char) {
-		wr_regb(port, S3C2410_UTXH, port->x_char);
+		wr_reg(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 		goto out;
@@ -852,7 +852,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		if (rd_regl(port, S3C2410_UFSTAT) & ourport->info->tx_fifofull)
 			break;
 
-		wr_regb(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
+		wr_reg(port, S3C2410_UTXH, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		count--;
@@ -916,7 +916,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_regb(port, S3C2410_UMSTAT);
+	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -2185,7 +2185,7 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
 		return NO_POLL_CHAR;
 
-	return rd_regb(port, S3C2410_URXH);
+	return rd_reg(port, S3C2410_URXH);
 }
 
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
@@ -2200,7 +2200,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, c);
+	wr_reg(port, S3C2410_UTXH, c);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -2212,7 +2212,7 @@ s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
-	wr_regb(port, S3C2410_UTXH, ch);
+	wr_reg(port, S3C2410_UTXH, ch);
 }
 
 static void
-- 
2.15.0.rc1

