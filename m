Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561EC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiCGIKc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiCGIK2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:10:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5B4507D
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:09:35 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6CFC83F61D
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640573;
        bh=kV9bWky3aqex0YOWejd45KPzqFNsCZcNjbYJT0yjx5k=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RQphjHQJmXBAx8OeYX3OY6E4zyOjEy4PMuiTtFe9MtP6VCgrOaAkK0apjKxRO7F7m
         K7BmT9MdmXicq9yhv0zszOqSmESNTkEaUonfd3E9yTFDBO/wwWnLiOuh+uydgdycSl
         IWYvNCP/ksnjlqLXFz6hipklyLKAr1QAXGOom/GhpbS1yzdShup3re0/4i9epK7snC
         eHZ0slxKAOjPmYX0xj8aqJ2Op8sEtILpBkxkDcqy5Ie8qBz7qD2cWaGH66e3/hi4I5
         40jzuA0yuQIucLROu97t2utbpOIUpMrWrogbQhua8zJG5Q9MdGN56JkpKvpN5eCIIO
         TQa0rPmVzbDUQ==
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so1782181edq.8
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 00:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kV9bWky3aqex0YOWejd45KPzqFNsCZcNjbYJT0yjx5k=;
        b=IUp5Nc3eZ8cjaLR/Ne6xh+7W2XIe0SB44zRo2WhlHeC4idMu0tLmpf9fnfIcJM+tWu
         YNnrmM4iOWYW77Am12GBKBJH6vCc8xwejlMrI3/G0sy4EHWzZI5hvdR2WNFnovz1ARTZ
         9NLirNyWcO1wZE7iQJP/9xrSfA0I7RqPEXqCm8uvL7+JyPoDnhCRGZ2hIUIf4+KmRo1Y
         B8MANuOE9/sOQuc7/ExEax/FrJ3eSayQ6ZYG5rbStFmWLYVFahjWXxXpeiBcGlO6qLVw
         Xgb/p9DRP4DeNM7HPVTpcSHkiAPaAHiBxJC7FQQPw5Ry4fXT0qsJxaeTMK4TZ2LFcxCS
         mLsw==
X-Gm-Message-State: AOAM530kf2UIgSl5GZqq+wYtMHsvLP3eTh7U4f6klPc4DNhaTY+eiKE5
        Qd69sWVLCNjIhdHoodkh5MSArsVI49NmzuA4vNZ/Jzy1TLo3QdCr5PVojDTA2V1TK7qncz14yru
        SwL+m1071UXaXGOXzDAMTueP0QbffdYTPDIHQ/qvQMA==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr7978728ejc.635.1646640572158;
        Mon, 07 Mar 2022 00:09:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu85jkg65tIPk5L9NKONVRpMHiBi3IKZigN9L3D0ZJ8f0joA64x28uwWQqTpa7qj5dJKGMqw==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr7978714ejc.635.1646640572014;
        Mon, 07 Mar 2022 00:09:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq14-20020a1709069d8e00b006da650af5a9sm4472594ejc.3.2022.03.07.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:09:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] tty: serial: samsung: constify s3c24xx_serial_drv_data members
Date:   Mon,  7 Mar 2022 09:09:23 +0100
Message-Id: <20220307080925.54131-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is never modified, so
also its members can be made const.  Except code style this has no
impact because the structure itself is always a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7025306f76b7..b9783d8fb440 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	info;
-	struct s3c2410_uartcfg		def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	const struct s3c24xx_uart_info	info;
+	const struct s3c2410_uartcfg	def_cfg;
+	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
 
 struct s3c24xx_uart_dma {
-- 
2.32.0

