Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE9308F23
	for <linux-serial@vger.kernel.org>; Wed, 20 May 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247978; cv=none; b=PlrWPCeHR96rYFqaZ+BTVFiZBiThxdntMCu4ZOXUp4n/BWIMjGcvl3dnbuAUhmDwlX6J9ide+CGOaGGCjtRic+MyvW5qUokHxtfcOdG3tYV7VIn0qM96F1mKAGsT0MSzjhgF3NGWZlgak9kKF/nI5sgG+BgM5kHBw9ryo9SG7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247978; c=relaxed/simple;
	bh=DE7lfdFY0tW8txQ93NLpBlb9NX1IgxQFhteEfn+hLH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnxMK4+bLgSRweXSZow3jqTyzllEYdaIx6DarcFttSJ21b3nLKM77w4HP+DEYPb6lMByB+Wu/kGdleQOXeFP897I8ZItkuSLHP4whESO3XgLB6wUSc3vy5RnldTt7LsVn+yVhRlNDo7PysJrOBUuxemCA9Yq4N8x21+VKbqre0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duk+i3PY; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duk+i3PY"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-135200bc7d2so931801c88.0
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2026 20:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247975; x=1779852775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZwT6jFAkQrUSs7LqDce8uNZux1QgXwZ4Wl56JV19lI=;
        b=Duk+i3PYiW4IdRnR82qeVs1OB63hZ2gUlunzOaZxIvb1I2wkQVC7dWma1bJ+iw94H6
         3QCHMB4TEUflSs3XLVm+IIeJUoN1Bx8C2vhk62LxfC2GlKQcf8IP3ctyNAm3DQA/8Vlu
         ODo7+2B0ufkSPisPlXriUm2ieaG8oh/2kwrJyhgeZrd2zGvpcbMBiFEXPbJGxp1CMTrb
         2mZfjBnc5AZ0UTrMj15okoLmtQICEi8eahl74br0oWmVTowKZAEVD7Ry7HwhYhPGEPrw
         3sz9DyxAWSNogPAIlmYGTHIr4rMWDBI3Ywj18YlA7WzGOOgR1V06m/In5Ufygp0T77cK
         pe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247975; x=1779852775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZwT6jFAkQrUSs7LqDce8uNZux1QgXwZ4Wl56JV19lI=;
        b=Vewv2rBuEAqO+2BwUMFydCzNuv/j8N8o8Sgy6FBYF/DecKNZcmfXEUZf7FO+l0p0yt
         TNDHGJBNLpVWZAe3bCVCDzrPQP9MXQOcYSibxAEg2/rUk+0fThOh+dSWKlsEGQnNd2gh
         Vf5kVwwwOcejyj36Ww9Qy5T/JLv0VX4FbxK9Y8FN2SpPecTUjtiNu3SZvAnErWcP5gvf
         /oQy1MQNqHpYp/4aUsy+L+szwGoJ9OPvpa65iIKn/N4ECAcM9TZZffxwt7S10Pze4NzF
         7+W9jcSR9FK8NZbUcMa58BUqnaYh8yAuQ7oMOAzoiOyUKwH5e1dpKR4VgdD72jDRfx5R
         t73A==
X-Forwarded-Encrypted: i=1; AFNElJ8uqiLJ662fTPHebmgi/ReEe1OEhD3sqTfHMiHgOx5XZxKpQ4xV6Rh0nLYVl+SINchaClEuky9dlFrT5cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uxHW8+lJrAZKrTpWRb3B/Tcl3PAY2Lmq8UVHGcdycTIHh+cB
	EcRzvxgJ1wKe5iefN/EGir7hpfgIfERVIaP7z+tqF1P8fWkxj1Rz92A3
