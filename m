Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB88C433E3
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC81B6198B
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCSSo6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:44:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhCSSoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 14:44:22 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JIfj1n006382;
        Fri, 19 Mar 2021 19:43:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=MtAr9SmPeXDyn07+vMdhlHldoLloU0A8q7B1CdEbI6c=;
 b=l0fbkVr+KP8H3lp1nH0JfnHWaFZXNZT4Q2f/Nyc2UqgJiHOLWbj9NUKQYOk8z50cR9Qo
 1yin/i8hToXS+jqq77z0ZxfBruAF7+WGSBI3M7vovh5X49Rq7SBHIEoNnOtHwbv0mMg/
 sHuf1u5k1WaydCWvklkxx5HdKkSBuKbtKon91Xh3WlaznPSdu2/J/HTALehuqYyYqu9A
 ksUcq4xJCLFpiIbw76HRkfZDRFB/tF9+3yxVBJUdHahvBSNb4JTMPhhEw3iv4eORqR8V
 pOQWDZw8dPxZUQojziWPz30L4oi/NfahTquhRGuYo7ZKtLMepyAYL2lvup3BPsNEyaTB AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378psa4ygp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 19:43:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D66110002A;
        Fri, 19 Mar 2021 19:43:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 74D342721FC;
        Fri, 19 Mar 2021 19:43:23 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 19:43:23
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/5] stm32 usart wakeup rework
Date:   Fri, 19 Mar 2021 19:42:48 +0100
Message-ID: <20210319184253.5841-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series reworks stm32 usart wakeup management.

Alexandre Torgue (1):
  serial: stm32: update wakeup IRQ management

Erwan Le Ray (4):
  serial: stm32: rework wakeup management
  serial: stm32: clean wakeup handling in serial_suspend
  irqchip/stm32: add usart instances exti direct event support
  ARM: dts: stm32: Add wakeup management on stm32mp15x UART nodes

 arch/arm/boot/dts/stm32mp151.dtsi | 24 ++++++++++++-------
 drivers/irqchip/irq-stm32-exti.c  |  7 ++++++
 drivers/tty/serial/stm32-usart.c  | 40 +++++++++++--------------------
 drivers/tty/serial/stm32-usart.h  |  2 +-
 4 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.17.1

