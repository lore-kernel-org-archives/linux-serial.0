From: Pavel Machek <pavel@ucw.cz>
Subject: serial ioctl emulation done right
Date: Tue, 6 May 2003 20:47:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030506184731.GA5419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: linux-serial@vger.kernel.org

Hi!

What about this one? This makes it possible to kill copy from
x86-64/ia32/ia32_ioctl.c, and adds support for setserial on all
architectures...

							Pavel

Index: linux/drivers/serial/core.c
===================================================================
--- linux.orig/drivers/serial/core.c	2003-05-06 00:50:12.000000000 +0200
+++ linux/drivers/serial/core.c	2003-05-06 19:38:50.000000000 +0200
@@ -1147,6 +1147,66 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+struct serial_struct32 {
+	int	type;
+	int	line;
+	unsigned int	port;
+	int	irq;
+	int	flags;
+	int	xmit_fifo_size;
+	int	custom_divisor;
+	int	baud_base;
+	unsigned short	close_delay;
+	char	io_type;
+	char	reserved_char[1];
+	int	hub6;
+	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned short	closing_wait2; /* no longer used... */
+	__u32 iomem_base;
+	unsigned short	iomem_reg_shift;
+	unsigned int	port_high;
+	int	reserved[1];
+};
+
+static int serial_struct_ioctl(unsigned fd, unsigned cmd,  void *ptr) 
+{
+	typedef struct serial_struct SS;
+	struct serial_struct32 *ss32 = ptr; 
+	int err;
+	struct serial_struct ss; 
+	mm_segment_t oldseg = get_fs(); 
+	if (cmd == TIOCSSERIAL) { 
+		if (copy_from_user(&ss, ss32, sizeof(struct serial_struct32)))
+			return -EFAULT;
+		memmove(&ss.iomem_reg_shift, ((char*)&ss.iomem_base)+4, 
+			sizeof(SS)-offsetof(SS,iomem_reg_shift)); 
+		ss.iomem_base = (void *)((unsigned long)ss.iomem_base & 0xffffffff);
+	}
+	set_fs(KERNEL_DS);
+		err = sys_ioctl(fd,cmd,(unsigned long)(&ss)); 
+	set_fs(oldseg);
+	if (cmd == TIOCGSERIAL && err >= 0) { 
+		if (__copy_to_user(ss32,&ss,offsetof(SS,iomem_base)) ||
+		    __put_user((unsigned long)ss.iomem_base  >> 32 ? 
+			       0xffffffff : (unsigned)(unsigned long)ss.iomem_base,
+			       &ss32->iomem_base) ||
+		    __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift) ||
+		    __put_user(ss.port_high, &ss32->port_high))
+			return -EFAULT;
+	} 
+	return err;	
+}
+
+static void __init init_compat(void)
+{
+    register_ioctl32_conversion(TIOCGSERIAL, serial_struct_ioctl);
+    register_ioctl32_conversion(TIOCSSERIAL, serial_struct_ioctl);
+}
+
+__initcall(init_compat);
+#endif
+
 static void uart_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;

%diffstat
 drivers/serial/core.c        |   60 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/compat_ioctl.h |    3 +-
 2 files changed, 62 insertions(+), 1 deletion(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
