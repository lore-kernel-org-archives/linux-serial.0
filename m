From: Corbin <corbinat@gmail.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Wed, 23 May 2012 09:37:31 -0500
Message-ID: <CAA0x6_-aq2CZzz1dU7Re-GwyW2jeE-frCC38mHY6o4AG6vrvMw@mail.gmail.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com>
 <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
 <20120515172710.0d0ce47b@pyramind.ukuu.org.uk> <CAA0x6_9dTE6zFaJOAqsrj2OcehARKG9KgicQPdf1yv2RjDbZwA@mail.gmail.com>
 <20120515220831.11f04213@bob.linux.org.uk> <CAA0x6_8mPs_JLxnjrzNYc4qej-c0kkhbVyuJPsaPg8xBvmThqQ@mail.gmail.com>
 <OF12D97EE0.DCA5956B-ON86257A05.00532260-86257A05.00537F9F@ni.com>
 <20120521170553.7822c01c@pyramind.ukuu.org.uk> <CAA0x6__sgnqhCXiSR29qnqKhGZrLuOa7siQcBJM7-UnkSn2Jtw@mail.gmail.com>
 <4FBBF93B.1000206@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57675 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab2EWOhw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 May 2012 10:37:52 -0400
Received: by dady13 with SMTP id y13so9835618dad.19
        for <linux-serial@vger.kernel.org>; Wed, 23 May 2012 07:37:51 -0700 (PDT)
In-Reply-To: <4FBBF93B.1000206@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jason Smith <jason.smith@ni.com>, Alan Cox <alan@linux.intel.com>, Corbin Atkinson <corbin.atkinson@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Tue, May 22, 2012 at 3:38 PM, Jiri Slaby <jslaby@suse.cz> wrote:

> That it is perfectly concealed.
>
> (I'm not subscribed to linux-serial and cannot find it anywhere. A link
> would be appreciated...)

Oh, sorry about that. Here is an archived version of the email thread:
http://www.spinics.net/lists/linux-serial/msg06104.html
I'll also copy and paste my patch here:

Currently, serial drivers don't report buffer overruns. When a buffer overrun
occurs, tty_insert_flip_char returns 0, and no attempt is made to insert that
same character again (i.e. it is lost). This patch reports buffer overruns via
the buf_overrun field in the port's icount structure.

Signed-off-by: Corbin Atkinson <corbin.atkinson@xxxxxx>
---
 drivers/tty/serial/serial_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c4c05b..59fb3ba 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2526,14 +2526,16 @@ void uart_insert_char(struct uart_port *port,
unsigned int status,
 	struct tty_struct *tty = port->state->port.tty;

 	if ((status & port->ignore_status_mask & ~overrun) == 0)
-		tty_insert_flip_char(tty, ch, flag);
+		if (tty_insert_flip_char(tty, ch, flag) == 0)
+			++port->icount.buf_overrun;

 	/*
 	 * Overrun is special.  Since it's reported immediately,
 	 * it doesn't affect the current character.
 	 */
 	if (status & ~port->ignore_status_mask & overrun)
-		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		if (tty_insert_flip_char(tty, 0, TTY_OVERRUN) == 0)
+			++port->icount.buf_overrun;
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);

-- 
1.7.5.4
