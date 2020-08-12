Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337DC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C90207F7
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="VEyzj5gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHLMeb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgHLMe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 08:34:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C282C06174A
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j22so1074734lfm.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3PY9g/3/EzQtmuocoGjs6eUqtHowr2V4yVpGVas3X0U=;
        b=VEyzj5gra4cxoy/wdy5O5z5Bz553WMZvULoWkFfcoz/4di5udkPcO6IWQNFJr5EMTo
         SjKLojI83beWEA8w6E1MVuOFGeqyn/7d6Kyvna+7eLO3MpMU+I5/CpRE8oBOF2Z7/9HH
         QnJ7BOAK4RrFLQ3cGi/o1R5lXtu2MbuL3b7Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3PY9g/3/EzQtmuocoGjs6eUqtHowr2V4yVpGVas3X0U=;
        b=bZJDJFzCWjN6PxrmTul9VCE9wS/T3wubpnmpak0nlKd18xH0nM5PMbUDSaNdOQCRqh
         yY4WZGFVfbQjTUdnOPTph7HS2QOjbpgtAUaThfOE7y2gtANfu3xRTvHWRkU5RCMCEsP8
         3jgSYPyV8DFVws6cwwRHNnEYlkWG3QMXNjYvf6vRmIGqObbGI1nTVTThCGnNA1K9wDRm
         CDOL5L2PueKnirTIf7O3Z35UQ44Rd1gpu77n+vaoldZtGYLyVIp+EPOTprQYxepFR7i3
         3c6Yng6SZt+Iv91yBw31dFYv3tFsKGa7vWujQXjUCOOqj8N9PY12cfD1H3SBUIPtrHoJ
         IDuA==
X-Gm-Message-State: AOAM532/tCMfM0XdcVVxZLD5lpKuLNqmaxYvvsSfWvZ+x548j6G7VeJj
        atbHywV6SNPqy1+Fe51Vhkh+Sg==
X-Google-Smtp-Source: ABdhPJwf8GYwfzv3jViud9QQgL4gJawJOl2Y04nHSxNPmi7VZVAjHIBFM3GfspJ6RsGF1UUFtSgW+Q==
X-Received: by 2002:a19:414b:: with SMTP id o72mr5729172lfa.86.1597235667709;
        Wed, 12 Aug 2020 05:34:27 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id a7sm416952ljk.2.2020.08.12.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:34:27 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:34:20 +0200
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
Subject: [PATCH v10 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200812143324.2394375-2-mholenko@antmicro.com>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
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
+  It's purpose is to verify LiteX CSR (Control&Status Register) access
+  operations and provide function for other drivers to read/write CSRs
+  and to check if those accessors are ready to use.
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
+        reg = <0xf0000000 0xC>;
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

