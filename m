Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20241C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0E42074D
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOeLXcXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgFVO1n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgFVO1k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6FFC061573
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14so2935097pjj.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sjUQXgLs8QLSZt9fRiSIf9rP+l/zfeDDFs4yVtYk7Z0=;
        b=QOeLXcXXYJY7Mbx/0GKxWfojZNvqp1+/iUKrhHvJJPT9TVW7hdHXE2t9l97MfMSFpN
         a08ODnr/u8hVAu7RVgm3nwaohgTk6yIAfdCRoM5WfyRsqxQHCEGEzi9wTA/yKOQSDDTn
         EspPlVmFhi6LGov/zu0zVQxHn0TORwdNIp4Tz25YBXpANqqkhTFuF4GxAxBipD+4hDqG
         jmvq8KHWY56pQ4Uhc3UmRVKr91Ozy+VR2DUlvgYbGewgO3jRkY/Dp81cKfOw8z4F75Dm
         Z8nwP0kHFAnNAqtxxXXSBop65W6O3MFJ//0g5Mpc6ZSBKBujqa7snPffto/Uxw5BV9qX
         S9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sjUQXgLs8QLSZt9fRiSIf9rP+l/zfeDDFs4yVtYk7Z0=;
        b=QTmxIjEjqvvuCoQ0FZST/EAfc5XfdufzwuMMPIdTOu4t9vhoFClodMDYu2EPc5q9Ti
         b/+l0hTuFYXjFWdRcnAu143H0mBOefefx+/Fy3yBslvMGhRoc4u3fkjW2C5CQ+ZmS0/4
         aqAX05Xb9rmhs73U/SSRv0xwDzgFRCvL3fkYtP6xwcpK/OupkMnhcP5XXFAqYFcKxsix
         Gl/q9jK2O953Kge/ylNJTToI9dXqCswvaX5J5CuhkYv523wx901RJEmYIt6l42i/Pcnz
         qE8a0ktwmYbk2UhZzTjA4iLFPZnN4munYdNPFxX3E8rtHaD3jEHSvvwnANNvy4zseYbD
         NpLg==
X-Gm-Message-State: AOAM53194KlOUwCOdn1jEHNeqdBGsad0wfBWaiOmuHYkGfu7oBPh9z+8
        Rv4cnoff/HIPXm4tJs7oQfVCoQmxli4=
X-Google-Smtp-Source: ABdhPJzpaCxkbO/21akB31Cg1TWuLDrphNwsB5izjnAOPjR2mgcdxwifka4NWh+oyQbNDK0xDtgcng==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr17596432pju.61.1592836060022;
        Mon, 22 Jun 2020 07:27:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 4/7] serial: kgdb_nmi: Add support for interrupt based fallback
Date:   Mon, 22 Jun 2020 19:56:21 +0530
Message-Id: <1592835984-28613-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Add a generic NMI fallback to support kgdb NMI console feature which can
be overridden by arch specific implementation.

This common fallback mechanism utilizes kgdb IO based interrupt in order
to support entry into kgdb if a user types in kgdb_nmi_magic sequence. So
during NMI console init, NMI handler is installed corresponding to kgdb
IO based NMI which is invoked when a character is pending and that can be
cleared by calling @read_char until it returns NO_POLL_CHAR.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 47 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index b32c6b1..2580f39 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -42,9 +42,46 @@ MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
 static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
 static struct console *orig_dbg_cons;
 
+static int kgdb_nmi_poll_one_knock(void);
+
+static irqreturn_t kgdb_handle_nmi(int irq, void *dev_id)
+{
+	int ret;
+
+	if (kgdb_nmi_knock < 0) {
+		kgdb_breakpoint();
+		return IRQ_HANDLED;
+	}
+
+	ret = kgdb_nmi_poll_one_knock();
+	if (ret == NO_POLL_CHAR)
+		return IRQ_NONE;
+
+	while (ret != 1) {
+		ret = kgdb_nmi_poll_one_knock();
+		if (ret == NO_POLL_CHAR)
+			return IRQ_HANDLED;
+	}
+
+	kgdb_breakpoint();
+	return IRQ_HANDLED;
+}
+
 static int kgdb_nmi_console_setup(struct console *co, char *options)
 {
-	arch_kgdb_ops.enable_nmi(1);
+	int res;
+
+	if (arch_kgdb_ops.enable_nmi) {
+		arch_kgdb_ops.enable_nmi(1);
+	} else if (dbg_io_ops->request_nmi) {
+		res = dbg_io_ops->request_nmi(kgdb_handle_nmi, co);
+		if (res) {
+			pr_err("ttyNMI0: Cannot request nmi/irq\n");
+			return res;
+		}
+	} else {
+		return -ENODEV;
+	}
 
 	/* The NMI console uses the dbg_io_ops to issue console messages. To
 	 * avoid duplicate messages during kdb sessions we must inform kdb's
@@ -328,9 +365,6 @@ int kgdb_register_nmi_console(void)
 {
 	int ret;
 
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-
 	kgdb_nmi_tty_driver = alloc_tty_driver(1);
 	if (!kgdb_nmi_tty_driver) {
 		pr_err("%s: cannot allocate tty\n", __func__);
@@ -380,9 +414,8 @@ int kgdb_unregister_nmi_console(void)
 {
 	int ret;
 
-	if (!arch_kgdb_ops.enable_nmi)
-		return 0;
-	arch_kgdb_ops.enable_nmi(0);
+	if (arch_kgdb_ops.enable_nmi)
+		arch_kgdb_ops.enable_nmi(0);
 
 	ret = unregister_console(&kgdb_nmi_console);
 	if (ret)
-- 
2.7.4

