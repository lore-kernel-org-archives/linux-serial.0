From: Arseny Maslennikov <ar@cs.msu.ru>
Subject: [PATCH v2 1/7] signal.h: Define SIGINFO on all architectures
Date: Tue, 25 Jun 2019 19:11:47 +0300
Message-ID: <20190625161153.29811-2-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir D. Seleznev" <vseleznv@altlinux.org>, Rob Landley <rob@landley.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
List-Id: linux-serial@vger.kernel.org

This complementary patch defines SIGINFO as a synonym for SIGPWR
on every architecture supported by the kernel.
The particular signal number chosen does not really matter and is only
required for the related tty functionality to work properly,
so if it does not suite expectations, any suggestions are warmly
welcome.

SIGPWR looks like a nice candidate for this role, because it is
defined on every supported arch and is already defined as a synonym
for SIGINFO on alpha; SIGPWR is currently only used to inform
PID 1 of power failures, and daemons that care about low-level
events do not tend to have a controlling terminal.

However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
to that architecture, with a narrow set of intended uses that do not
combine well with interactively requesting status.
SIGLOST is not used by any kernel code at the moment.
I'm not sure there is a more reasonable alternative right now.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/arm/include/uapi/asm/signal.h     | 1 +
 arch/h8300/include/uapi/asm/signal.h   | 1 +
 arch/ia64/include/uapi/asm/signal.h    | 1 +
 arch/m68k/include/uapi/asm/signal.h    | 1 +
 arch/mips/include/uapi/asm/signal.h    | 1 +
 arch/parisc/include/uapi/asm/signal.h  | 1 +
 arch/powerpc/include/uapi/asm/signal.h | 1 +
 arch/s390/include/uapi/asm/signal.h    | 1 +
 arch/sparc/include/uapi/asm/signal.h   | 2 ++
 arch/x86/include/uapi/asm/signal.h     | 1 +
 arch/xtensa/include/uapi/asm/signal.h  | 1 +
 include/uapi/asm-generic/signal.h      | 1 +
 12 files changed, 13 insertions(+)

diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 9b4185ba4f8a..b80b53a17267 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index e15521037348..7a2b783af22b 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index aa98ff1b9e22..b4c98cb17165 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -45,6 +45,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 /* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
 #define	SIGUNUSED	31
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index 915cc755a184..a0b4e4108cb8 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index 53104b10aae2..975a6f0d3b0b 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -43,6 +43,7 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #define SIGCHLD		18	/* Child status has changed (POSIX).  */
 #define SIGCLD		SIGCHLD /* Same as SIGCHLD (System V).	*/
 #define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGINFO		SIGPWR	/* Keyboard status request (4.2 BSD). */
 #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
 #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
 #define SIGIO		22	/* I/O now possible (4.2 BSD).	*/
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index d38563a394f2..fe2e00d590ac 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -22,6 +22,7 @@
 #define SIGUSR2		17
 #define SIGCHLD		18
 #define SIGPWR		19
+#define SIGINFO		SIGPWR
 #define SIGVTALRM	20
 #define SIGPROF		21
 #define SIGIO		22
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 85b0a7aa43e7..e7f3885905b4 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -53,6 +53,7 @@ typedef struct {
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 9a14a611ed82..12ee62987971 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -58,6 +58,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST         29
 */
 #define SIGPWR          30
+#define SIGINFO         SIGPWR
 #define SIGSYS		31
 #define SIGUNUSED       31
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index ff9505923b9a..b655163198bb 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -71,6 +71,8 @@
 #define SIGWINCH	28
 #define SIGLOST		29
 #define SIGPWR		SIGLOST
+/* XXX: is it OK for SIGINFO to collide with LOST? */
+#define SIGINFO		SIGPWR
 #define SIGUSR1		30
 #define SIGUSR2		31
 
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index e5745d593dc7..1539bb28826c 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -55,6 +55,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 005dec5bfde4..d644234305de 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -65,6 +65,7 @@ typedef struct {
 #define SIGPOLL		SIGIO
 /* #define SIGLOST		29 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 5c716a952cbe..9f9a1db0d43c 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -43,6 +43,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
-- 
2.20.1
