Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F80C83007
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E232072A
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOuY2Gb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD1VO4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbgD1VO1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8D4C03C1AD
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so8999062plp.13
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZjd+VbYFO+1h5w9yjkd4z7WzJT1OucgLbQwpoTJjsA=;
        b=lOuY2Gb8Q6KEWCWP5EslFdqN/LC9fpknyHXTvHxdjmkFrI4r4rBzXjc+YvsJgRkzC8
         jVFG3uCPZlsic43UT0Gw9PlL0ei+sNW5WrQwsZuTvSukWMWJru6i3GMWhWwif4PdhBsQ
         ZgHdHDF/dHq26QcWnl9DHKrCzM+M+E2zX43nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZjd+VbYFO+1h5w9yjkd4z7WzJT1OucgLbQwpoTJjsA=;
        b=BkwYQAWZpjcLCTKu02P3n6BCJ20WYCu0fMPVskjNVNmQrJCoCsGjb0iPMG8Dho+ZLv
         qedQixAXunllzTtBg3DcSocTjeFKaVP9+aUb1nZadCsuQj4EP/KlGxr5Zc8QwXs878/X
         7xOPfzppHbdn1ZA8nPD1MfgG8WH2jYQl5CpWr2EakQGVdTfmcK5qvJhx2fKwIkq4EZG0
         9y/1PhGYWhiLqFIG5P1dnnsk5MyS9KjP7M1adcSq1vCvGEEWa9GxsJeNXTol3bbejVxk
         ANtmnaavp8JmlkOHLEButV1psDbxbS4bBr/uceHJyLOBtrsKwJTVviXAFeV6rA0gMtR+
         +IPw==
X-Gm-Message-State: AGi0PuYcTzw18Yqo0yWnZCUONZoH+6+ffTJptKhKWSczXH4k9x6nBM+m
        +RMtyeZkfffSk5o97Cj7B4zg2Q==
X-Google-Smtp-Source: APiQypJNo1Mwq4p2UlVCx+CzUxAgHlfOnMX98dr2BJvlZvshU+HZaiGJ8EAOQ3FI12KaD0Dtngashw==
X-Received: by 2002:a17:902:262:: with SMTP id 89mr30540617plc.131.1588108466854;
        Tue, 28 Apr 2020 14:14:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 18sm2988202pjf.30.2020.04.28.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:14:26 -0700 (PDT)
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
Subject: [PATCH v3 06/11] kgdb: Prevent infinite recursive entries to the debugger
Date:   Tue, 28 Apr 2020 14:13:46 -0700
Message-Id: <20200428141218.v3.6.I89de39f68736c9de610e6f241e68d8dbc44bc266@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428211351.85055-1-dianders@chromium.org>
References: <20200428211351.85055-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If we detect that we recursively entered the debugger we should hack
our I/O ops to NULL so that the panic() in the next line won't
actually cause another recursion into the debugger.  The first line of
kgdb_panic() will check this and return.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("kgdb: Prevent infinite recursive entries to the debugger") new for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 503c1630ca76..faf5bd4c34ee 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -532,6 +532,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	if (exception_level > 1) {
 		dump_stack();
+		kgdb_io_module_registered = false;
 		panic("Recursive entry to debugger");
 	}
 
-- 
2.26.2.303.gf8c07b1a785-goog

