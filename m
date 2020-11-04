Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0961FC2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE84B20679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDmsFAU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKDTgB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgKDTf7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:35:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEFDC0613D4
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:35:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so2555801wmg.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH+6ay3ML2IZuG2ItERyIkPsniEGNFXIQf0sfM9xhn4=;
        b=eDmsFAU7R/9xFhQgOZLSoSX4Ozyo7emaZvpoFzlYhKNIkMDz+wFqWLCCvpdbQvhFq8
         ru8XqVU6zE7B6/3rxJWElO0jg8aRU4ZGGMgcpUY/ybI4fJEJZtA5qHFG1/qPv3D5ao4l
         hvhhcYYE7pHbLhzxIlNiz78CcLLxGru7pDHJpWucJPZUkhA1yu5CK+VK047+eqUDGSCg
         zoLNP36tEymkyuyGc6kuetKvRHfnu1GgmFtvoZ6sIqj2pA3Hn171mu5/7KpEpFELkmDK
         OfeA39skAzWp4Kjb9IYniGlqNkpeZ310jPckyoU/haA5GL6VPZAAuQg1wr/tt5i+6xgW
         Qt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH+6ay3ML2IZuG2ItERyIkPsniEGNFXIQf0sfM9xhn4=;
        b=X1ELCZsZ11j3AFpeAxtyo1vYCdU/1ik5uWCNd+eo7SCjLCgIYF4y/9Bmcy9AsYw35c
         gpcQNPAUbpOOQrRuYHUEEFMcOGWbhNNy+UIEyVLLERPpIlqjReCpxPCjBFC/PDilYm5V
         OXkfDRPW0ehb94s3iXUb2oMidp2rtusyZkcIfbh/4Bn5WxBOGUYGMz1G1CX4mfeqx92v
         Ng5g0tXzQ+UOM+gWMBOFSzD5dCoYZAaX7+JibPEOUgJHTr4szKiSjYEsR/Mx9FIBPqTS
         1GJg4Bxcw6miiRLb+7v2FS8XM5smw8gx8H4SjFec4dEr412zIaNNZxg3G/McDOnHJBFg
         8SjA==
X-Gm-Message-State: AOAM533pnIma4TZjj96hd1AWWh0Ncb6PDPzqmfHmEf/tVSQFGjMjoHG6
        td7kwqKsvz9OnS0GWKXrpMk8jQ==
X-Google-Smtp-Source: ABdhPJwv9KaK3YsFPmWngapSaiAdWGp0IVoe9eZG7kU0Utng+LM5h3HswS/vwkbPrp46bn+qVqtzSg==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr6696117wma.91.1604518557593;
        Wed, 04 Nov 2020 11:35:57 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:35:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 01/36] tty: serdev: core: Remove unused variable 'dummy'
Date:   Wed,  4 Nov 2020 19:35:14 +0000
Message-Id: <20201104193549.4026187-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

No need to have a dummy variable here.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serdev/core.c: In function ‘serdev_controller_remove’:
 drivers/tty/serdev/core.c:791:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serdev/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c5f0d936b003a..fecc28a73b3b2 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -788,13 +788,10 @@ static int serdev_remove_device(struct device *dev, void *data)
  */
 void serdev_controller_remove(struct serdev_controller *ctrl)
 {
-	int dummy;
-
 	if (!ctrl)
 		return;
 
-	dummy = device_for_each_child(&ctrl->dev, NULL,
-				      serdev_remove_device);
+	device_for_each_child(&ctrl->dev, NULL, serdev_remove_device);
 	pm_runtime_disable(&ctrl->dev);
 	device_del(&ctrl->dev);
 }
-- 
2.25.1

