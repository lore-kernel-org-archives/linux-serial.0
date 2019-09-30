From: Mateusz Holenko <mholenko@antmicro.com>
Subject: [PATCH 1/3] dt-bindings: vendor: add vendor prefix for LiteX
Date: Mon, 30 Sep 2019 15:04:11 +0200
Message-ID: <20190930130411.GA8312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sam Ravnborg <sam@ravnborg.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Icenowy Zheng <icenowy@aosc.io>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 329b668da..4143c52a8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -533,6 +533,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.23.0
