Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBB6C33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9756824656
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="o7zZznzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgANRT2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:19:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45528 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANRT1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:19:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6875145pfg.12
        for <linux-serial@vger.kernel.org>; Tue, 14 Jan 2020 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV0m/dXPWRmuP2RjACCvkkMA97TOhcVtBgTEpOrLJfk=;
        b=o7zZznzhqZFGgU9x2MbhAKw04qYYxhD8b7BKYI/OMvzOHR2NDcQykBrM770RXdPCxU
         m6UbMbRulyr1pTxNJ+7Ug+Qty0Hrl07WK8bS+OoMtjmhQ0N9scmO0Z7bzoH9D/d2rEIK
         NmAwp46D4yPecyvTMpDWNVO9MZbDturBdBnOI5ql5FHTB5sQ7rgBBojpdc7/BWZxYgIW
         m5c3vp8pX5c8lUj8+pKbVBj/BZy3dUj89ALRKwMDK0/lnVdyKokBmHVvWNdmV0jothLt
         a0UPrZlFaT8RHluzZEFtVM9V2nbcLnHlSJ0i9y5qj2igz2RnnFIOYLPJZOwzLQUYQ2TV
         OKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sV0m/dXPWRmuP2RjACCvkkMA97TOhcVtBgTEpOrLJfk=;
        b=PEW0eWQBGkgnvOIMAJxpGOyS8SNJDjHBE0eB2cYzfB0V/Ukj1OnG+/PDVUpfMXvCdr
         kFRgCcW+wb2r+bJSKqvRelVqHKODVprwbxi7MTIkT2g4gzuJ9TeL73pZ9LGvj956GLMN
         m48hE/9yRTgQHVgvotgJIbheMBHecbKBv/CyNMWFrtoiD63iUDI1bgmLk+0p6qg/qQY3
         KCNFNsxvB9BV0/CwGB90cnHqUhYfFy1GPsAoH+IPdMhKeifBSyruMdETkPfuGRHRjGXf
         dihE/hE0g2iDBVajC77tyssntXXAxQcy0Vwz+MVTdTi2TnzhNF6Oshdi05Zd/zFXiXu5
         ej6g==
X-Gm-Message-State: APjAAAXU5w+fcr+W1ZGP3BviYSQjMlgdneOrC1H2Cc8ToYrctFySun8Z
        H5IJ2QFhJXIh39U8iusdXImTeA==
X-Google-Smtp-Source: APXvYqxnkgB7dODzw4NXcFYzDJCNxG/IKs5tPYtgPo5DN5549y6+1pt2+Cuqa9Ve6PvwtSCgHyCxHQ==
X-Received: by 2002:a63:fe50:: with SMTP id x16mr27638703pgj.31.1579022366814;
        Tue, 14 Jan 2020 09:19:26 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m128sm18965687pfm.183.2020.01.14.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:19:26 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHv2-next 1/3] sysctl/sysrq: Remove __sysrq_enabled copy
Date:   Tue, 14 Jan 2020 17:19:10 +0000
Message-Id: <20200114171912.261787-2-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114171912.261787-1-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

As a preparation to add sysrq_toggle_support() call into uart,
remove a private copy of sysrq_enabled from sysctl - it should reflect
the actual status of sysrq.

Furthermore, the private copy isn't correct already in case
sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
getter-helper for sysrq enabled status.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c   |  7 +++++++
 include/linux/sysrq.h |  7 +++++++
 kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f724962a5906..ef3e78967146 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -73,6 +73,13 @@ static bool sysrq_on_mask(int mask)
 	       (sysrq_enabled & mask);
 }
 
+int sysrq_get_mask(void)
+{
+	if (sysrq_always_enabled)
+		return 1;
+	return sysrq_enabled;
+}
+
 static int __init sysrq_always_enabled_setup(char *str)
 {
 	sysrq_always_enabled = true;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..ad09a7eefda2 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -50,6 +50,7 @@ int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
 
 int sysrq_toggle_support(int enable_mask);
+int sysrq_get_mask(void);
 
 #else
 
@@ -71,6 +72,12 @@ static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op)
 	return -EINVAL;
 }
 
+static inline int sysrq_get_mask(void)
+{
+	/* Magic SysRq disabled mask */
+	return 0;
+}
+
 #endif
 
 #endif /* _LINUX_SYSRQ_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..6ddb4d7df0e1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -229,25 +229,8 @@ static int proc_dopipe_max_size(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-/* Note: sysrq code uses its own private copy */
-static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
-
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos)
-{
-	int error;
-
-	error = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (error)
-		return error;
-
-	if (write)
-		sysrq_toggle_support(__sysrq_enabled);
-
-	return 0;
-}
-
+			void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 static struct ctl_table kern_table[];
@@ -747,7 +730,7 @@ static struct ctl_table kern_table[] = {
 #ifdef CONFIG_MAGIC_SYSRQ
 	{
 		.procname	= "sysrq",
-		.data		= &__sysrq_enabled,
+		.data		= NULL,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= sysrq_sysctl_handler,
@@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 }
 #endif
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static int sysrq_sysctl_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int tmp, ret;
+
+	tmp = sysrq_get_mask();
+
+	ret = __do_proc_dointvec(&tmp, table, write, buffer,
+			       lenp, ppos, NULL, NULL);
+	if (ret || !write)
+		return ret;
+
+	if (write)
+		sysrq_toggle_support(tmp);
+
+	return 0;
+}
+#endif
+
 static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int write,
 				     void __user *buffer,
 				     size_t *lenp, loff_t *ppos,
-- 
2.24.1

