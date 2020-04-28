Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A5C83001
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C12054F
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXhWPL5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgD1QWr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgD1QWr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 12:22:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C52C03C1AB
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 09:22:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so3488542wmj.1
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ3V+kSzSOvh3yPLaUGq339r3FXngS2JfBwbre6zrhE=;
        b=qXhWPL5O7QAlv2qAlEN7m7ou3SRfXay58XLzapUHPOrqFq57kRVrnAzyNaGqh0bdcT
         uiUDpYM+PCcW+uNeiiV1PYYfD2ZfHjhEvIQhhoqqiJ0KeDHG3kZUjXl4MfKlTjAfVuIe
         dkwhWQN/n2d7ZCrIC44jjhiVvc0O9z8yYk4Mspwztl1qzB4z2nK6zbYiijDhavRbx0ku
         ah3ajFogcn4fC/aTM48Eiq4MLrUhzDADKX33b7Wj5M3a8WtYnbT8a/KxUGc0+mTstRoa
         C1JbOFU2h0y1kg1tUKWJGCUF9Z1uYkdiDOykvYngQnHUHQjXICAXSV6IuWKcL7nvMnMv
         eySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZ3V+kSzSOvh3yPLaUGq339r3FXngS2JfBwbre6zrhE=;
        b=EupWdnhtsmJy9f8D2fVYVVoHWFWrKCme5RhpfWaXlIbxn7LTr+UaXCszE5MTCg6PQA
         yGX3pmaNryQ+IzgeAmVuAV+euxQOQh89CQB3YjQINu5aMZqinr+q7VJRJPsEop3CGp0v
         v/pMQ6jzvEJbis23uuuX6mMYGU+EX2kv0c9xwyPoJ/8V+fWbse4MZhuEXsShxMr3B0/J
         JkU+cq3TSNIX17rB2cpFSoJJb1mvZ3JEADNexNdVpcY36GvpcJue9r/OG9P9ke1PisQt
         ZwGQHT64rzg1VRJstQpaUevH5N+zXFEZL+ic3E7m/ZKOloieLR63lt4CYi0szlPyVOEW
         dF/A==
X-Gm-Message-State: AGi0PuYb7IHXj/tSjEEYmGiUXvL2NSJdmeJ4yqAY5EyiET9++a2KH5K0
        57I7aXTu0reoNlxmc1im0mS1MNFC1U6qrg==
X-Google-Smtp-Source: APiQypL+DZ5U8Se/92OpfKlWfoY0M5q66E1XNeANbqXCYI9gMYeEmYEHp30ZLcpfBz/YNt7hw8TgYA==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr5124445wme.115.1588090965173;
        Tue, 28 Apr 2020 09:22:45 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o6sm17736097wrw.63.2020.04.28.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:22:44 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH] serial: earlycon: Allow earlier DT scan is acpi=off
Date:   Tue, 28 Apr 2020 17:22:27 +0100
Message-Id: <20200428162227.687978-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently if the kernel has support for ACPI SPCR parsing then earlycon
without arguments is processed later than the full earlycon=...
alternative.

If ACPI has been explicitly disabled on the kernel command line then
there is not need to defer since the ACPI code (both x86 and arm64)
will never actually run.

Or, put another way it allows lazy people to throw "acpi=off earlycon"
onto the command line of a DT systems and be confident the console will
start as early as possible without them having to lookup the driver
and address needed for a specific platform.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/earlycon.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 2ae9190b64bb..ebb648aacb47 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -215,6 +215,31 @@ int __init setup_earlycon(char *buf)
  */
 bool earlycon_acpi_spcr_enable __initdata;

+/*
+ * This takes a sneaky peek at other boot arguments (which may not have
+ * been parsed at this point in the boot) to check whether ACPI has
+ * been explicitly disabled. If it is explicitly disabled then there is
+ * no reason to defer initialization of the early console.
+ */
+static bool earlycon_check_for_acpi_off(void)
+{
+	static const char token[] = "acpi=off";
+	const char *arg;
+	char before, after;
+
+	arg = strstr(boot_command_line, token);
+	while (arg) {
+		before = arg == boot_command_line ? ' ' : arg[-1];
+		after = arg[sizeof(token)-1];
+		if (isspace(before) && (isspace(after) || after == '\0'))
+			return true;
+
+		arg = strstr(arg+1, token);
+	}
+
+	return false;
+}
+
 /* early_param wrapper for setup_earlycon() */
 static int __init param_setup_earlycon(char *buf)
 {
@@ -222,7 +247,8 @@ static int __init param_setup_earlycon(char *buf)

 	/* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
 	if (!buf || !buf[0]) {
-		if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
+		if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE) &&
+		    !earlycon_check_for_acpi_off()) {
 			earlycon_acpi_spcr_enable = true;
 			return 0;
 		} else if (!buf) {
--
2.25.1

