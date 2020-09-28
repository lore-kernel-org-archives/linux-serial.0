Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB7C4741F
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 10:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11FA206C9
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 10:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTg5zb7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1K3x (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1K3x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Sep 2020 06:29:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD8C061755
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 03:29:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so646393lfl.5
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2020 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KIuuoPkfN9AHA3rQQTx1FanM697ocstYg046vC45hc=;
        b=XTg5zb7AoXau66O2R7eHRw5n4IOdN1N+ihrU7BywonWLpof9t5/A6ias5+wgoZcYni
         f+5Vj19LGB0HuPXYFPT9OIgADALziOWN4Oa489+2YxCwfTKFYwWYB9DCotqYz4imwAHS
         A6lrRcWMQ7PjdRHBPx1jo0iFRqdlw+PnR1AyGvwt1fWAxrZXfMFjG10QSj7QOyIM7WsI
         jpZzcqF0F6TOd55WAXjScFJgrupdW3t9FEsw1TWAXogaqIw2SvYK+TLpKim0V548lWXC
         JtQG3uEjIiyWXufSfHo/zzs0v9RDdDcP0PGuBolx52hiO4SDYwmeGhlrZh2iFIAuiEKA
         4AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KIuuoPkfN9AHA3rQQTx1FanM697ocstYg046vC45hc=;
        b=Q0vYj0HnkX6WAN3VGJhtkhmv2inFbfyWHApN0c1cml0mV3XS03ZJmuDLsQ52bKa2EV
         ruLV1M/CFbIhSOyH0iPuuPwSfnzEmTb5srvnoyWL7G6K4ibBYb/sHXBp1DEZsNqHROKt
         nJXjYIHPYGyGOhntG53ls9weavY3Xa5J8BaoMKkaAZnFtHHnA6rREp2S0rY+AtsEWSkW
         XYXhupPHQdubipQvahyPJ+UoJwAJqdAIMsGCFPFsNE5BJlWj6cLz2cij2E3+R+dmZm3d
         uC3kJZy4D+8HTz5moeuwrRgIplWUWQXAOCYfHwK/ijuecgiFfFDgfKoIZKkTIzxSj5Eh
         s8tg==
X-Gm-Message-State: AOAM532xnq9EXTgFhe9B0AjTtwvMr4oywgaAURDybuoHOCGw9MKzTHLP
        fyHtMaDDEug3S5zA4I4FdsbMUh5ndzjlbRyf
X-Google-Smtp-Source: ABdhPJzU9xS3VN8x/BZmwGglipTz0k9Eu57zKryBFEceVb5wgj4h3of0tGnwXw9R+nGqqmqiVKBgQA==
X-Received: by 2002:ac2:55a2:: with SMTP id y2mr239468lfg.44.1601288991088;
        Mon, 28 Sep 2020 03:29:51 -0700 (PDT)
Received: from localhost.localdomain (110.80-203-69.nextgentel.com. [80.203.69.110])
        by smtp.gmail.com with ESMTPSA id p19sm2803078lfc.22.2020.09.28.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:29:50 -0700 (PDT)
From:   drolevar@gmail.com
X-Google-Original-From: aabyzov@slb.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Andrij Abyzov <aabyzov@slb.com>
Subject: [PATCH v2 1/1] serial: 8250_fsl: Fix TX interrupt handling condition
Date:   Mon, 28 Sep 2020 12:28:41 +0200
Message-Id: <20200928102841.43782-2-aabyzov@slb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928102841.43782-1-aabyzov@slb.com>
References: <20200928102841.43782-1-aabyzov@slb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andrij Abyzov <aabyzov@slb.com>

This is the port of the commit db1b5bc047b3 ("serial: 8250: Fix TX
interrupt handling condition") to the 8250_fsl irq handling logic.

Interrupt handler checked THRE bit (transmitter holding register
empty) in LSR to detect if TX fifo is empty.
In case when there is only receive interrupts the TX handling
got called because THRE bit in LSR is set when there is no
transmission (FIFO empty). TX handling caused TX stop, which in
RS-485 half-duplex mode actually resets receiver FIFO. This is not
desired during reception because of possible data loss.

The fix is to check if THRI is set in IER in addition of the TX
fifo status. THRI in IER is set when TX is started and cleared
when TX is stopped.
This ensures that TX handling is only called when there is really
transmission on going and an interrupt for THRE and not when there
are only RX interrupts.

Signed-off-by: Andrij Abyzov <aabyzov@slb.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..ceac6cfce4c7 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	serial8250_modem_status(up);
 
-	if (lsr & UART_LSR_THRE)
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-- 
2.25.1

