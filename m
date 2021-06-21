Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE035C4743C
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92643600D3
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFUVRs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUVRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 17:17:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856CC061574
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 14:15:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i13so32396241lfc.7
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8LCz6lkvapvDVbV9d8++oTpnZmaRJcBw/CJv5OQ27c=;
        b=AANXDapCv9pqmNzUsLOiY7pKVQlXUzBAUTC92MqkETvxK9Mesbo5daRa/nXLdrdDm7
         xc0iLGmHbWDYXwnA+WbT8jY4rNvhEBdet4YiWUP+u3dIr7Jpp4TvXobvb6cgfFofMSDO
         Ykd8dtn0iwE9dyQiOBUTYpDOkjNT50gLkV3+g2xMJSZflTVuUhWxmjU3v2Kty8ckT+Ot
         NW5xn/O+0ulqiBA4bzuhRzjEN8PH4J/PqWVXFVq/p+XezVv834C6FRhL7YXSAvdPyfs3
         q0G4DsavUeBbjEe5rWHn/H9mEzl8tfHRInnr+ELzRu1vi9NAmfODt+I9Bdiy2F2Wq1M3
         Uybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8LCz6lkvapvDVbV9d8++oTpnZmaRJcBw/CJv5OQ27c=;
        b=nTY1TaQr0R00+yUdRmKYnHAOaWg4bwxCNh5guYystCmuCV7Bss7wtYNdRMsMINbbbv
         UoM8Qk+eHC3j4RBTQytRvtPYJnYyKDADGAvJMZHhJUnWZdQnQMTmbkOFHuMx4XPyXknR
         8Seim1pwkH/H5q7fNDd5JxIdRuWXEEpJwR0X1+Qsrz6G448ZS0bHAvg+/XVZjruEGZcv
         aVhu31CjC32l7a74X4foF0ELAAW005jjAnLwnhMF3d2YasGOZPP287rX32jyfeVpb6wF
         /g7HIzHgwMq9/nGoQ2dbLqyBMLgmpl1/EHA6QeVPSSJl+dDdYvzKQsBTpggA/1TfJWgh
         9GtQ==
X-Gm-Message-State: AOAM5329uJDn4mX1xPlVh+QlQbY2/fXFiC2ats4X/0OFO9be6kKpEeMA
        D4Y+h9gOupR47fGbxzUZHiqylA==
X-Google-Smtp-Source: ABdhPJwlfqTgPLIW2DfAo+owEtoA5YnoYw5Nj8WaozvGfiNmryLDEH/CS7gK1VG/jtGPkN80jJ3T0A==
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr164708lfu.549.1624310130117;
        Mon, 21 Jun 2021 14:15:30 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v8sm1213943ljk.122.2021.06.21.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:15:29 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] serial: qcom_geni_serial: use DT aliases according to DT bindings
Date:   Tue, 22 Jun 2021 00:15:28 +0300
Message-Id: <20210621211528.1607516-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Device tree bindings do not specify "hsuart" aliases, instead all serial
ports should use "serial" alias name as noted by Rob Herring [1].
Make qcom_geni_serial driver use "serial" alias and fallback to "hsuart"
if one is not found.

[1] https://lore.kernel.org/linux-arm-msm/6dd1f5cd-03c7-5945-9fa2-1c2698405110@linaro.org/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 23d729ed3bf6..85f1c1f96597 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1354,7 +1354,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		line = of_alias_get_id(pdev->dev.of_node, "serial");
 	} else {
 		drv = &qcom_geni_uart_driver;
-		line = of_alias_get_id(pdev->dev.of_node, "hsuart");
+		line = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (line == -ENODEV) /* compat with non-standard aliases */
+			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
 	port = get_port_from_line(line, console);
-- 
2.30.2

