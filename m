From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] termios: Enable new style termios ioctls on x86-64
Date: Wed, 08 Nov 2006 20:34:52 +0000
Message-ID: <1163018092.23956.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423245AbWKHUaO@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This turns on the split input/output speed features and arbitary baud
rate handling for the x86-64 platform. Nothing should break if you use
existing standard speeds. If you use the new speed stuff then you may
see some drivers failing to report the speed changes properly in error
cases. This will be worked on further. For the working cases this all
seems happy. I'll post a test suite used to test the basic stuff as
well.

Patches for i386 will follow when I get a moment but are basically the
same. If people could patch/test-suite other architectures and submit
them that would be great.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/ioctls.h linux-2.6.19-rc4-mm1/include/asm-x86_64/ioctls.h
--- linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/ioctls.h	2006-10-31 15:40:49.000000000 +0000
+++ linux-2.6.19-rc4-mm1/include/asm-x86_64/ioctls.h	2006-11-03 13:32:07.000000000 +0000
@@ -46,6 +46,10 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T',0x2A, struct termios2)
+#define TCSETS2		_IOW('T',0x2B, struct termios2)
+#define TCSETSW2	_IOW('T',0x2C, struct termios2)
+#define TCSETSF2	_IOW('T',0x2D, struct termios2)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/termbits.h linux-2.6.19-rc4-mm1/include/asm-x86_64/termbits.h
--- linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/termbits.h	2006-10-31 21:11:50.000000000 +0000
+++ linux-2.6.19-rc4-mm1/include/asm-x86_64/termbits.h	2006-11-03 13:30:19.000000000 +0000
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct termios2 {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 struct ktermios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -129,6 +140,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define	   BOTHER 0010000		/* non standard rate */
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
@@ -144,10 +156,12 @@
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CIBAUD	  002003600000	/* input baud rate */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define IBSHIFT	  8		/* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define ISIG	0000001
 #define ICANON	0000002
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/termios.h linux-2.6.19-rc4-mm1/include/asm-x86_64/termios.h
--- linux.vanilla-2.6.19-rc4-mm1/include/asm-x86_64/termios.h	2006-10-31 15:40:49.000000000 +0000
+++ linux-2.6.19-rc4-mm1/include/asm-x86_64/termios.h	2006-11-03 13:31:26.000000000 +0000
@@ -98,8 +98,10 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
+#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
 
 #endif	/* __KERNEL__ */
 
