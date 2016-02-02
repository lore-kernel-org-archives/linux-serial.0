From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 08/10] MAINTAINERS: Extend dts entry for ARM64 mvebu files
Date: Tue,  2 Feb 2016 19:07:46 +0100
Message-ID: <1454436468-4241-9-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Extend the mvebu entry to ARM64 device tree sources.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..ad49b62c5abc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ F:	arch/arm/mach-mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
+F:	arch/arm64/boot/dts/marvell/armada*
 
 
 ARM/Marvell Berlin SoC support
-- 
2.5.0
