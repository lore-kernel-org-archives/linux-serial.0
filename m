From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Wed, 31 May 2017 16:04:20 +0100
Message-ID: <20170531160420.3b173a4a@alans-desktop>
References: <CA+55aFwgiAmy4Gw4RosbNVBJmOG-WQoZKOd76Ziuqx5CzPFMZQ@mail.gmail.com>
        <20170413183403.GA16022@kroah.com>
        <CAOMGZ=G9t7ih=ydr=fkKn6cbgu5-qbdQs7XChmn=d598H95QVA@mail.gmail.com>
        <20170414123029.GA17217@kroah.com>
        <CACT4Y+acU1xTZEo+oeBvZL__c12bzcSPa0CBfDiw4j7+CUjfDg@mail.gmail.com>
        <CAOMGZ=GJah0GNXzscGGkYgScbZaeSM_TpxmrLZuxhrqWmBX9BQ@mail.gmail.com>
        <20170503120101.GA21119@kroah.com>
        <CACT4Y+arELXuPr7psYFETt6NrDNgeS=tP=jGhP4a0_C_8Fa=LA@mail.gmail.com>
        <20170530130905.382487d5@alans-desktop>
        <CACT4Y+aoRRao41hGpVkO+qVk9TB5ZSPiRpQxp7H9EN+RqW-1-Q@mail.gmail.com>
        <20170531111612.GA6332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531111612.GA6332@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Vegard Nossum <vegard.nossum@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 31 May 2017 20:16:12 +0900
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 31, 2017 at 10:39:23AM +0200, Dmitry Vyukov wrote:
> > On Tue, May 30, 2017 at 2:09 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:  
> > >> >> I'll think about possible solutions, but I have no prior experience
> > >> >> with the tty code. In the meantime syzkaller also hit a couple of
> > >> >> other fun tty/pty bugs including a write/ioctl race that results in
> > >> >> buffer overflow :-/  
> > >
> > > There are several of those, including some of that have been documented
> > > for years but nobody ever volunteered to fix - in particular all the
> > > interfaces that push characters to the tty other than via the normal
> > > interrupt receive path are dodgy (console selection in particular)
> > >
> > > The original tty model btw was that setting the ldisc to n_tty cannot
> > > fail, and the structure allocated was smaller than a page size so was
> > > safe.
> > >
> > > The simple way to fix it is to restore that behaviour by adding a 'null'
> > > ldisc that we can fail to instead of N_TTY since the N_TTY failback path
> > > is long broken.  
> > 
> > Greg, what do you think about this patch? Are you ready to accept
> > something like this?
> > Definitely shorter than changing all drivers.  
> 
> Yes, it looks reasonable to me.



Ok try this

