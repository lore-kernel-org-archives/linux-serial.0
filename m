Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60854C2BA12
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372E52078B
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="eKwqVvG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgDBGqD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:46:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40486 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBGqD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 02:46:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so2002982ljj.7
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9xnZbxvNOKHFAZYRn5/ijjeLydct9dBBxLdIGW7A/1s=;
        b=eKwqVvG/nU10Aj1fIjxcIlnBIAW/UAhyk+8spqGbl4M1nzkJAQGK7aiXHgyF290n5C
         qnu5SXmd5sdqBePY5exZQrd/hen9mtA+pmwiH4qcPxkfh3jDQ+ngZKTRoEs2a5xXoWzr
         HG4Br6j52jlUlFCxZ9FShqQI5KWiWw9z+hkxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9xnZbxvNOKHFAZYRn5/ijjeLydct9dBBxLdIGW7A/1s=;
        b=hfCeAI0r+I8q2wk3KcI0CTw2Npl6XL3t9RzTOK3zqlJRPVAiUiSaNXNcKY9f8rJd4/
         bdV1j0nccMvKLD9FMvsRpA64icne/qT9kxWZykXnuKmCreFUf/+V5lJZnWRf+33741BF
         GPHSyruoleL0xbNdjrr+dAr1kRS3RYbX//E71bAqbgsHketYezFaTtr81U/q/LyIAZeU
         pRNxB9WueedkGvtvocGewiIo7wKOfGif8rvrqLx/ekR0jkDFbokCgk8jYxM5BQPgyQsv
         ueEaUKdz900Ij5Uq6LXgBplBMGZgwI7B5f6nZYeTyJzN1IxrY4l5DHB8bynoazpUrk0g
         kc2Q==
X-Gm-Message-State: AGi0PuY6v/zc6GJOsr6VyWHQprqQWEYGbO3pnHQmXp39ib1b4f+TxVbg
        WLXxQQ+DOnWgJgYogPgjVBDNiQ==
X-Google-Smtp-Source: APiQypL5ab8kUwVRVcWcIiAwRrCmT//wFOwkdykPYlBYC88rMzjY4NOYcT/9iGaPrjtsMaol4ojq7g==
X-Received: by 2002:a2e:9588:: with SMTP id w8mr1064366ljh.262.1585809960043;
        Wed, 01 Apr 2020 23:46:00 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id n26sm2559155ljg.93.2020.04.01.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:45:59 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:45:54 +0200
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
Subject: [PATCH v4 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200402084513.4173306-2-mholenko@antmicro.com>
References: <20200402084513.4173306-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402084513.4173306-0-mholenko@antmicro.com>
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
index cc1d18cb5d18..2f5ede8a08aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9724,6 +9724,12 @@ L:	kunit-dev@googlegroups.com
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

