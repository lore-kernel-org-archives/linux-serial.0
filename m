Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1318C83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C04E2083B
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h/doTU1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD1VOW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgD1VOV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F127C03C1AC
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so1161330plq.12
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OVNvnisfgkYu5LPJfO/kG/+xFAcsPKgHoSUZfW5y90=;
        b=h/doTU1qG1diDauaG4awPo0siVlKxs5d3hJ4lnA8tM0J401L3v3bBQmJoeyedEqXwb
         51qxQobOPjOp0YRYa5DgkvyAUSbSbtN8u8KC6zK6J0bnGAluamUTpb+thPIv8ZnZ6hHp
         Agc3yHDWqkGWoApmfRi9iFjYsxh8LUGVylncM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OVNvnisfgkYu5LPJfO/kG/+xFAcsPKgHoSUZfW5y90=;
        b=G38iulB8zpFdICZGFevbJfO0bQgqhROy98XwJorppPJa7ET6lhY3i8PGVe06gTHyIi
         rDrIcVReMahaI4LX7VkEtJR6Ea17bVkWnZrdj1IC0QqhXDY8eiVducUBUsdiFujq5elm
         6YDxBLJ2AKgrxK2/YBIQ23qM2l8Du5l9Yl55EmvhPiZZLq46aRhxtU0+4rHlVb4yFGFv
         4CWbMwrh2LZYg6uLY5sWHs/F1LHRg45hLX7QuE7Q1v7aZKYIUYGsqijTCsRlsQNc8+4U
         RD96kP6tXrACtmx41dzLbvvDEg7r3n4xFR0kV4IwUBFZx69RDhEFDtqHKXQg0bOtDcK+
         qIfA==
X-Gm-Message-State: AGi0PubZsICiFo/BOroR7yvXQgnT8Zd6BzpLZlckKXeATa6g5I0DoV5S
        jTpTRSzsYLiyZVPswlGsbScaew==
X-Google-Smtp-Source: APiQypICBO33ruUlGkSJaFNPeFlv0L/gbSK0rXL8fq3M4//PGxHAL3DVuuFb8F/+QnhjSj2tyQD97w==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr18601373pls.214.1588108460637;
        Tue, 28 Apr 2020 14:14:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] Revert "kgdboc: disable the console lock when in kgdb"
Date:   Tue, 28 Apr 2020 14:13:42 -0700
Message-Id: <20200428141218.v3.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1.

Commit 81eaadcae81b ("kgdboc: disable the console lock when in kgdb")
is no longer needed now that we have the patch ("kgdb: Disable
WARN_CONSOLE_UNLOCKED for all kgdb").  Revert it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v3: None
Changes in v2:
- ("Revert "kgdboc: disable the console lock when in kgdb"") new for v2.

 drivers/tty/serial/kgdboc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c9f94fa82be4..8a1a4d1b6768 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -275,14 +275,10 @@ static void kgdboc_pre_exp_handler(void)
 	/* Increment the module count when the debugger is active */
 	if (!kgdb_connected)
 		try_module_get(THIS_MODULE);
-
-	atomic_inc(&ignore_console_lock_warning);
 }
 
 static void kgdboc_post_exp_handler(void)
 {
-	atomic_dec(&ignore_console_lock_warning);
-
 	/* decrement the module count when the debugger detaches */
 	if (!kgdb_connected)
 		module_put(THIS_MODULE);
-- 
2.26.2.303.gf8c07b1a785-goog

