Return-Path: <SRS0=Ld9p=54=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F4C2BB55
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179E206C3
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w+3hJt5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2179E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgDLSPJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgDLSPG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Apr 2020 14:15:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F192C0A88B7;
        Sun, 12 Apr 2020 11:09:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFA6206DA;
        Sun, 12 Apr 2020 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586714993;
        bh=KvvVL4O/277aJbdbXBvwqPERBOm9+Bv6KLT8QTuv4zM=;
        h=From:To:Cc:Subject:Date:From;
        b=w+3hJt5/xqWcvDyO97BZEb7+ZEa7zW4Mbf5oiloYlbd4WzthZF/hm1ykeDka3C5w+
         rHcMPFBC82G3Vrd48IF1ABsAKL8i7DaTXzEs2IIKlrQQ+NiD57WKPlUimhh3DR69ZJ
         /QWLrfeWOkTcCxbPXNtaGpeMhV+jg5jDKpp3Dpu8=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/2] Add software flow control support for STM32 UART
Date:   Sun, 12 Apr 2020 23:39:21 +0530
Message-Id: <20200412180923.30774-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This patchset adds software flow control support for STM32 UART controller.
This is necessary for the upcoming STM32MP1 based board called Stinger96
IoT-Box. On that board, a bluetooth chip is connected to one of the UART
controller but the CTS/RTS lines got swapped mistakenly. So in order to
workaround that hardware bug and also to support the usecase of using only
Tx/Rx pins, this patchset adds software flow control support.

This patchset has been validated w/ Stinger96 IoT-Box connected to Murata
WiFi-BT combo chip.

Thanks,
Mani

Manivannan Sadhasivam (2):
  dt-bindings: serial: Add binding for software flow control in STM32
    UART
  tty: serial: Add software flow control support for STM32 USART

 .../bindings/serial/st,stm32-uart.yaml        |  15 +-
 drivers/tty/serial/stm32-usart.c              | 143 +++++++++++++++++-
 drivers/tty/serial/stm32-usart.h              |   4 +
 3 files changed, 155 insertions(+), 7 deletions(-)

-- 
2.17.1