X-Gm-Gg: Acq92OFJu+uuVDymFtMrHDPPb9Q+OPTRkYUpwHpr2falFJ9U0/ruHIbfoyPJOaQa6MX
	vczjHQA/AKSQ+HjXgoCdFoBrGPaWkwqqPXFl/jPlBNCJn0gCo8hJB8yP8/mToAxybp20NzYFrhD
	V89pjGW6X833+sTZUvPdtRDNc+B0SXLscqb4sUdxwVIqYtBOKvbcHpMo+o4uOnz6SewfsU25fZC
	AR70jGl672VlSGB4qi4SaDDiyijsmq6D/X77eBkqOwSW9RbYm4sWm7wwS/hDSJMZA1k2wT1iyTu
	n3v+Z6xeuPFAUR9p/qZgyOezzlbo7TDFHJBvC58pCmUv/tw37+4r7jUHBAzZfWVoGfQb1WDGZrh
	meHgw8cppE0njiIbyfoxqR0xVfcMnWprn5qUCcO7mHutL6bifevW+iL87Caa4o6yHzlWxwr0fpu
	qSi9jTvcP6D0NCyNeTG5EJf1SnXI1HStFhegRyOstxU6McgJEyfQ1bvpiDpf9CJMigG1B0JwlMn
	H4kGqUPs9QJGzjuz75XJifol/kDvq4HHPsjCBs9S/sJsBOrKjfr+NcOvXPC0iz1S+iQ+m7gY9sW
	u8EHGuMueDLLQF2k3Q==
X-Received: by 2002:a05:7022:f9d:b0:133:1ba6:f42d with SMTP id a92af1059eb24-1350451e2b2mr11405371c88.3.1779247974860;
        Tue, 19 May 2026 20:32:54 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm24582900c88.2.2026.05.19.20.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:32:54 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] video: console: mdacon: remove this obsolete driver
Date: Tue, 19 May 2026 20:31:36 -0700
Message-ID: <20260520033155.17378-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mdacon driver supports using ISA MDA or Hercules-compatible display
adapters as a secondary text console. This was commonly used in the
1990s and earlier for debugging software which took over the primary
display. It is highly unlikely anyone is doing so nowadays because
serial consoles and much better methods of debugging exist.

The driver is not enabled by any defconfig, nor any of the
dozens of distro configs collected at [1]. It has been relegated to VTs
13-16 since commit 0b9cf3aa6b1e ("mdacon messing up default vc's - set
default to vc13-16 again") in Linux 2.6.27 (and before Linux 2.5.53 -
see the link in the message of the above commit). The change in 2.6.27
was done because it was incorrectly detecting non-MDA adapters as MDA
and taking over all VTs, rendering them unusable.

Furthermore, vgacon supports using MDA/Hercules-compatible adapters as
the primary text console, so any systems with only one of these
adapters were already using vgacon and will not experience any loss in
functionality from the removal of this driver.

Given all of these factors, the mdacon driver is likely entirely
unused. Remove it.

[1] https://github.com/nyrahul/linux-kernel-configs/tree/f0bee86a135a0406ea427855f52702dd00d770f9

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |   5 -
 arch/alpha/kernel/io.c                        |   2 +-
 arch/powerpc/include/asm/vga.h                |   4 +-
 drivers/tty/vt/vt.c                           |   3 -
 drivers/video/console/Kconfig                 |  15 -
 drivers/video/console/Makefile                |   1 -
 drivers/video/console/mdacon.c                | 566 ------------------
 include/linux/console.h                       |   2 -
 include/linux/vt_buffer.h                     |   2 +-
 9 files changed, 4 insertions(+), 596 deletions(-)
 delete mode 100644 drivers/video/console/mdacon.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..e873b27cdd30 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -36,7 +36,6 @@
 	M68k	M68k architecture is enabled.
 			These options have more detailed description inside of
 			Documentation/arch/m68k/kernel-options.rst.
-	MDA	MDA console support is enabled.
 	MIPS	MIPS architecture is enabled.
 	MOUSE	Appropriate mouse support is enabled.
 	MSI	Message Signaled Interrupts (PCI).
@@ -3816,10 +3815,6 @@ Kernel parameters
 	md=		[HW] RAID subsystems devices and level
 			See Documentation/admin-guide/md.rst.
 
