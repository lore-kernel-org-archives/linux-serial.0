From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 08/12] devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
Date: Tue, 16 Feb 2016 19:14:58 +0100
Message-ID: <1455646502-23834-9-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
introduces the Device Tree binding that documents the top-level
compatible strings for Armada 3700 based platforms.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/marvell/armada-37xx.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
new file mode 100644
index 000000000000..51336e5fc761
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -0,0 +1,16 @@
+Marvell Armada 37xx Platforms Device Tree Bindings
+--------------------------------------------------
+
+Boards using a SoC of the Marvell Armada 37xx family must carry the
+following root node property:
+
+ - compatible: must contain "marvell,armada3710"
+
+In addition, boards using the Marvell Armada 3720 SoC shall have the
+following property before the previous one:
+
+ - compatible: must contain "marvell,armada3720"
+
+Example:
+
+compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
-- 
2.5.0
