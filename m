From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Wed, 26 Oct 2016 18:09:03 +0200
Message-ID: <20161026160903.vkucyecu5r2pxik3@piout.net>
References: <20161025161135.7316-1-richard.genoud@gmail.com>
 <20161025171754.a4lult2ld3gv5a2q@pengutronix.de>
 <f89c29e4-b68f-a8ea-cefb-e70dda6739a0@gmail.com>
 <20161026153548.xxvciigcscrjb5uv@piout.net>
 <CACQ1gAhfSQG1_otKjvQUiXCajfZvOM-=VqhyKs1D+fXEU9eCnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAhfSQG1_otKjvQUiXCajfZvOM-=VqhyKs1D+fXEU9eCnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 26/10/2016 at 17:51:07 +0200, Richard Genoud wrote :
> 2016-10-26 17:35 GMT+02:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> > Richard,
> >
> > On 26/10/2016 at 16:55:02 +0200, Richard Genoud wrote :
> >> On 25/10/2016 19:17, Uwe Kleine-König wrote:
> >> Quote from the commit message:
> >> "   Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> >>     hardware handshake is enabled") actually allowed to enable hardware
> >>     handshaking.
> >>     Before, the CRTSCTS flags was silently ignored.
> >> "
> >> This wasn't true.
> >> This was a misunderstanding of the ATMEL_US_USMODE_HWHS flag:
> >> Commit 1cf6e8fc8341 didn't allowed to enable hardware handshaking, but
> >> introduced the ATMEL_US_USMODE_HWHS flag.
> >> And before 1cf6e8fc8341, the CRTSCTS flags wasn't silently ignored, it
> >> was perfectly respected.
> >>
> >
> > It was not really a misunderstanding, it is a difference in
> > expectations. There is one topic on which we don't agree and I'm fine
> > with your solution as long as I don't have to support people with the
> > failures (hence my ack). My (and Cyrille's) opinion is that CRTSCTS has
> > to be 100% reliable and this is only possible with assistance from the
> > hardware. That's why I wanted to report when HW didn't have proper
> > support to userspace.
> > On your side you are fine with software handling of RTS and CTS (which
> > is a feature that worked before our patches). You just have to remember
> > that at some point because of latencies and the way the IPs are clocked,
> > this will fail and you'll start losing bytes.
> >
> > Again, I'm fine with that but I won't handle people complaining about it
> > :)
> 
> So you broke this on purpose ?
> Without saying so in the commit message ?
> Nice to know.

No, I didn't think about that use case at the time and I understood
after you explanations. I wouldn't have removed an existing
functionality like that.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
