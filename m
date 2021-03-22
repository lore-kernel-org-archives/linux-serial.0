Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281EC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C416C61990
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhCVLFc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:05:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:30190 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCVLFG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:05:06 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2021 04:05:06 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Mar 2021 04:05:03 -0700
X-QCInternal: smtphost
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Mar 2021 16:34:32 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 16BD3315A; Mon, 22 Mar 2021 16:34:31 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mka@chromium.org, robh+dt@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [PATCH V3 0/2] Separate out earlycon 
Date:   Mon, 22 Mar 2021 16:34:27 +0530
Message-Id: <20210322110429.14950-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Roja Rani Yarubandi (2):
  soc: qcom-geni-se: Cleanup the code to remove proxy votes
  arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path

 arch/arm64/boot/dts/qcom/sc7180.dtsi  |  4 --
 drivers/soc/qcom/qcom-geni-se.c       | 74 ---------------------------
 drivers/tty/serial/qcom_geni_serial.c |  7 ---
 include/linux/qcom-geni-se.h          |  2 -
 4 files changed, 87 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

