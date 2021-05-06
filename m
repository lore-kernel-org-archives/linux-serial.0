Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A82C43461
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74283613CD
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhEFNWa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 09:22:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18359 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhEFNWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 09:22:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FbZ101PT8zlc6W;
        Thu,  6 May 2021 21:19:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 21:21:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/2] dt-bindings: serial: Add label property in serial.yaml
Date:   Thu, 6 May 2021 21:20:49 +0800
Message-ID: <20210506132049.1513-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210506132049.1513-1-thunder.leizhen@huawei.com>
References: <20210506132049.1513-1-thunder.leizhen@huawei.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 2fdf4ed198da781..c75ba3fb6465005 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -23,6 +23,8 @@ properties:
   $nodename:
     pattern: "^serial(@.*)?$"
 
+  label: true
+
   cts-gpios:
     maxItems: 1
     description:
-- 
2.26.0.106.g9fadedd


