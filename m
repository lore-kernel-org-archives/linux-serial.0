Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C83C35DFB
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6DB21556
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="kpRNGoAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgBYIqx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:46:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42029 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgBYIqx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 03:46:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id 83so9096851lfh.9
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2020 00:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Q26y6k84gThGD9CxGLIQPfQ8ikXiupLsGZ4lp4CB8w=;
        b=kpRNGoARmWU8XjGCP2z9Fam8yf6dnxqylyxgXgR+Nvn0OW9mFVKL30hlcW4N+wVax5
         LIbcqc+Gu8RthM4IkBiUZ35D3fylMlgXFFcvE7/jfD1P+ErCL2v6Ldwqj3nfUDy0Owg0
         56GPonBX61WmQMxQnag2YyqwQ2+TBeZ2hNDZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Q26y6k84gThGD9CxGLIQPfQ8ikXiupLsGZ4lp4CB8w=;
        b=KmLnyzjp/OPlUVWungOgt62voO8Tve89JhTnON/kaWFv8tNIuLfzVVaf+2iSLpUO0V
         V+zF066RqTyANAm/qbRZoQpU6V73ZaaPGePshephg6+AnoT+3jd5gmPfioluaiYNvfeA
         jXZxhcVSj+ZZc9S1kfEObzXl3TkaWUEsbILnNE1K/rcWD1C5GprJDsLCac91t95bHsGX
         mJge2q+vp/e9as3I8UUGjTC4HyZdMuWaEbIO5yFqZx8oZ9bUD677CbCEJXghNqq4HHGw
         nuPIX1JZLQox4rgy2+x7QUo9BoJBjf+nzLhIcyfW/8KFQ2xGyo0UAy6IaQsif4y5MX3R
         NPuA==
X-Gm-Message-State: APjAAAUJYf1dG3s4Lm/Vcsw51UaFrKxRQ2ekBky1F4LJNWs1i5IHAmqX
        H+BUhLsT1CAJC0l1xqJZNUEQ3g==
X-Google-Smtp-Source: APXvYqzvYs+hLaAs0izcAja0Yg3oxr7AuA/zxEsLqTC9Lha97ddDLSPwJXo8+dQtSGCs/HcWBKD0VQ==
X-Received: by 2002:ac2:4a62:: with SMTP id q2mr11390516lfp.82.1582620410425;
        Tue, 25 Feb 2020 00:46:50 -0800 (PST)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id e25sm7260951ljp.97.2020.02.25.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:46:49 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:46:45 +0100
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
Subject: [PATCH v3 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200225094437.4170502-2-mholenko@antmicro.com>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

Add documentation for LiteX SoC Controller bindings.

Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---

Notes:
    This commit has been introduced in v3 of the patchset.

 .../soc/litex/litex,soc_controller.yaml       | 46 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml b/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
new file mode 100644
index 000000000000..039894265319
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
@@ -0,0 +1,46 @@
+PDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/litex/litex,soc_controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+    const: litex,soc_controller
+
+  reg:
+    description: Base address and length of the register space
+
+  status:
+    description: |
+      disables or enables node
+
+    const: "okay"
+
+required:
+  - compatible
+  - reg
+  - status
+
+examples:
+  - |
+
+  soc_ctrl0: soc_controller@f0000000 {
+			compatible = "litex,soc_controller";
+			reg = <0x0 0xf0000000 0x0 0xC>;
+			status = "okay";
+  };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4beb8dc4c7eb..ec925c081dd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9725,6 +9725,12 @@ L:	kunit-dev@googlegroups.com
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
2.25.0

