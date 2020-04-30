Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC9C47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F83320873
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sosUSrAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgD3QQe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3QQd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:16:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF708C035494;
        Thu, 30 Apr 2020 09:16:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so7082335lja.13;
        Thu, 30 Apr 2020 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcawBkXikPYOd9gFykEVGPuWXUWfQrJeZCwUFjbXlT4=;
        b=sosUSrAuUHwXK5OEpDrkqaJHrO0GGy0Ln5+fNdN+gN6s5xxybYMfk62DTRz82hFfDW
         3WsUtL5mZtTtjasdrGDXuLX2ENo0nhL8CRdGd74HWHwz3Y/lLcmgVn8w01cgM9gIYSWy
         1ClW/qZfGqJQKSpQZiLtz7DccWTt1sbgjnej1CuSydRY/DBLa+BQdaaVd4SgxYuTZAc+
         2YgxHtxvdynliAeIBWW300Rq2M7JTEnyXdt/G4CdzegQM8ORS3/eBubBGzy2nENr9s66
         tMOSZY6mY7hx0HwZufKzxtYA8dCj2iV167701I6iC3ADwXddcvMiFgS2X52N8DC6+Luj
         21rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcawBkXikPYOd9gFykEVGPuWXUWfQrJeZCwUFjbXlT4=;
        b=o08cn9zMoA4uM9+4lnDDW67hx5RyLW8+Tj8kRk0OuF2UnscoSKB3bLPXUKuviS3bpZ
         maQYdMqt9s9Et2HVBR4ZhaPsgHVXkdeBsVwOGE5Aa6eL5D19jNQZWGW8CB1W4jVQwNFz
         P0fzNYBs2EXMEyPdadM1mC0A2phOC1NqCZnCPDwobtGM45HLFYzn3Obfn6vLSxpZLZWj
         bGaxgXs3QOS68uKdNgLgvjQnMoyPtuqZEzhgD9u22Qc8H001P7+cYW+eIhyX9QDMoKuq
         Ihuafqjbqw9kKj+abPdH++fOwbPf3SBHLluVhotDI05NIVCB4r33IxbF6Xyrx2INMJzj
         Alaw==
X-Gm-Message-State: AGi0Puam89ACaSus3+r+ICNVx3h2XvxBGgecdDzotc5mwrnw2hA3O6Ls
        3owdKH/bFjDC0aCc9nfYKPI=
X-Google-Smtp-Source: APiQypJlHPjg7i2J2gTNDSPTCeeNvzQBhsBhfepNh86Pej0Lou55gA4cVl+9dZI3HWGt3Ys5ggHMhQ==
X-Received: by 2002:a2e:b012:: with SMTP id y18mr44709ljk.238.1588263391301;
        Thu, 30 Apr 2020 09:16:31 -0700 (PDT)
Received: from localhost.localdomain ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id k6sm60638lfm.91.2020.04.30.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:16:30 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH v2 1/3] printk: Add function to set console to preferred console's driver
Date:   Thu, 30 Apr 2020 19:14:35 +0300
Message-Id: <20200430161438.17640-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, add_preferred_console sets a preferred console, but doesn't
actually change /dev/console to match it. That part is handled within
register_device, where a newly registered console driver will be set as
/dev/console if it matches the preferred console.

However, if the relevant driver is already registered, the only way to
set it as /dev/console is by un-registering and re-registering it. An
example is the xenfb_make_preferred_console() function:

	console_lock();
	for_each_console(c) {
		if (!strcmp(c->name, "tty") && c->index == 0)
			break;
	}
	console_unlock();
	if (c) {
		unregister_console(c);
		c->flags |= CON_CONSDEV;
		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
		register_console(c);
	}

The code above was introduced in commit 9e124fe16ff2 ("xen: Enable
console tty by default in domU if it's not a dummy"). In short, it's aim
is to set VT as the preferred console only after a working framebuffer
is registered and thus VT is not the dummy device.

This patch introduces an update_console_to_preferred function that
handles the necessary /dev/console change. With this change, the example
above can be replaced with:

	console_lock();
	add_preferred_console("tty", 0, NULL);
	update_console_to_preferred();
	console_unlock();

More importantly, these two calls can be moved to vt.c in order to bump
its priority when a non-dummy backend for it is introduced, solving that
problem in general.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

---

Changes in v2:
- Use the correct format when referencing a commit

 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 56 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 75dd20650fbe..4b3fa34be245 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -172,6 +172,7 @@ enum con_flush_mode {
 };
 
 extern int add_preferred_console(char *name, int idx, char *options);
+extern int update_console_to_preferred(void);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
 extern struct console *console_drivers;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6ede4a7222e6..efda422203e4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2240,12 +2240,68 @@ __setup("console=", console_setup);
  * be used by arch-specific code either to override the user or more
  * commonly to provide a default console (ie from PROM variables) when
  * the user has not supplied one.
+ *
+ * Preferences set by this function don't take effect until the next
+ * time a matching driver for the preferred console is registered. If a
+ * matching driver was already registered, @update_console_to_preferred
+ * function can be used to set that as the preferred console driver.
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
 	return __add_preferred_console(name, idx, options, NULL, false);
 }
 
+/**
+ * update_console_to_preferred - set console to the preferred console's driver.
+ *
+ * Updates console_drivers and CON_CONSDEV flags so that an already
+ * registered and enabled console driver matching the preferred console
+ * is used as /dev/console.
+ *
+ * Must be called within console_lock();.
+ */
+int update_console_to_preferred(void)
+{
+	struct console_cmdline *c = NULL;
+	struct console *con = NULL;
+	struct console *tmp = NULL;
+
+	if (preferred_console >= 0)
+		c = &console_cmdline[preferred_console];
+
+	if (!c || !c->name[0])
+		return 0;
+
+	for_each_console(con) {
+		if (!con->next || !(con->next->flags & CON_ENABLED))
+			continue;
+		if (strcmp(c->name, con->next->name) != 0)
+			continue;
+		if (con->next->index >= 0 &&
+		    con->next->index != c->index)
+			continue;
+		break;
+	}
+
+	if (!con)
+		return -ENODEV;
+
+	pr_info("switching to console [%s%d]\n",
+		con->next->name, con->next->index);
+
+	tmp = con->next;
+	con->next = con->next->next;
+	tmp->next = console_drivers;
+	console_drivers = tmp;
+
+	if (console_drivers->next)
+		console_drivers->next->flags &= ~CON_CONSDEV;
+	console_drivers->flags |= CON_CONSDEV;
+	has_preferred_console = true;
+
+	return 0;
+}
+
 bool console_suspend_enabled = true;
 EXPORT_SYMBOL(console_suspend_enabled);
 
-- 
2.26.2

