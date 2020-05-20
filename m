Return-Path: <SRS0=iED7=7C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276CAC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EE3207D3
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 13:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rwnlnI1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETNkH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 May 2020 09:40:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46787 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbgETNkG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 09:40:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KDZU1M013236;
        Wed, 20 May 2020 15:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ArUV+HFn/C8Z3UZZJNpc9RKgx2vqaUmmaj6fhlTfivg=;
 b=rwnlnI1GXtCJVbfrq5wfodJRg2QzJ/tkJ60vGTW98FkJKUFXPl/Lrm0mWdeW8O9/JP6u
 nO+Jq/QZERPXnmPQMOwxNp6pPzCi6vtnROWzsN5o0xKmAwEEXprf+M1SVscv4jkpEEGw
 KHCb9FWDyHOtdjKQQPdrMnkHM0GGvFTN0/Z547EjsctIhwAayY/dBm4bs7W2JNr8KAKg
 SI1HD/aEADQE7GXk7Grq5DJXZkM3VGfPNGgX4sUfkqxMaT8FTqHSmjriCiNoaxfUrvx/
 ast7T1HhJKpfwOxqDTP0flKL8sgJk2TKhH97dhBx6N7NVmcB6+eFnOunGxxgmhxj4IyP UQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3125xy0jf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 15:39:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8029210002A;
        Wed, 20 May 2020 15:39:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 667EA2C38A9;
        Wed, 20 May 2020 15:39:37 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May 2020 15:39:36
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] add generic DT binding for RTS/CTS
Date:   Wed, 20 May 2020 15:39:30 +0200
Message-ID: <20200520133932.30441-1-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_09:2020-05-20,2020-05-20 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support of generic DT binding for annoucing RTS/CTS lines. The initial
binding 'st,hw-flow-control' is not needed anymore since generic binding
is available, but is kept for backward compatibility.

Erwan Le Ray (2):
  dt-bindings: serial: add generic DT binding for announcing RTS/CTS
    lines
  serial: stm32: Use generic DT binding for announcing RTS/CTS lines

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 4 +++-
 drivers/tty/serial/stm32-usart.c                            | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1

