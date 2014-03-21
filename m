From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 3/8] arm64: enable FIX_EARLYCON_MEM kconfig
Date: Fri, 21 Mar 2014 16:08:43 -0500
Message-ID: <1395436128-11244-4-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Rob Herring <robh@kernel.org>

In order to support earlycon on arm64, we need to enable earlycon fixmap
support.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e2424f9..a839444 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -112,6 +112,9 @@ config IOMMU_HELPER
 config KERNEL_MODE_NEON
 	def_bool y
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
1.8.3.2
