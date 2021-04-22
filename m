Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1BBC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980636144D
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 12:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhDVMLw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:11:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVMLv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 08:11:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lZYAt-0004lM-Am; Thu, 22 Apr 2021 12:11:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] tty: serial: jsm: remove redundant assignments of several variables
Date:   Thu, 22 Apr 2021 13:11:15 +0100
Message-Id: <20210422121115.246625-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Several variables are being assigned with values that are never
read and being updated later with a new value. The initializations
are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index b507a2cec926..b58ea4344aaf 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -349,8 +349,8 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
 
 static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 {
-	int qleft = 0;
-	u8 linestatus = 0;
+	int qleft;
+	u8 linestatus;
 	u8 error_mask = 0;
 	u16 head;
 	u16 tail;
@@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 	head = ch->ch_r_head & RQUEUEMASK;
 	tail = ch->ch_r_tail & RQUEUEMASK;
 
-	/* Get our cached LSR */
-	linestatus = ch->ch_cached_lsr;
 	ch->ch_cached_lsr = 0;
 
 	/* Store how much space we have left in the queue */
-- 
2.30.2