commit f6db8de7eca11cfeafa92f2ec866fa75425c5f38
Author: Alan Cox <alan@llwyncelyn.cymru>
Date:   Tue May 30 12:59:45 2017 +0100

    tty: handle the case where we cannot restore a line discipline
    
    Historically the N_TTY driver could never fail but this has become broken over
    time. Rather than trying to rewrite half the ldisc layer to fix the breakage
    introduce a second level of fallback with an N_NULL ldisc which cannot fail,
    and thus restore the guarantees required by the ldisc layer.
    
    We still try and fail to N_TTY first. It's much more useful to find yourself
    back in your old ldisc (first attempt) or in N_TTY (second attempt), and while
    I'm not aware of any code out there that makes those assumptions it's good to
    drive(r) defensively.

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index f02becd..8689279 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
-				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o
+				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
+				   n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
new file mode 100644
index 0000000..d63261c
--- /dev/null
+++ b/drivers/tty/n_null.c
@@ -0,0 +1,80 @@
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/module.h>
+
+/*
+ *  n_null.c - Null line discipline used in the failure path
+ *
+ *  Copyright (C) Intel 2017
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+static int n_null_open(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static void n_null_close(struct tty_struct *tty)
+{
+}
+
+static ssize_t n_null_read(struct tty_struct *tty, struct file *file,
+			   unsigned char __user * buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
+			    const unsigned char *buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static void n_null_receivebuf(struct tty_struct *tty,
+				 const unsigned char *cp, char *fp,
+				 int cnt)
+{
+}
+
+static struct tty_ldisc_ops null_ldisc = {
+	.owner		=	THIS_MODULE,
+	.magic		=	TTY_LDISC_MAGIC,
+	.name		=	"n_null",
+	.open		=	n_null_open,
+	.close		=	n_null_close,
+	.read		=	n_null_read,
+	.write		=	n_null_write,
+	.receive_buf	=	n_null_receivebuf
+};
+
+static int __init n_null_init(void)
+{
+	BUG_ON(tty_register_ldisc(N_NULL, &null_ldisc));
+	return 0;
+}
+
+static void __exit n_null_exit(void)
+{
+	tty_unregister_ldisc(N_NULL);
+}
+
+module_init(n_null_init);
+module_exit(n_null_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alan Cox");
+MODULE_ALIAS_LDISC(N_NULL);
+MODULE_DESCRIPTION("Null ldisc driver");
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index f6ffe28..2fe216b 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -492,6 +492,29 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
+ *	tty_ldisc_failto	-	helper for ldisc failback
+ *	@tty: tty to open the ldisc on
+ *	@ld: ldisc we are trying to fail back to
+ *
+ *	Helper to try and recover a tty when switching back to the old
+ *	ldisc fails and we need something attached.
+ */
+
+static int tty_ldisc_failto(struct tty_struct *tty, int ld)
+{
+	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
+	int r;
+
+	if (IS_ERR(disc))
+		return PTR_ERR(disc);
+	tty->ldisc = disc;
+	tty_set_termios_ldisc(tty, ld);
+	if ((r = tty_ldisc_open(tty, disc)) < 0)
+		tty_ldisc_put(disc);
+	return r;
+}
+
+/**
  *	tty_ldisc_restore	-	helper for tty ldisc change
  *	@tty: tty to recover
  *	@old: previous ldisc
@@ -502,9 +525,6 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
-	struct tty_ldisc *new_ldisc;
-	int r;
-
 	/* There is an outstanding reference here so this is safe */
 	old = tty_ldisc_get(tty, old->ops->num);
 	WARN_ON(IS_ERR(old));
@@ -512,17 +532,13 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 	tty_set_termios_ldisc(tty, old->ops->num);
 	if (tty_ldisc_open(tty, old) < 0) {
 		tty_ldisc_put(old);
-		/* This driver is always present */
-		new_ldisc = tty_ldisc_get(tty, N_TTY);
-		if (IS_ERR(new_ldisc))
-			panic("n_tty: get");
-		tty->ldisc = new_ldisc;
-		tty_set_termios_ldisc(tty, N_TTY);
-		r = tty_ldisc_open(tty, new_ldisc);
-		if (r < 0)
-			panic("Couldn't open N_TTY ldisc for "
-			      "%s --- error %d.",
-			      tty_name(tty), r);
+		/* The traditional behaviour is to fall back to N_TTY, we
+		   want to avoid falling back to N_NULL unless we have no
+		   choice to avoid the risk of breaking anything */
+		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
+		    tty_ldisc_failto(tty, N_NULL) < 0)
+			panic("Couldn't open N_NULL ldisc for %s.",
+			      tty_name(tty));
 	}
 }
 
diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index e7855df..cf14553 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -36,5 +36,6 @@
 #define N_TRACEROUTER	24	/* Trace data routing for MIPI P1149.7 */
 #define N_NCI		25	/* NFC NCI UART */
 #define N_SPEAKUP	26	/* Speakup communication with synths */
+#define N_NULL		27	/* Null ldisc used for error handling */
 
 #endif /* _UAPI_LINUX_TTY_H */
