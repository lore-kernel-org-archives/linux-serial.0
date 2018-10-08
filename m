From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH stable v2 2/2] termios, tty/tty_baudrate.c: simplify,
 auto-generate baud table
Date: Mon, 8 Oct 2018 10:29:52 -0700
Message-ID: <f069ac14-a067-49d7-a838-8f0cad2e706d@zytor.com>
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-3-hpa@zytor.com> <20181008154655.GE3332@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------16E7F5314AD1487554F5F572"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008154655.GE3332@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Eugene Syromiatnikov <esyr@redhat.com>, linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------16E7F5314AD1487554F5F572
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 10/8/18 8:46 AM, Johan Hovold wrote:
>
> So we need a minimal fix for this only as this patch in particular
> should not be backported to stable.
> 
> I'm not sure when I'll have time to review this one thoroughly, so
> perhaps others can chime in meanwhile.
> 
> Johan
> 

OK.  In the past Greg has generally liked to avoid fixes which will diverge
from upstream (because code in stable which is not in upstream can make
debugging difficult), but this is the minimal patch as requested; which to
apply is up to Greg.

As far as reviewing the cleanup patch, I strongly recommend:

a) Looking at the resulting file, not at the patch. Most of the code is simply
   merging the input and output rate functions into a common help function,
   and restructuring the code to that the utterly bizarre coding of a for loop
   using a do { ... } while() loop with the initial condition set at variable
   declaration(!!) far from the loop itself.
b) Examine bmacros.h after a build.
c) Build drivers/tty/tty_baudrate.s.  You can directly examine the baud_table
   and verify that it is, indeed, correct for whatever architecture you build.

	-hpa

--------------16E7F5314AD1487554F5F572
Content-Type: text/x-patch;
 name="0002-termios-tty-tty_baudrate.c-fix-buffer-overrun.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-termios-tty-tty_baudrate.c-fix-buffer-overrun.patch"

>From c8195635f63508f4c75ef553b4703c4cc3c750e2 Mon Sep 17 00:00:00 2001
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 8 Oct 2018 09:32:00 -0700
Subject: [PATCH 02/16] termios, tty/tty_baudrate.c: fix buffer overrun

On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in tty_baudrate.c does
not do any limit checking on the tty_baudrate[] array, and in fact a
buffer overrun is possible on both architectures. Add a limit check to
prevent that situation.

This will be followed by a much bigger cleanup/simplification patch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Requested-by: Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <stable@vger.kernel.org>
---
 drivers/tty/tty_baudrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 7576ceace571..f438eaa68246 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -77,7 +77,7 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 }
 EXPORT_SYMBOL(tty_termios_baud_rate);
 
@@ -113,7 +113,7 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 #else	/* IBSHIFT */
 	return tty_termios_baud_rate(termios);
 #endif	/* IBSHIFT */
-- 
2.17.1


--------------16E7F5314AD1487554F5F572--
