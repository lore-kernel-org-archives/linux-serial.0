From: Joe Millenbach <jmillenbach@gmail.com>
Subject: Fwd: [PATCH] tty: Added a CONFIG_TTY option to allow removal of TTY
Date: Thu, 23 Aug 2012 18:14:48 -0700
Message-ID: <CADwDc1BgCM9AA4T3mUxfOGNaNoYwERP-x4y2ZS4mAhfF-K_qzA@mail.gmail.com>
References: <1345499431-21658-1-git-send-email-jmillenbach@gmail.com>
	<20120821142047.777e4bb0@pyramind.ukuu.org.uk>
	<CADwDc1AvCvWbj8znN-1WbkZA9WYVAqaTkxi7+ENZfJ-qFNRAvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADwDc1AvCvWbj8znN-1WbkZA9WYVAqaTkxi7+ENZfJ-qFNRAvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, team-fjord@googlegroups.com
List-Id: linux-serial@vger.kernel.org

---------- Forwarded message ----------
From: Joe Millenbach <jmillenbach@gmail.com>
Date: Thu, Aug 23, 2012 at 5:56 PM
Subject: Re: [PATCH] tty: Added a CONFIG_TTY option to allow removal of TTY
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox
<alan@linux.intel.com>, linux-serial@vger.kernel.org,
linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
team-fjord@googlegroups.com


On Tue, Aug 21, 2012 at 6:20 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> ...
>
> >  config MOUSE_PS2
> >       tristate "PS/2 mouse"
> > +     depends on TTY
>
> It shouldn't. It would be good to understand why this occurs.


If I enable this config option, and turn off TTY I get the below errors.

drivers/built-in.o: In function `serport_ldisc_read':
serport.c:(.text+0x1aace6): undefined reference to `tty_name'
serport.c:(.text+0x1aad57): undefined reference to `tty_name'
drivers/built-in.o: In function `serport_init':
serport.c:(.init.text+0x8478): undefined reference to `tty_register_ldisc'
drivers/built-in.o: In function `serport_exit':
serport.c:(.exit.text+0xb29): undefined reference to `tty_unregister_ldisc'

All because MOUSE_PS2 depends on SERIO, just like a lot of entries I
blocked.  I assume this means I should keep the dependency on TTY.
Unfortunately, I don't have time to dig deeper for the true cause of the
dependency right now.

- Joe


* Resending message as I forgot to turn off HTML messaging in Gmail
(sorry), and I've heard SPAM blockers might eat HTML messages sent to
LKML people.

- Joe
