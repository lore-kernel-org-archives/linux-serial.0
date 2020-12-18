Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C929C35296
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58023B88
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgLRTCB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:02:01 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49738 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgLRTB0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:26 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIusIs011760;
        Fri, 18 Dec 2020 20:00:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=selector1;
 bh=8b7meip5c3anz5ISPIJdzkp6HNWVOIs8d92UiRmxRUo=;
 b=PCi1WDFDNvaqiYUVQZuMXyuIiyxvx45AYpOkPPQfBshAJIoeBpHiE1199Qo4Dd3zbmNJ
 QSSc4bxXym96AU61VKbKM9d6oE4lIJGFbXjXoTN3lkNUItIe8OKHrkCSYeysWUjGGpTq
 4f4+i1nCzun7PcW8+XosBzCB7V6CVeZ1MxFcMHjRS3znStgB/ILwEsXE53Slsi7DCiFX
 NGVSXsw0sVuoukdSLuBKY+lXOqqEIynssjx8BYSDdxT0uT0gWYHP/QYfRMe3bvub0YYo
 PUhgaikMMKOT84SlW4CUgVLRNHqDH6PDTpUk/y5d79ouXhl/EI0nQstGABvVHvsVrvxd /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpt9ux3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 462D310002A;
        Fri, 18 Dec 2020 20:00:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34A26231C3D;
        Fri, 18 Dec 2020 20:00:24 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec 2020 20:00:23
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
Date:   Fri, 18 Dec 2020 20:00:11 +0100
Message-ID: <20201218190020.1572-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series brings various fixes, cleanups and improvements to stm32-usart
driver.

Erwan Le Ray (8):
  serial: stm32: fix -Wall W=1 compilation warnings
  serial: stm32: fix code cleaning warnings and checks
  serial: stm32: add "_usart" prefix in functions name
  serial: stm32: add author
  dt-bindings: serial: stm32: update rts-gpios and cts-gpios
  serial: stm32: update conflicting RTS/CTS config comment
  serial: stm32: clean probe and remove port deinit
  serial: stm32: update transmission complete error message in shutdown

 .../bindings/serial/st,stm32-uart.yaml        |  13 +-
 drivers/tty/serial/stm32-usart.c              | 417 +++++++++---------
 2 files changed, 227 insertions(+), 203 deletions(-)

-- 
2.17.1

