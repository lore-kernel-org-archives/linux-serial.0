Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEEC49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA6261425
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFYJca (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFYJc3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:32:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B2C061574
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:30:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so5123467pji.4
        for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2021 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgJH30M4gbJI11No9Z9T8HpQflTB7qEwzVBfIQm5RFg=;
        b=GUOUA7J9E9Fantbv1P2emZtjPCI9XEDAMgs1YqUDfUNlvKFIGC4RManN01khP2GmD0
         i+cLRDiO2ctS0M3Ktv0H5aa5CeAw/NUzVWOSh5it0vTlPVcSQUBj2J8xIiCQDw9pF7yX
         sKkQiTg4wchhW/wr1o5hT4FVuSijCQTL68JaTqScas9k0DZCz5XFBWZH/rbiKeiI3UQC
         9gwC0gdbR8QNJOKRIeRzgX/E19QDHLCF99Rvx/XmA1aJuahl9pWuN6J7plUIWEQJWkGJ
         viVnPZpGeCd9maJ67QZhUWw1q6xdu2GAmXc2ohMTJlxqM+DZfwN6NO9eRpWTEkYvGssc
         rndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgJH30M4gbJI11No9Z9T8HpQflTB7qEwzVBfIQm5RFg=;
        b=Ym01gIXUaMCF8qF0rHn6b5SxovBGThDTTyRNOG5Hj/Ux+YExO0MtQ1YwhJQpCfr7Ez
         MleQ6mqCbkNHDCV3qBfoDWNLjqnfAG1ag/cxddyly3ggV+hyzAlialJAPKdHsxi7RQDW
         H69IpeHyY1pZ8h2WzWg2/YmHSP7Y5LXfkh3256lDzR9Hr+qu0Hwa3jKIJlOMn0s7zEgj
         dv92HZ5x682zUJP3XvIWHXx6AzKXd99oGC/F/fPgVYh2kl+cP+mMWQjgULptckgnaRI+
         +hJUx7ojoXGz1h2RNpvoPDCj1DLauq8LIphOcudwP3Vesj78vcL678tNfRQ0riWrHr9N
         pTZw==
X-Gm-Message-State: AOAM530QU0VDjIxlf6soLG0ky4L/iPVUJ3raEoX48tb+dDExzR/EpA0/
        WnOYmmTA8Hn/LnCvSDUt1zM=
X-Google-Smtp-Source: ABdhPJwf6BpwtRHaSqESI3iMiFO1DQn7PHROXc6XlE3wkaTjwKe4h+iCBEZnwXaySJLxg9tMwYTQzA==
X-Received: by 2002:a17:90a:c591:: with SMTP id l17mr20655506pjt.105.1624613407056;
        Fri, 25 Jun 2021 02:30:07 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id y3sm4891716pga.72.2021.06.25.02.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:30:06 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC serial port driver
Date:   Fri, 25 Jun 2021 17:29:52 +0800
Message-Id: <20210625092952.12601-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC serial port

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Kconfig b/Kconfig
index 603137d..e440760 100644
--- a/Kconfig
+++ b/Kconfig
@@ -518,3 +518,18 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_8250_SDC
+	tristate "SUNIX SDC serial port support"
+	depends on SERIAL_8250 && MFD_SUNIX_SDC
+	help
+	  Support for SUNIX SDC serial port.
+
+config SERIAL_OF_PLATFORM
+	tristate "Devicetree based probing for 8250 ports"
+	depends on SERIAL_8250 && OF
+	help
+	  This option is used for all 8250 compatible serial ports that
+	  are probed through devicetree, including Open Firmware based
+	  PowerPC systems and embedded systems on architectures using the
+	  flattened device tree format.
-- 
2.20.1

