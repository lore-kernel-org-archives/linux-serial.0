From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/9] Add and make use of a common rs485 device tree
 parsing function
Date: Thu, 29 Jun 2017 20:47:02 +0200
Message-ID: <20170629184702.znzbc6i3gnccfegq@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170629151200.GA16362@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170629151200.GA16362-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

On Thu, Jun 29, 2017 at 05:12:00PM +0200, Greg KH wrote:
> On Mon, Jun 26, 2017 at 11:07:54AM +0200, Uwe Kleine-König wrote:
> > this is v3 of the series that targets to consolidate parsing the rs485 specific
> > dt properties in a single place.
> 
> This patch breaks the build, and not all of them applied properly :(

sigh :( Sorry for the build breaker.

Regarding "doesn't apply": I tested to rebase on next/master (and so
tty-next) and it applies there just fine. I considered that good enough.
I guess you're talking about tty-testing?! I suggest to mention the
branch name you want to apply patches on in such mails.

There is a patch you applied on tty-testing that is not ok I think
("serial: imx-serial - move DMA buffer configuration to DT"). I
commented this one in the respective thread now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
