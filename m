Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C0C38A29
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C5220936
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZznCU+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404984AbgDPE47 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404858AbgDPE4k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 00:56:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE3BC061A0F;
        Wed, 15 Apr 2020 21:56:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so1110560pfc.12;
        Wed, 15 Apr 2020 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnsPtbUAG8+OLZCkp5n0IoYKsiXqO3fcv50rNC7/i2M=;
        b=OZznCU+SRBn2uhYNibIFqabynpAFL/VkKh8/8GgtCs3M3FFAaA+pcRNmYjldigU4To
         AziU82I6lp1EYnd8/gnQqDq609EwfTlqvEICsOOSR0tm4gZmcZEcEL1lrl/ZW4SC+oEY
         V1xgMZEO1+9NfWXcRekmJWx2BvEFeeNiQ6beKeXkPdqvbXTPsHyMIRughKN6rrELD1yo
         9dfSZG1UtfKNprULb152Zi3D2DrVKaUJiYrMmZTn0KTn3D5ISW21E8UcAewGZ1SBa4Rl
         Sxr7AVZMRSiyw20AyyI5SaqVCctC7szEoEs5HPIm5wHYhXxNnNHjqZ5fxS/ZAT1udHd4
         NdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnsPtbUAG8+OLZCkp5n0IoYKsiXqO3fcv50rNC7/i2M=;
        b=S/eYydJYlDmRWetKnDg3NXyFcQZ6yF4XPZTTSlqgBIiofNbnC/ujvB8TMmno2t5qGY
         A+et2eAPH/Yk57CDf2ago3cYWPtW9i12FjhhonipZOogyTCtMEhErYC0kRnEcHWqznft
         Qb5WgU7jP1VnsQH0xthU/Z2v2ZOtpmgSPZWdR/ICeZJa0uEYIOIHXYxRtK/RfP2MTSWv
         p7OEHfm7N4Nu8n5rmiZqRCBhNQFG3P8EpWqSlaoltVmD7nOobhSOlKYpDdK3Ln2K8dFv
         foIDED0Ll1R6XyMaH/InNMhZZplx5QsQDnh4h0vbhB4u4QoIA2oKniRhqlWXWJJqKoe1
         5ztQ==
X-Gm-Message-State: AGi0PubtrXsk57zaCTwHEBcmc6FALIZFV2J0hjaWvu2xI/1nfyF5FmwO
        Jp1ZJDKGz4YjJsLfz+X27B4=
X-Google-Smtp-Source: APiQypIMZsvVzOrKvQjryqOOdns5smIKzC8/IUR6PDFhf4fV6xu469FkjndHCcf+7bGsKyk4sp7UZQ==
X-Received: by 2002:a05:6a00:12:: with SMTP id h18mr12711857pfk.293.1587012999860;
        Wed, 15 Apr 2020 21:56:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.182.213])
        by smtp.gmail.com with ESMTPSA id 3sm4749198pgh.75.2020.04.15.21.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 21:56:39 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, andriy.shevchenko@linux.intel.com
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3 3/4] tty: documentation: abi: add ttyvs null modem driver sysfs nodes
Date:   Thu, 16 Apr 2020 10:26:13 +0530
Message-Id: <1587012974-21219-3-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ttyvs driver exposes sysfs file called event to emulate
various serial port events. This commit document this file.
User space application writes various codes to this file.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
- Rebased on top of v5.7-rc1

Changes in v2:
- Updated path to /sys/class/tty/ttyvsN/event
- Used Documentation/ABI/testing/sysfs-tty, previously new file was created

 Documentation/ABI/testing/sysfs-tty | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index e157130..c17b49d 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -161,3 +161,18 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
 		 Allows user to detach or attach back the given device as
 		 kernel console. It shows and accepts a boolean variable.
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

