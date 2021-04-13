Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA2C43462
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BA8613B1
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhDMRlA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:41:00 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:11148 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232335AbhDMRk6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Apr 2021 13:40:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHWGx5007108;
        Tue, 13 Apr 2021 19:40:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=xvCqCJ5wLw4DeHWmhhSm6Q7pUSCJMjCpJrF+54VEZ4c=;
 b=5azSTVGtCCItxEOCtZBVWvi1ToMy4mSLaJisxMc/10I+7R731rfvp39iO5ZVfadGrlU9
 qLeSGuFc4W+8JRjb+w7efmWts5yeWUQIXHgO1P9Py+CBrDyMGTq/dVoA54pQY1ByMks0
 EIsR54QPeE6iuOwv34+sAZJX1vlTLprgjovNG3d1NBYhSbXN+DQE871e5au+FjRI4QKy
 d9aC1B6KHSSp5a+HgNCPaJtjKZbtXJxTt5UkOc0WfwDSsng93f94eVQduEW7Ri9zIqv0
 RT09kWU3wzQuQvxIml8Xk3ecelpw/QkysH9WL7r//jBlLgCd8GeFvTwJq/5eRIjg+CJ8 ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37vwg95t17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 19:40:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9613D10002A;
        Tue, 13 Apr 2021 19:40:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89ABA2159E9;
        Tue, 13 Apr 2021 19:40:22 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 19:40:22
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
Subject: [PATCH v2 3/4] dt-bindings: serial: 8250: update TX FIFO trigger level
Date:   Tue, 13 Apr 2021 19:40:14 +0200
Message-ID: <20210413174015.23011-4-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413174015.23011-1-erwan.leray@foss.st.com>
References: <20210413174015.23011-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove data type from tx-threshold trigger level as defined now as a
serial generic property.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index c0e292cdaa6b..ff0fa9b2a390 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -166,7 +166,6 @@ properties:
       property.
 
   tx-threshold:
-    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Specify the TX FIFO low water indication for parts with programmable
       TX FIFO thresholds.
-- 
2.17.1

