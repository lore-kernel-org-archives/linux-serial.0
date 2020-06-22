Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0CCC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F93C20767
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hI2iPwM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgFVO1h (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgFVO1f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A609C061795
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r18so8201733pgk.11
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SpQVzSBjDEPebQy5qXPK/BkcdPQ45hc1OKMcPgP/hpg=;
        b=hI2iPwM6eHl78f/Rf8OaivVcHz3gxNYp7IujpJ0Fw4woi28ptBxRkJmesqWs9PJ8eq
         yFgt6ooC0ATzyjeS3E3XgbmXm+QpmI3HL0rWsAUsTdQfAkLwHauCN9foUfI51PEMGHZ8
         yODUaCBZN8pKYgqZBYI9xuc0XcLmgHZwlVFZ3KYI3auT9hZPwg6xMXFq9NPQ8FSG50FJ
         oR8FlHOsAAzKbPhx4LYo0bJFdsUWcoUsugtAVKLcLzmcam3p7brbYKkOdLUOjAkWmQ16
         9WZbzObPYrGJctJ6gY4fm+CGqzRaZTkVF7lUIi5989wtOBl4m4X8YvITzEhSBDAYRgCI
         lq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SpQVzSBjDEPebQy5qXPK/BkcdPQ45hc1OKMcPgP/hpg=;
        b=iKYnfkz8876fuJCUsgAL42s2qE0e5TTxzHVcB7fK3tmbmrvWNXcT0Ndz6cbwoKxBfm
         CV0WsPAv82opxPK15fHvSDhzGjFh8Hqqr4W+ZNIcsx61uLN/+UwCyBzRaOnv6KUhLfnA
         l8xR7WuXhZMv5elTIvc/eaHGsqYOK/30wEkqNzIaZrxl2sphoNVuv2f+duzl/k7vIYDP
         UbhIOWiQC4JQ1mufOvH3k3/GeStjchDdh3j4Nkk8OF055kyhkQUybyKvB0iA8Bmg3wSt
         Ta9kTL3DzVNI34Sj1dnK94FrLLutkG+pe9fIh00XDqU5dc+MhRC0mXeFhePzeybZJGH8
         h84A==
X-Gm-Message-State: AOAM531nASJAsvbRplm+n69lO8Y/2s3C4MjRB/IdlTneUZ0MVfYNLuLp
        9e/iYW+vIJ7xMIVa+/WbOirU3Q==
X-Google-Smtp-Source: ABdhPJwEwxcR4qCfAcHSUX33rqxUd8JB5pxuQIXs8e8eUwjmKcCs+hmNcxPhJxjHoOv9HJRsrjAwZw==
X-Received: by 2002:a63:eb54:: with SMTP id b20mr13113025pgk.380.1592836055116;
        Mon, 22 Jun 2020 07:27:35 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:34 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for kgdboc
Date:   Mon, 22 Jun 2020 19:56:20 +0530
Message-Id: <1592835984-28613-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Add request_nmi() callback to install a non-maskable interrupt handler
corresponding to IRQ retrieved from polling interface. If NMI handler
installation fails due to missing support from underlying irqchip driver
then fallback to install it as normal interrupt handler.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdboc.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/kgdb.h        |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 84ffede..263afae 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,9 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -390,12 +393,44 @@ static void kgdboc_post_exp_handler(void)
 	kgdboc_restore_input();
 }
 
+static int kgdb_tty_irq;
+
+static int kgdboc_request_nmi(irq_handler_t fn, void *dev_id)
+{
+	int irq, res;
+
+	/* Better to avoid double allocation in the tty driver! */
+	if (kgdb_tty_irq)
+		return 0;
+
+	if (!kgdb_tty_driver->ops->poll_get_irq)
+		return -ENODEV;
+
+	irq =
+	    kgdb_tty_driver->ops->poll_get_irq(kgdb_tty_driver, kgdb_tty_line);
+	if (irq <= 0)
+		return irq ? irq : -ENODEV;
+
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
+	if (res) {
+		res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
+		WARN_ON(res);
+	}
+
+	enable_irq(irq);
+
+	kgdb_tty_irq = irq;
+	return 0;
+}
+
 static struct kgdb_io kgdboc_io_ops = {
 	.name			= "kgdboc",
 	.read_char		= kgdboc_get_char,
 	.write_char		= kgdboc_put_char,
 	.pre_exception		= kgdboc_pre_exp_handler,
 	.post_exception		= kgdboc_post_exp_handler,
+	.request_nmi		= kgdboc_request_nmi,
 };
 
 #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 529116b..b32b044 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -16,6 +16,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/atomic.h>
+#include <linux/interrupt.h>
 #ifdef CONFIG_HAVE_ARCH_KGDB
 #include <asm/kgdb.h>
 #endif
@@ -276,6 +277,10 @@ struct kgdb_arch {
  * the I/O driver.
  * @post_exception: Pointer to a function that will do any cleanup work
  * for the I/O driver.
+ * @request_nmi: Pointer to a function that can install an non-maskable
+ * interrupt handler that will be called when a character is pending and that
+ * can be cleared by calling @read_char until it returns NO_POLL_CHAR. If NMI
+ * installation fails then fallback to install normal interrupt handler.
  * @cons: valid if the I/O device is a console; else NULL.
  */
 struct kgdb_io {
@@ -287,6 +292,8 @@ struct kgdb_io {
 	void			(*deinit) (void);
 	void			(*pre_exception) (void);
 	void			(*post_exception) (void);
+	int			(*request_nmi)(irq_handler_t nmi_handler,
+					       void *dev_id);
 	struct console		*cons;
 };
 
-- 
2.7.4

