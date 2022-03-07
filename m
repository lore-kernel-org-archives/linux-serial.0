Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EDC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiCGIKo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiCGIKb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:10:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696B4CD64
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:09:37 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A08E73F621
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640573;
        bh=4HAGUFdmLrEMxU9EFzkJe4Ux3HcmnFK/yDcsBQCmOjM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=e1AUiT7qakrbezj64vxttoVNwYMCdWU3ly9Nd2DI5BPjvLHZrgZtmASbVy60aywZP
         3FGc6mbv1esEpSPaoW/gAr3418SntY/mvnmbUh3/kQGnSk7mSM8m/mUtWL5DxE9XUO
         SrsdPBOsGW4knPH3aA831USgCfjRIg7/txa7ZPs+iDCMH1ZgA+fJ/0gMllOgyMwfBe
         CBQUKgdByTZQwMkOH1UekB6rUt7hsGrcydUaNQ7CgqHE2Q9cINYtbL+AO8OYKdakgO
         gRBT5mvhp71oNEP1ZQPJikEB9rOLJUTtQnCMHW/8mpwy2ZkJyC46HDASE+AbxCPLg8
         rriHFvGM2ZM/g==
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso8155534edc.16
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 00:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HAGUFdmLrEMxU9EFzkJe4Ux3HcmnFK/yDcsBQCmOjM=;
        b=f2xj5JeRwM2B0X5tka2V1q0AV/FyU/4bi52pHhgFmes9Z7psDZQbbntjQOZids1ev2
         iHyE+R4yN4s60FRPBiSb+YG0A4iCO4B5Oa+WqKKKFWgYC4YNt9hbnNODvgQgTopze+DW
         MIYBgXjnMq/I0Kz42wf2lSUAKLheQboa8MfbNT/RM2csxUe5YoxvOGGj92wRiXhFaVuN
         OtEkIWZJWVUDG+doqmMZL8zrjV4rRPdYzrO980smfzh5RGsVIY/XKW/FiKyI+SskcYOx
         izPD9Dnj7fptdRNsymc7Npr3A82+3/9QMynXyd1jGqZYKmNF2P6xESTrbZcXSW6TPF/5
         5Z5Q==
X-Gm-Message-State: AOAM531FqJzqcyuSt+7EjZDD+d3NjA1JUgKJnCRkr/S6IHPaTeYPBW7m
        YjLnhp8LiHGM4R0srAFFTPLuqVCrLxlbphUTAdkKBZ/z/z0ZCySZqKzQqkhMQ0vYsPgUMh4UxbY
        7h3VI1vUFiAzP2cG2zKqLJDq/9DElQSymP8dX1427uA==
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id d24-20020a056402001800b0041086cd9dcemr9810250edu.70.1646640570856;
        Mon, 07 Mar 2022 00:09:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgU+c7KFSylijaRWQXv0cNRe/wpPkgSFLwallIr6sdnzfiO44fulIE699j1F9ifcnE8L0KOA==
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id d24-20020a056402001800b0041086cd9dcemr9810243edu.70.1646640570665;
        Mon, 07 Mar 2022 00:09:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq14-20020a1709069d8e00b006da650af5a9sm4472594ejc.3.2022.03.07.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:09:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] tty: serial: samsung: constify UART name
Date:   Mon,  7 Mar 2022 09:09:22 +0100
Message-Id: <20220307080925.54131-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4b13f2d6e26..7025306f76b7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

