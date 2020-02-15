Return-Path: <SRS0=m38j=4D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB9C71153
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373402084E
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSIGygHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBORvb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:51:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgBORvb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 Feb 2020 12:51:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so6658371pfz.9;
        Sat, 15 Feb 2020 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVB6oJBhfw18s3DA1KnYSCc0m58Ryst2uhXN2gMkyMQ=;
        b=dSIGygHoczG629ume4JXo7FibeDOl8G+85fyUdiLH/Xmi8oPgmEnx+JWDQogHCalBP
         d0RIBDOCCAoiZ0FsINSwx7TehIXT9bI0BsHCWeIHcaTC65BwTeUL6o5AfWXkrp1tSDFn
         AMT/eKjhVkLUs9hHztVkvCL1zMlMKBfoGYXXv8NXE414KEUhyhtv3OAM1gTc6LxrihtK
         2KyaId99RXn1WNrCXzq/lhjbR8oZuSTYur35229vhZKguS2UAdLZTecKhghi4Rh61ft7
         /EejwhrpTpK0DO2G01df+s6mHICdR1H/jQ1Wu5XyNyH07qEO6BIfni7+kznEao7k/tur
         JHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aVB6oJBhfw18s3DA1KnYSCc0m58Ryst2uhXN2gMkyMQ=;
        b=L7jyZaH718HuPQ3wc/dKCjg9kr4qphf1H819+C1eXzF9GnxjIGslXcnk+jJ+T3njK2
         4PT4KJDQyDybaA7mrY9RnRBM4zAedGjkZ9vES7HtMVc3/dmJLZXsPy81dfBWunSvIYMz
         xCrrD9f64ovAlIjAD7jTGSgyW+7xrQ69D7HwmWWFrIgjZm1hGjyopMvrAHVpEUuhTbpU
         buFc1/5yZ8h1k/HiA47WlGrtiUKSscuTTCz7w1F012glFiZB4A3Q6GubFbM/VAijoD1X
         sU97VIar5mW2E/uwthqX1iuKhQBsvvhlsypRqMYMIA+UOO+dfRgoaDPCF42jGdaDP/Un
         vu/A==
X-Gm-Message-State: APjAAAXasPx3UtvoWBzYomBAQyyetC4xqfD/pH5c+GM8K3Jhf1R4yblh
        vaNYhYRS48qwTdkVmrZUjwk=
X-Google-Smtp-Source: APXvYqwSlsbRSNfsLrImx9wHusvROw7wvZ4kCeBl3vnVexCJadtI5VOmRTuZJXcsQ3cUbUnKD+lEJQ==
X-Received: by 2002:a65:6201:: with SMTP id d1mr6023898pgv.189.1581789090646;
        Sat, 15 Feb 2020 09:51:30 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.214])
        by smtp.gmail.com with ESMTPSA id g13sm7176375pgh.82.2020.02.15.09.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Feb 2020 09:51:30 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2 3/4] tty: documentation: abi: add ttyvs null modem driver sysfs nodes
Date:   Sat, 15 Feb 2020 23:21:08 +0530
Message-Id: <1581789069-5232-3-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
References: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ttyvs driver exposes sysfs file called event to emulate
various serial port events. This commit document this file.
User space application writes various codes to this file.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Updated path to /sys/class/tty/ttyvsN/event
- Used Documentation/ABI/testing/sysfs-tty, previously new file was created

 Documentation/ABI/testing/sysfs-tty | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 9eb3c2b..c6002c5 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -154,3 +154,18 @@ Description:
 		 device specification. For example, when user sets 7bytes on
 		 16550A, which has 1/4/8/14 bytes trigger, the RX trigger is
 		 automatically changed to 4 bytes.
+
+What:		/sys/class/tty/ttyvsN/event
+Date:		February 2020
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		The ttyvs driver will emulate serial port event; parity error,
+		framing error, overrun error, asserting/de-asserting break
+		condition and ring indication when user space application
+		writes an event code on this sysfs file.
+
+		Write 1 to emulate framing error, write 2 for parity error,
+		write 3 for overrun error, write 4 to set ring indication,
+		write 5 to clear ring indication, write 6 to emulate a break
+		condition detected, write 7 to emulate a faulty cable and
+		write 8 to remove faulty cable condition.
-- 
2.7.4

