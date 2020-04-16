Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E508C2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1688A20786
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587059906;
	bh=uob6JmhQsIuVSxn6LknqVxhOVd73KK6UiP0jt6GPlzk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ObggAcB1Ewz6yYJ9S9ovY05lVwzTOLsvzpZK2GKQYqxELLsB0PyeDCJFgkk2G8+/+
	 pn2B3+J2izKfv5PnLeuXscjQ5Z3tWefji0aiziCpGe6UhDY5SMifoY9DJGmVTY+fhZ
	 L8Woxh3IlXS0incAnbUpkscCl5JS/fmwAwLg0Fqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgDPR6W (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgDPR6U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 13:58:20 -0400
Received: from localhost.localdomain (unknown [157.50.106.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806A120786;
        Thu, 16 Apr 2020 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059900;
        bh=uob6JmhQsIuVSxn6LknqVxhOVd73KK6UiP0jt6GPlzk=;
        h=From:To:Cc:Subject:Date:From;
        b=aNPdJIx5+vDQui9jyo5c0PQmu3LjohwVttopU8ZmKeKBHx8mi2M+Edq5DRSaNbXm5
         n5/4lsaW/h65mCndQWun1ybG2cdAe33Ryq18d5sNBIei7V6QbUDHrj6dod5utxYXLQ
         O9BSXR/p24p2y4RGMqv9laLGn3wUa0rlNVPbcNVw=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 0/2] Add CTS/RTS gpio support to STM32 UART
Date:   Thu, 16 Apr 2020 23:27:27 +0530
Message-Id: <20200416175729.5550-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This patchset adds CTS/RTS gpio support to STM32 UART controller.
Eventhough the UART controller supports using dedicated CTS/RTS gpios,
sometimes we need to use different set of gpios for flow control.

This is necessary for the upcoming STM32MP1 based board called Stinger96
IoT-Box. On that board, a bluetooth chip is connected to one of the UART
controller but the CTS/RTS lines got swapped mistakenly. So this patchset
serves as a workaround for that hardware bug and also supports the
usecase of using any gpio for CTS/RTS functionality. As per the sugggestion
provided by Andy for v1, I've now switched to mctrl_gpio driver.

This patchset has been validated with Stinger96 IoT-Box connected to Murata
WiFi-BT combo chip.

Thanks,
Mani

Changes in v2:

As per the review by Andy:

* Switched to mctrl_gpio driver instead of using custom CTS/RTS
  implementation
* Removed the use of software flow control terminology.

Manivannan Sadhasivam (2):
  tty: serial: Add modem control gpio support for STM32 UART
  dt-bindings: serial: Document CTS/RTS gpios in STM32 UART

 .../bindings/serial/st,stm32-uart.yaml        | 14 ++++++
 drivers/tty/serial/Kconfig                    |  1 +
 drivers/tty/serial/stm32-usart.c              | 43 ++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h              |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.17.1

