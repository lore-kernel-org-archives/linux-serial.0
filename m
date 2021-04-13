Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3349C433B4
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1EC613B2
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 08:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhDMIqs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:46:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:31527 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbhDMIqq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Apr 2021 04:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618303573; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UNLwXAFowvzkpoknwlLaUr0/O30ckBbWbRLC0RhsGy6G35aJkjFBQkSf0F015KjE+o
    AIrk0OA8fJ9eKVUx8dLUMe8qU7G9BIdDhg+ma2Bqck94D4su8JIAPe2aOpShGkp4REfE
    f6Mkgl1VMeNzU3CvxOKf1Sw9PjzdQzQr8IspuU7lFXYWluatOwFRUw99mG+98j/Xv252
    wC+MTRtATeERXoyw498iXgEeISs1SjuTFI2eSrk515ZxpSVR6OljYDCtfLH4dmCbBm0U
    jPc2nk3emDAfvbWhuwm5lE7XLTnOR62SIC85rGHkyt71BAOUET+Zeb6WSNZq1eTQvygz
    pafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1618303573;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UszZM0lxzcT1TucYYh81PlY6CI1II6hKqZ0KtEwG5JI=;
    b=AdcrTIm0QGglFhn3sR++Xn2cexUhH1UpTuKYO1pPv8BIgaJw8EdvCfzZHdlw0T+FVB
    7trGuvdlHJVKqqRa/BvEwDAo0kFTm8zxhJjR8Bxi3Bf69q5jrUBLw5b58e/g2vzqq3pQ
    0NOrMTYHhh5S8ifuDIyEV3rcsR85nwZY65xz0XkA6JgYvlgQ2VYsGREyO0UWz03CKKj7
    IJDcsqpefIIs6Ctv2aXjvZs87roCH4WlqT9bowTPv0Yw4/sK9j6XVDK15huA2Hc26aZ4
    y30QolZ8WMRna1to5dQSTHomcuTNsHpunpZ9oe8+jXhmEFIkR+RZ+tOm2QNmJOuyhSy4
    1D8Q==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1618303573;
    s=strato-dkim-0002; d=fpond.eu;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UszZM0lxzcT1TucYYh81PlY6CI1II6hKqZ0KtEwG5JI=;
    b=Wc3yoPEoK6vmST9hChb9UB8rzSA//PWU+d7G3fQmercRwjOQfc5QK4izIyx2D/Byqa
    C0miNznC4Q/baeNOCPcm3VhZJryy16pOFLAaYIoqUx05SrAymYWt0W4o97PXrgoumXUg
    ZJFlSxQYiuLzgk+pTziWSXmVkyoVtdnrXnbPrjMi5LTpjgSwl1Lt1iKutUzK1MUMuikh
    EGpnaW/BrP5bAlkCK0KUYkm+W9LzpFE20CryACMh+CkKFmjzRD5zuoSrrc8grZvHW6Q6
    DPnkJF2/V8dfVHWZE2nLpWapfBAV95kikG52/83E+g6wBOHsPY8bpd8WeN62F5Sq+QVY
    wBJg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA67Ot4fvR82FZd1Lc+g=="
X-RZG-CLASS-ID: mo00
Received: from groucho.site
    by smtp.strato.de (RZmta 47.24.0 DYNA|AUTH)
    with ESMTPSA id m01edax3D8kDOQO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Apr 2021 10:46:13 +0200 (CEST)
From:   Ulrich Hecht <uli+renesas@fpond.eu>
To:     linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     wsa@kernel.org, geert@linux-m68k.org,
        yoshihiro.shimoda.uh@renesas.com,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH] serial: sh-sci: remove obsolete latency workaround
Date:   Tue, 13 Apr 2021 10:46:11 +0200
Message-Id: <20210413084611.27242-1-uli+renesas@fpond.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since the transition to hrtimers there is no more need to set a minimum
RX timeout to work around latency issues.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
---
 drivers/tty/serial/sh-sci.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e3af97a59856..ef37fdf37612 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2609,21 +2609,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		udelay(DIV_ROUND_UP(10 * 1000000, baud));
 	}
 
-	/*
-	 * Calculate delay for 2 DMA buffers (4 FIFO).
-	 * See serial_core.c::uart_update_timeout().
-	 * With 10 bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above
-	 * function calculates 1 jiffie for the data plus 5 jiffies for the
-	 * "slop(e)." Then below we calculate 5 jiffies (20ms) for 2 DMA
-	 * buffers (4 FIFO sizes), but when performing a faster transfer, the
-	 * value obtained by this formula is too small. Therefore, if the value
-	 * is smaller than 20ms, use 20ms as the timeout value for DMA.
-	 */
+	/* Calculate delay for 2 DMA buffers (4 FIFO). */
 	s->rx_frame = (10000 * bits) / (baud / 100);
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	s->rx_timeout = s->buf_len_rx * 2 * s->rx_frame;
-	if (s->rx_timeout < 20)
-		s->rx_timeout = 20;
 #endif
 
 	if ((termios->c_cflag & CREAD) != 0)
-- 
2.20.1

