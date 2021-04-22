Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43DDC43461
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA636117A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 08:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhDVJAR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:00:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhDVJAR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 05:00:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQrrQ6WFZzPrBl;
        Thu, 22 Apr 2021 16:56:38 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 16:59:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/3] dt-bindings: serial: Add label property in serial.yaml
Date:   Thu, 22 Apr 2021 16:58:37 +0800
Message-ID: <20210422085837.513-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210422085837.513-1-thunder.leizhen@huawei.com>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When there is more than one serial port present, the property 'label'
allows a custom name to be used for briefly describe the usage or position
of each serial port.

Without this "label" property, many dtbs_check warnings similar to the
following are reported:
arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
        From schema: Documentation/devicetree/bindings/serial/pl011.yaml

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 71aec7fda07d..04ec229cbb4f 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -23,6 +23,8 @@ properties:
   $nodename:
     pattern: "^serial(@[0-9a-f,]+)?$"
 
+  label: true
+
   cts-gpios:
     maxItems: 1
     description:
-- 
2.21.1


