From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Sun, 26 Jan 2014 22:09:07 +0100
Message-ID: <20140126210907.GB7246@Nokia-N900>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
 <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
 <20140120100530.GY15937@n2100.arm.linux.org.uk>
 <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
 <20140123180423.1a62611a@www.etchedpixels.co.uk>
 <20140123184022.GC11727@sirena.org.uk>
 <52E163DC.1090002@samsung.com>
 <20140123193633.GG11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140123193633.GG11727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <t.figa@samsung.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Thu 2014-01-23 19:36:33, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 07:47:56PM +0100, Tomasz Figa wrote:
> > On 23.01.2014 19:40, Mark Brown wrote:
> 
> > >We'd need to leave it user selectable rather than enabling it for ARM,
> > >the whole reason this got noticed is that people are trying to build
> > >kernels that support a wider range of devices for ARM.
> 
> > What about making it depend on !MULTIPLATFORM and enabled by default?
> 
> That'd work, but if we're doing that then substituting in the dynamic
> assignment only when we hit a collision seems smoother and more general.

That seems like a mess. I had enough fun debugging "WTF is
going on with my serials" as is...

Plus... collision can happen at runtime when you insert
BT CF card... at that point it is too late to reassign.

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
