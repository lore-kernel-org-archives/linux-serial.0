From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH v2] serial: Add OMAP high-speed UART driver
Date: Fri, 28 May 2010 08:06:24 -0500
Message-ID: <201005280806.30838.luke@dashjr.org>
References: <58269.192.168.10.88.1274708590.squirrel@dbdmail.itg.ti.com> <201005271100.41305.luke@dashjr.org> <AANLkTikta1db8KHV2Crz1zJEagmcOI20mSnXYUq02sZ5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zinan.dashjr.org ([173.242.112.54]:47534 "EHLO zinan.dashjr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab0E1NGt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 May 2010 09:06:49 -0400
In-Reply-To: <AANLkTikta1db8KHV2Crz1zJEagmcOI20mSnXYUq02sZ5@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 28 May 2010 02:11:29 am you wrote:
> On Thu, May 27, 2010 at 9:30 PM, Luke-Jr <luke@dashjr.org> wrote:
> > On Wednesday 26 May 2010 05:48:58 pm Kevin Hilman wrote:
> >> FYI... this also works on OMAP2.
> >>
> >> I tested it on my n810 along with UART hwmod conversion and it works
> >> just fine there.
> >
> > Is it somehow different from the basic 8250 driver on OMAP2? I've been
> > struggling to figure out why my N810's GPS isn't working when I change
> > kernels (I've already made sure ttyS0 is the correct major/minor and
> > adjusted the GPIO calls; gpiodriver is talking to the chip, but not
> > getting anywhere).
> 
> You need to use ttyO0 [%s/ttyS*/ttyO*]
> 
> Since uart tty interface name as been modified with this driver.
> 
> +#define OMAP_SERIAL_NAME       "ttyO"

Beyond the fact that this is hard-coded into Nokia's blob and thus not 
something trivial to change, I meant it doesn't work with the 8250 driver. My 
question pertains to if this driver does anything different that would make it 
possibly work.
