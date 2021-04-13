Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF118C43600
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D2B61004
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhDMRlA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:41:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232356AbhDMRk6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Apr 2021 13:40:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHWLTQ025271;
        Tue, 13 Apr 2021 19:40:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=pZ9s/N4lfu05HqEWvS2/jUO/gf8ZaUn/1iPWaeBL6gE=;
 b=uRcjaPdUe34wNzIXpnwi73magRFgB096RjbKGaaJzULmjXgXJSdEBGdqsoLQ9azelkov
 hI1h/slpMONIc14wLAa6f6iwikByOLFuNubPl9/sCnGCwIPKMXkj2vRhH/UdKeuq/B4I
 aQBA+K9t5nAeZsuGqnB3DbNheTn6x8D1/Hk7jrjieZu22oPcFHTll5c7lqpRRO1frmjH
 q8fFqIXNK4vQSphrlKd1yoXl27mftv8MPTzMeKmIpAXozbX4QEVHWQRyedpAOEtruHgB
 mNRsoUG159HuD1iW9ViW1rpA2wPA/LSrHioZcUYw+KxrRVPCazydwzm5mzd8P6YDGRyJ MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37w3mbv1ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 19:40:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75C9810002A;
        Tue, 13 Apr 2021 19:40:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63CA92159E9;
        Tue, 13 Apr 2021 19:40:20 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 19:40:19
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
Subject: [PATCH v2 0/4] stm32 usart add fifo threshold configuration
Date:   Tue, 13 Apr 2021 19:40:11 +0200
Message-ID: <20210413174015.23011-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds the support for two optional DT properties to configure
RX and TX FIFO thresholds:
 - rx-threshold
 - tx-threshold
This replaces hard-coded 8 bytes threshold. No functional change expected
if unspecified (keep 8 as default).

Changes in v2:
Change added properties naming and factorize it in serial.yaml as proposed
by Rob Herring. 

Erwan Le Ray (3):
  dt-bindings: serial: add RX and TX FIFO properties
  dt-bindings: serial: stm32: override FIFO threshold properties
  dt-bindings: serial: 8250: update TX FIFO trigger level

Fabrice Gasnier (1):
  serial: stm32: add FIFO threshold configuration

 .../devicetree/bindings/serial/8250.yaml      |  1 -
 .../devicetree/bindings/serial/serial.yaml    | 10 ++++
 .../bindings/serial/st,stm32-uart.yaml        | 27 +++++++++-
 drivers/tty/serial/stm32-usart.c              | 53 ++++++++++++++++---
 drivers/tty/serial/stm32-usart.h              |  8 +--
 5 files changed, 85 insertions(+), 14 deletions(-)

-- 
2.17.1

