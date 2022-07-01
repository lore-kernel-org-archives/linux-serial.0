Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5EC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 08:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiGAIXj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiGAIWi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 04:22:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C07358F
        for <linux-serial@vger.kernel.org>; Fri,  1 Jul 2022 01:21:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l6so1690160plg.11
        for <linux-serial@vger.kernel.org>; Fri, 01 Jul 2022 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noUyypKftE40ROE3MTZpJWzx7cTIt4r0kQzFClbiivU=;
        b=anUlmuF/xY4AUURsJoVDq8a+6jE3vDG+mIzYb/pfyha56fzt1qv/ljhrQgm9o+bxve
         Zg0ABJUz/n+zxKw73Awhp/GQGUsZXYw7TDDlWjqgXybkdK0MERUWp/DkHyskqb5XPGe1
         /rT6mYQuDi5mQB1f2FwcTxYkYRoe0c8N347t6v6kuxFQiAHypSUnhxg162GHuKs7y1dl
         jiXER+GymjG9CHTkKUPKi8QGEkoblsvt7ZT3NLr4WCCoDU3eNAsPSvublTsus9S+2cAD
         mw4DNjfGPTozwMVO1IvEyIq+Wha2nniZQBmxW7pqJJ158/L866DL+fEUU50434hmeVwP
         rsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noUyypKftE40ROE3MTZpJWzx7cTIt4r0kQzFClbiivU=;
        b=RoZ+BBpaQgjbj00Z8wy4vkdFIM7frtKMqFQMMWdddagWqg0yGOJZamDwf8kzOXfilR
         Vdgu4J8VkcXzHxJM+9CeoUNSekPgc7w4KZLiAUHxjX4DIIEDYfv5JwjHUmWjugJ+8NNx
         JFkSgcd5W4ktWan0elRFlE9YPN8rV0TIw5yIW/tm+fKWlOUVL2YwuuvUxC8hQBaXP0Dj
         PGO3sLVzPglzyRhDlOD0CijaJ1M+Y2ccSspwyFFg7rrVXWIALh1HFVy1Ep6hYvS+AFvf
         2v+SP8qfJNNMqG8RGvcPrsdBycwTiZ0/9wuEkkaab4nbyeimAYIk5YxvcjftnZK1uX8S
         y9Gw==
X-Gm-Message-State: AJIora9Vy/Ppb/pWks6ugNab6WqwZbzEfmVfWw7ae94AFj6WyH6UDFS+
        MDJKvStNwdSvAGUynnJFvvG6zg==
X-Google-Smtp-Source: AGRyM1vPBHYPyEmnR6pJN+h8oaoYat/QQyCYYbGDGAZ6ThwRx3949kCJYsfczawiYp2t+ZlbH+644w==
X-Received: by 2002:a17:90a:f8d2:b0:1ec:b55b:2fdc with SMTP id l18-20020a17090af8d200b001ecb55b2fdcmr15087951pjd.115.1656663712055;
        Fri, 01 Jul 2022 01:21:52 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id y41-20020a056a001ca900b00518d06efbc8sm15099135pfw.98.2022.07.01.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:19 +0530
Message-Id: <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4733a233bd0c..ab667838d082 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1347,6 +1347,10 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	int irq;
 	bool console = false;
 	struct uart_driver *drv;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "se" },
+		.clk_count = 1,
+	};
 
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
@@ -1430,7 +1434,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

