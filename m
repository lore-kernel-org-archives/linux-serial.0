Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A90C4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF360F22
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 08:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhHQIPf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbhHQIPb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 04:15:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDCC061764;
        Tue, 17 Aug 2021 01:14:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso5102564pjy.5;
        Tue, 17 Aug 2021 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WCp8noSccte2B57AIkhkKtX0SS0VncdQyviMk909mfM=;
        b=VFHPjEaMVaSuu/WtG+/pu5/GTX7hnLMHr0QpzkV7whvPns3ADAaZBe8HDqpjOdFXQx
         qqdf7Ih1PpIgs9oO+1JVwH19Xt+YM6y4yXzI+VHtqX2vmQMyPdJ6OdQHnPJMzA2Pm7tx
         I2UYbySGeg+lWShsUE+O5vRrR9I4dYNohzxzlOasCUg2DdF7nscnz57oDJcAgebB7bLz
         ryZWCuMhixUDt17AZMiM/hUBdFRDZnPZP4IiWfIcsIpTH9K4FUeorNgmgVk6tGjsxySh
         Je7DTLP7zcAvlpqnJWskJ/2ROn73rEvaWXP0bwHemrCl0OllUi2PKUxpa0Hj4d7uU/g/
         y6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WCp8noSccte2B57AIkhkKtX0SS0VncdQyviMk909mfM=;
        b=ay21+ZDURs0MkFxXYPjFdWZPuxQE65TVshb/6tz0wljqUzRgvV5ZJLapuojivWWdXH
         cdgY4exAJthCayjaKQdlsQa9Qtx+JEJozig645gIq00HaS0mIgFHuhEQ6h0VdMNJx+Cl
         A7nBoFr3CkyUYzTRKXoS4NHMGMiJF4pORc0HXe635M7sY6N+af+0NKytRJGJ3FySZA1J
         M8V97U7cNL8p6kK4MRaTBOdJSn45C3H3gcNzoxQx1LJgfxmjIW9dwU4h1JCfGohORSQ0
         /VtU67hY2+Hpvttf8SanLWMQj3PC3p5wbb3gN/n7Onb5gnQ2wsng8oZLtcG4qw5pnePU
         h6sA==
X-Gm-Message-State: AOAM530tQPWmd1gPtyshLQ4M7yLjC6UXhkJ5gx3Y9KIympyuOO+wcFsO
        /MNs1pF4uo+f++bKW+QccYs=
X-Google-Smtp-Source: ABdhPJweRksqNTFuRv+jSndFB0RZaTfEwZZsX+QUaVfXporkhL5jdLJ3olG7lSAgdNGypubz1jHEyw==
X-Received: by 2002:a17:90b:1c8e:: with SMTP id oo14mr2489762pjb.108.1629188097947;
        Tue, 17 Aug 2021 01:14:57 -0700 (PDT)
Received: from localhost.localdomain ([49.36.209.103])
        by smtp.googlemail.com with ESMTPSA id b190sm2079847pgc.91.2021.08.17.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:14:57 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] serial: 8250_mid: Use pci_irq_vector() to get IRQ
Date:   Tue, 17 Aug 2021 13:44:01 +0530
Message-Id: <20210817081401.3440-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of a direct assignment, use pci_irq_vector() to get the
Linux IRQ number.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 drivers/tty/serial/8250/8250_mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index efa0515139f8..3a279ce0e904 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -299,7 +299,7 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
 	uart.port.dev = &pdev->dev;
-	uart.port.irq = pdev->irq;
+	uart.port.irq = pci_irq_vector(pdev, 0);
 	uart.port.private_data = mid;
 	uart.port.type = PORT_16750;
 	uart.port.iotype = UPIO_MEM;
-- 
2.17.1

