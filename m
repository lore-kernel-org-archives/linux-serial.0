Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35BC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDA5611EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJTPGP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 11:06:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230103AbhJTPGO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 11:06:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KAW1Ao018138;
        Wed, 20 Oct 2021 17:03:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=/mbS3rI3GU5MtgSIiUL4Dk27DaAKwzz06CpbrXE9B/4=;
 b=3khk3uMbHjpd3EYtptaJXkilu2nS7czzNUIEbyfxvdLgPYQkIMRayfI9R/WikkUHLLCi
 Lh4bT2yAYmJvaw1nEY8GJ5eoootJwl34FJ+kyed0dXuaQV8tLD1onAEKiNCQmUUo6zo0
 UOSew+OfRLKiwhfhiJPODr0eu+0b9t6WvGfsLo1BSwUl+Ory5BsvXAV3CqFnCTrQCQrA
 /DxXNsKJJ0TIeRXW7DVKpAls6pfgUadVN8Krawzk9xQmFOPXIGb4/ZmyGNjltBLLsFXm
 4VDnMGTA29remt53CY2B41trxySBGS6x0twaFDVnOfQJOkov8xepIqJEjplB2DTL0z52 NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3btdkybm16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 17:03:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 446FA10002A;
        Wed, 20 Oct 2021 17:03:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CAAA22A6E8;
        Wed, 20 Oct 2021 17:03:50 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct 2021 17:03:49
 +0200
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
        Valentin Caron <valentin.caron@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/3] Rework STM32 UART RX over DMA
Date:   Wed, 20 Oct 2021 17:03:29 +0200
Message-ID: <20211020150332.10214-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_05,2021-10-20_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series reworks STM32 UART RX over DMA.

Erwan Le Ray (3):
  serial: stm32: re-introduce an irq flag condition in
    usart_receive_chars
  serial: stm32: rework RX over DMA
  serial: stm32: update throttle and unthrottle ops for dma mode

 drivers/tty/serial/stm32-usart.c | 240 ++++++++++++++++++++++++-------
 drivers/tty/serial/stm32-usart.h |  13 +-
 2 files changed, 200 insertions(+), 53 deletions(-)

-- 
2.17.1

