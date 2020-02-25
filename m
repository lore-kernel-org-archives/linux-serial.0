Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC6C35DF5
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BC6218AC
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 13:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgBYN4C (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:56:02 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:65130 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgBYN4C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 08:56:02 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Feb 2020 19:25:25 +0530
Received: from c-skakit-linux.qualcomm.com ([10.242.50.210])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 Feb 2020 19:24:54 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id B6B173AE7; Tue, 25 Feb 2020 19:24:52 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     swboyd@chromium.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        akashast@codeaurora.org, rojay@codeaurora.org,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 0/2] Fix RX cancel command failure
Date:   Tue, 25 Feb 2020 19:24:20 +0530
Message-Id: <1582638862-9344-1-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Changes in V2:
- Add patch to allocate port->rx_fifo buffer in probe to resolve
  NULL pointer dereference crash reported by stephen.

The crash is caused due to set_termios call starting RX engine and RX engine
is sampling some garbage data from line, and by the time startup is called,
we have few data to read but port->rx_fifo buffer is not allocated causing
NULL pointer dereference.

satya priya (2):
  tty: serial: qcom_geni_serial: Allocate port->rx_fifo buffer in probe
  tty: serial: qcom_geni_serial: Fix RX cancel command failure

 drivers/tty/serial/qcom_geni_serial.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

