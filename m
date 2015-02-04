From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 26/34] MIPS: allow mach-provided serial.h
Date: Wed, 4 Feb 2015 15:21:55 +0000
Message-ID: <1423063323-19419-27-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

Allow platforms to set BAUD_BASE, which is used by earlycon to calculate
the baud clock.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>

---
V2 Removed FSF address
---
 arch/mips/include/asm/Kbuild                |  1 -
 arch/mips/include/asm/mach-generic/serial.h | 21 +++++++++++++++++++++
 arch/mips/include/asm/serial.h              | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-generic/serial.h
 create mode 100644 arch/mips/include/asm/serial.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 200efea..3cd9114 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += segment.h
-generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/mach-generic/serial.h b/arch/mips/include/asm/mach-generic/serial.h
new file mode 100644
index 0000000..25932bb
--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/serial.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2015 Imagination Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_GENERIC_SERIAL_H__
+#define __MACH_GENERIC_SERIAL_H__
+
+#include <asm-generic/serial.h>
+
+#endif /* __MACH_GENERIC_SERIAL_H__ */
diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
new file mode 100644
index 0000000..a50e7b0
--- /dev/null
+++ b/arch/mips/include/asm/serial.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2015 Imagination Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __ASM_SERIAL_H__
+#define __ASM_SERIAL_H__
+
+#include_next <serial.h>
+
+#endif /* __ASM_SERIAL_H__ */
-- 
1.9.1
