Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F646C34023
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B0A22527
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="crwcAUNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBQNas (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:30:48 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:29562 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbgBQNas (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 08:30:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581946248; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Z5/MTeBK1zupTFMk9qwaVYa801gbbRa24zyXNMFfhXw=; b=crwcAUNEeTs3vaeHH6cPJtjnoLtOzBbRlOqYirfe3vOET73F7+cOWhvpM2wOlMrmfWEqV1B7
 e2HFrRcIWHmHhqdm6nIPFvXRsiCFZ44zogpI5u5AiCqt+88dpGQifzjV8JsPCUjgaVkUQd3l
 IpZ7n0pqDLY6AEXBDGiCDpWomfE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a9578.7f29dfd51500-smtp-out-n03;
 Mon, 17 Feb 2020 13:30:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21684C4479D; Mon, 17 Feb 2020 13:30:31 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC83BC447AA;
        Mon, 17 Feb 2020 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC83BC447AA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH 0/6] Add interconnect support to UART, I2C, SPI and QSPI
Date:   Mon, 17 Feb 2020 18:59:59 +0530
Message-Id: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dt-binding patch for UART, I2C and SPI.
 - https://patchwork.kernel.org/patch/11385965/ [Convert QUP bindings
	to YAML and add ICC, pin swap doc]

dt-binding patch for QSPI.
 - https://patchwork.kernel.org/cover/11386003/ [Convert QSPI binding
	to YAML and add interconnect doc]

Akash Asthana (6):
  soc: qcom: geni: Support for ICC voting
  tty: serial: qcom_geni_serial: Add interconnect support
  i2c: i2c-qcom-geni: Add interconnect support
  spi: spi-geni-qcom: Add interconnect support
  spi: spi-qcom-qspi: Add interconnect support
  arm64: dts: sc7180: Add interconnect for QUP and QSPI

 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 199 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c    |  84 +++++++++++++-
 drivers/spi/spi-geni-qcom.c           |  65 ++++++++++-
 drivers/spi/spi-qcom-qspi.c           |  38 ++++++-
 drivers/tty/serial/qcom_geni_serial.c |  84 ++++++++++++--
 include/linux/qcom-geni-se.h          |  31 ++++++
 6 files changed, 481 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
