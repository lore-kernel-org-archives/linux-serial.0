From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] serdev: add controller runtime PM support
Date: Fri, 11 May 2018 05:56:27 -0700
Message-ID: <20180511125627.GI98604@atomide.com>
References: <20180509094419.13470-1-johan@kernel.org>
 <20180510164831.GH98604@atomide.com>
 <20180511080725.GE2285@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180511080725.GE2285@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180511 08:09]:
> On Thu, May 10, 2018 at 09:48:31AM -0700, Tony Lindgren wrote:
> > If this solution works for GPS then this should also work for modems
> > that might produce data. And as long as the serdev consumer driver
> > can wake up the UART with pm_runtime_get(&serdev->ctrl->dev) then
> > the out of band GPIO wake interrupts will work to. And for TX,
> > the serdev consumer driver can toggle the wake GPIO, and then call
> > pm_runtime_get(&serdev->ctrl->dev).
> 
> I don't think any serdev driver action is needed for TX however. The
> serial driver itself would know that there's data in the write buffer
> and should manage PM itself until the buffer has been drained (which may
> never happen due to flow control).

Sure if the serial driver can manage TX wake directly. However, the
case I'm thinking needs few hundred milliseconds after toggling the
GPIO before we can even attempt to do TX. I guess what I'm saying
let's not try to stuff any "application specific" GPIO handling to
generic UART code :)

> But either way, the mechanism introduced by this patch is general enough
> that it could in principle be used also for something like that.

Yes I agree your patches should work for both cases.

Regards,

Tony
