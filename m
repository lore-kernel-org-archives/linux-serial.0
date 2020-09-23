Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F0C4727E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13011214D8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="tcJZLeee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgIWKJD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgIWKJC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 06:09:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DFC0613D1
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:09:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d15so21419602lfq.11
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YV40cowgKYQsE/dctRxya7aokqQdDkJKMCXMJgCmuao=;
        b=tcJZLeeeBUEIzP12lEZlavx1cQUBugRhU4Hscm5qYVLJQx4qN5STqy30aeU3P2Ik55
         SDaTmWjEVACymaxvWtYkQqssJBrJsxXX+QyT75USkSI1NRspEU4uxss+5//ii1bUhf8p
         RbdvFS3qrXrxFZJ8VbWcajRb3LDuhedxn0lw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YV40cowgKYQsE/dctRxya7aokqQdDkJKMCXMJgCmuao=;
        b=EJM1cGql4KJ5qnpQEx+a7z8YXNEdy12Uh/6s7W4IGalXfJ0+ALXdAgykHpNt98OA7w
         xBwAyMF0rqDNPSpcaUdzF9yQSKMfwT6uMYLxh/VGALueWa+FuKwiAEXmjr88MKE+p5L7
         Dsg6CzOMhpKe+vbvXHKsyM3p4yz5MqLQa8KMXRflGNaG3X86LrCiHuy7XDsw9qyX0g0g
         6N4MH5RwC2IvT9j7lDG9o5DKqFgEqqsYFd9ehXnr37pCq2Vha3uiOHnlQ2bIcx6MthfO
         tBVcSzC8zb7sRwmc5Ek8kXNDQYtrYExbK8EpbFNbpx63h/7NQ+qfi7qirsoeUBz4i1Mz
         hmjg==
X-Gm-Message-State: AOAM530eJ9ySOGHZwSg0D+Xel8Dslje/rJSQ9NfGIon+oKqAhdEYm46v
        WFP8bLe6hW3a0PgP7KT7dBjzzA==
X-Google-Smtp-Source: ABdhPJx4idkoyyn/iWQCyKkfv5WqoeS2/VAjvcTDmHzCKhiWxMKpNArRpHPADC1fwIvxQC52GO3tfg==
X-Received: by 2002:a19:a41a:: with SMTP id q26mr2954392lfc.121.1600855740817;
        Wed, 23 Sep 2020 03:09:00 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id y6sm4535624lfh.106.2020.09.23.03.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:09:00 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:08:54 +0200
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
Subject: [PATCH v11 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200923120817.1667149-2-mholenko@antmicro.com>
References: <20200923120817.1667149-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923120817.1667149-0-mholenko@antmicro.com>
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

