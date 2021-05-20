Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0354C43460
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE4D610A1
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhETL5w (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 07:57:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbhETL4I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 07:56:08 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm7Pp45bbzqTpd;
        Thu, 20 May 2021 19:51:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 19:54:45 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 19:54:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] dt-bindings: serial: pl011: Avoid matching device tree nodes of variant pl011 drivers
Date:   Thu, 20 May 2021 19:54:40 +0800
Message-ID: <20210520115440.8259-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210520115440.8259-1-thunder.leizhen@huawei.com>
References: <20210520115440.8259-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a variant driver of pl011, which may have a compatible string
written as: "arm,sbsa-uart", "arm,pl011". Because it contains "arm,pl011",
so the corresponding device tree nodes are also checked by this YAML file.
As a result, many flase warnings similar to the following are reported:

arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dt.yaml:
 serial@21c0000: compatible:0: 'arm,pl011' was expected
 serial@21c0000: compatible:1: 'arm,primecell' was expected

Change to only check the device tree nodes that are matched exactly.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 5ea00f8a283d..3683e4567645 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -16,9 +16,9 @@ allOf:
 select:
   properties:
     compatible:
-      contains:
-        enum:
-          - arm,pl011
+      items:
+        - const: arm,pl011
+        - const: arm,primecell
   required:
     - compatible
 
-- 
2.21.1


