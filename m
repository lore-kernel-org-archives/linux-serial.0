Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD3C47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7333A20873
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbHXr1KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD3QSI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbgD3QSH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810DC035494
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:18:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so2618092wma.4
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bAsvHqWCwGkT9CQd5T/W8xxkcoMDs4/cE7bMjlYKe0=;
        b=gbHXr1KRjKzHoWccXlTIFlKA6SNRGpxXOO+JrrqgTvF8sYDdJfErPMiJJXwfzBd82v
         +Bp0Fn/5Bb8Gtwik2V1YrWSCqY7eslqiV5SJZQSfWPtOaDewmOSMtwJ7Bzs9PFtODxoR
         RH7O/FjGUW8detzTpo+wXVG3U2QUMlLmWBYXJF5Eyzv2rUOCusSe4RelyEqOkdYzr16H
         13FPv5lrfR0iidWprYTw97a8ojDJa0Zj30usR+mgFPxUKVVsrJ226gWyB4GvZHeCPtwn
         AEmL2ybLlvTiEIWqjII/JOaclnZlhSDE4LV+MfUFikvplidy4TPP4nHQM016g7+PbXmc
         6Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bAsvHqWCwGkT9CQd5T/W8xxkcoMDs4/cE7bMjlYKe0=;
        b=UTfKwt+HrZowhipFmfUKNxvpFssvHwn8MA4UH/5aL8IEGm4TvRTtjlk87P0UpsCWBO
         On8KQQoj3wksarMcvu4g8RMJSRwn3COb+WKimOyeTtTztbLgiiAYVFMD08dZ7yvAX+P7
         EuWgH41uhYGj7pnU2Jd80vSxznd/x7Jin+mhg9/tpuACeFCRmGOcMT4fAMJBphvqx0Rr
         YTKOwXeh9xHvjCwE4eJpNCuKd12rh765JHcZR36G4QMlO7GzhXnLrRYId4EvM5D6QbrA
         oLNxQGez7LqXR4BqVU1DT9fdbWSb1Vj4inI0l4Duz8E5FG/UMZYdv0ZiUivESvGf6lhE
         OcEQ==
X-Gm-Message-State: AGi0PuZn+S8FBQj5/7B4OAYL1eZfCN+Q6mR7T+PdOq30o2EUBkPE3qJ3
        J4VTlrXiD3fVyS76QJ3iOiaWyg==
X-Google-Smtp-Source: APiQypLdCkOL76wT2MKicI01rEncdS8lGfzgse247Irn4tIefaTYWYzAtLZod6xQ+/HXO2xHj/xMhA==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr3766023wmb.75.1588263486041;
        Thu, 30 Apr 2020 09:18:06 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y18sm160634wmc.45.2020.04.30.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:18:05 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: [PATCH v2] serial: kgdboc: Allow earlycon initialization to be deferred
Date:   Thu, 30 Apr 2020 17:17:41 +0100
Message-Id: <20200430161741.1832050-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429170804.880720-1-daniel.thompson@linaro.org>
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently there is no guarantee that an earlycon will be initialized
before kgdboc tries to adopt it. Almost the opposite: on systems
with ACPI then if earlycon has no arguments then it is guaranteed that
earlycon will not be initialized.

This patch mitigates the problem by giving kgdboc_earlycon a second
chance during console_init(). This isn't quite as good as stopping during
early parameter parsing but it is still early in the kernel boot.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    v2: Simplified, more robust, runs earlier, still has Doug's
        recent patchset as a prerequisite. What's not to like?
    
    More specifically, based on feedback from Doug Anderson, I
    have replaced the initial hacky implementation with a console
    initcall.
    
    I also made it defer more aggressively after realizing that both
    earlycon and kgdboc_earlycon are handled as early parameters
    (meaning I think the current approach relies on the ordering
    of drivers/tty/serial/Makefile to ensure the earlycon is enabled
    before kgdboc tries to adopt it).
    
    Finally, my apologies to Jason and kgdb ML folks, who are seeing
    this patch for the first time. I copied the original circulation
    list from a patch that wasn't kgdb related and forgot to update.

 drivers/tty/serial/kgdboc.c | 41 +++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7aca0a67fc0b..596213272ec3 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -509,6 +509,10 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
 	.is_console		= true,
 };

+#define MAX_CONSOLE_NAME_LEN (sizeof((struct console *) 0)->name)
+static char kgdboc_earlycon_param[MAX_CONSOLE_NAME_LEN] __initdata;
+static bool kgdboc_earlycon_late_enable __initdata;
+
 static int __init kgdboc_earlycon_init(char *opt)
 {
 	struct console *con;
@@ -529,7 +533,24 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_unlock();

 	if (!con) {
-		pr_info("Couldn't find kgdb earlycon\n");
+		/*
+		 * Both earlycon and kgdboc_earlycon are initialized during
+		 * early parameter parsing. We cannot guarantee earlycon gets
+		 * in first and, in any case, on ACPI systems earlycon may
+		 * defer its own initialization (usually to somewhere within
+		 * setup_arch() ). To cope with either of these situations
+		 * we can defer our own initialization to a little later in
+		 * the boot.
+		 */
+		if (!kgdboc_earlycon_late_enable) {
+			pr_info("No suitable earlycon yet, will try later\n");
+			if (opt)
+				strscpy(kgdboc_earlycon_param, opt,
+					sizeof(kgdboc_earlycon_param));
+			kgdboc_earlycon_late_enable = true;
+		} else {
+			pr_info("Couldn't find kgdb earlycon\n");
+		}
 		return 0;
 	}

@@ -543,8 +564,24 @@ static int __init kgdboc_earlycon_init(char *opt)

 	return 0;
 }
-
 early_param("kgdboc_earlycon", kgdboc_earlycon_init);
+
+/*
+ * This is only intended for the late adoption of an early console.
+ *
+ * It is not a reliable way to adopt regular consoles because
+ * we can not control what order console initcalls are made and
+ * many regular consoles are registered much later in the boot
+ * process than the console initcalls!
+ */
+static int __init kgdboc_earlycon_late_init(void)
+{
+	if (kgdboc_earlycon_late_enable)
+		kgdboc_earlycon_init(kgdboc_earlycon_param);
+	return 0;
+}
+console_initcall(kgdboc_earlycon_late_init);
+
 #endif /* CONFIG_KGDB_SERIAL_CONSOLE */

 module_init(init_kgdboc);

base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
prerequisite-patch-id: cbaa70eb783f1f34aec7f5839d1fecbc7616a9f6
prerequisite-patch-id: d7543cdd19fb194ded3361d52818970083efdb06
prerequisite-patch-id: 2238d976451dac9e3ee1bf02a077d633e342aa0c
prerequisite-patch-id: 9e4296261b608ee172060d04b3de431a5e370096
prerequisite-patch-id: 2b008e0e14a212072874ecb483d9c6844d161b08
prerequisite-patch-id: f5b692b89c997d828832e3ab27fffb8f770d7b6f
prerequisite-patch-id: 851d6f4874aa24540db9d765275ae736e8b2955b
prerequisite-patch-id: d3969c2fb7cd320eafebe63d7da270dac5a82fc9
prerequisite-patch-id: e1fc1478b7f75094d263ffc64a9f3528151831cf
prerequisite-patch-id: 45fb53996a9f5993e03673c10eebf2834c58307f
prerequisite-patch-id: 50ac1ddb52c3cce8b712036f212fdd67d7493112
--
2.25.1

