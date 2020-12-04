Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54EFC4361B
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42393227C3
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 09:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgLDJkg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Dec 2020 04:40:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgLDJkg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Dec 2020 04:40:36 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnSMx44wbz15XWc;
        Fri,  4 Dec 2020 17:39:25 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 17:39:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/5] dt-bindings: devapc: add the required property 'additionalProperties'
Date:   Fri, 4 Dec 2020 17:38:12 +0800
Message-ID: <20201204093813.1275-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201204093813.1275-1-thunder.leizhen@huawei.com>
References: <20201204093813.1275-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When I do dt_binding_check for any YAML file, below wanring is always
reported:

xxx/soc/mediatek/devapc.yaml: 'additionalProperties' is a required property
xxx/soc/mediatek/devapc.yaml: ignoring, error in schema:
warning: no schema found in file: xxx/soc/mediatek/devapc.yaml

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
index 6c763f873a632d2..31e4d3c339bfe72 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
@@ -44,6 +44,8 @@ required:
   - clocks
   - clock-names
 
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
1.8.3


