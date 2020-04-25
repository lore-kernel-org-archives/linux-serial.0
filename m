Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5AC55185
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0820724
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="KBSdOBng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYLmY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDYLmY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 07:42:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16316C09B04B
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:42:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so12632783lja.13
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmVccqbZBFAGvYE285z5vpBDUG7a3gigAjE4qLquOAA=;
        b=KBSdOBngPsJBsjT1ruAEUcGyt0dC8W+10zgde9IFv/BXKJP1P6hnJbESFiYgQwuFom
         FaP4F+PwgGEp7xb79xEhBwa7K6cW3/9l+gOc513S9hQ0PRTIBuEXS7xMQwfMbsfQpmFr
         R2z0v12HNoHqzVpizuMLyrJD64fBprcupRMS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmVccqbZBFAGvYE285z5vpBDUG7a3gigAjE4qLquOAA=;
        b=IfvVS2Jyq//9O7WxiMqseKZherqCbktlGLGKHs1kVatDfC3ALBLbpsk8NLLJDEVwXu
         WvicMGy3amqZTrcW+tStVlijGfG5xfeT2EN2xHUGuKBgBAp5lhsvwOJ5RI6bl6gtQ89x
         N05OmNYSLth2a0EPG1L5+kHGcmNJuHJz17ogC+SAia3EFoA8Od4hoyozP7bI67SqoMZ2
         GtyOzUVM2LakzLILjdBiN2FUDcykQo15Gl9rxbU+0QFU+rKjRIHkzbCtSOSPnT/WA09i
         Adx9B/Cv8QUUur1sGsisxc1rIA8dNfFVkO7HKDtaM1dOmDpHduTAHoBgQyKruSjFuZEu
         fSSQ==
X-Gm-Message-State: AGi0PuZoWIHX18b0UCoznwtJwKc5lVi0P1f+zqEEla0rJjM+ovxqS5or
        cGkZPm8s1MB4c8QPIaETJLhVqA==
X-Google-Smtp-Source: APiQypLIuh6Wx2YYEHW+X+0yYOAYZjZznzwLHj2f4QkO+MbgcYDHm/NdYofOExvM4GYvIJgUB4zcTg==
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr267630ljq.125.1587814942576;
        Sat, 25 Apr 2020 04:42:22 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id o3sm6613414lfl.78.2020.04.25.04.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:42:22 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:42:17 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200425133939.3508912-4-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425133939.3508912-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
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
index 000000000000..87bf846b170a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
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
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
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

