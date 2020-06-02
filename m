Return-Path: <SRS0=qx80=7P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F94BC433DF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 19:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445CA20734
	for <linux-serial@archiver.kernel.org>; Tue,  2 Jun 2020 19:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E3gsKcsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBTlK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgFBTlK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Jun 2020 15:41:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B0C08C5C0
        for <linux-serial@vger.kernel.org>; Tue,  2 Jun 2020 12:41:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so5635498pgb.10
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2020 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sErQwKMHt7iGLm2dkUe7i9Rye2SnJsz1zTCi4R7MuJo=;
        b=E3gsKcsgv6/Srf1A1gu6zEoSliyxZlDuNhy/OP5M/2ndpyXT9P1dvGeDFz9AwT70TJ
         d/tSrWWziiKlSy83j1afTohsy+zdSWBZzFVzEQdsovPTiWpvVFtk9OP/eAutFukZ7ee2
         sx5oGL87Ca7tQTzPJ4xfAIMkNKn63dOaBGx2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sErQwKMHt7iGLm2dkUe7i9Rye2SnJsz1zTCi4R7MuJo=;
        b=UdKt/j9SW67jhI44xtqTLrl0Zxdd7c0GoLUE5UeCrcBrjV2QfAtPxKBGI36GkGvzh6
         v0yX85GdK4BIDtylHM8xTjvVJr6xNH3pBL3BkreBkh7hu64ytDcb3AfPvC4JenAoV9tJ
         K6xuibLfeQqZj3RZxFFF9hjcPdxGfaSFk66XC8CPlR9vlvupzoZcODKqhAjuPW+GRdJB
         +sbSHwJ0T/EiTv+d6W4PapiKcTB3wDjSnoCPIHYbTwB3cAMIWcBrpsAKPIbPiMUDSDx5
         hJUj2fP/2lIjbk2iL6hqnpR1I7s5QklF/CzA0THf5jbK3DF71kCLI2m/CcUoonrUtgwW
         48rQ==
X-Gm-Message-State: AOAM532Z14jBPodZsxCmUv1vul3CI7qGKP1oFhuTH7P3H+Zxz0Lagxi7
        Ss6fpQgtDnZ/+dEmB4xYW7NzjQ==
X-Google-Smtp-Source: ABdhPJzkajkv6lkdxaEr5KKelaECEixaFCdukA9P7kLW3mm4vqllhyX6Oxnj1ZYiAUVkLPzMFIO/Aw==
X-Received: by 2002:a63:3859:: with SMTP id h25mr25618661pgn.370.1591126869771;
        Tue, 02 Jun 2020 12:41:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id gv4sm2998073pjb.6.2020.06.02.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:41:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: kgdboc: Fix bad line wrapping in comment
Date:   Tue,  2 Jun 2020 12:40:48 -0700
Message-Id: <20200602124044.1.Iee31247bc080d42a02e167454b1225a1b4283705@changeid>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In commit a4912303ac6f ("serial: kgdboc: Allow earlycon initialization
to be deferred") it looks like Daniel really took Linus's new
suggestion about not needing to wrap at 80 columns to heart and he
jammed two full lines of comments into one line.  Either that or he
just somehow accidentally deleted a carriage return when doing final
edits on the patch.  In either case let's make it look prettier.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/kgdboc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 41396982e9e0..fe6ae98360a2 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -538,7 +538,8 @@ static int __init kgdboc_earlycon_init(char *opt)
 
 	if (!con) {
 		/*
-		 * Both earlycon and kgdboc_earlycon are initialized during			 * early parameter parsing. We cannot guarantee earlycon gets
+		 * Both earlycon and kgdboc_earlycon are initialized during
+		 * early parameter parsing. We cannot guarantee earlycon gets
 		 * in first and, in any case, on ACPI systems earlycon may
 		 * defer its own initialization (usually to somewhere within
 		 * setup_arch() ). To cope with either of these situations
-- 
2.27.0.rc2.251.g90737beb825-goog

