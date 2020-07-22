Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F58C433E2
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03A020771
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 10:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="hOWgqX0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgGVK2g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgGVK2g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 06:28:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC3C0619DE
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2020 03:28:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so1938498ljm.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2020 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f2Azkhucxb/pnU8VfCN/EExALtippQJVTuRoVrjKIxs=;
        b=hOWgqX0LwfxfvbAOdBv1Z78e1kGsBPy0uiuIVTESlTjNCfmhOuQfJSBaspgWtRJnoX
         uAJGVdzl1CpYTn49bb0/Zt+jpmKCxOeDhwSUhspOpdZWLHd9iwT/q999uGk8QKhrxXB0
         m93myJ6jOEZ1iSYgSsdqxFoLRXTT0khoezKn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2Azkhucxb/pnU8VfCN/EExALtippQJVTuRoVrjKIxs=;
        b=GNb38gIQxd8LKeOP51hI6kNzR9sMrxCZBoJ+Mw0voMGlUN4IIb8IACguRIqWBICeOc
         OvNLkjZlis/vs4TQvZIss/J2hjtJtKHDp1KMyCHYZNsMTGtqy+AxOYkoE9w6lnHPA2hC
         m5MPFHyLsEEw0LmZeM5KtakW/2+AYn9GfftdWv5zGfP46seYbRwbFnNNeaJT8tWk5DR0
         hh5+RPVzHrffG6+uQ+ufZUeXGAeAReWl6aJAuenVFER7yDjCCBlJbxZXaycmrls/VIYZ
         zGCocHsGHf7ICzdKO0clYf6YG/aUg0ptTzYrolldAv5GZRt7536y66L+ugwwWClw1LQz
         ld/Q==
X-Gm-Message-State: AOAM530TgMBxFpfbDW5UL/P2KJvVxfQE+57lpGciRBGmjdzbRRI3BBBq
        KxnzVBeAejbioD16MVOUCtPBBQ==
X-Google-Smtp-Source: ABdhPJxoM/ndSVx7j2L1NumIdmT3pHxi6QfEAZ9wDYCgwxlNCNdTy2dzY9X50+gRKrjwl7eZKrLNvQ==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr13827089ljg.339.1595413714108;
        Wed, 22 Jul 2020 03:28:34 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id i24sm7803958lfg.83.2020.07.22.03.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:28:33 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:28:27 +0200
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
Subject: [PATCH v9 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200722122704.1153221-4-mholenko@antmicro.com>
References: <20200722122704.1153221-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722122704.1153221-0-mholenko@antmicro.com>
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

