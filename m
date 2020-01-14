Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A226C33CB1
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214424679
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uGkZEg9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgANMdz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:33:55 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4108 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727044AbgANMdz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 07:33:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ECXGIh004903;
        Tue, 14 Jan 2020 13:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=NtNtpTywFRxlwwiU8XggPJSlwYsAOE1UVCac4kloP4A=;
 b=uGkZEg9TS86fMNjklnyni2wXKhu4WEum5uiTX3h/LPqCmRjhFGbTBf8ldTuM/0gCYqnJ
 VNltSZJWYGrrND67U5bwy0ygRuLxpExhqbQye5AaA8j17Bo84a8s9mlVKLP8bcg0XjEB
 FwN4CO5L+WGRpniYCvoDC7juBizu3u4yEho1ycqWY6PY7edVPJpgaKOTWrcHZUkIVj6F
 s8wiStAt53o2a2yudfTwX7oZrFQfWFSJZZ6CjYctL+QDEnjZDkMzYE0Op5e2s2lGfB5v
 fTK4cIecG3AT4Nvhj4MI3Es8Pf9B445WKMSENRMzhNakP74/qCKKaXwT2sZumxwuY7rs Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s5f01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 13:33:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B3B0100039;
        Tue, 14 Jan 2020 13:33:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 507582AD9EB;
        Tue, 14 Jan 2020 13:33:33 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 13:33:33
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <fabrice.gasnier@st.com>,
        <erwan.leray@st.com>, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/2] Convert STM32 UART bindings to yaml
Date:   Tue, 14 Jan 2020 13:33:27 +0100
Message-ID: <20200114123329.3792-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The goal of this series is to convert STM32 UART bindings to json-schema.
Since STM32 UART bindings use rs485 bindings it is also the opportunity
to convert them to json-schema.

Benjamin Gaignard (2):
  dt-bindings: serial: Convert rs485 bindings to json-schema
  dt-bindings: serial: Convert STM32 UART to json-schema

 Documentation/devicetree/bindings/serial/rs485.txt | 32 +--------
 .../devicetree/bindings/serial/rs485.yaml          | 45 ++++++++++++
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 80 ++++++++++++++++++++++
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 57 ---------------
 4 files changed, 126 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

-- 
2.15.0

