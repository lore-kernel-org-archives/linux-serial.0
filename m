Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E15BC4332E
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42932312E
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbhAFQXg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:23:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51498 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727608AbhAFQXf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jan 2021 11:23:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GHpZZ021044;
        Wed, 6 Jan 2021 17:22:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=tbJLds3vrWTGc+McVGokXb86aMApKHBuBvfQpbgg5vE=;
 b=usa3wpebIGXmf4V+RWvyoAXCRDiruOhcAUTczwADQGzzFf43cbCih3kVoGDEzQGUKctZ
 TeFDP6EBuvGdtsyGu+1e21jdQrWCzxorcG3vgQvo+cSFkDjz66fiN2ZQqpJgcldA/aHX
 85zdzr50lYLlvFUTlxrULd4RnYLfl/zJF5KuDD7S9uL3tkS8aCGstcPdedS4Qqgsi7/F
 7FdVHAYY+F5qzddEqsfhkOqhAaIU2qedyCfT6tngd/ut78JgjM4HKufF1WiC0H+QTY3W
 OYAkUcFFiLExxecuBtEkC2thSFoWtv+MzhWKriQKS8cBnhk/uoYstNxgpup9hI5U/zZa jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tgkn09ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 17:22:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF75C10002A;
        Wed,  6 Jan 2021 17:22:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCD542AD2C6;
        Wed,  6 Jan 2021 17:22:44 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan 2021 17:22:44
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
Subject: [PATCH v2 4/8] serial: stm32: add author
Date:   Wed, 6 Jan 2021 17:21:59 +0100
Message-ID: <20210106162203.28854-5-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106162203.28854-1-erwan.leray@foss.st.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
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

