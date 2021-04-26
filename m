Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE22AC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D9F6135F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 09:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhDZJj2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhDZJj2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 05:39:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62741C061574
        for <linux-serial@vger.kernel.org>; Mon, 26 Apr 2021 02:38:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 10so3128513pfl.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Apr 2021 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nNYVoLZ2M9Fv+cfVXQBe5h6IwwsXLKTHYix9oWYmm8=;
        b=W+3dPf44tUVS3krdJWP1Y+bVI9DLY1/yvpg4/PN6mluYrjfrYr/6f5ibJLIMxQ/YE6
         V4NN6z4nOh+bRr+WXC9drqUcU23MxEmekkX/YdnmiAmxU3uYxmzlynbNBsRiNsTLCmZ9
         IZDVw63/uc2S6fCshMcax3HdLqP9PD8c5MroiF3COt81X6w+GRiettXANs+9xi/fkYL5
         D187bJtQRunpuE/1Q0RxrNVQsDucHEFe1cxXBQ/PCf2RsdgXUZgycjUsFSMmugMr4yaN
         v25NaXwsXmkS7GJD5Z12ik1ABDji/rdzzHeohRyXNEBCi4QTihQl97SO9cjF1lCjn13W
         ZCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nNYVoLZ2M9Fv+cfVXQBe5h6IwwsXLKTHYix9oWYmm8=;
        b=TbT/VTH7g6xB/+fx4jkGGPRtIct3TIsEw/WIO+nLyTHQve1rm/uXkqo1vuF9jwmysp
         rWu39sr6W5aif9cvEzG+F/sylt+3g43uw7dyifP+1USaxwETusAL+tU67y4JyWrT5DLP
         mlFoE5/O1/2nv+4sV12fZWG8gHx1ZZSedDkg39t1bJVAmq7Ebrwtsfgz0kSuXWcuM5a0
         aSiMtCQJCiX+nPUEbuadP6YGSGoGygLUIMsroNsnOnN+dVmky1ZgbRsKjtZK5KyZYPEV
         XaASDXHRFXmZVV3zycTowaUpCB+GQJbkO2ngOuPbe4cKwaqRser7UgR82P3shWPoR/1h
         bPTg==
X-Gm-Message-State: AOAM530uk1/qJ43QDPr/pJkPb7lkAaSSmP/JAMC832LQG+3WyqkguSri
        Js3Vy/spSEp7B22RemJH55Qhe/BgMkK7GQ==
X-Google-Smtp-Source: ABdhPJwbGOekzQOeo0USv4qqqSEB7LuS3rtACYFb0/4x1sH1ISUbGZ1JP3MW1eisOiibcewt+5HFLw==
X-Received: by 2002:aa7:948b:0:b029:25c:f974:e0b4 with SMTP id z11-20020aa7948b0000b029025cf974e0b4mr16831940pfk.81.1619429925937;
        Mon, 26 Apr 2021 02:38:45 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id w2sm11110214pfb.174.2021.04.26.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:38:45 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: Add support for SUNIX multi I/O board
Date:   Mon, 26 Apr 2021 17:38:28 +0800
Message-Id: <20210426093828.10348-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Sunix SDC Multi I/O board are different to Timedia's.

This patch adds proper support for Sunix SDC Multi I/O board.

Signed-off-by: Morris Ku<saumah@gmail.com>
---
 tty/serial/8250/8250_pci.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tty/serial/8250/8250_pci.c b/tty/serial/8250/8250_pci.c
index 8814ff38..5758a98b 100644
--- a/tty/serial/8250/8250_pci.c
+++ b/tty/serial/8250/8250_pci.c
@@ -1802,6 +1802,25 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+static int
+pci_sunix_sdc_setup(struct serial_private *priv,
+		const struct pciserial_board *board,
+		struct uart_8250_port *port, int idx)
+{
+	int bar;
+	int offset;
+
+	port->port.flags |= UPF_FIXED_TYPE;
+	port->port.type = PORT_SUNIX;
+
+	if (idx < 4) {
+		bar = 1
+		offset = idx * board->uart_offset;
+	}
+
+	return setup_port(priv, port, bar, offset, 0);
+}
+
 static int
 pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
@@ -2430,6 +2449,13 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_sunix_setup,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_SUNIX,
+		.device		= PCI_DEVICE_ID_SUNIX_2000,
+		.subvendor	= PCI_VENDOR_ID_SUNIX,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_sunix_sdc_setup,
+	},
 	/*
 	 * Xircom cards
 	 */
@@ -2924,6 +2950,7 @@ enum pci_board_num_t {
 	pbn_sunix_pci_4s,
 	pbn_sunix_pci_8s,
 	pbn_sunix_pci_16s,
+	pbn_sunix_sdc_pci_4s
 	pbn_moxa8250_2p,
 	pbn_moxa8250_4p,
 	pbn_moxa8250_8p,
@@ -3704,6 +3731,11 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[pbn_sunix_sdc_pci_4s] = {
+		.num_ports	= 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x10,
+	},
 	[pbn_moxa8250_2p] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 2,
@@ -4783,7 +4815,9 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
 		PCI_VENDOR_ID_SUNIX, 0x0010, 0, 0,
 		pbn_sunix_pci_16s },
-
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_2000,
+		PCI_VENDOR_ID_SUNIX, 0x0001, 0, 0,
+		pbn_sunix_sdc_pci_4s },
 	/*
 	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
 	 */
-- 
2.20.1

