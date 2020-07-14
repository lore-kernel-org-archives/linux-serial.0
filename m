Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76715C433E5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 05:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F37E221E7
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 05:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WxFTS3bB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgGNFeG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 01:34:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58208 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgGNFeF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 01:34:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594704843; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PIxPn9TmwLUH9DoRtn54FfW6ocCPCNMGRIylWUzieFA=; b=WxFTS3bBM2zXMF9aoJv/LN/Gm4VyKCJexFgVhPzU5ilu8yIGVDIKcQ5X4H8zMMIEplC8MKjF
 m/VPEsRcw57yzCuCm8wLCc5QAAy/mOFltneBT/XH+/k2r2O51GgLh87uc1cQX30AovpA8mr3
 LXJdhvklsYyLQzFG8zXw86Dm6iw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f0d435dd3d650842287222a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 05:32:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF5FFC43395; Tue, 14 Jul 2020 05:32:12 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4143C433C8;
        Tue, 14 Jul 2020 05:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4143C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        gregkh@linuxfoundation.org, georgi.djakov@linaro.org
Cc:     akashast@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2] tty: serial: qcom-geni-serial: Drop the icc bw votes in suspend for console
Date:   Tue, 14 Jul 2020 11:01:49 +0530
Message-Id: <1594704709-26072-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When using the geni-serial as console, its important to be
able to hit the lowest possible power state in suspend,
even with no_console_suspend.
The only thing that prevents it today on platforms like the sc7180
is the interconnect BW votes, which we certainly don't need when
the system is in suspend. So in the suspend handler mark them as
ACTIVE_ONLY (0x3) and on resume switch them back to the ALWAYS tag (0x7)

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Akash Asthana <akashast@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Rebased on the latest qcom for-next

 drivers/soc/qcom/qcom-geni-se.c       |  9 +++++++++
 drivers/tty/serial/qcom_geni_serial.c | 16 +++++++++++++++-
 include/linux/qcom-geni-se.h          |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index e2a0ba2..355d503 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -771,6 +771,15 @@ int geni_icc_set_bw(struct geni_se *se)
 }
 EXPORT_SYMBOL(geni_icc_set_bw);
 
+void geni_icc_set_tag(struct geni_se *se, u32 tag)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++)
+		icc_set_tag(se->icc_paths[i].path, tag);
+}
+EXPORT_SYMBOL(geni_icc_set_tag);
+
 /* To do: Replace this by icc_bulk_enable once it's implemented in ICC core */
 int geni_icc_enable(struct geni_se *se)
 {
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 583d903..07b7b6b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1505,16 +1505,30 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
+	/*
+	 * This is done so we can hit the lowest possible state in suspend
+	 * even with no_console_suspend
+	 */
+	if (uart_console(uport)) {
+		geni_icc_set_tag(&port->se, 0x3);
+		geni_icc_set_bw(&port->se);
+	}
 	return uart_suspend_port(private_data->drv, uport);
 }
 
 static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 {
+	int ret;
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
-	return uart_resume_port(private_data->drv, uport);
+	ret = uart_resume_port(private_data->drv, uport);
+	if (uart_console(uport)) {
+		geni_icc_set_tag(&port->se, 0x7);
+		geni_icc_set_bw(&port->se);
+	}
+	return ret;
 }
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index afa511e..8f385fb 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -454,6 +454,7 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len);
 int geni_icc_get(struct geni_se *se, const char *icc_ddr);
 
 int geni_icc_set_bw(struct geni_se *se);
+void geni_icc_set_tag(struct geni_se *se, u32 tag);
 
 int geni_icc_enable(struct geni_se *se);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

