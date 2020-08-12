Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F81C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E76D2080C
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="blx13TC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHLMe5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgHLMe4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 08:34:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37DC061787
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so2008117ljk.9
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pglXO+6K/BTFXcwEdyiLnM7Xs0mjyJhSNxYsCV9xqgs=;
        b=blx13TC0dE16F1HmE5vlcCN9pZD8feFB/RFR901TQX8gar50GWeDFSwmaHRm3+XLT8
         GZNUhV0AC3wfjFgEm6uNMnnvHth/JwFHtYwMXcsv19rhfY6yufO5J4A0j6Bk+tw1RjYn
         fbJFQ4NNUlMQuuuqAFMtYjHTSSWzNHmDdRMzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pglXO+6K/BTFXcwEdyiLnM7Xs0mjyJhSNxYsCV9xqgs=;
        b=KB6cP2G2tNL398shDj2v/w0+ZDstBxlJ4s0ek1QXxzV/bJzIIsuRz5vqouyCFnw4F2
         QEm81j5MorulDy8aRD1ObnQR+dGXEmIYjYLDSvBHhM3dMMdPrdhLJO71M82QRqXfW2OD
         BOzw4f6h5/uRYBLOTwqW3d2vVLwm1mExNmrifNP4ulhujOlGwEBH+lT1GuZJyhYq2jNF
         LuD9DH5ploBRXtN+V7TW+3fLqXSq6TRcQo2p3L6RkZOnZzgO0AIoxpC/Coz67yxn/MYe
         WOzJmUVq5f2IcIVLNrGxf9a1uyIuLRD87o2EhW0xpcBRe49JEi06sz9RH8hI76OehXWq
         e6nQ==
X-Gm-Message-State: AOAM532Lwfp5wGXyq0OyGyFYZ9gMxFsvbJ0G3m5N4Fkk4+gShtN96nUg
        rd7uM7QfXBzzOjh6QbkH2ODXmw==
X-Google-Smtp-Source: ABdhPJzX0hZy4nJorOBOP7eIPeUE710RJeLyasUK4Qb5rCOmD9pXCFSzq/jchrACUwgnVshRn4ljLg==
X-Received: by 2002:a2e:9854:: with SMTP id e20mr4824063ljj.318.1597235694668;
        Wed, 12 Aug 2020 05:34:54 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id s21sm417393ljs.8.2020.08.12.05.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:34:54 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:34:47 +0200
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
Subject: [PATCH v10 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200812143324.2394375-4-mholenko@antmicro.com>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-0-mholenko@antmicro.com>
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

