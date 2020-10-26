Return-Path: <SRS0=yy8S=EB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C7BC4363A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504B7222C8
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="hKM+EPsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788942AbgJZR62 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:58:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37088 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788934AbgJZR60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Oct 2020 13:58:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id h6so6494069pgk.4
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2020 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9/6iMyuxRs29CcJNRGQlw3NkjK+ZAaS1DQKNOdZ49Y=;
        b=hKM+EPsFhBXudgBvBD6S/N+2rd4p0d87n+1PsscRuF8xG8aOokGqs1Scy01fSvCylK
         vFtVN5EVEStMT82Rv5AUwG7HaV95viWhftFrFm7Pjd8/H3nFJ1srA4+LYQdNcMX9ELOP
         NtwOz1qez9ijYPcyDSgSwsG9dlxvuQ8A6NppwAb4Hc0xYclisfujp8nptwltUtB4p+x9
         ldxOiwgJS3JsyKj2WHpa0s3C6i9/jmUy2HWSBwVM2xCGJrxi8K/Eoc1i236ds5H/G4wJ
         xmXaC6bIw+9iwiba92w30PmnOojGPKtaLVBaot3yRtneEjVV5ZvXiGLCxaRjXgLn4+6r
         SbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9/6iMyuxRs29CcJNRGQlw3NkjK+ZAaS1DQKNOdZ49Y=;
        b=lgqyZ1S0/h3WCSMcHi212ay5c/pwekfz0aXtE32bwqnv4knbQuXZtEZT+3biBaBthF
         jAnOIDLyLHZMVYERIK6BOl2FkQ+Tmz6M6LnOUdw+blv3CRSv6eMfYwWp8CKfKzAZCfOW
         Ge2IjulSaQthFLT+iXGDpI/6ka6zSVvXfsf0Vb2uxKhuFnjZXf1gO4Ov1JBbSDEBDTh9
         SW5T7IkBKNuzXcWmfE5KlSMn7wm+RVipU7q2hTH2dpPqzvmWOb59Y7n/AzXEfempSTYQ
         Xauq4JRWbNx3rFjkrhNBq+gTrOOFZhE5esq6TY4jWaOXyPWtfosoeFwV87+Xpb7pmlMx
         Bh1w==
X-Gm-Message-State: AOAM531vTcbOpbFRhQztQb0h1jmgFcBNII5wk35yvLvPwrz2Ef0hgToL
        V9ffnrTQFVsZi7kw9okIiOP7
X-Google-Smtp-Source: ABdhPJw2lnv9eXuIfyKMaV0vZcd4W0AB+lLZP2R6KF9/aiT6U25wEoMJoTUI98wCUAp3d0KnHSTTnw==
X-Received: by 2002:a62:148a:0:b029:156:857e:853f with SMTP id 132-20020a62148a0000b0290156857e853fmr9112632pfu.25.1603735104771;
        Mon, 26 Oct 2020 10:58:24 -0700 (PDT)
Received: from localhost.localdomain ([116.68.74.56])
        by smtp.gmail.com with ESMTPSA id o65sm11583088pga.42.2020.10.26.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:58:24 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     johan@kernel.org
Cc:     ribalda@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kbuild@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, vaishnav@beagleboard.org
Subject: [RFC PATCH 5/5] gnss: change of_property_read to device_property_read
Date:   Mon, 26 Oct 2020 23:27:18 +0530
Message-Id: <20201026175718.965773-6-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026175718.965773-1-vaishnav@beagleboard.org>
References: <20201026175718.965773-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

change of_property_read_u32() for the current-speed property
to use the device_property_read_u32() this helps passing the
properties over a suitably populated struct property_entry.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/gnss/serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index def64b36d994..473faeea6aae 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -110,10 +110,9 @@ static int gnss_serial_set_power(struct gnss_serial *gserial,
 static int gnss_serial_parse_dt(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
-	struct device_node *node = serdev->dev.of_node;
 	u32 speed = 4800;
 
-	of_property_read_u32(node, "current-speed", &speed);
+	device_property_read_u32(&serdev->dev, "current-speed", &speed);
 
 	gserial->speed = speed;
 
-- 
2.25.1

