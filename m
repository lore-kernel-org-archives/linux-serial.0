Return-Path: <SRS0=pZl0=7J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C24C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A320890
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="c31xNxz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgE0Q06 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbgE0Q05 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 12:26:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35AC03E97D
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so29717655ljc.8
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F8tmgHUoHk36ri66dg3fmf/UvjxIGvzJKrgXW7rlCA0=;
        b=c31xNxz8HKVKICjYWT+NoNaFPS4cNmxcqDm4C0+VhDnXvaSPv9LR4vSv5JYTeUVWeV
         a4Ii15SXjW8tBXaRd/ZsVg9Gkq82i/fWRVzV7qOj+n0I+itUPTqUVGTa65wMSa9+oI9Q
         cerXH3QJCnwXnmikSjYctaYbFLfBmV+FUSTis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8tmgHUoHk36ri66dg3fmf/UvjxIGvzJKrgXW7rlCA0=;
        b=ZB0+OKrGgYuDxOBRijGScCUHWho6b3OoxbWRARLD6e4xpPhxJjM5WyIlp2KBn+t6cA
         bnqOFt/C+HgkxuBugOcjwYOKgy5jT3wvn+W0H0o0LK1WQH8voewYTxhpq724xigpY7tt
         TWIVnVsY6KTnYLdtFIIkggRrTZxKE9C6XTG9tQm3WiO1tXhYceAz1bzSez4y+ftLciif
         HoCEpY9IRMwBSOf9oBbzj3fZp+8cc72wxf6MLYGMWX5A9s40SdlbvW5PpNJxQYYgSwel
         y849fvmBHSEJJAy2scqeZoBVXeiOEKyHVoZ4k0ebK+3hCXR63Tq/Xjo1baDxNdGqInpi
         PYpA==
X-Gm-Message-State: AOAM531hDQRFyb6TK8NWHSsJLRomhSUqS4qyhSH9pleGlYPPge/1xZ57
        131bQ1cX/P40HDJOZ2U2nhv7vQ==
X-Google-Smtp-Source: ABdhPJwKC5EKHBnswklS6abOBVt/T4q6wZevGb8+Xp5q4r3Ls+UHA6A8a+HrySnHhgMc7cGSRWwPUw==
X-Received: by 2002:a2e:810c:: with SMTP id d12mr3387247ljg.410.1590596815858;
        Wed, 27 May 2020 09:26:55 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id z13sm906402lfd.7.2020.05.27.09.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:26:55 -0700 (PDT)
Date:   Wed, 27 May 2020 18:26:50 +0200
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
Subject: [PATCH v6 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200527182545.3859622-4-mholenko@antmicro.com>
References: <20200527182545.3859622-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527182545.3859622-0-mholenko@antmicro.com>
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
index 000000000000..87bf846b170a
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

