Return-Path: <SRS0=ooY1=ZA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F05C5DF60
	for <linux-serial@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7EE2248B
	for <linux-serial@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iVy3OBxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKHNDb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41270 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfKHNCM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id m9so6114352ljh.8
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2019 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=iVy3OBxWjNuefDddBNbhbl7Cs/NtWVdjCC/od1h2NY+gSnjfqrNC9xMyzWE6JCHadL
         meWz1TdGa1kFUaFe1LBV/jM67MkOrHyRosHmDMbLKH/YlGIs4KIFUjA0IRlMr2sAmplm
         OZODn39ovzWFKJB/jcopkfA5Ou+HMW8/g56bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rl5uwkPm7ODgb0mKXC73DMWhjRD0JTB3vFmrVrN5ZB0=;
        b=m8JcYvebxFu+ciiHIvg63Ik9P7kGMwCuD4ipKIHn7eAlkBhFcDodTCZ53vwqQh0tDf
         zXwEPTyEIM+2Fe5TCU2/RG/RNSdaHCxlePp7wD08xtZF6vofXvqEf7W86hYqJfw3lgfv
         Ag/8VghoPLfYiR2tmITy34JNCTJLFeWGxJ5GYFF/20lnG40PWUcrf5U2sinzX3OCOBO2
         Aj7YxQf2XQRttKify2q5dGbWKA0jq7z3m/tOLLJwk7NK9l0sO5ov6G/jnwa7vQzV1bcf
         YI44cF2cO1EtJjxQonTSkRLqJS0+3Gcx0jtOirAcDxYYAPnfpDnzYKm9xeHLwce7nXT5
         +OIA==
X-Gm-Message-State: APjAAAW/7KFz62NQlY1/SbmPXaTeqgtuyntqEI28YpIt6VlIqtK+t6wI
        Jj5PRKBlZ0l0wXooZWqI+13ZlQ==
X-Google-Smtp-Source: APXvYqzZa5jEsgyjO4bjCEsZXjRtgdus6spNSgtKC++GgbqHCKBa6/dHZb1FcDGJ/haiGgd6jr0bwA==
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr6831944ljo.52.1573218130055;
        Fri, 08 Nov 2019 05:02:10 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 33/47] serial: ucc_uart: access __be32 field using be32_to_cpu
Date:   Fri,  8 Nov 2019 14:01:09 +0100
Message-Id: <20191108130123.6839-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The buf member of struct qe_bd is a __be32, so to make this work on
little-endian hosts, use be32_to_cpu when reading it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f5ea84928a3b..a5330582b610 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -343,7 +343,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 		/* Pick next descriptor and fill from buffer */
 		bdp = qe_port->tx_cur;
 
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		*p++ = port->x_char;
 		qe_iowrite16be(1, &bdp->length);
@@ -371,7 +371,7 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
 	       (xmit->tail != xmit->head)) {
 		count = 0;
-		p = qe2cpu_addr(bdp->buf, qe_port);
+		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 		while (count < qe_port->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -491,7 +491,7 @@ static void qe_uart_int_rx(struct uart_qe_port *qe_port)
 		}
 
 		/* get pointer */
-		cp = qe2cpu_addr(bdp->buf, qe_port);
+		cp = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
-- 
2.23.0

