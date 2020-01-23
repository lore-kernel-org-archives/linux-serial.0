Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18315C2D0DB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB29024673
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAWMts (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:49:48 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:18646 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgAWMts (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 07:49:48 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jan 2020 18:18:28 +0530
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg02-blr.qualcomm.com with ESMTP; 23 Jan 2020 18:18:06 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id 809F926EE; Thu, 23 Jan 2020 18:18:04 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        mgautam@codeaurora.org, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [PATCH v2 0/1] tty: serial: qcom_geni_serial: Configure UART_IO_MACRO_CTRL register
Date:   Thu, 23 Jan 2020 18:18:01 +0530
Message-Id: <20200123124802.24862-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Configure UART_IO_MACRO_CTRL register if UART lines are swapped.

Roja Rani Yarubandi (1):
  tty: serial: qcom_geni_serial: Configure UART_IO_MACRO_CTRL register

 drivers/tty/serial/qcom_geni_serial.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation

