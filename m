Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31419C433E7
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C292070A
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 08:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iXbxDR0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgEUIal (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 04:30:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63556 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728671AbgEUIal (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 04:30:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590049840; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nBasdgm95GcvV4SG9BAhA7HRcljTFajhuwtYn0IaZ4M=; b=iXbxDR0x4p2x3JOeuRbyem5rX+pzi4p14uCrpRT/td0LnfPmg5EY5uA8sua5Sxbeczyd5zuV
 uOm/VD16ChU0cH1Vz/d6HnyhaNAAOh/BiJa0B5vFkrmVOIGIak05KxisDeMr3Eza0ZJj0717
 v8Jc0o06MiXstfEBkCrW3St5FNs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec63c12.7f82d86081b8-smtp-out-n05;
 Thu, 21 May 2020 08:30:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA099C433A0; Thu, 21 May 2020 08:30:10 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E479C4339C;
        Thu, 21 May 2020 08:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E479C4339C
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
        dianders@chromium.org, msavaliy@codeaurora.org,
        evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V6 3/7] i2c: i2c-qcom-geni: Add interconnect support
Date:   Thu, 21 May 2020 13:59:20 +0530
Message-Id: <1590049764-20912-4-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590049764-20912-1-git-send-email-akashast@codeaurora.org>
References: <1590049764-20912-1-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Get the interconnect paths for I2C based Serial Engine device
and vote according to the bus speed of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Wolfram Sang <wsa@kernel.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_i2c_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

Changes in V3:
 - As per Matthias comment, use common library APIs defined in geni-se
   driver for ICC functionality.

Changes in V4:
 - Move peak_bw guess as twice of avg_bw if nothing mentioned explicitly
   to ICC core.

Changes in V5:
 - Use icc_enable/disable in power on/off call.

Changes in V6:
 - No changes

 drivers/i2c/busses/i2c-qcom-geni.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 18d1e4f..f2e786d 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -557,6 +557,25 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = dev->of_node;
 	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
+	ret = geni_icc_get(&gi2c->se, "qup-memory");
+	if (ret)
+		return ret;
+	/*
+	 * Set the bus quota for core and cpu to a reasonable value for
+	 * register access.
+	 * Set quota for DDR based on bus speed.
+	 */
+	geni_icc_bw_init(&gi2c->se.icc_paths[GENI_TO_CORE], GENI_DEFAULT_BW,
+				0);
+	geni_icc_bw_init(&gi2c->se.icc_paths[CPU_TO_GENI], GENI_DEFAULT_BW,
+				0);
+	geni_icc_bw_init(&gi2c->se.icc_paths[GENI_TO_DDR],
+				Bps_to_icc(gi2c->clk_freq_out), 0);
+
+	ret = geni_icc_set_bw(&gi2c->se);
+	if (ret)
+		return ret;
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
 		dev_err(dev, "Error turning on resources %d\n", ret);
@@ -579,6 +598,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = geni_icc_disable(&gi2c->se);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
 	gi2c->suspended = 1;
@@ -623,7 +646,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
-	return 0;
+	return geni_icc_disable(&gi2c->se);
 }
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
@@ -631,6 +654,10 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	ret = geni_icc_enable(&gi2c->se);
+	if (ret)
+		return ret;
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
