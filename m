Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C167C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5468420758
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiVBIWKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHQI7k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgHQI7j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 04:59:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E7C061388;
        Mon, 17 Aug 2020 01:59:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so7491463pjb.3;
        Mon, 17 Aug 2020 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dprMDdtzRUqVhrLyliJzSuOBrFlLqstZsl9JNe0NSK4=;
        b=PiVBIWKYpZOwpl3l30M6Fo3rPU5nW0nfTubZQV7JUc+vV0A64yGrNLFdEjouXpaa5k
         Z5MoM3QXi9zN03azfYuFoEgScl5BTcR6CYvCRXQ0yUUkhjRyt2gbWOpjMrL8eEKGIAH/
         t5PN9g3nz5jnInLj5+xhlgTaoAPzC1QEmRa/NN3HL8FR4C0cKFBl2OyupfYgLxWhk4qZ
         y6oV4Jn7ofsbDRM2qFptLzVp5oA/WPWcct7BDmWBh2FIlElullflHeaz9Rjp6X4myAn5
         MJD3otw4Ijv/FhpK+p9x8q2mI9Vd1VRlhBf7SnAUps5VsK+hCda8WhTlrQ/B6j9SiBas
         2ZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dprMDdtzRUqVhrLyliJzSuOBrFlLqstZsl9JNe0NSK4=;
        b=HHpWEkVN7NBP/RiyeNvU+R5//i8XBHa4iXd8T/d6fZtucwhmwHK67YcTBAWl1pSfrt
         93yDMSOasSuXmH3l7wKDr2VS4mON0yQJXcwyH2tXuHx/2tAU317lWWJhy18MIZ6nqAhD
         zELc/gLiWCzJ6HJ5KCEs0ants3pH9ZR4MqZgYpN1cdd3Rh/tmy1+ArAWTHD7hBYyrz/z
         O1INngrRRxqbYri5y9tnrLWojpyxvbt/8lI+emUHp8ouMuCF7TUR5ZlcqOqoMJidosVL
         FlWlc8pjCVkYEzTaOsly7va3p7Y9YHtrBTZcZxOWRwWtdqrnIUPWPBfgpL/IzAz36sUy
         PG3g==
X-Gm-Message-State: AOAM532lnc/e0OsLB0VXdep8vRhA7KkFCE688oCSYsE/d3+XyqHaXrd2
        J8KkBV3eYwDZx54qPy+NzJbdHtuGc6/jmA==
X-Google-Smtp-Source: ABdhPJyhdp9fjnJK79p+NpoPwon5bOwfZA4oyGKma49ni2x2sF9tVyQew0t66rGvuOPdfS5alrGOlg==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr10665077plj.64.1597654778442;
        Mon, 17 Aug 2020 01:59:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j13sm18508547pfn.166.2020.08.17.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:59:37 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 2/4] tty: atmel_serial: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:29:19 +0530
Message-Id: <20200817085921.26033-3-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085921.26033-1-allen.cryptic@gmail.com>
References: <20200817085921.26033-1-allen.cryptic@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e43471b33710..a9c47f56e994 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1722,10 +1722,11 @@ static int atmel_prepare_rx_pdc(struct uart_port *port)
 /*
  * tasklet handling tty stuff outside the interrupt handler.
  */
-static void atmel_tasklet_rx_func(unsigned long data)
+static void atmel_tasklet_rx_func(struct tasklet_struct *t)
 {
-	struct uart_port *port = (struct uart_port *)data;
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
+							  tasklet_rx);
+	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
@@ -1733,10 +1734,11 @@ static void atmel_tasklet_rx_func(unsigned long data)
 	spin_unlock(&port->lock);
 }
 
-static void atmel_tasklet_tx_func(unsigned long data)
+static void atmel_tasklet_tx_func(struct tasklet_struct *t)
 {
-	struct uart_port *port = (struct uart_port *)data;
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
+							  tasklet_tx);
+	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
@@ -1911,10 +1913,8 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	atomic_set(&atmel_port->tasklet_shutdown, 0);
-	tasklet_init(&atmel_port->tasklet_rx, atmel_tasklet_rx_func,
-			(unsigned long)port);
-	tasklet_init(&atmel_port->tasklet_tx, atmel_tasklet_tx_func,
-			(unsigned long)port);
+	tasklet_setup(&atmel_port->tasklet_rx, atmel_tasklet_rx_func);
+	tasklet_setup(&atmel_port->tasklet_tx, atmel_tasklet_tx_func);
 
 	/*
 	 * Initialize DMA (if necessary)
-- 
2.17.1

