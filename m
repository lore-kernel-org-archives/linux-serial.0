From: Julien BLACHE <jblache@debian.org>
Subject: Re: [PATCH] IP22: fix serial console hangs
Date: Sun, 09 Jul 2006 20:40:17 +0200
Message-ID: <873bdamxke.fsf@frigate.technologeek.org>
References: <87irm6naxt.fsf@frigate.technologeek.org>
	<20060709175841.GB24958@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from frigate.technologeek.org ([62.4.21.148]:63971 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S1161042AbWGISkQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jul 2006 14:40:16 -0400
In-Reply-To: <20060709175841.GB24958@deprecation.cyrius.com> (Martin
	Michlmayr's message of "Sun, 9 Jul 2006 19:58:41 +0200")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

--=-=-=

Martin Michlmayr <tbm@cyrius.com> wrote:

Hi,

>> The patch below fixes serial console hangs as seen on IP22
>> machines. Typically, while booting, the machine hangs for ~1 minute
>
> Thanks for tracking this down.  You've to send the patch to
> rmk+serial@arm.linux.org.uk and linux-serial@vger.kernel.org
> though.

Here it is for the serial hackers, then ;)



The patch below fixes serial console hangs as seen on IP22
machines. Typically, while booting, the machine hangs for ~1 minute
displaying "INIT: ", then the same thing happens again when init
enters in the designated runlevel and finally the getty process on
ttyS0 hangs indefinitely (though strace'ing it helps).

strace (-e raw=ioctl, otherwise the ioctl() translation is utterly
bogus) reveals that getty hangs on ioctl() 0x540f which happens to be
TCSETSW (I saw it hang on another console ioctl() but couldn't
reproduce that one).

A diff between ip22zilog and sunzilog revealed the following
differences:
 1. the channel A flag being set on up.port.flags instead of up.flags
 2. the channel A flag being set on what is marked as being channel B
 3. sunzilog has a call to uart_update_timeout(port, termios->c_cflag, baud);
    at the end of sunzilog_set_termios(), which ip22zilog lacks (on
    purpose ?)

The patch below addresses point 1 and fixes the serial console hangs
just fine. However point 2 should be investigated by someone familiar
with the IP22 Zilog; it's probably OK as is but even if it is, a
comment in ip22zilog.c is badly needed.

Point 3 is left as an exercise for whoever feels like digging into
ip22zilog :)

These are the main obvious differences between ip22zilog and
sunzilog. Newer versions of sunzilog (Linus's git tree as of today)
are more close to ip22zilog as the sbus_{write,read}b have been
changed into simple {write,read}b, which shrinks the diff by a fair
amount. Resyncing both drivers should be doable in a few hours time
now for someone familiar with the IP22 Zilog hardware.


Additional point: the IP22 thinks it's using the console on the
framebuffer when booting, when it's really using the serial console
(console=ttyS passed at boot, console=d, consoleOut=serial(0))


Please apply, along with the RTC typo fix from yesterday.

Thanks,

JB.

---
IP22: fix serial console hang due to a typo in ip22zilog.c

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ip22zilog-channel-A-flag.patch
Content-Description: fix for IP22 serial console hangs

--- source-mips-none/drivers/serial/ip22zilog.c	2006-06-18 03:49:35.000000000 +0200
+++ source/drivers/serial/ip22zilog.c	2006-07-09 14:25:11.847260358 +0200
@@ -1145,9 +1145,8 @@
 		up[(chip * 2) + 1].port.fifosize = 1;
 		up[(chip * 2) + 1].port.ops = &ip22zilog_pops;
 		up[(chip * 2) + 1].port.type = PORT_IP22ZILOG;
-		up[(chip * 2) + 1].port.flags |= IP22ZILOG_FLAG_IS_CHANNEL_A;
 		up[(chip * 2) + 1].port.line = (chip * 2) + 1;
-		up[(chip * 2) + 1].flags = 0;
+		up[(chip * 2) + 1].flags |= IP22ZILOG_FLAG_IS_CHANNEL_A;
 	}
 }
 

--=-=-=



-- 
 Julien BLACHE <jblache@debian.org>  |  Debian, because code matters more 
 Debian & GNU/Linux Developer        |       <http://www.debian.org>
 Public key available on <http://www.jblache.org> - KeyID: F5D6 5169 
 GPG Fingerprint : 935A 79F1 C8B3 3521 FD62 7CC7 CD61 4FD7 F5D6 5169 

--=-=-=--
