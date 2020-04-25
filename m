Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B8C55186
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B56E20724
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="sJIa7UY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgDYLmA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDYLmA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 07:42:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4031C09B04B
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so12637656ljl.6
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emYQSiWUk9pXC+qgp9CZOobl8THByK9dpDVBfnExNiM=;
        b=sJIa7UY+vdeI0DLQm1TmNiXHCr0jBIRVtQM+ppEoAUS05h7c0CrwrQz2Vf6ZbHQf3P
         tIdmXfazuI5Fr1TzJW8vEB2eADCbLGpEeLd53jXrfK/HdRZF/zZBSJeAXQY4AQFoIaGl
         /fRDDt95a+3Gz1FM6Nj05pPsLST9J5hnCm3wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emYQSiWUk9pXC+qgp9CZOobl8THByK9dpDVBfnExNiM=;
        b=d09+QfhMHmA+Va2AN60pLUYtf9CAthTgQ4OZH4/BPD5d0qE21Je/EpwKj1SYFXB2fu
         kBv1ChYl6G84lcBruYtypLsXg8owCCuI+SehYk24J9Ez7d6jQ+4NDa/lXzg0Qa89qkIr
         3BS9t2VLl9gyKYfBRE7QNnCvHt94XxrftMcMksFvZDLO7co2+e52Rw1ugVnxlCPgrGIM
         QBYLL7R953f27BuIqLRSzio8PFJIWDObOQ0rUxBc0pqaCiEbCqrjRJaOc0UG8WlZLOns
         xlHqptqFz/YUskeAUVse8sWhKDGM20CoCI5ivJvDSCj+ailWPQUFn0Jru4KCTxcNpy/T
         f4kQ==
X-Gm-Message-State: AGi0PuZY7Mgp4ZO6XVGnra+GNVqeqlRkQKOZxI6PxdB4npzdX5e6DJBg
        K/6mTTjIyKhUc4Ru12FuxMTsTQ==
X-Google-Smtp-Source: APiQypLPz9UzCVkQ8qSxyzucGk9+IobObT7s65fPyLJfWUIub59qVOsyT2S5xBcDKj1PRvO4Se50lg==
X-Received: by 2002:a2e:740f:: with SMTP id p15mr7642529ljc.151.1587814918455;
        Sat, 25 Apr 2020 04:41:58 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id o6sm5900082lja.70.2020.04.25.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:41:57 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:41:52 +0200
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
Subject: [PATCH v5 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200425133939.3508912-2-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425133939.3508912-0-mholenko@antmicro.com>
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
index 000000000000..b118ddbf04a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
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
+        reg = <0x0 0xf0000000 0x0 0xC>;
+        status = "okay";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 44c1e8b3b3b4..421ede6c4f71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9815,6 +9815,12 @@ L:	kunit-dev@googlegroups.com
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

