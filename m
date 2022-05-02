Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C22C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 10:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiEBKtG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384583AbiEBKtD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 06:49:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D86BC87;
        Mon,  2 May 2022 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651488335; x=1683024335;
  h=from:to:cc:subject:date:message-id;
  bh=Ge6cW1KRLSm/yhVqCsAL/hK1N7KsMakAzUmoDrCCAbw=;
  b=HFwIeJ7Gp45Q4OrqA/3wn5KVEirLJzTtcStLVIh0l089C8UdBQh6b8j2
   RfyZBlN13R+hSI3810jOwR2DTyt9ZsnkZ4swigV9Y2FjEXi/Fo66GNcVs
   VnKH/XX6lJik9Ha7w4WWO6sZLMWQ5LWFzrfnq7wUGZ0FJF/tfUGGUwRgx
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 03:45:35 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 03:45:33 -0700
X-QCInternal: smtphost
Received: from hu-vnivarth-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.111.166])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 16:15:18 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id E8AD23D9A; Mon,  2 May 2022 16:15:16 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 0/2] Disable MMIO tracing from QUP wrapper and serial driver
Date:   Mon,  2 May 2022 16:15:12 +0530
Message-Id: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Register read/write tracing is causing excessive
logging and filling the rtb buffer and effecting
performance.

Disabled MMIO tracing from QUP wrapper and serial
driver to disable register read/write tracing.

Vijaya Krishna Nivarthi (2):
  soc: qcom: geni: Disable MMIO tracing
  tty: serial: qcom_geni_serial: Disable MMIO tracing

 drivers/soc/qcom/qcom-geni-se.c       | 8 +++++++-
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 

