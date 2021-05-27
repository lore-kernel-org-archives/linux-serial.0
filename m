Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B55C4707F
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1337A610A0
	for <linux-serial@archiver.kernel.org>; Thu, 27 May 2021 09:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhE0JRi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 May 2021 05:17:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21408 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230111AbhE0JRg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 May 2021 05:17:36 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R975JH017729;
        Thu, 27 May 2021 11:15:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6LbctrlGWT2o3at8WTYe5NC/Zi11DhpFPDsO8JzG8GI=;
 b=ytDnZJQaXp1x31/dIDlLvBApS0oxl1MSVAQ7mWjUidwA/rCE/RvGdVRkqNiHQcV8PnVA
 sPZ7/tSrem1LIbwjN1tFwC1d6Jf/Dj9dQ9QS+EYMhvzjDFHHIzxxiQg8tg5hQDd85cp7
 +MMSIHw2MMrUHaRAX/GDuilJhBEeHqeDSzhzISq6W7GlyDd0QpbhwuXJxHCK9DKZ7UhA
 Sz536AL4h29ihcJo9ucCKVIcs/y6ezqeH0wkVW67c4GrU4Je/OuNzn6vLnNATBB2nwXg
 1L+41KualxRV+VUujto63VqyoUbokiZhvb+ZUaMsgO+l4E3wXBGyUT/k3mkLl+08RFv1 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t7k38enc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 11:15:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D13E410002A;
        Thu, 27 May 2021 11:15:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF53B2171D7;
        Thu, 27 May 2021 11:15:47 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 11:15:47
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
Subject: [PATCH 0/2] stm32 usart improve DMA probe
Date:   Thu, 27 May 2021 11:15:35 +0200
Message-ID: <20210527091537.8997-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_04:2021-05-26,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series improves DMA probe.

Erwan Le Ray (2):
  serial: stm32: reset dma buffers during probe
  serial: stm32: defer probe for dma devices

 drivers/tty/serial/stm32-usart.c | 165 +++++++++++++++----------------
 1 file changed, 79 insertions(+), 86 deletions(-)

-- 
2.17.1

