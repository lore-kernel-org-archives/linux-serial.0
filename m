Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A0C54E49
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E37321582
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wji61SIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEGUJ5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728383AbgEGUJE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 16:09:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014AC05BD43
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 13:09:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so3540215pfx.6
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/DsRm4g6gIbDNrt7b5XJT8F2ZdnzG78OB1C4FcIZRg=;
        b=Wji61SIerY4A7CIjkXjeQbrgHiPO+IPz799kwT2t+CDnNp3fyN1ul6dEyGHysTzfpC
         JZo5ah0CiyK9u/ZGlwjIyCE/GpmxmmZIYPu0KXJO2nZfLuj433mngzH/hie8b0wDBddz
         NnCipZ1Khy+kmgpi29vWHoHozWaVMNYziA4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/DsRm4g6gIbDNrt7b5XJT8F2ZdnzG78OB1C4FcIZRg=;
        b=WJdiXZWV+Ay54LaJuR7l8lKOExWLerDfjJoPGXKDfm6IwUiFZn5p1AntsSHvEhOPvH
         oWyEjyG4BnCBXPJ7M0JBd5CFHprVF3GAV3EHyZx8hFlRUUeyay1Gv8etsN/RXjB8dQnk
         RpsCDKEUqf1StXlK2zV2+wFvrKklFpU29LYUvHteFGOFmnlRxtPcHp0za91ZaxdHulKY
         SOXJcS6U3DIQcJ9yIbSssirqGq8kCzNVIRsi9mKHzvjFbYGjjoNLiVW/GNmj9PIPrVlU
         ojUrFDEua9vW7EDGW073cKfPnuyuzwep+k+ZPz4thTfP7jhMqaInVBe54itkL010Cgw8
         QShw==
X-Gm-Message-State: AGi0PuYXIvrFsg58qGw2bZDuCPc3GqPnyCn+Ctd4eyNl94/WGgidbqpw
        92CM/hMnOMl2knhsfaztGc7qTw==
X-Google-Smtp-Source: APiQypICIyZYq+Lw5KlpKjR4sb4ChoSHP4P4KSBPQc5p5Oha2jBsP7gH0oqRg+pBV+ShiYgjJnWVXQ==
X-Received: by 2002:a63:200b:: with SMTP id g11mr1896922pgg.22.1588882142461;
        Thu, 07 May 2020 13:09:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/12] Revert "kgdboc: disable the console lock when in kgdb"
Date:   Thu,  7 May 2020 13:08:40 -0700
Message-Id: <20200507130644.v4.2.I02258eee1497e55bcbe8dc477de90369c7c7c2c5@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
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

Changes in v4: None
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
2.26.2.645.ge9eca65c58-goog

