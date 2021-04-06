Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F2C433B4
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F736101D
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbhDFHWC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:22:02 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:3186 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233289AbhDFHV7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Apr 2021 03:21:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1367H7Fc007447;
        Tue, 6 Apr 2021 09:21:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=98McyI4svfF5KndUNWGyXXAvHiKV60OEgW91gDPLjCE=;
 b=RN6N+EPtFLJuKAQRtc/wR7QIUYLt8hkTSY8blMcCRjPnfkuwYnOuHuELDcpqOH1fRFWe
 0Qg+5vRO7LBP0pfqGn8I4G/k5xHZDDC6SVoyAQhjIE/rC6KVchnDW3TKShMNHzMTAxoH
 LZ/ELilmRj92sdi9sehyQWxgRKYFsMbEVFMHm2Kd4Ktd1KkHWh/9PdcRuVRUuWZCehiN
 B6JMWwK6MFDLbB84EkXKXdkKIy7Z+EYSyz5wdEBWrIdWPjmXbgdRutmX18GlGnetulLN
 1wswdiY+Cczjam9dk2DZYtyW8upvrCUys8viCiqa3z/S3d6VB2ABqguGBz7zXQmVj1T2 GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37r6u731ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 09:21:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 845B810002A;
        Tue,  6 Apr 2021 09:21:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 707C121E66A;
        Tue,  6 Apr 2021 09:21:26 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr 2021 09:21:26
 +0200
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
Subject: [PATCH 0/2] stm32 usart add fifo threshold configuration
Date:   Tue, 6 Apr 2021 09:21:20 +0200
Message-ID: <20210406072122.27384-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_01:2021-04-01,2021-04-06 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds the support for two optional DT properties, to configure
RX and TX FIFO thresholds:
 - st,rx-fifo-threshold-bytes
 - st,tx-fifo-threshold-bytes
This replaces hard-coded 8 bytes threshold. No functional change expected
if unspecified (keep 8 as default).

Erwan Le Ray (1):
  dt-bindings: serial: stm32: add fifo threshold configuration

Fabrice Gasnier (1):
  serial: stm32: add fifo threshold configuration

 .../bindings/serial/st,stm32-uart.yaml        | 31 ++++++++++-
 drivers/tty/serial/stm32-usart.c              | 53 ++++++++++++++++---
 drivers/tty/serial/stm32-usart.h              |  8 +--
 3 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.17.1

