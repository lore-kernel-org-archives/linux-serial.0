Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49950C7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 02:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCBCfO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Mar 2023 21:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCBCfN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Mar 2023 21:35:13 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C573B840
        for <linux-serial@vger.kernel.org>; Wed,  1 Mar 2023 18:35:13 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so304392407b3.10
        for <linux-serial@vger.kernel.org>; Wed, 01 Mar 2023 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677724512;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=caFgStrTuySjAQcmvmwnTSRJEM4Rl3g/SRMkznV97d8=;
        b=iY8Jh2kRo29CB7vA8hyuykn4S8nQHPN2KKKIjOyaG75XwivUDLy7g6fX1TNcCdNfwb
         Y+t1Sy0aulmA1tVRWscaVXEek1xrr4gd4a3hEjifTotPlt5Af2XyscpbvGxgj6FZBp1O
         ozIYFehno9Grehq4PJPMlK7VPjkil82KaCz+AHGmF4aUGPQcI+LD88tjvjmJWzxgerYr
         djV4+ezic/RZhbrrLzFPa2vnUm4Z51Ds6IhEV+1REBMcmEOFjo8Uh9a1mSiHvfsI5mpq
         hLyr0tfELWJzfcSi5s78jgjDPDllEudvMk3atr1WpAdJVQUfbjhQ/wyyHYplo9RB0Jz/
         nquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677724512;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caFgStrTuySjAQcmvmwnTSRJEM4Rl3g/SRMkznV97d8=;
        b=KGNzGi0FnE/hh5XTGvTf/uPjQVKX8WeSFW1la1sBo3CYiCLSEKQgCJ9K4l9EBjyEbw
         i/6zGYAvMWzcGiXDPyhNy7hwopaLNttN8U6JkJkzGyibZ743+a0X/dvf6wntyu1SLXsZ
         ym76B68b07x5LdwiCM69Tk7stCBzE4e9Q9HqGJNx5Is0GxQxpsbKs5GyqGeWxeHvbN1b
         VZgrcWqK2+VS9TybM8Jrm+2JTHbcttP+XQhS7+iPLD6Iyg+jGZKYzFqaOYeTfuCL4mwV
         6hI/cG32l1ZvGPp19nVPlVcCSphc8jW5Rz+WCCfla/DueeU1RsvUSIg7QrUi7v6UJ2eF
         vulw==
X-Gm-Message-State: AO0yUKVU3Q/DxU4ROw7X+v5B8Tw9j6VntZfmpTm2/lch9yMVApebsDWc
        i+3sfWv3lirWqalvF9RMDyFbIzDdr4cd/no=
X-Google-Smtp-Source: AK7set/Hv+rH5hBk60nAMaxloM3SlgNfaFtK67uEGAQpoRWIHi0ABy3iw5mGbd1AwDypVrqmmHn/62tQ/dI1M5s=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7e6c:b66b:c51a:b6ed])
 (user=saravanak job=sendgmr) by 2002:a81:b305:0:b0:536:155a:b73d with SMTP id
 r5-20020a81b305000000b00536155ab73dmr5460494ywh.2.1677724512316; Wed, 01 Mar
 2023 18:35:12 -0800 (PST)
Date:   Wed,  1 Mar 2023 18:35:09 -0800
Message-Id: <20230302023509.319903-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1] serdev: Set fwnode for serdev devices
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        kernel-team@android.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This allow fw_devlink to do dependency tracking for serdev devices.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Florian,

Can you give it a shot and a tested-by please?

-Saravana

 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index aa80de3a8194..678014253b7b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -534,7 +534,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		if (!serdev)
 			continue;
 
-		serdev->dev.of_node = node;
+		device_set_node(&serdev->dev, of_fwnode_handle(node));
 
 		err = serdev_device_add(serdev);
 		if (err) {
-- 
2.39.2.722.g9855ee24e9-goog

