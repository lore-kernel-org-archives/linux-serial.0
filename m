Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D9C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FF0230F9
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLGIs6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:48:58 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:44566 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgLGIs4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 03:48:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607330911; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=vqKFDMyKSdWm8xKsJqBa05cZhDEYEg8fVL7CcxI3zKQ=; b=TvT4E32T+X7gf79pBY2LyXj7mwy+cibl0rcDi/FQl+QBKsgzFM4S63h2lGuTe7QscOKOjyNi
 no/byrWpixRBn6OuYNKA/Sbe+zj1smgnvEYsIZrMXLy2sGjJ3lnwx1/zQ9F7+/cLRLFbgYMK
 qNOf9jfjtVeocXmdk/Idq+LcUyI=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fcdec3fb50fb3818a3d1077 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 08:47:59
 GMT
Sender: akashast=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07775C43463; Mon,  7 Dec 2020 08:47:59 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65E57C433ED;
        Mon,  7 Dec 2020 08:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65E57C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH  2/3] arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path
Date:   Mon,  7 Dec 2020 14:17:26 +0530
Message-Id: <1607330847-15522-3-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607330847-15522-1-git-send-email-akashast@codeaurora.org>
References: <1607330847-15522-1-git-send-email-akashast@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We had introduced the QUP-CORE ICC path to put proxy votes from
QUP wrapper on behalf of earlycon, if other users of QUP-CORE turn
off this clock before the real console is probed, unclocked access
to HW was seen from earlycon.

With ICC sync state support proxy votes are no longer need as ICC
will ensure that the default bootloader votes are not removed until
all it's consumer are probed.

We can safely remove ICC path for QUP-CORE clock from QUP wrapper
device.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 22b832f..cd09b67 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -763,8 +763,6 @@
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x43 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>;
-			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -1054,8 +1052,6 @@
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x4c3 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>;
-			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c6: i2c@a80000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

