From: Bob Bell <bbell@users.sourceforge.net>
Subject: Serial driver related problems on Linux
Date: Thu, 10 Mar 2005 10:41:27 -0500
Message-ID: <20050310154125.GB12846@magick.macroped.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Received: from srv01.macroped.com ([207.44.188.8]:56706 "EHLO
	srv01.macroped.com") by vger.kernel.org with ESMTP id S262665AbVCJPlb
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Mar 2005 10:41:31 -0500
Received: from bells.yi.org (68-235-8-202.lndnnh.adelphia.net [68.235.8.202])
	(authenticated bits=0)
	by srv01.macroped.com (8.12.11/8.12.11) with ESMTP id j2AFfOqu017916
	for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2005 10:41:24 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ted, Russell, whomever,

I'm contacting you because I'm experiencing a problem on Linux with a
serial line, and I've traced the problem as far as the Linux kernel.
I'm hoping that this is the best way to further troubleshoot this
problem; I noted that Ted T'so is listed as the maintainer for the 2.4
series (I'm running a 2.4.21 kernel) and Russell for the 2.6 series, so
I'm hoping a message sent to this mailing list gets the attention of
whomever is currently actively maintaining the serial/tty code.

The user-visible symptoms of this problem are that after typing in a
username and hitting enter, the serial login prompt hangs.  I've traced
this hang to an ioctl in the login code (TCSETSF, a result of calling
tcsetattr(,TCSAFLUSH,)).  I've further traced that ioctl to being stuck
in tty_wait_until_sent().

As part of debugging this problem, I've attempted to #define
TTY_DEBUG_WAIT_UNTIL_SENT and SERIAL_DEBUG_RS_WAIT_UNTIL_SENT.  However,
the printk()s that these #defines add make the problem go away.
Similarly, adding any of my own printk()s make the problem go away.
Therefore, I've instead mimicked the printk()s with calls to my own
routine (dbg_addmsg()) to add the same output to an in-kernel buffer.
It's a quick hack, but the problem does indeed persist with this
debugging technique, and it captures what the printk() output, with
which you may be familiar, would have been.  I've attached my changes as
linux.tty_debug.patch; hopefully, they are very straight-forward.

The debugging output has a lot of references to "pts", which is not
surprising as I'm running `crash`, etc. from an ssh login.  Filtering
those out leaves the following from the time of the login:
    ttyS wait until sent...
    waiting ttyS...(1)
    waiting ttyS...(62)
    interrupted

There is a long delay between "(1)" and "(62)".  This delay corresponds
to the amount of time login has set for SIGALRM.  I've bumped this time
from 1 minute to 5 minutes.  After 5 minutes of waiting, the wait is
finally interrupted by the signal, as indicated by the "interrupted"
output line that I added (not in the original debug printk()s).  During
this time, there is no output from rs_wait_until_sent().  I've attached
the output with all "pts" lines filtered out as "output.nonpts".

Do you have any idea what could be going on here?  I've put in notable
time getting this far, and I'm willing to work with whomever to further
debug this problem.  I've also attached the output of `lspci -v` as
'lspci.out', so that you can get an idea as to the type of hardware I'm
dealing with.

Thank you for your time.

    -- Bob

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux.tty_debug.patch"

diff -rup --exclude '*SCCS*' --exclude BitKeeper linux.orig/drivers/char/serial.c linux/drivers/char/serial.c
--- linux.orig/drivers/char/serial.c	Wed Mar  9 17:47:18 2005
+++ linux/drivers/char/serial.c	Wed Mar  9 16:40:09 2005
@@ -265,6 +265,9 @@ static int serial_refcount;
 
 static struct timer_list serial_timer;
 
+extern pid_t watched_pid;
+extern void dbg_addmsg(char *fmt, ...);
+
 /* serial subtype definitions */
 #ifndef SERIAL_TYPE_NORMAL
 #define SERIAL_TYPE_NORMAL	1
@@ -2945,10 +2948,13 @@ static void rs_wait_until_sent(struct tt
 	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
 	printk("jiff=%lu...", jiffies);
 #endif
+	dbg_addmsg("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
+	dbg_addmsg("jiff=%lu...", jiffies);
 	while (!((lsr = serial_inp(info, UART_LSR)) & UART_LSR_TEMT)) {
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
+		dbg_addmsg("lsr = %d (jiff=%lu)...", lsr, jiffies);
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
@@ -2959,6 +2965,7 @@ static void rs_wait_until_sent(struct tt
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 #endif
+	dbg_addmsg("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
 }
 
 /*
diff -rup --exclude '*SCCS*' --exclude BitKeeper linux.orig/drivers/char/tty_ioctl.c linux/drivers/char/tty_ioctl.c
--- linux.orig/drivers/char/tty_ioctl.c	Wed Mar  9 17:47:18 2005
+++ linux/drivers/char/tty_ioctl.c	Wed Mar  9 17:15:31 2005
@@ -25,6 +25,16 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+char dbg_msgbuf[1024*128] = { '\0' };
+char *dbg_msgcur = dbg_msgbuf;
+void dbg_addmsg(char *fmt, ...) {
+    va_list args;
+    va_start(args, fmt);
+    dbg_msgcur += vsprintf(dbg_msgcur, fmt, args);
+    va_end(args);
+}
+
+
 #undef TTY_DEBUG_WAIT_UNTIL_SENT
 
 #undef	DEBUG
@@ -40,11 +50,12 @@ void tty_wait_until_sent(struct tty_stru
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
 	char buf[64];
+#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
 	
 	printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
 #endif
+	dbg_addmsg("%s wait until sent...\n", tty_name(tty, buf));
 	if (!tty->driver.chars_in_buffer)
 		return;
 	add_wait_queue(&tty->write_wait, &wait);
@@ -55,13 +66,19 @@ void tty_wait_until_sent(struct tty_stru
 		printk(KERN_DEBUG "waiting %s...(%d)\n", tty_name(tty, buf),
 		       tty->driver.chars_in_buffer(tty));
 #endif
+		dbg_addmsg("waiting %s...(%d)\n", tty_name(tty, buf),
+			   tty->driver.chars_in_buffer(tty));
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			dbg_addmsg("interrupted\n");
 			goto stop_waiting;
+		}
 		if (!tty->driver.chars_in_buffer(tty))
 			break;
 		timeout = schedule_timeout(timeout);
 	} while (timeout);
+	dbg_addmsg("done waiting %s...(%d)\n", tty_name(tty, buf),
+		   tty->driver.chars_in_buffer(tty));
 	if (tty->driver.wait_until_sent)
 		tty->driver.wait_until_sent(tty, timeout);
 stop_waiting:

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="output.nonpts"

ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1819...lsr = 96 (jiff=1819)...done
In rs_wait_until_sent(3) check=1...jiff=1819...lsr = 96 (jiff=1819)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1819...lsr = 96 (jiff=1819)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1819...lsr = 96 (jiff=1819)...done
In rs_wait_until_sent(3) check=1...jiff=1819...lsr = 96 (jiff=1819)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1822...lsr = 0 (jiff=1822)...lsr = 96 (jiff=1823)...done
In rs_wait_until_sent(3) check=1...jiff=1823...lsr = 96 (jiff=1823)...done
ttyS wait until sent...
waiting ttyS...(4)
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1824...lsr = 0 (jiff=1824)...lsr = 0 (jiff=1825)...lsr = 96 (jiff=1826)...done
In rs_wait_until_sent(3) check=1...jiff=1826...lsr = 96 (jiff=1826)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1826...lsr = 0 (jiff=1826)...lsr = 96 (jiff=1827)...done
In rs_wait_until_sent(3) check=1...jiff=1827...lsr = 96 (jiff=1827)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
In rs_wait_until_sent(6) check=1...jiff=1828...lsr = 96 (jiff=1828)...done
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
ttyS wait until sent...
waiting ttyS...(0)
done waiting ttyS...(0)
ttyS wait until sent...
waiting ttyS...(1)
waiting ttyS...(62)
interrupted

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.out"

00:00.0 Host bridge: Intel Corporation: Unknown device 2560 (rev 01)
	Subsystem: Intel Corporation: Unknown device 2560
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [1105]

00:02.0 VGA compatible controller: Intel Corporation: Unknown device 2562 (rev 01) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 2562
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Memory at ec100000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corporation: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 24c2
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corporation: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 24c2
	Flags: bus master, medium devsel, latency 0, IRQ 3
	I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corporation: Unknown device 24c7 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 24c2
	Flags: bus master, medium devsel, latency 0, IRQ 7
	I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corporation: Unknown device 24cd (rev 01) (prog-if 20)
	Subsystem: Intel Corporation: Unknown device 24cd
	Flags: bus master, medium devsel, latency 0, IRQ 5
	Memory at ec180000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ec000000-ec0fffff

00:1f.0 ISA bridge: Intel Corporation: Unknown device 24c0 (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 24cb (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation: Unknown device 24c2
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f000 [size=16]
	Memory at 7f800000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation: Unknown device 24c3 (rev 01)
	Subsystem: Intel Corporation: Unknown device 24c2
	Flags: medium devsel, IRQ 9
	I/O ports at 0500 [size=32]

01:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 10)
	Subsystem: Intel Corporation: Unknown device 1040
	Flags: bus master, medium devsel, latency 32, IRQ 12
	Memory at ec0a1000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c000 [size=64]
	Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2

01:04.0 Ethernet controller: Intel Corporation: Unknown device 100e (rev 02)
	Subsystem: Intel Corporation: Unknown device 002e
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at ec020000 (32-bit, non-prefetchable) [size=128K]
	Memory at ec040000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at c400 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

01:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 10)
	Subsystem: Intel Corporation: Unknown device 1040
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at ec0a0000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c800 [size=64]
	Memory at ec080000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2


--BOKacYhQ+x31HxR3--
