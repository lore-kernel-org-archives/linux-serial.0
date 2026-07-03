Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B5383339;
	Fri,  3 Jul 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068446; cv=none; b=jLS/gmz/NV0c0yBWbjc4FxltfNq6XOU+dlUTefmyin3CYpY1JGXoZPfowBB14+hFsl1cvdlwfRp+8/SSHL7tteyuSoqJhZ4LdzrgCs1RfaNyMEzH3RDl5r+0BQVttd27qqqa7sjwMmXJNdInHOHa48+cAS+2Dqj/BQbmF3NxXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068446; c=relaxed/simple;
	bh=4OSLlPM6PqiFgR3Mn8UM6JKHP2WJMHTx8XdhaHVseDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Imb90HJdcNJWcEbt+a4MixvHCTdFxyFUns5sEoYbqrZVAeMmDlSyNjeseBtfKK5ihYIT6dcdXl9bQwHYGP9DHDwii1Fr00pzz2F6wKKxiQdcM/9mbEEKRmuE+YnJ4lCjplwSyGXY3gKGNAniaezhZPjHJIMFAnLVuv1WEb2MwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3HTw9zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3HTw9zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701A61F000E9;
	Fri,  3 Jul 2026 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068444;
	bh=nb9VOLAuCr2LlvVdJMmXIe0Yg1/y885z7dzJx+6fUt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3HTw9zp2sSOKLETVwNreZvAGfnHHhOemN5U98A1XeUrA/ecP1+XTgkz94yqM5pG+
	 elpWrDMqc29hvERIHYJ2+uqmQgsE0LkOAjingokSuUULhN79VN/106GJIbD+xBG5dP
	 ok8VtFUzZR6B1fQp0PMAottTh3HM+musnDGlUXYQ2V0+B7nsWUOU3KYoJVVm7EdSKD
	 GmOm6GvtvpDZYGpLOWV+KNw4WkasRLkYAFhvnCO0lirdtAKRdz1k0W063Hl6g7uobZ
	 7BsC3R7w3l3Ax0O3EZeXVLcLkvrCXNpsw/wdTJn+ohPTA5GA+nIxXw00V2BCItl4A/
	 DgjoBE+yINQUA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/4] tty: goldfish: move gf_write_ptr() to tty/goldfish.c
Date: Fri,  3 Jul 2026 10:47:16 +0200
Message-ID: <20260703084717.176442-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703084717.176442-1-jirislaby@kernel.org>
References: <20260703084717.176442-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty/goldfish.c is the only user of gf_write_ptr(). Move it there, drop
the unneeded casts, and name it appropriately.

FTR, the last non-tty user was removed in 2018 by 4ae0fe70a097 ("Delete
the goldfish_nand driver.").

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c   | 13 +++++++++++--
 include/linux/goldfish.h | 13 -------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 69367d878877..c643d76e9d1b 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_core.h>
+#include <linux/wordpart.h>
 
 /* Goldfish tty register's offsets */
 #define	GOLDFISH_TTY_REG_BYTES_READY	0x04
@@ -48,6 +49,14 @@ static u32 goldfish_tty_line_count = 8;
 static u32 goldfish_tty_current_line_count;
 static struct goldfish_tty *goldfish_ttys;
 
+static inline void gf_write_addr(unsigned long addr, void __iomem *portl, void __iomem *porth)
+{
+	gf_iowrite32(lower_32_bits(addr), portl);
+#ifdef CONFIG_64BIT
+	gf_iowrite32(upper_32_bits(addr), porth);
+#endif
+}
+
 static void do_rw_io(struct goldfish_tty *qtty, unsigned long address,
 		     size_t count, bool is_write)
 {
@@ -55,8 +64,8 @@ static void do_rw_io(struct goldfish_tty *qtty, unsigned long address,
 	void __iomem *base = qtty->base;
 
 	spin_lock_irqsave(&qtty->lock, irq_flags);
-	gf_write_ptr((void *)address, base + GOLDFISH_TTY_REG_DATA_PTR,
-		     base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
+	gf_write_addr(address, base + GOLDFISH_TTY_REG_DATA_PTR,
+		      base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
 	gf_iowrite32(count, base + GOLDFISH_TTY_REG_DATA_LEN);
 
 	if (is_write)
diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index 40a059e03d78..98a4719c6776 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -2,8 +2,6 @@
 #ifndef __LINUX_GOLDFISH_H
 #define __LINUX_GOLDFISH_H
 
-#include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/io.h>
 
 /* Helpers for Goldfish virtual platform */
@@ -15,15 +13,4 @@
 #define gf_iowrite32 iowrite32
 #endif
 
-static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
-				void __iomem *porth)
-{
-	const unsigned long addr = (unsigned long)ptr;
-
-	gf_iowrite32(lower_32_bits(addr), portl);
-#ifdef CONFIG_64BIT
-	gf_iowrite32(upper_32_bits(addr), porth);
-#endif
-}
-
 #endif /* __LINUX_GOLDFISH_H */
-- 
2.54.0

