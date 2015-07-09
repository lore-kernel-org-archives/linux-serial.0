From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] m32r: Add ioreadXX/iowriteXX big-endian mmio accessors
Date: Wed,  8 Jul 2015 23:10:06 -0400
Message-ID: <1436411406-6466-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fengguang Wu <fengguang.wu@intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-serial@vger.kernel.org

commit c627f2ceb692 ("serial: 8250: Add support for big-endian MMIO accesses")
added support for 32-bit big-endian mmio to the 8250 driver. Support for
ioreadXXbe/iowriteXXbe io accessors was missing from m32r arch, which caused
build errors.

Add trivial macro mmio accessors.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/m32r/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 9cc00db..d7a034d 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -173,6 +173,11 @@ static inline void _writel(unsigned long l, unsigned long addr)
 #define iowrite16 writew
 #define iowrite32 writel
 
+#define ioread16be(addr)	be16_to_cpu(readw(addr))
+#define ioread32be(addr)	be32_to_cpu(readl(addr))
+#define iowrite16be(v, addr)	writew(cpu_to_be16(v), (addr))
+#define iowrite32be(v, addr)	writel(cpu_to_be32(v), (addr))
+
 #define mmiowb()
 
 #define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
-- 
2.4.5
