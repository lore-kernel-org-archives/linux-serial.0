Return-Path: <SRS0=ezJB=ZU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BCBC432C3
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB89521787
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IG7ILqGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfK1O5z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43383 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfK1O5w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id l14so20241478lfh.10
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2019 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0x5wbE3oWhrhZ8xGvXaAjigLpm6RmB7AlwGRCMNCtnI=;
        b=IG7ILqGGC9tpQ8FusycptMBnNxwJXMYm82mpACt/Psiu0vHUsWa927iCp7UiIH/rmb
         9xQ2Zj7lLEDuHO/sqXD1kn010Uz5be6KX9wrm88JYO9gw2lgmO8Swi8EEXMC6ivXbyEl
         kpL465Jo/BdCLfZ4fsLJ9HDEhHnupdiLdWy8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0x5wbE3oWhrhZ8xGvXaAjigLpm6RmB7AlwGRCMNCtnI=;
        b=bj4zRjSVszSEU3ApL69ubAgSqYeTvCY1kx28ZskRzCcQqwEbrkqYscR99AoYHxx2SX
         6JolRe7zF2HnIQy9Yxk/kJ3LGimeZ/X4agviYLkWlDLAR0Va3kXk3RNjmninktWMUChG
         wPMK6z4qvcAd09KZpy6HBU29iCEVYRfK7K3so3gQejiqrow8J6qFiGjXyFyayJ/9KW5h
         aej5kDDG5W+mYXPXZCrGqgsX9PT0VMJMsTN1GvZWMEMDpZ/y+gvYhanwxqOcBaB0R4mB
         sQJw2DuV7V5UuWfHiA2eyVgaKt6e4v5v2+YtKIvkawBb5CE5NQLla5rkbTmYMcgY+/BV
         1DxQ==
X-Gm-Message-State: APjAAAWgz9YFFfML5IL18VS8HYo7/sQf6DRLByNcX9eyHOGcEZ2zji/U
        5mViKXplgiXRXGV922iZt0N/5A==
X-Google-Smtp-Source: APXvYqz3m7QVhlf+pIxahJt5XIkNCk58Ecms1+2HgXq/oWJHBU5oMS00KEY4yL0L5WSDwNo3uZhHOw==
X-Received: by 2002:a19:22cc:: with SMTP id i195mr32347477lfi.148.1574953070415;
        Thu, 28 Nov 2019 06:57:50 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:49 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 34/49] serial: ucc_uart: access __be32 field using be32_to_cpu
Date:   Thu, 28 Nov 2019 15:55:39 +0100
Message-Id: <20191128145554.1297-35-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The buf member of struct qe_bd is a __be32, so to make this work on
little-endian hosts, use be32_to_cpu when reading it.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 9436b93d5cfa..afc2a5d69202 100644
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

