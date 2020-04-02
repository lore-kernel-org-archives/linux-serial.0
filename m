Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD5C2BA12
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C42080C
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="c6gdlmsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgDBGqa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:46:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33223 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgDBGqa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 02:46:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id f20so2072321ljm.0
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HyJ7YTufcrtaBiFCHjuoK9+SL6M+7IJE59xeCbvCaLQ=;
        b=c6gdlmsBNmy1dp9T3FDNqaez1rIdxpwOjBSbIUoIj09b3TUXyiA2XQUeyx/dixaxCp
         5hHmO3C5+eJqwMgpquKsSPTOfWWNcwXz7WYi+Fvex1C4qPlVmmzV7Pes0wi7WLCNomem
         neCXg6szyY0rYGSmFzijZIz2S1lb0/sg3usDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HyJ7YTufcrtaBiFCHjuoK9+SL6M+7IJE59xeCbvCaLQ=;
        b=rRQL7KSnjJ+6zqsCEVR5420KFnC1PB8fw41JNoQoPJev48qfY8YEko3R3w2eoVm0EQ
         XW/bz/AnO3/LWgqQoa1ZQIKsFQkRDwQLMbjM8jH+zZCMgk4BGqaqB3ZMy9fisRw8qsv8
         z2Bz5tkt/o/fi0Dl96MZvG8dWA06GvsOw1NIpRj1W2EnRZUW2O9ngD+LEW8BH8jDYOG1
         ylhvD2Ah5H3odFRQvzd710ZKjy1Gji8dbcNSXJDs2c/pJPrP6QGZSzJ5fFte0t2cNFgY
         fS3biHKPcAcgVeB2uF92YusKrkEo96KcK8g/Ky8KDH8riU284avosak3aWAogKkOvbtU
         kyhg==
X-Gm-Message-State: AGi0PuYYnfkDUuAN0/78X8GoxYlsyPSTzNal7T0nnN4gezvl6AKkZpd3
        s53x3oRCJFXXMgFdoZxhgBD8qw==
X-Google-Smtp-Source: APiQypLUSEe2djYB9OeSI9W5ScDyWLf0Z0tCnMHenu0gfRxN+XVgwkJNHpjj188KThIl39seiMQLQg==
X-Received: by 2002:a2e:700e:: with SMTP id l14mr1096379ljc.51.1585809988021;
        Wed, 01 Apr 2020 23:46:28 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id h10sm3137572lfc.42.2020.04.01.23.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:46:27 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:46:22 +0200
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
Subject: [PATCH v4 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200402084513.4173306-4-mholenko@antmicro.com>
References: <20200402084513.4173306-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402084513.4173306-0-mholenko@antmicro.com>
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

