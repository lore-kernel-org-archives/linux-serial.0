Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D06DC4361B
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327722333E
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgLFHkX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLFHkW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:40:22 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAFC0613D0;
        Sat,  5 Dec 2020 23:39:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n10so6310052pgv.8;
        Sat, 05 Dec 2020 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=sl7tPaYtWuJtN4a02jewnPtACMGAgfca/itbB7j5yGS6l6p12/agrLhqB+LnoTH4EU
         VXUeR2dCsxgSEECjQ0YBTDIJlxRA8dEi0eY3YV0zPB76OQyhOhFzJOb4EQA8E6oYOcY9
         venDmOcHboGd+UqZukFY9tKpPUImm+ALbrJz66toLW/t5lJt+T5k5AYLzyze6ieqm+vi
         vdof9DuXg+RP8cX/1D27XhBes9XkrGvEdyks4/rqwis3oBFUlcnOh/qn043kndUAtrxx
         J5j7D0mJmThQzfyfuVLGcU6vJiwvmycXC9bZ7jCXK8odmzN8eNJcY13gI40Uc89VZ5p/
         VRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=jegscwTw8RQeBqoXMxVxEy+y0IK9EbeoIZM4mK+JfDsfZpIsTfGH8KWbwpNKvKQDCj
         tw30MCuA5ER2splrqgNHcijctmQE1ZUgBuOJ2TEPVFk6rKf9jazA9lw8ruoX3BFQPffO
         dkXQCt5jTGwNs0sy+I3/ZW4HqbSX5D3iEAUGwAz+NlntZEd7ut2h7otevixHHBiDspT8
         zAVrR98A8VWIxaxzvNBwnhdMBr3KjzcL1jETrb3YLEODNxDrU3jqjXjcN+BtMRGYJopZ
         17Cjhw27Wtv0FbHaFjFl+l8iKWwtpTxXyrA9FQyADxQHHHgWVs6tcnlxcTD8ft25Vu0N
         w/ng==
X-Gm-Message-State: AOAM530xCVy/O+GkQ+WZsN8g5Ek+QXQpBc+wZn/+dXqBFPzM2Aeiqzh6
        GhmLEtkXGh84S8O1nOM5tcA=
X-Google-Smtp-Source: ABdhPJx4vTPoVDjjto5SxXJBsbNYSt6P4giSe/+q7gxvUTKUAQE7jOG4M/WxfOmF/mhKK8HZ9iT2Rw==
X-Received: by 2002:a62:b417:0:b029:18b:8c55:849f with SMTP id h23-20020a62b4170000b029018b8c55849fmr11068305pfn.27.1607240381271;
        Sat, 05 Dec 2020 23:39:41 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:40 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:25 +0530
Message-Id: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..512b77195e9f 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,7 +607,7 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
+				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-- 
2.27.0

