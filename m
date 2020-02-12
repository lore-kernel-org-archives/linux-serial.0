Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC2BA83
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4767721734
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 16:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="zxAs9Y/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBLQfz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:35:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43173 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgBLQfy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 11:35:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so2501165oth.10
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2020 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl2PlEEW/OcqeGW2B9HrUYrTRB6X4SONJGCgCc3XydE=;
        b=zxAs9Y/gHCE9rA3PhVYSee+bSf/vDErJTHnsi4TLl056W99fYxhof0SJ/zZUquU5S1
         ojQ9y8T4sgzIG1miea81KwehcDg6BbRQgjIKXx2bb51zUXvz9SQU2ksxOTDz8V5PYRuT
         abvTk1BzlOgUAmblvKjrFJuoDYy/zbqemwfOfsZY3mu8ZkpsUK02SrspKGK5Ouomzx88
         AnwRjEyzLoaboqRs5SDYG8JvITRELEetfGuHuifn2m3fYVYV9OeJll/1YIfNaFmS3yyO
         jcMERpmcgtZmzPvmy5Wh3x20GENoPqg2v1YJkJ6+C5KLvJWPe3KjLSixl+5h5CQkZmqD
         JzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zl2PlEEW/OcqeGW2B9HrUYrTRB6X4SONJGCgCc3XydE=;
        b=enKQ0+Keujqb4OEN8LausJWOVAZLc7kSaCcdYixEX7YFkscjBI/03oo3JCmfs8vXvi
         uh+CssgUqgZHb+D0TitpNSrM7utdRo/7M9lNw98MplbRw7pp/ZVWeO7fa8o1Rsn3T+e3
         8OxOrU1wG90M9HPc9A9G9o0jYdQfC3ICsM89vG7uYmwf+2ObXJ1NiCsoo+7jc2bRhMZ9
         cfuwfQafv7X6rdlSNlDyqPLud/i/FJuQ0JdY8vxTVVSo6vYueRMFdGpSVP9cWtUAkI9e
         ocHtgIYQoFRba0vptQmLxzcVC2YH3rD0o4HphmB6N3XOvJwbnVwmCDwXWDoMbS+DmZO5
         lDNA==
X-Gm-Message-State: APjAAAVonqdQr8WcOt75TlQ5/T5XVuy8IQgouyLpLTO8UvPaQxS+tPyW
        nAlBoG56qS8rkLJYd7inFeVLng==
X-Google-Smtp-Source: APXvYqzuRwLgt8dIAgf5ikkNeGR7ZlyM7mSLTFEJEEgXBP99P7Bw+Hz5dawOuL4/UOoKHiMvni4r6g==
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr9442246otq.221.1581525354081;
        Wed, 12 Feb 2020 08:35:54 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id q22sm321034otf.17.2020.02.12.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:35:53 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
Subject: [PATCH v3 1/2] dt-bindings: serial: document fsl,inverted-tx and -rx options
Date:   Wed, 12 Feb 2020 10:35:37 -0600
Message-Id: <20200212163538.3006-2-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212163538.3006-1-ghilliard@kopismobile.com>
References: <20200212163538.3006-1-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for the new fsl,inverted-tx and fsl,inverted-rx
options for the i.MX UART peripheral.

Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
---
v1..v2: Removed confidentiality spam

 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
index 35957cbf1571..c8d677f9491f 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -8,6 +8,10 @@ Required properties:
 Optional properties:
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
+- fsl,inverted-tx , fsl,inverted-rx : Indicate that the hardware attached
+  to the peripheral inverts the signal transmitted or received,
+  respectively, and that the peripheral should invert its output/input
+  using the INVT/INVR registers.
 - rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
   linux,rs485-enabled-at-boot-time: see rs485.txt. Note that for RS485
   you must enable either the "uart-has-rtscts" or the "rts-gpios"
-- 
2.25.0

