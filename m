Return-Path: <SRS0=yy8S=EB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F29C4363A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC9222D9
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="udPLBiKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781783AbgJZR6D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:58:03 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54407 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782683AbgJZR6C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Oct 2020 13:58:02 -0400
Received: by mail-pj1-f67.google.com with SMTP id az3so3633825pjb.4
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7x6I87gAC9xvdMA8/xgooissCxMzszxa0RkbWyw6hB4=;
        b=udPLBiKRzopNzVEN4HaoEnB2q5A+8XhiYVHfoMBoTleM9m+IL2+Ufzbc6rExR5uCCB
         s22ivYrIYpyrmK53nSVEf2DfOiKndD7QV+XP9D4dIgWrdAXePiason3y15YU65Vw6icA
         KqnoI23rdTk7HO7yNu2h9bfcxSRoaYnadDfA5oxWHFXm8yh0PEHj3Xz1YGEAzsaH1hEF
         UN6u4vjiz8E3fMNoZA7tlSyiAXxDjc6sD5SSuSz3+hhJkAllMieDzum6Yofxh0UGP61N
         tKqq52xjRz3JizMLgFtjNdSPJYocUylNNBHdUBmkuR/KQcDaVIueQF3+fsv3MkAQAcBf
         /3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7x6I87gAC9xvdMA8/xgooissCxMzszxa0RkbWyw6hB4=;
        b=I6+HXmv1GZJ8nOebBPehEWQyvI26xh5+Kf+iFw3Fp2d6SHjt4k6zk7taLD0eC33vGm
         UsBgLkSbTtzNqI/DMdnCkIbqJr/oLijEOMdSGY41yCi78xhHMUQOWY0Z2xYG1av+ap5R
         i4OkvaxeF6157LwUYWZKGqWEpMtRcPWGOELiE985MQJVliNard8KjgKWV4CkeLYUThrm
         H0/fbSRgOD/E2ZRxZ1LbRb1bv6UusOPkEnKljX0/kl3p0tsqmmyraQRwtvSr9ZtCyXas
         trLjJrw2227JVgC903NCDD9IBReOfOOeI8HlRoKjsIYR6e6f6w6KEsEey3ZaUoXrk6gh
         qVpw==
X-Gm-Message-State: AOAM533HAC0yejfDaD51Ctllxo7elptVajHVEl8/Io0DVAy1YjLqvHgT
        agU+jP5T4sfrTgqsEVTHphrK
X-Google-Smtp-Source: ABdhPJxorBhGf3L1PmYRHh4xbOyaOA/4Oy7aKXmiw4zw/MdyjAkOMU3yiJcy4KJEY8BRyiAJNspM/A==
X-Received: by 2002:a17:902:26c:b029:d6:83c:9486 with SMTP id 99-20020a170902026cb02900d6083c9486mr9673144plc.85.1603735081495;
        Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
Received: from localhost.localdomain ([116.68.74.56])
        by smtp.gmail.com with ESMTPSA id o65sm11583088pga.42.2020.10.26.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     johan@kernel.org
Cc:     ribalda@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kbuild@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, vaishnav@beagleboard.org
Subject: [RFC PATCH 2/5] file2alias: Support for serdev devices
Date:   Mon, 26 Oct 2020 23:27:15 +0530
Message-Id: <20201026175718.965773-3-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026175718.965773-1-vaishnav@beagleboard.org>
References: <20201026175718.965773-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch allows file2alias to generate the proper module headers to
support serdev modalias drivers.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 27007c18e754..732cd03e911d 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -152,6 +152,9 @@ int main(void)
 	DEVID_FIELD(i3c_device_id, part_id);
 	DEVID_FIELD(i3c_device_id, extra_info);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2417dd1dee33..540fee036d9d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -947,6 +947,15 @@ static int do_spi_entry(const char *filename, void *symval,
 	return 1;
 }
 
+static int do_serdev_entry(const char *filename, void *symval,
+			   char *alias)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+	sprintf(alias, SERDEV_MODULE_PREFIX "%s", *name);
+
+	return 1;
+}
+
 static const struct dmifield {
 	const char *prefix;
 	int field;
@@ -1420,6 +1429,7 @@ static const struct devtable devtable[] = {
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
 	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
+	{"serdev", SIZE_serdev_device_id, do_serdev_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
 	{"platform", SIZE_platform_device_id, do_platform_entry},
-- 
2.25.1

