Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D4C43381
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4028664E15
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBSRst (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:48:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37599 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhBSRsf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 12:48:35 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JHgYZ0008252;
        Fri, 19 Feb 2021 18:47:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=loIA3esYt/3shriHTJz+2fSOwQFG2K336Aa8gSHwP6I=;
 b=0kGfbam1bIRwLSW/7zqqo5xRV11Y9stvRP2Fjj/iBLedOUexpuiTq+f8quiGLpUcFo6z
 vkClfBKpsC7xtslq5eZensZfJ4kVLen1xsjCrs7m9liUvAN1BLi0y4bKEvvxUfC8sx7P
 viLgCm+Rs0xSuMEGpF6egRM1I7X5y+KZjjj/Uc795RHE08ol85W2t+dkMyoDKVtxduhY
 Q+d8QmAJQbxTUZFXQ7y98/Pznvr+9+B5kP72SWTkJcDT+vMABxtMeHSYfJSBFj1arjfB
 4i1ONc8ZEhZp/om09i55xNFsAe2TsZuB5/xaS9+uxV7RtEC1u9igX6TdVBcompjbmsc4 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36sqadhawq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:47:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB51610002A;
        Fri, 19 Feb 2021 18:47:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99A4C25F3FB;
        Fri, 19 Feb 2021 18:47:40 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Feb 2021 18:47:40
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
Subject: [PATCH 00/13] stm32 usart various fixes
Date:   Fri, 19 Feb 2021 18:47:23 +0100
Message-ID: <20210219174736.1022-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series brings various fixes to stm32-usart driver.

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