-	mdacon=		[MDA]
-			Format: <first>,<last>
-			Specifies range of consoles to be captured by the MDA.
-
 	mds=		[X86,INTEL,EARLY]
 			Control mitigation for the Micro-architectural Data
 			Sampling (MDS) vulnerability.
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index c28035d6d1e6..2bad1b4fb240 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -647,7 +647,7 @@ void _memset_c_io(volatile void __iomem *to, unsigned long c, long count)
 
 EXPORT_SYMBOL(_memset_c_io);
 
-#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE)
 
 #include <asm/vga.h>
 
diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index f2dc40e1c52a..e45063b02b45 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -14,7 +14,7 @@
 #include <asm/io.h>
 
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#ifdef CONFIG_VGA_CONSOLE
 
 #define VT_BUF_HAVE_RW
 /*
@@ -40,7 +40,7 @@ static inline void scr_memsetw(u16 *s, u16 v, unsigned int n)
 	memset16(s, cpu_to_le16(v), n / 2);
 }
 
-#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
+#endif /* !CONFIG_VGA_CONSOLE */
 
 #ifdef __powerpc64__
 #define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e99636ab9db5..3ca5e3dc5ac0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3978,9 +3978,6 @@ int __init vty_init(const struct file_operations *console_fops)
 		panic("Couldn't register console driver\n");
 	kbd_init();
 	console_map_init();
-#ifdef CONFIG_MDA_CONSOLE
-	mda_console_init();
-#endif
 	return 0;
 }
 
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 12f54480f57f..9f81af3506da 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -23,21 +23,6 @@ config VGA_CONSOLE
 
 	  Say Y.
 
