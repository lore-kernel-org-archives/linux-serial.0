Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB0C47404
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7DE2133F
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570202076;
	bh=At7Vw3YFrrg3TOqKMg8f1TsgKNBKoiEKL7wq9XiiUKk=;
	h=From:To:Subject:Date:List-ID:From;
	b=E20xYkkIU9RFoFzu9df+ayDinJm2IDfCCdaC5GiFSXUOh+KY65dO8WiptDewn+w81
	 GHGSErCWfbFi4ucVrGLjYBe7yoWyigySyqUZGB2DZgL5Vxso2mOcn1peejj4UPN5m8
	 QahNQUKezighDujxnCaSBSb7xm+XS2pK6EDc1jAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfJDPO0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfJDPOZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 11:14:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4017F207FF;
        Fri,  4 Oct 2019 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570202065;
        bh=At7Vw3YFrrg3TOqKMg8f1TsgKNBKoiEKL7wq9XiiUKk=;
        h=From:To:Subject:Date:From;
        b=BeGHmF7Rbd6pkfOjo2uCfn8OcrdTdcDJynBCXDiHZNqmgwIE1+aRy4wZQW23eUGGP
         U+RHRG2J0ZC+B7hAvb/Ik0Nsr00FdebTvb84NysQA4HHgL8yfGWaQ2VW+9bCdu7zMd
         kUWdVsOOM75RFDTU0Ja0JGS5R4l69pzZnlhyyzYs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be unique in PMU
Date:   Fri,  4 Oct 2019 17:14:12 +0200
Message-Id: <20191004151414.8458-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20191004151412.sGaxsfBkZpSKCvQH4WIcz4o2G3I-NNnedECCnP6h_eg@z>

The clkoutN names of clocks must be unique because they represent
unique inputs of clock multiplexer.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
index 73b56fc5bf58..d8e03716f5d2 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
@@ -53,8 +53,10 @@ properties:
       List of clock names for particular CLKOUT mux inputs
     minItems: 1
     maxItems: 32
-    items:
-      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
+    allOf:
+      - items:
+          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
+      - uniqueItems: true
 
   clocks:
     minItems: 1
-- 
2.17.1

