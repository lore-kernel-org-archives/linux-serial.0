Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B3C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D6960EDF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhJYNpM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:45:12 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43256 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhJYNpM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 09:45:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P8Cv20003285;
        Mon, 25 Oct 2021 15:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=E7GL8g1LVuwhIdouDAVJoi6iJL0Ledft7BjGYWbxztI=;
 b=KLAmXwuJpp88Cnn9S2ipCQ4INbPe6u8cnhgTExKCM7OI65kdmJ1oysd94AzwXD7+APVM
 huWI8HmbJF+VM+Yx83Mz1ScF7X0jzBk12Sl+DE0OIv5NUEfP613at/leLFeMdyuSgJgG
 DbnmWfBZjAzRhekq6LgYEdMxW3x53xDL1/MCMHY4i5jNxpmhpyZCtEwaXq+qEX6cpzEN
 JqW+3EYe0O4ebCl0lErHbUYlcJdmHReuK7c1XXrDvth5KpEAY0LE1z9A+XYjzan1vyDV
 Futyv9vdXW5muXoAo9Lcy1/PuC67egVSqUMYOVoMA7brxYapVCI38XI7BlrZX8C//bS7 kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwrvj1t9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 15:42:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8DCCD10002A;
        Mon, 25 Oct 2021 15:42:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85C482309DF;
        Mon, 25 Oct 2021 15:42:34 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 15:42:34
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
Subject: [PATCH 0/3] Power management improvements for STM32 UART DMA RX
Date:   Mon, 25 Oct 2021 15:42:26 +0200
Message-ID: <20211025134229.8456-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series improves power management for STM32 UART DMA RX.

Erwan Le Ray (3):
  serial: stm32: rework RX dma initialization and release
  serial: stm32: terminate / restart DMA transfer at suspend / resume
  serial: stm32: push DMA RX data before suspending

 drivers/tty/serial/stm32-usart.c | 216 +++++++++++++++++++++----------
 1 file changed, 148 insertions(+), 68 deletions(-)

-- 
2.17.1