-config MDA_CONSOLE
-	depends on VGA_CONSOLE && ISA
-	tristate "MDA text console (dual-headed)"
-	help
-	  Say Y here if you have an old MDA or monochrome Hercules graphics
-	  adapter in your system acting as a second head ( = video card). You
-	  will then be able to use two monitors with your Linux system. Do not
-	  say Y here if your MDA card is the primary card in your system; the
-	  normal VGA driver will handle it.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mdacon.
-
-	  If unsure, say N.
-
 config SGI_NEWPORT_CONSOLE
 	tristate "SGI Newport Console support"
 	depends on SGI_IP22 && HAS_IOMEM
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index fd79016a0d95..f1000605210c 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -7,4 +7,3 @@ obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
-obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
deleted file mode 100644
index d52cd99cd18b..000000000000
--- a/drivers/video/console/mdacon.c
+++ /dev/null
@@ -1,566 +0,0 @@
-/*
- *  linux/drivers/video/mdacon.c -- Low level MDA based console driver
- *
- *	(c) 1998 Andrew Apted <ajapted@netspace.net.au>
- *
- *      including portions (c) 1995-1998 Patrick Caulfield.
- *
- *      slight improvements (c) 2000 Edward Betts <edward@debian.org>
- *
- *  This file is based on the VGA console driver (vgacon.c):
- *	
- *	Created 28 Sep 1997 by Geert Uytterhoeven
- *
- *	Rewritten by Martin Mares <mj@ucw.cz>, July 1998
- *
- *  and on the old console.c, vga.c and vesa_blank.c drivers:
- *
- *	Copyright (C) 1991, 1992  Linus Torvalds
- *			    1995  Jay Estabrook
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive for
- *  more details.
- *
- *  Changelog:
- *  Paul G. (03/2001) Fix mdacon= boot prompt to use __setup().
- */
-
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/console.h>
-#include <linux/string.h>
-#include <linux/kd.h>
-#include <linux/vt_kern.h>
-#include <linux/vt_buffer.h>
-#include <linux/selection.h>
-#include <linux/spinlock.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/vga.h>
-
-static DEFINE_SPINLOCK(mda_lock);
-
-/* description of the hardware layout */
-
-static u16		*mda_vram_base;		/* Base of video memory */
-static unsigned long	mda_vram_len;		/* Size of video memory */
-static unsigned int	mda_num_columns;	/* Number of text columns */
-static unsigned int	mda_num_lines;		/* Number of text lines */
-
-static unsigned int	mda_index_port;		/* Register select port */
-static unsigned int	mda_value_port;		/* Register value port */
-static unsigned int	mda_mode_port;		/* Mode control port */
-static unsigned int	mda_status_port;	/* Status and Config port */
-static unsigned int	mda_gfx_port;		/* Graphics control port */
-
-/* current hardware state */
-
-static int	mda_cursor_loc=-1;
-static int	mda_cursor_size_from=-1;
-static int	mda_cursor_size_to=-1;
-
-static enum { TYPE_MDA, TYPE_HERC, TYPE_HERCPLUS, TYPE_HERCCOLOR } mda_type;
-static char *mda_type_name;
-
-/* console information */
-
-static int	mda_first_vc = 13;
-static int	mda_last_vc  = 16;
-
-static struct vc_data	*mda_display_fg = NULL;
-
-module_param(mda_first_vc, int, 0);
-MODULE_PARM_DESC(mda_first_vc, "First virtual console. Default: 13");
-module_param(mda_last_vc, int, 0);
-MODULE_PARM_DESC(mda_last_vc, "Last virtual console. Default: 16");
-
-/* MDA register values
- */
-
-#define MDA_CURSOR_BLINKING	0x00
-#define MDA_CURSOR_OFF		0x20
-#define MDA_CURSOR_SLOWBLINK	0x60
-
-#define MDA_MODE_GRAPHICS	0x02
-#define MDA_MODE_VIDEO_EN	0x08
-#define MDA_MODE_BLINK_EN	0x20
-#define MDA_MODE_GFX_PAGE1	0x80
-
-#define MDA_STATUS_HSYNC	0x01
-#define MDA_STATUS_VSYNC	0x80
-#define MDA_STATUS_VIDEO	0x08
-
-#define MDA_CONFIG_COL132	0x08
-#define MDA_GFX_MODE_EN		0x01
-#define MDA_GFX_PAGE_EN		0x02
-
-
-/*
- * MDA could easily be classified as "pre-dinosaur hardware".
- */
-
-static void write_mda_b(unsigned int val, unsigned char reg)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mda_lock, flags);	
-
-	outb_p(reg, mda_index_port); 
-	outb_p(val, mda_value_port);
-
-	spin_unlock_irqrestore(&mda_lock, flags);
-}
-
-static void write_mda_w(unsigned int val, unsigned char reg)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mda_lock, flags);
-
-	outb_p(reg,   mda_index_port); outb_p(val >> 8,   mda_value_port);
-	outb_p(reg+1, mda_index_port); outb_p(val & 0xff, mda_value_port);
-
-	spin_unlock_irqrestore(&mda_lock, flags);
-}
-
-#ifdef TEST_MDA_B
-static int test_mda_b(unsigned char val, unsigned char reg)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mda_lock, flags);
-
-	outb_p(reg, mda_index_port); 
-	outb  (val, mda_value_port);
-
-	udelay(20); val = (inb_p(mda_value_port) == val);
-
-	spin_unlock_irqrestore(&mda_lock, flags);
-	return val;
-}
-#endif
-
-static inline void mda_set_cursor(unsigned int location) 
-{
-	if (mda_cursor_loc == location)
-		return;
-
-	write_mda_w(location >> 1, 0x0e);
-
-	mda_cursor_loc = location;
-}
-
-static inline void mda_set_cursor_size(int from, int to)
-{
-	if (mda_cursor_size_from==from && mda_cursor_size_to==to)
-		return;
-	
-	if (from > to) {
-		write_mda_b(MDA_CURSOR_OFF, 0x0a);	/* disable cursor */
-	} else {
-		write_mda_b(from, 0x0a);	/* cursor start */
-		write_mda_b(to,   0x0b);	/* cursor end */
-	}
-
-	mda_cursor_size_from = from;
-	mda_cursor_size_to   = to;
-}
-
-
-#ifndef MODULE
-static int __init mdacon_setup(char *str)
-{
-	/* command line format: mdacon=<first>,<last> */
-
-	int ints[3];
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-
-	if (ints[0] < 2)
-		return 0;
-
-	if (ints[1] < 1 || ints[1] > MAX_NR_CONSOLES || 
-	    ints[2] < 1 || ints[2] > MAX_NR_CONSOLES)
-		return 0;
-
-	mda_first_vc = ints[1];
-	mda_last_vc  = ints[2];
-	return 1;
-}
-
-__setup("mdacon=", mdacon_setup);
-#endif
-
-static int mda_detect(void)
-{
-	int count=0;
-	u16 *p, p_save;
-	u16 *q, q_save;
-
-	/* do a memory check */
-
-	p = mda_vram_base;
-	q = mda_vram_base + 0x01000 / 2;
-
-	p_save = scr_readw(p);
-	q_save = scr_readw(q);
-
-	scr_writew(0xAA55, p);
-	if (scr_readw(p) == 0xAA55)
-		count++;
-
-	scr_writew(0x55AA, p);
-	if (scr_readw(p) == 0x55AA)
-		count++;
-
-	scr_writew(p_save, p);
-
-	if (count != 2) {
-		return 0;
-	}
-
-	/* check if we have 4K or 8K */
-
-	scr_writew(0xA55A, q);
-	scr_writew(0x0000, p);
-	if (scr_readw(q) == 0xA55A)
-		count++;
-	
-	scr_writew(0x5AA5, q);
-	scr_writew(0x0000, p);
-	if (scr_readw(q) == 0x5AA5)
-		count++;
-
-	scr_writew(p_save, p);
-	scr_writew(q_save, q);
-	
-	if (count == 4) {
-		mda_vram_len = 0x02000;
-	}
-	
-	/* Ok, there is definitely a card registering at the correct
-	 * memory location, so now we do an I/O port test.
-	 */
-
-#ifdef TEST_MDA_B
-	/* Edward: These two mess `tests' mess up my cursor on bootup */
-
-	/* cursor low register */
-	if (!test_mda_b(0x66, 0x0f))
-		return 0;
-
-	/* cursor low register */
-	if (!test_mda_b(0x99, 0x0f))
-		return 0;
-#endif
-
-	/* See if the card is a Hercules, by checking whether the vsync
-	 * bit of the status register is changing.  This test lasts for
-	 * approximately 1/10th of a second.
-	 */
-	
-	p_save = q_save = inb_p(mda_status_port) & MDA_STATUS_VSYNC;
-
-	for (count = 0; count < 50000 && p_save == q_save; count++) {
-		q_save = inb(mda_status_port) & MDA_STATUS_VSYNC;
-		udelay(2);
-	}
-
-	if (p_save != q_save) {
-		switch (inb_p(mda_status_port) & 0x70) {
-		case 0x10:
-			mda_type = TYPE_HERCPLUS;
-			mda_type_name = "HerculesPlus";
-			break;
-		case 0x50:
-			mda_type = TYPE_HERCCOLOR;
-			mda_type_name = "HerculesColor";
-			break;
-		default:
-			mda_type = TYPE_HERC;
-			mda_type_name = "Hercules";
-			break;
-		}
-	}
-
-	return 1;
-}
-
-static void mda_initialize(void)
-{
-	write_mda_b(97, 0x00);		/* horizontal total */
-	write_mda_b(80, 0x01);		/* horizontal displayed */
-	write_mda_b(82, 0x02);		/* horizontal sync pos */
-	write_mda_b(15, 0x03);		/* horizontal sync width */
-
-	write_mda_b(25, 0x04);		/* vertical total */
-	write_mda_b(6,  0x05);		/* vertical total adjust */
-	write_mda_b(25, 0x06);		/* vertical displayed */
-	write_mda_b(25, 0x07);		/* vertical sync pos */
-
-	write_mda_b(2,  0x08);		/* interlace mode */
-	write_mda_b(13, 0x09);		/* maximum scanline */
-	write_mda_b(12, 0x0a);		/* cursor start */
-	write_mda_b(13, 0x0b);		/* cursor end */
-
-	write_mda_w(0x0000, 0x0c);	/* start address */
-	write_mda_w(0x0000, 0x0e);	/* cursor location */
-
-	outb_p(MDA_MODE_VIDEO_EN | MDA_MODE_BLINK_EN, mda_mode_port);
-	outb_p(0x00, mda_status_port);
-	outb_p(0x00, mda_gfx_port);
-}
-
-static const char *mdacon_startup(void)
-{
-	mda_num_columns = 80;
-	mda_num_lines   = 25;
-
-	mda_vram_len  = 0x01000;
-	mda_vram_base = (u16 *)VGA_MAP_MEM(0xb0000, mda_vram_len);
-
-	mda_index_port  = 0x3b4;
-	mda_value_port  = 0x3b5;
-	mda_mode_port   = 0x3b8;
-	mda_status_port = 0x3ba;
-	mda_gfx_port    = 0x3bf;
-
-	mda_type = TYPE_MDA;
-	mda_type_name = "MDA";
-
-	if (! mda_detect()) {
-		printk("mdacon: MDA card not detected.\n");
-		return NULL;
-	}
-
-	if (mda_type != TYPE_MDA) {
-		mda_initialize();
-	}
-
-	/* cursor looks ugly during boot-up, so turn it off */
-	mda_set_cursor(mda_vram_len - 1);
-
-	printk("mdacon: %s with %ldK of memory detected.\n",
-		mda_type_name, mda_vram_len/1024);
-
-	return "MDA-2";
-}
-
-static void mdacon_init(struct vc_data *c, bool init)
-{
-	c->vc_complement_mask = 0x0800;	 /* reverse video */
-	c->vc_display_fg = &mda_display_fg;
-
-	if (init) {
-		c->vc_cols = mda_num_columns;
-		c->vc_rows = mda_num_lines;
-	} else
-		vc_resize(c, mda_num_columns, mda_num_lines);
-
-	/* make the first MDA console visible */
-
-	if (mda_display_fg == NULL)
-		mda_display_fg = c;
-}
-
-static void mdacon_deinit(struct vc_data *c)
-{
-	/* con_set_default_unimap(c->vc_num); */
-
-	if (mda_display_fg == c)
-		mda_display_fg = NULL;
-}
-
-static inline u16 mda_convert_attr(u16 ch)
-{
-	u16 attr = 0x0700;
-
-	/* Underline and reverse-video are mutually exclusive on MDA.
-	 * Since reverse-video is used for cursors and selected areas,
-	 * it takes precedence. 
-	 */
-
-	if (ch & 0x0800)	attr = 0x7000;	/* reverse */
-	else if (ch & 0x0400)	attr = 0x0100;	/* underline */
-
-	return ((ch & 0x0200) << 2) | 		/* intensity */ 
-		(ch & 0x8000) |			/* blink */ 
-		(ch & 0x00ff) | attr;
-}
-
-static u8 mdacon_build_attr(struct vc_data *c, u8 color,
-			    enum vc_intensity intensity,
-			    bool blink, bool underline, bool reverse,
-			    bool italic)
-{
-	/* The attribute is just a bit vector:
-	 *
-	 *	Bit 0..1 : intensity (0..2)
-	 *	Bit 2    : underline
-	 *	Bit 3    : reverse
-	 *	Bit 7    : blink
-	 */
-
-	return (intensity & VCI_MASK) |
-		(underline << 2) |
-		(reverse << 3) |
-		(italic << 4) |
-		(blink << 7);
-}
-
-static void mdacon_invert_region(struct vc_data *c, u16 *p, int count)
-{
-	for (; count > 0; count--) {
-		scr_writew(scr_readw(p) ^ 0x0800, p);
-		p++;
-	}
-}
-
-static inline u16 *mda_addr(unsigned int x, unsigned int y)
-{
-	return mda_vram_base + y * mda_num_columns + x;
-}
-
-static void mdacon_putcs(struct vc_data *c, const u16 *s, unsigned int count,
-			 unsigned int y, unsigned int x)
-{
-	u16 *dest = mda_addr(x, y);
-
-	for (; count > 0; count--) {
-		scr_writew(mda_convert_attr(scr_readw(s++)), dest++);
-	}
-}
-
-static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
-			 unsigned int width)
-{
-	u16 *dest = mda_addr(x, y);
-	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
-
-	scr_memsetw(dest, eattr, width * 2);
-}
-
-static bool mdacon_switch(struct vc_data *c)
-{
-	return true;	/* redrawing needed */
-}
-
-static bool mdacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
-			 bool mode_switch)
-{
-	if (mda_type == TYPE_MDA) {
-		if (blank) 
-			scr_memsetw(mda_vram_base,
-				mda_convert_attr(c->vc_video_erase_char),
-				c->vc_screenbuf_size);
-		/* Tell console.c that it has to restore the screen itself */
-		return true;
-	} else {
-		if (blank)
-			outb_p(0x00, mda_mode_port);	/* disable video */
-		else
-			outb_p(MDA_MODE_VIDEO_EN | MDA_MODE_BLINK_EN, 
-				mda_mode_port);
-		return false;
-	}
-}
-
-static void mdacon_cursor(struct vc_data *c, bool enable)
-{
-	if (!enable) {
-		mda_set_cursor(mda_vram_len - 1);
-		return;
-	}
-
-	mda_set_cursor(c->state.y * mda_num_columns * 2 + c->state.x * 2);
-
-	switch (CUR_SIZE(c->vc_cursor_type)) {
-
-		case CUR_LOWER_THIRD:	mda_set_cursor_size(10, 13); break;
-		case CUR_LOWER_HALF:	mda_set_cursor_size(7,  13); break;
-		case CUR_TWO_THIRDS:	mda_set_cursor_size(4,  13); break;
-		case CUR_BLOCK:		mda_set_cursor_size(1,  13); break;
-		case CUR_NONE:		mda_set_cursor_size(14, 13); break;
-		default:		mda_set_cursor_size(12, 13); break;
-	}
-}
-
-static bool mdacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
-		enum con_scroll dir, unsigned int lines)
-{
-	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
-
-	if (!lines)
-		return false;
-
-	if (lines > c->vc_rows)   /* maximum realistic size */
-		lines = c->vc_rows;
-
-	switch (dir) {
-
-	case SM_UP:
-		scr_memmovew(mda_addr(0, t), mda_addr(0, t + lines),
-				(b-t-lines)*mda_num_columns*2);
-		scr_memsetw(mda_addr(0, b - lines), eattr,
-				lines*mda_num_columns*2);
-		break;
-
-	case SM_DOWN:
-		scr_memmovew(mda_addr(0, t + lines), mda_addr(0, t),
-				(b-t-lines)*mda_num_columns*2);
-		scr_memsetw(mda_addr(0, t), eattr, lines*mda_num_columns*2);
-		break;
-	}
-
-	return false;
-}
-
-
-/*
- *  The console `switch' structure for the MDA based console
- */
-
-static const struct consw mda_con = {
-	.owner =		THIS_MODULE,
-	.con_startup =		mdacon_startup,
-	.con_init =		mdacon_init,
-	.con_deinit =		mdacon_deinit,
-	.con_clear =		mdacon_clear,
-	.con_putcs =		mdacon_putcs,
-	.con_cursor =		mdacon_cursor,
-	.con_scroll =		mdacon_scroll,
-	.con_switch =		mdacon_switch,
-	.con_blank =		mdacon_blank,
-	.con_build_attr =	mdacon_build_attr,
-	.con_invert_region =	mdacon_invert_region,
-};
-
-int __init mda_console_init(void)
-{
-	int err;
-
-	if (mda_first_vc > mda_last_vc)
-		return 1;
-	console_lock();
-	err = do_take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
-	console_unlock();
-	return err;
-}
-
-static void __exit mda_console_exit(void)
-{
-	give_up_console(&mda_con);
-}
-
-module_init(mda_console_init);
-module_exit(mda_console_exit);
-
-MODULE_DESCRIPTION("MDA based console driver");
-MODULE_LICENSE("GPL");
-
diff --git a/include/linux/console.h b/include/linux/console.h
index 5520e4477ad7..d624200cfc17 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -718,8 +718,6 @@ extern bool console_suspend_enabled;
 extern void console_suspend_all(void);
 extern void console_resume_all(void);
 
-int mda_console_init(void);
-
 void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
 
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index b6eeb8cb6070..6c15c6a15f74 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
-- 
2.43.0

