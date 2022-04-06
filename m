Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07FC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  6 Apr 2022 11:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiDFLlg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiDFLjs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Apr 2022 07:39:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECC5601DE;
        Wed,  6 Apr 2022 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649233636; x=1680769636;
  h=from:to:cc:subject:date:message-id;
  bh=mxkKTAJbE88/K0WJ0aBJfYdx2O1wtFiDPVBLHhOOmjw=;
  b=WF+hPYF+k2lxiae9ecAKwzqzVOS3LyZE+q/FmDv9+tcV50+05XPqzgI0
   Jl/lX5rQ/luj+Eqx6FBOzXvKQ8Y2sYoEPLqx6O9vJowbv6Yq/FXtRFaXD
   fBAoR70wVIUyMUiMgL9Pnh5byDZ9+jfyZUs5dYg7NS422fXrEy5oENaOV
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 01:27:15 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Apr 2022 01:27:13 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 Apr 2022 13:57:00 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 54D213B54; Wed,  6 Apr 2022 13:56:59 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V2] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend path for console if console_suspend is disabled
Date:   Wed,  6 Apr 2022 13:56:52 +0530
Message-Id: <1649233612-30844-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For the case of console_suspend disabled, if back to back suspend/resume
test is executed, at the end of test, sometimes console would appear to
be frozen not responding to input. This would happen because, for
console_suspend disabled, suspend/resume routines only turn resources
off/on but don't do a port close/open.
As a result, during resume, some rx transactions come in before system is
ready, malfunction of rx happens in turn resulting in console appearing
to be stuck.

Do a stop_rx in suspend sequence to prevent this. start_rx is already
present in resume sequence as part of call to set_termios which does a
stop_rx/start_rx.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1543a60..6f767c7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1481,6 +1481,10 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
+	/* do a stop_rx here, start_rx is handled in uart_resume_port by call to setermios */
+	if (!console_suspend_enabled && uart_console(uport))
+		uport->ops->stop_rx(uport);
+
 	/*
 	 * This is done so we can hit the lowest possible state in suspend
 	 * even with no_console_suspend
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

