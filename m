Return-Path: <SRS0=HiSo=DU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31320C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83E92488C
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="Ap1hDLxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbgJMOpt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbgJMOpt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7821C0613D5
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l28so7107251lfp.10
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJiypWtRSWGeA7qvGozCNTMcITV17kuSzo6s5k3yp0c=;
        b=Ap1hDLxKbZkfleLmsjHoYjiy28861EusmWSvaGnN18GXwiUwqo+45d8ucMkH5ORbIf
         f+WP8dmVnjmPjdfCJ2ai+mdU3DJF5gQ6AW2ftlfnR7rLgm8oR1PFkRkTZnK40WFEu+Y0
         shcI5xjGascCEm9BQluFvr5KMJq0AM2AQ4wOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJiypWtRSWGeA7qvGozCNTMcITV17kuSzo6s5k3yp0c=;
        b=k8p6rPW+974jdyJkwxSKkqGozmilA5tjUazRsWXNp89aBOdKYVBmEpsKaREWLObFw7
         BYXGKhYSZ4HHg1sjdCTcB5kCCaiHbdZ9VOBiJZ/tGAf7GXNxgbd3buEZMBFiTiHFrAVr
         /uwHuqSQShnEbRQ8PdSTwIn00AmImhR3Z9DhdBI5S4D+nhEuzffXWx6kUGtfRKVONviq
         Ae4f0w5mAwTd0n3BNG94ENISdTSwRi+52cM0Fw6UOS33W/EW5oY8X3eWn/YHe7EKwwgb
         PGIrAxSC6iFjCeXhtrouHo0WJozLiqlym36jPGr9zdettJhXbaCRcAWWgPZNEvOLz/+6
         48UQ==
X-Gm-Message-State: AOAM531nh8jBKGQnrNqAtkaqnEF1d+c6xwW+B0X3bBFgRBH3viLPzEDP
        jKdn9vTleGPQ/vUTX9OdH/2Ymw==
X-Google-Smtp-Source: ABdhPJzdCS2hRhUwwM98BhE9GUIZoNmvjOpWxz8AWxl855PrVpwphnpEHcu0tXGfCY+abzv0n/z7Sw==
X-Received: by 2002:a19:2302:: with SMTP id j2mr8897933lfj.78.1602600346272;
        Tue, 13 Oct 2020 07:45:46 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id m30sm4506250lfc.97.2020.10.13.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:45 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:40 +0200
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
Subject: [PATCH v12 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20201013164454.2002023-2-mholenko@antmicro.com>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

Add documentation for LiteX SoC Controller bindings.

Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v12:
    - fixed the description and the example in the yaml file

    No changes in v11.

    No changes in v10.

    Changes in v9:
        - fixed the `reg` node notation in the DT example

    No changes in v8.

    No changes in v7.

    Changes in v6:
        - fixed license header

    Changes in v5:
        - added reviewed-by tag
    
    Changes in v4:
        - changes compatible to "litex,soc-controller"
        - fixed yaml's header
        - removed unnecessary sections from yaml
        - fixed indentation in yaml
    
    This commit has been introduced in v3 of the patchset.

 .../soc/litex/litex,soc-controller.yaml       | 39 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
new file mode 100644
index 000000000000..53121c1fbe4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2020 Antmicro <www.antmicro.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/litex/litex,soc-controller.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: LiteX SoC Controller driver
+
+description: |
+  This is the SoC Controller driver for the LiteX SoC Builder.
+  Its purpose is to verify LiteX CSR (Control&Status Register) access
+  operations and provide functions for other drivers to read/write CSRs
+  and to check if those accessors are ready to be used.
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+properties:
+  compatible:
+    const: litex,soc-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    soc_ctrl0: soc-controller@f0000000 {
+        compatible = "litex,soc-controller";
+        reg = <0xf0000000 0xc>;
+        status = "okay";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b58ca29cc80..39be98db7418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9835,6 +9835,12 @@ L:	kunit-dev@googlegroups.com
 S:	Maintained
 F:	lib/list-test.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/litex,*.yaml
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
-- 
2.25.1

