From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH v2 5/7] tty: Add NOKERNINFO lflag to termios
Date: Tue, 25 Jun 2019 19:11:51 +0300
Message-ID: <20190625161153.29811-6-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/ia64/include/uapi/asm/termbits.h    | 1 +
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 arch/xtensa/include/uapi/asm/termbits.h  | 1 +
 include/linux/tty.h                      | 1 +
 include/uapi/asm-generic/termbits.h      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index bb895d467033..850dd8dc4c51 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -204,6 +204,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 86898e4c5905..f777b99bc5ab 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -190,6 +190,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index 3dd60924f0ef..2755cfd1497e 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -206,6 +206,7 @@ struct ktermios {
 #define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
 #define ITOSTOP TOSTOP
 #define EXTPROC 0200000		/* External processing on pty */
+#define NOKERNINFO 0400000		/* Disable kernel output from VSTATUS. */
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index ecca3b7d0c66..c7ba145adf02 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -183,6 +183,7 @@ struct ktermios {
 #define PENDIN  0040000
 #define IEXTEN  0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index c85e98d75e76..79dbcc546217 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -192,6 +192,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index a1638c9cde8b..108c039ddefb 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -225,6 +225,7 @@ struct ktermios {
 #define PENDIN	0x00004000
 #define IEXTEN	0x00008000
 #define EXTPROC	0x00010000
+#define NOKERNINFO	0x00020000
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/arch/xtensa/include/uapi/asm/termbits.h b/arch/xtensa/include/uapi/asm/termbits.h
index 77969cb275b8..6155e1c81164 100644
--- a/arch/xtensa/include/uapi/asm/termbits.h
+++ b/arch/xtensa/include/uapi/asm/termbits.h
@@ -199,6 +199,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 38d8ffe7f0e3..07189f18f93d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -186,6 +186,7 @@ struct tty_bufhead {
 #define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
 #define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
+#define L_NOKERNINFO(tty)	_L_FLAG((tty), NOKERNINFO)
 
 struct device;
 struct signal_struct;
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 11bb142ba844..6219803d6f4d 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -181,6 +181,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.20.1
