Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F02C55185
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6399B20747
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKvElx00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUVPV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDUVPV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37013C0610D5
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so1152030pjh.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1Fvyyf5nczEffjGBcL+8ckFidnOh9Vp/pUQ4gio37U=;
        b=PKvElx00HHdwyyEhNv9HrFEWal6afEqN2MXBKrf15GbVJ1eqTVjzJ6PBhfgwxArQ19
         utaZDQ51WhLVHhZzbl4Ndd3g3CEgTOuSoyzsZq6y/bGCEj9EjYU3rkyWXz+mEGaXN0ri
         A/vxKbYEYsvT+2dcKVPlQPPPY8HZwtQmJYTV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1Fvyyf5nczEffjGBcL+8ckFidnOh9Vp/pUQ4gio37U=;
        b=VFtbJWjNOzIejQBNojDsxsLdyLEIVLeFF0DG9N1lZR3vbs2T/TrN7I8XHF0rvJNxPe
         Lgl+52xTT+cW820ej2iCErZk7ZRk4xklphMC+0s4tmfjGH1JVNWdRCtfxYWrp0P3+u8H
         m4OzCJ5elEwMOOEtzMhyKlWBeuhshNKhBm06n+5vVkLRiUiqCp51XXOWsX7lULNbKZMQ
         teFn0UEStKqTB4bL2zEP8wxUuE/KySeDLOP6NQAeU25kno86ccruzubLn0IvRRR7FmYc
         SEmwFJTBCOtY0nka3H9VrGVOLXxe2/ejwtgopltkGbJ0yZX7W9xO+RRUE038TQuUD16S
         lbCg==
X-Gm-Message-State: AGi0PuasV6p8tbz2pkC2NdI+LvWgLsP8SVxoOuTAFwfIZmAwa2Chayko
        huxe97FTaj582wb3LaMR1VDBjg==
X-Google-Smtp-Source: APiQypLO8Vq+2uFDtn1QekfYaQkMUKtaot3jc7Cj/gRVKWbD0siljhiALve3Rxk+OpHLYMMkTVAwJA==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr23179231pli.334.1587503720751;
        Tue, 21 Apr 2020 14:15:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] Revert "kgdboc: disable the console lock when in kgdb"
Date:   Tue, 21 Apr 2020 14:14:40 -0700
Message-Id: <20200421141234.v2.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
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
---

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
2.26.1.301.g55bc3eb7cb9-goog

