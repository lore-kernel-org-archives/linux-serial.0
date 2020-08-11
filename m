Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574BC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCC2206B2
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 07:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHKHny (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:43:54 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:9229 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgHKHny (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 03:43:54 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Aug 2020 00:43:34 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Aug 2020 00:43:32 -0700
Received: from parashar-linux.qualcomm.com ([10.206.13.63])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Aug 2020 13:13:24 +0530
Received: by parashar-linux.qualcomm.com (Postfix, from userid 2363307)
        id 891AC214D9; Tue, 11 Aug 2020 13:13:21 +0530 (IST)
From:   Paras Sharma <parashar@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paras Sharma <parashar@codeaurora.org>
Subject: [PATCH V2] serial: qcom_geni_serial: To correct QUP Version detection logic
Date:   Tue, 11 Aug 2020 13:13:14 +0530
Message-Id: <1597131794-1076-1-git-send-email-parashar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The current implementation reduces the sampling rate by half
if qup HW version greater is than 2.5 by checking if the geni
SE major version is greater than 2 and geni SE minor version
is greater than 5.

This implementation fails when the version is 3 or greater.

Hence by adding the another check for geni SE major version,
this problem can be solved.

Signed-off-by: Paras Sharma <parashar@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3aa29d2..a9f92d8 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -995,7 +995,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
 	ver = geni_se_get_qup_hw_version(&port->se);
-	if (GENI_SE_VERSION_MAJOR(ver) >= 2 && GENI_SE_VERSION_MINOR(ver) >= 5)
+	if ((GENI_SE_VERSION_MAJOR(ver) >= 2 && GENI_SE_VERSION_MINOR(ver) >= 5)
+		|| GENI_SE_VERSION_MAJOR(ver) >= 3)
 		sampling_rate /= 2;
 
 	clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

