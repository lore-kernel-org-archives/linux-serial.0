Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44319C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F3D20767
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnopgcIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgFVO13 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgFVO1Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC8C061573
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so8501452pfe.4
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8IF9E1gKHyjaeJfo2rxkpn7RVtFle/sJ4XKWmX86Q3Q=;
        b=vnopgcIuuGUomYyixYh3vmsH/ZEfcTlDpC9WbItwt2rL5Q/fAjVXnBvbwwOoml4Xop
         A4WCt4YiyvLALgP7spO6E9WpjRI5FqApFXfKm/XTeM4GWsztkl57XMdB59ib9gjLR7zk
         akE2I/kgqYJMQGP/cAXVUxx+4PC8BFLzoLMLkQIel8iaYCBE1KVlxO0ohMYj+qR5KTbP
         yhbnqOiI0guRk7dVDMuLikFBsjozadCgYhD4WJLJCy6/RaZjdIMFrniappbpl3733COV
         /XvsPO/au4Ik/ONpHzsmRCiDPYfMGMVlJL7MFHhfFFf4iSSPJwedCqKzyzuVDR8ocHV8
         Dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8IF9E1gKHyjaeJfo2rxkpn7RVtFle/sJ4XKWmX86Q3Q=;
        b=lj7sdY6IY3N8q+7So7qiXHblZ897K1aarSrM7J1hngTp/7YxWhzzConOks/s5zDJGn
         g3W55WO2LpIpnfLrBiuNS4u5tBltOtS8Djov5blF+XW7lU7rKNTf9HPjBRlWEtn8cWm/
         Gp8kZxxWgqvVXN7HEwcaW3HPu0XNi2lUvvbNeQCfUvcMaNELzk2I8nwn8c98cA9ma8Kn
         05YxoCCr928Fe5GVwzKH5E4VLCYWBWGPoBvFA8s+5016YQ+pgAMKAG9tUUB3GcA2OBBb
         tk5hxncBK94wFLEohkVkt11YF4732L5B+ETpEOWGsMp7bGpWbAMub3lXycGV49MZt2PP
         oFMQ==
X-Gm-Message-State: AOAM532vm5ph4sv6SG1MN7jr7t2dKuRodXzvwrT+yehu+pGOMvPClRYF
        RaNvreKjOrLTd3MkE88zfJBfPQ==
X-Google-Smtp-Source: ABdhPJw1G6y/vA/2LyrBh5KKvrd/mrZs5tAwapcsLdAG5iU7VgfWzP+NKCihESo4wOGF+Pl8dkMW/A==
X-Received: by 2002:aa7:9818:: with SMTP id e24mr21368063pfl.30.1592836044694;
        Mon, 22 Jun 2020 07:27:24 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:23 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/7] serial: kgdb_nmi: Allow NMI console to replace kgdb IO console
Date:   Mon, 22 Jun 2020 19:56:18 +0530
Message-Id: <1592835984-28613-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Traditionally, kgdb NMI console relied on cmdline option "console=" to
enable/disable consoles. But it didn't took into account DT/ACPI modes
which can also provide default preferred console that can be enabled
prior to kgdb NMI console. And if that default preferred console is
used for debug IO operations as well then it will lead to duplicate
consoles representing same physical serial device which in turn leads
to duplicate printk messages.

In order to avoid this duplication, we need to disable/unregister debug
IO console in case the NMI console is enabled successfully. Also, we
wouldn't like to see beginning boot messages twice, so we need to
remove flag: CON_PRINTBUFFER prior to NMI console registration.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 6004c0c..b32c6b1 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -40,6 +40,7 @@ module_param_named(magic, kgdb_nmi_magic, charp, 0600);
 MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
 
 static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
+static struct console *orig_dbg_cons;
 
 static int kgdb_nmi_console_setup(struct console *co, char *options)
 {
@@ -352,8 +353,22 @@ int kgdb_register_nmi_console(void)
 		goto err_drv_reg;
 	}
 
+	/*
+	 * If we already have an active debug IO console, and are switching
+	 * to a NMI console, don't print everything out again, since debug IO
+	 * console, and the NMI console are the same physical device, it's
+	 * annoying to see the beginning boot messages twice.
+	 */
+	if (dbg_io_ops->cons && (dbg_io_ops->cons->flags & CON_ENABLED)) {
+		orig_dbg_cons = dbg_io_ops->cons;
+		kgdb_nmi_console.flags &= ~CON_PRINTBUFFER;
+	}
+
 	register_console(&kgdb_nmi_console);
 
+	if (orig_dbg_cons && (kgdb_nmi_console.flags & CON_ENABLED))
+		unregister_console(orig_dbg_cons);
+
 	return 0;
 err_drv_reg:
 	put_tty_driver(kgdb_nmi_tty_driver);
@@ -373,6 +388,9 @@ int kgdb_unregister_nmi_console(void)
 	if (ret)
 		return ret;
 
+	if (orig_dbg_cons)
+		register_console(orig_dbg_cons);
+
 	ret = tty_unregister_driver(kgdb_nmi_tty_driver);
 	if (ret)
 		return ret;
-- 
2.7.4

