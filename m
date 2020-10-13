Return-Path: <SRS0=HiSo=DU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF1C433E7
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDF72489A
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="upDG6raP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbgJMOqO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgJMOqO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Oct 2020 10:46:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D9C0613D2
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:46:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a5so20708997ljj.11
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJCKBgHgW4lDU+uVvQKyp37+1e76x1SjLUcnRFvURBc=;
        b=upDG6raP+kKKGTPRROcyC2aybFVAYqI2JqD25uiW3NvYxHQFNYJfGGF3Wq8fOSZDpl
         7+zaf4+QrzWRWbtCZGIQpcGOb1EMS0DSanbFdkpn+fZfEIdhyAtIPEBJSo4uFmsCy/xy
         Kvdz97eyE3Sy+iepBJOfrhz/mw78R6x7RJjaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJCKBgHgW4lDU+uVvQKyp37+1e76x1SjLUcnRFvURBc=;
        b=ON+HfMP8u8mIBvE4lH58YqdiYsCQG/qxtuq+zT2EMrajXEH1oqoubHXE2onOmhF7CU
         JqV+bnHIpt7Vi1TwrLdF1U07LJo657G+6OM3CKOr5/QL1a3NPZ7AMjG4Rac9voxGXFP7
         sG5xP0u3qeuzngGK25KCDEYL0Ly3y8vVZgfvean7tdaxCO8xMx64++1IWs91kPjhXwlZ
         HYwCCMVR53cbIwDEnhVDeHKeqokHyR2hOxLiibVHx6b1ARIC47p7GrR0f8qr6+EBOLxl
         RnAlpy9vOAnTKjpp6riJXlR3sovet7RBhkkcgrj7dFz3wjf1Gq8ANWo9VV2CmNE2KWxb
         iXvA==
X-Gm-Message-State: AOAM532a6RItU5xHUgEWU+7vxaMOITrR/dFIQYpqBCjYHdTKSmHo3DjI
        jZPKRiVAeUVG5MOX4vg8/WfeTA==
X-Google-Smtp-Source: ABdhPJz1f+bFjCV43O0naIrFZo9QZf7p3X8sGfLVC7GD7QFmH4iAhaxM5bS3jeZ9MalfgLHrzCVyNg==
X-Received: by 2002:a2e:b531:: with SMTP id z17mr6171676ljm.28.1602600372047;
        Tue, 13 Oct 2020 07:46:12 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id p10sm4555297lfc.217.2020.10.13.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:46:11 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:46:05 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v12 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20201013164454.2002023-4-mholenko@antmicro.com>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v12:
    - fixed the description in the yaml file

    No changes in v11.

    No changes in v10.

    No changes in v9.

    No changes in v8.

    No changes in v7.

    Changes in v6:
    - fixed license header

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Reviewed-by tag
    - patch number changed from 3 to 4
    - removed changes in MAINTAINERS file (moved to patch #2)
    
    Changes in v2:
    - binding description rewritten to a yaml schema file
    - added interrupt line
    - fixed unit address
    - patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..69acb222bb57
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of the LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
-- 
2.25.1

