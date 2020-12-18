Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE4C3527E
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E9C23B8A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLRTB0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:26 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgLRTBZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:25 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIv7i9013541;
        Fri, 18 Dec 2020 20:00:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=tbJLds3vrWTGc+McVGokXb86aMApKHBuBvfQpbgg5vE=;
 b=RjMywbr0iEvoHPUukpda3ERODZ0Dl4aPOu06SKOCkwbY/q0AzVCVtY94h+dlpdT5zTXk
 hTbag85QBwnAbMk8YaAiapWhwm6/D9Z23Db5M33cGMdOgz1zTLVL9n17SpWrqVUQ18iW
 xNxYkUk0tC4D5COEE9qTy6bN7gTCT+cYMiSOU0raWjkHMq8G4o1eUq619ASij5/MUKmx
 BtYzIhUAZUOoYlnbMkbHXaLWqosY/ZYBE0WYZW9ErLzm+QNM4ER0+NMTLEwmNzxLgjji
 +XpkAwQyW8VPPesoXJLI0az/iUE9hrkyL2LyO4h2nrdWiZEot/nqozL9z6BU/sE/ZnoL sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cptdqw8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66D97100038;
        Fri, 18 Dec 2020 20:00:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AB44225E48;
        Fri, 18 Dec 2020 20:00:30 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec 2020 20:00:30
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
Subject: [PATCH 4/8] serial: stm32: add author
Date:   Fri, 18 Dec 2020 20:00:15 +0100
Message-ID: <20201218190020.1572-5-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Update email address add new author in authors list.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 717a97759928..938d2c4aeaed 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -3,7 +3,8 @@
  * Copyright (C) Maxime Coquelin 2015
  * Copyright (C) STMicroelectronics SA 2017
  * Authors:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- *	     Gerald Baeza <gerald.baeza@st.com>
+ *	     Gerald Baeza <gerald.baeza@foss.st.com>
+ *	     Erwan Le Ray <erwan.leray@foss.st.com>
  *
  * Inspired by st-asc.c from STMicroelectronics (c)
  */
-- 
2.17.1

