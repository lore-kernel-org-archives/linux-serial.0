Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C96C2BA19
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6389120737
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 10:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HoIjTrJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbgDOKmH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:42:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:15167 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896484AbgDOKXw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 06:23:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586946225; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GGjz8tY0e6WxXggFY13xcuAUvyD7bnrpD+rtVLsk8QA=; b=HoIjTrJ3PoZVyYIpJQZy1peVQo4Jxhtv0CipP1n/fHqEgBBDPtv9Ui7wRMrawvvDlX+Iu4hV
 YfLkTOOI8EJ9m+Cn9DlJvX1vJCrKrNAfUXhFXc64D3DxJEUsWiRZoVk1g/KeEAgOA6bkolT+
 pLl8Y3JYxkBWxCoxDitS0LNF9c0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96e0ad.7ff68bc01dc0-smtp-out-n02;
 Wed, 15 Apr 2020 10:23:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF2A6C44792; Wed, 15 Apr 2020 10:23:39 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFA8EC433F2;
        Wed, 15 Apr 2020 10:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFA8EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V4 0/9] Add interconnect support to QSPI and QUP drivers
Date:   Wed, 15 Apr 2020 15:53:09 +0530
Message-Id: <1586946198-13912-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dt-binding patch for QUP drivers.
 - https://patchwork.kernel.org/patch/11436621/ [Convert QUP bindings
        to YAML and add ICC, pin swap doc]

High level design:
 - QUP wrapper/common driver.
   Vote for QUP core on behalf of earlycon from probe.
   Remove BW vote during earlycon exit call

 - SERIAL driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from qcom_geni_serial_pm func.
   Bump up the CPU vote from set_termios call based on real time need

 - I2C driver.
   Vote for CORE/CPU/DDR path
   Vote/unvote from runtime resume/suspend callback
   As bus speed for I2C is fixed from probe itself no need for bump up.

 - SPI QUP driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.

 - QSPI driver.
   Vote only for CPU path
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.

Changes in V2:
 - Add devm_of_icc_get() API interconnect core.
 - Add ICC support to common driver to fix earlyconsole crash.

Changes in V3:
 - Define common ICC APIs in geni-se driver and use it across geni based
   I2C,SPI and UART driver.

Changes in V4:
 - Add a patch to ICC core to scale peak requirement
   as twice of average if it is not mentioned explicilty.

Akash Asthana (9):
  interconnect: Add devm_of_icc_get() as exported API for users
  interconnect: Set peak requirement as twice of average
  soc: qcom: geni: Support for ICC voting
  soc: qcom-geni-se: Add interconnect support to fix earlycon crash
  i2c: i2c-qcom-geni: Add interconnect support
  spi: spi-geni-qcom: Add interconnect support
  tty: serial: qcom_geni_serial: Add interconnect support
  spi: spi-qcom-qspi: Add interconnect support
  arm64: dts: sc7180: Add interconnect for QUP and QSPI

 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 127 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c    |  26 ++++++-
 drivers/interconnect/core.c           |  35 ++++++++++
 drivers/soc/qcom/qcom-geni-se.c       | 111 +++++++++++++++++++++++++++++
 drivers/spi/spi-geni-qcom.c           |  25 ++++++-
 drivers/spi/spi-qcom-qspi.c           |  43 +++++++++++-
 drivers/tty/serial/qcom_geni_serial.c |  32 ++++++++-
 include/linux/interconnect.h          |   7 ++
 include/linux/qcom-geni-se.h          |  33 +++++++++
 9 files changed, 433 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
