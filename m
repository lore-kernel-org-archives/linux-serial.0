From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 11/12] Documentation: arm: update supported Marvell EBU processors
Date: Wed,  3 Feb 2016 19:41:28 +0100
Message-ID: <1454524889-9207-12-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Now that we support Armada 37xx, let's add this family of SoC to the
Marvell documentation, and a reference to a link with more details about
those processors. As for Armda 39x, no datasheet is publicly
available at this time.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/arm/Marvell/README | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index ae89b67d8e23..ddbc048bb467 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -118,6 +118,19 @@ EBU Armada family
   Linux kernel mach directory: arch/arm/mach-mvebu
   Linux kernel plat directory: none
 
+EBU Armada family ARMv8
+-----------------------
+
+  Armada 3710/3720 Flavors:
+	88F3710
+	88F3720
+
+  Core: ARM Cortex A53 (ARMv8)
+
+  Homepage     : http://www.marvell.com/embedded-processors/armada-3700/
+
+  Device tree descritpion located in arch/arm64/boot/dts/marvell/armada-37*
+
 Avanta family
 -------------
 
-- 
2.5.0
