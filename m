Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00747C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48A1230F9
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLGIsh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:48:37 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:48317 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgLGIsg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 03:48:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607330893; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PTpMIA6cwoiCGN4K27xmRsY3lufcC0CDTr+pIgDPv6Y=; b=GaMndxRS39CqCvUYpyzMCiVs64zjGK4AmZFCNwtuKFE7s2sZaR/o/JCTjx8UoUZqS0FbmpCi
 NMMbXtgHMaGD4FsVLTw4xrbCIkPGg4EUpvtLx1e/jlHxMyVRG+Xizb9NyQdRsz0JVJ6k2FTk
 pktTnjdw/7YLKUDL9FuASV4WOBc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fcdec2fdc0fd8a317a7f079 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 08:47:43
 GMT
Sender: akashast=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92F8DC43463; Mon,  7 Dec 2020 08:47:43 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFCF3C433ED;
        Mon,  7 Dec 2020 08:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFCF3C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH  0/3] Separate out earlycon
Date:   Mon,  7 Dec 2020 14:17:24 +0530
Message-Id: <1607330847-15522-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Patch 3/3 depends on patch 1/3, Greg would it be possible to
ack patch 3/3. So it could land via QCOM tree.

Akash Asthana (3):
  soc: qcom-geni-se: Cleanup the code to remove proxy votes
  arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path
  Serial: Separate out earlycon support

 arch/arm64/boot/dts/qcom/sc7180.dtsi    |   4 -
 drivers/soc/qcom/qcom-geni-se.c         |  74 ----
 drivers/tty/serial/Kconfig              |   9 +
 drivers/tty/serial/Makefile             |   1 +
 drivers/tty/serial/qcom_geni_earlycon.c | 649 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/qcom_geni_serial.c   | 104 -----
 include/linux/qcom-geni-se.h            |   2 -
 7 files changed, 659 insertions(+), 184 deletions(-)
 create mode 100644 drivers/tty/serial/qcom_geni_earlycon.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

