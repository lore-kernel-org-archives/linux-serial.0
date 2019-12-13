Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B746C2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6DC227BF
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Dn0EjSQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfLMAI0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40984 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbfLMAIZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so337875pjb.8
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7pZ7oO5cTd5jJHwXLM3afh3aM9gIcDEQ2gb9GDo3I4=;
        b=Dn0EjSQVnNf9x71ZhWZNtbHBchagWSgfo6KrF9WwWS7N+/3iyq9ryQIUE8bGa+Tc4N
         xCUS4gudBd1JMrtDhL7EI+qQamrfjVvjNcxovLxsSnU81NqkeYCGV7iEVMz6nBb60IKn
         DOI6O2Bg1SdaK++MAjgoHHYaDTVsqdfayBZ7jr7C+qkKrXUoiAbPYeE75isPI+yFvFEu
         dCEqy80NqK13alVnG54vSe9lH4/PGMaLB3QvAPtRjjQjj/jn9oczdk9Fnew9Q5nsdsXX
         cLgHI8uMhnDCuaYPrqI3I28zdTYL8LaJ/rGQVbQhvx7TJ1+30GawvpVTTeytKlFlEi/t
         89KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7pZ7oO5cTd5jJHwXLM3afh3aM9gIcDEQ2gb9GDo3I4=;
        b=i6Cza3eL15V8o0hIqxKzKg9HKhYur68ujPvCMLAGrglZUL9E57J43HMRoM25QoXTx8
         2q0DN0Tj9Gz0SFWd8mejNyQAJNfJpIutB1UqP+22YdteFIDtiV0VfB10kqawh9cru/i8
         vktvPvKd984H0X84ufiynQTHkTU+iuRKneviv+SMUhY9kpRTebv20Dc+h/8DvTld1Zzg
         X4HtiaZ0wDAhbCdozZ0Q5e2UGN0OY7AJi7BYrCtWpbxWHW8CCFdKszmFr5pD0A/vFGnL
         Vwo/wynyh9AcQNLYuoiPm9YVzsFH2SnB9Pua5oG5f/hQXQUdmU+uAVfrgW3PlW120hFm
         1X7w==
X-Gm-Message-State: APjAAAVSaCa/lwMqvREpv44l794lo5lXgfNuj97hSPzb84VM5ZE4F6LU
        26GUtE/KeN1VwvqSpvolQAhDXQ==
X-Google-Smtp-Source: APXvYqzA+oagxH5ZgfTkITXn7ZGmdQEu2sG7wvhevc9As1nHQkVrubK1G02SUzcHYwcMYYup4yADIw==
X-Received: by 2002:a17:902:7884:: with SMTP id q4mr12814553pll.285.1576195704882;
        Thu, 12 Dec 2019 16:08:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:24 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 24/58] tty/serial: Don't zero port->sysrq
Date:   Fri, 13 Dec 2019 00:06:23 +0000
Message-Id: <20191213000657.931618-25-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_handle_sysrq_char() already does it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index ba1fddb6801c..af1700445251 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1378,10 +1378,8 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		ch = psc_ops->read_char(port);
 
 		/* Handle sysreq char */
-		if (uart_handle_sysrq_char(port, ch)) {
-			port->sysrq = 0;
+		if (uart_handle_sysrq_char(port, ch))
 			continue;
-		}
 
 		/* Store it */
 
-- 
2.24.0

