From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH v2 6/7] arm64: enable FIX_EARLYCON_MEM kconfig
Date: Fri, 18 Apr 2014 17:19:59 -0500
Message-ID: <1397859600-11507-7-git-send-email-robherring2@gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44570 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaDRWUX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 18:20:23 -0400
In-Reply-To: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>

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
index e6e4d37..22d1397 100644
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
1.9.1

