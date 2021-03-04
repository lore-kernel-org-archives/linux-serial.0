Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3237C43381
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C240664F4A
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhCDQYV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:24:21 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237014AbhCDQYG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:06 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GC7h1021044;
        Thu, 4 Mar 2021 17:23:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=lnJmncdKhm8n4sa+Kk8o9wrMO4GjhYYAQDF83lOvOVg=;
 b=7MD43yeq6IAfOw3ObYTT7RUss2O4qSgCOx5L/rAEtctIE+gL+KrtpRF203jgtmxmLsDT
 /u5UrRX/NkS8AJImFNsDTTT9ZAqlrPeLdi0R/kaD6WLEsuhmuL5Qe6TG1VeQGB/W1Kbn
 CDOQAo2BAgh5G9euIG+9ZNItCtrvigfLL5o5UzJt2C8L170egXJ2rlqz4WQHF+O1jTfN
 HNqk3EAhyH3i5os6fel/CSV+ceeyXgVEsd5qrJpIl6cg3SRyfqYVqhup59ta7rYdfftq
 p7L+7y5lMI2OgIbPi8yzX3KHJyTXLS4nssFm0V6R+8ykXFbXdDqNqPqcsdaUkXZP3adn vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfc48j8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:23:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E447D10002A;
        Thu,  4 Mar 2021 17:23:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D167020741B;
        Thu,  4 Mar 2021 17:23:11 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:23:11
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 00/13] stm32 usart various fixes
Date:   Thu, 4 Mar 2021 17:22:55 +0100
Message-ID: <20210304162308.8984-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Changes in v2:
Rebase on latest 5.12-rc1 requested by maintainer because of merge
conflict.

Erwan Le Ray (13):
  serial: stm32: fix probe and remove order for dma
  serial: stm32: fix startup by enabling usart for reception
  serial: stm32: fix incorrect characters on console
  serial: stm32: fix TX and RX FIFO thresholds
  serial: stm32: fix a deadlock condition with wakeup event
  serial: stm32: fix wake-up flag handling
  serial: stm32: fix a deadlock in set_termios
  serial: stm32: fix tx dma completion, release channel
  serial: stm32: call stm32_transmit_chars locked
  serial: stm32: fix FIFO flush in startup and set_termios
  serial: stm32: add FIFO flush when port is closed
  serial: stm32: fix tx_empty condition
  serial: stm32: add support for "flush_buffer" ops

 drivers/tty/serial/stm32-usart.c | 198 +++++++++++++++++++++----------
 drivers/tty/serial/stm32-usart.h |   3 -
 2 files changed, 135 insertions(+), 66 deletions(-)

-- 
2.17.1

