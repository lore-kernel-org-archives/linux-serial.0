Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D02AC433E0
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D3F23131
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbhAFQXR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:23:17 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbhAFQXQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jan 2021 11:23:16 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GI4Bs000344;
        Wed, 6 Jan 2021 17:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=ikH5iN8ZWitS2tO4VWYFgymi3kis4h647LOv4FmivAo=;
 b=Q1ri9XLMxaNR0Alo7XVZQgEPHxsMC43NPOgImNiSihk7ckeebKE7GKknu23FA0sq4MyS
 vkkTSgWPYWCuUgKnyI7wXMr3dMni1d8NTDVwd+01pxEdInUwwffLJgjv63ZUCbZH7bLb
 jo3lu0eocTA5kbknI0zXvD9BVCe6xf9/oPK+14aanHRZ/mB52x2/aZl9PIHDPrIQW7pd
 Friaymsk3f9RQ7+x7Z7V4vUv6q9dkdwEN5JFYUH8l2YTnJO9fFAWG4peRvk55EQLjKLh
 LySAYfq89LIK7bLLGdnAdBQwvAW7sHsl1/RW4U+NFdhD9UYgoeGikCQif4MdjNEZkGYq Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuv8mvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 17:22:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF1F9100034;
        Wed,  6 Jan 2021 17:22:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CAF12A4D83;
        Wed,  6 Jan 2021 17:22:19 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan 2021 17:22:19
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 0/7] STM32 uart cleanup and improvements
Date:   Wed, 6 Jan 2021 17:21:55 +0100
Message-ID: <20210106162203.28854-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series brings various fixes, cleanups and improvements to stm32-usart
driver.

Changes in v2:
- delete DMA cookie variables removal from V1 patch as already done by a
previous patch
- update commit message as DMA cookie variables removal is no more
included in this patch

Erwan Le Ray (8):
  serial: stm32: fix DMA initialization error handling
  serial: stm32: fix code cleaning warnings and checks
  serial: stm32: add "_usart" prefix in functions name
  serial: stm32: add author
  dt-bindings: serial: stm32: update rts-gpios and cts-gpios
  serial: stm32: update conflicting RTS/CTS config comment
  serial: stm32: clean probe and remove port deinit
  serial: stm32: update transmission complete error message in shutdown

 .../bindings/serial/st,stm32-uart.yaml        |  13 +-
 drivers/tty/serial/stm32-usart.c              | 415 +++++++++---------
 2 files changed, 227 insertions(+), 201 deletions(-)

-- 
2.17.1

