From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH v2 2/7] tty: termios: Reserve space for VSTATUS in .c_cc
Date: Tue, 25 Jun 2019 19:11:48 +0300
Message-ID: <20190625161153.29811-3-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
List-Id: linux-serial@vger.kernel.org

There was no architecture we had to increase NCCS on,
so the size of struct termios did not change.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/alpha/include/asm/termios.h         | 4 ++--
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/ia64/include/asm/termios.h          | 4 ++--
 arch/ia64/include/uapi/asm/termbits.h    | 1 +
 arch/mips/include/asm/termios.h          | 4 ++--
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/asm/termios.h        | 4 ++--
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/asm/termios.h       | 4 ++--
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/s390/include/asm/termios.h          | 4 ++--
 arch/sparc/include/asm/termios.h         | 4 ++--
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 arch/xtensa/include/uapi/asm/termbits.h  | 1 +
 include/asm-generic/termios.h            | 4 ++--
 include/uapi/asm-generic/termbits.h      | 1 +
 16 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index b7c77bb1bfd2..3f6e9995f415 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -8,9 +8,9 @@
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
 	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
 	start=^Q	stop=^S		lnext=^V	discard=^U
-	vmin=\1		vtime=\0
+	vmin=\1		vtime=\0	vstatus=^T
 */
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
+#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..bb895d467033 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -70,6 +70,7 @@ struct ktermios {
 #define VDISCARD 15
 #define VMIN 16
 #define VTIME 17
+#define VSTATUS 18
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c026444cc..b262e010baf2 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -15,9 +15,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 000a1a297c75..86898e4c5905 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -67,6 +67,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index bc29eeacc55a..9086e4f641f4 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -17,9 +17,9 @@
  *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
  *	start=^Q	stop=^S		susp=^Z		vdsusp=
  *	reprint=^R	discard=^U	werase=^W	lnext=^V
- *	eof=^D		eol=\0
+ *	eof=^D		eol=\0		status=^T
  */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
+#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0\024"
 
 #include <linux/string.h>
 
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..3dd60924f0ef 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -78,6 +78,7 @@ struct ktermios {
 #define VLNEXT		15		/* Literal-next character [IEXTEN].  */
 #define VEOF		16		/* End-of-file character [ICANON].  */
 #define VEOL		17		/* End-of-line character [ICANON].  */
+#define VSTATUS		18		/* Status request character [ISIG]. */
 
 /* c_iflag bits */
 #define IGNBRK	0000001		/* Ignore break condition.  */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90c1b..37828b15a428 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -9,9 +9,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..ecca3b7d0c66 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 
 /* c_iflag bits */
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index 205de8f8a9d3..263707fc3ec9 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -10,8 +10,8 @@
 
 #include <uapi/asm/termios.h>
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
+/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  ^T  */
+#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025\024"
 
 #include <asm-generic/termios-base.h>
 
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f63d..c85e98d75e76 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -62,6 +62,7 @@ struct ktermios {
 #define VSTOP		14
 #define VLNEXT		15
 #define VDISCARD	16
+#define VSTATUS		17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 46fa3020b41e..c84e49ed76b4 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -14,9 +14,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 4a558efdfa93..249c95cf285b 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -20,9 +20,9 @@
 	eof=^D		eol=\0		eol2=\0		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		dsusp=^Y
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	vmin=\1         vtime=\0
+	vmin=\1		vtime=\0	status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
+#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001\000\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..a1638c9cde8b 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -80,6 +80,7 @@ struct ktermios {
 #define VDISCARD 13
 #define VWERASE  14
 #define VLNEXT   15
+#define VSTATUS  16
 
 /* Kernel keeps vmin/vtime separated, user apps assume vmin/vtime is
  * shared with eof/eol
diff --git a/arch/xtensa/include/uapi/asm/termbits.h b/arch/xtensa/include/uapi/asm/termbits.h
index d4206a7c5138..77969cb275b8 100644
--- a/arch/xtensa/include/uapi/asm/termbits.h
+++ b/arch/xtensa/include/uapi/asm/termbits.h
@@ -72,6 +72,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4a1d..06fbfb87c991 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -10,9 +10,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..11bb142ba844 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
-- 
2.20.1
