From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Fri, 2 Aug 2013 15:29:49 +0800
Message-ID: <20130802072949.GA17717@kroah.com>
References: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
 <20130801095406.GD26420@e106331-lin.cambridge.arm.com>
 <1375354423.878127388@f433.i.mail.ru>
 <20130801141420.GB8095@e106331-lin.cambridge.arm.com>
 <20130802102755.0864a99ebbf0b8966d3fe422@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34521 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3HBH2s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 03:28:48 -0400
Content-Disposition: inline
In-Reply-To: <20130802102755.0864a99ebbf0b8966d3fe422@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Fri, Aug 02, 2013 at 10:27:55AM +0400, Alexander Shiyan wrote:
> On Thu, 1 Aug 2013 15:14:20 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, Aug 01, 2013 at 11:53:43AM +0100, Alexander Shiyan wrote:
> > > > On Wed, Jul 31, 2013 at 11:55:45AM +0100, Alexander Shiyan wrote:
> > > > > Add DT support to the SCCNCP serial driver.
> > > > > 
> > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > ---
> > > > >  .../bindings/tty/serial/sccnxp-serial.txt          | 53 ++++++++++++++++++++++
> > > > >  drivers/tty/serial/sccnxp.c                        | 46 +++++++++++++++----
> > > > >  include/linux/platform_data/serial-sccnxp.h        |  6 +--
> > > > >  3 files changed, 93 insertions(+), 12 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
> > > [...]
> > > > > +Optional properties:
> > > > > +- clocks: Phandle to input clock. If omitted, default IC frequency will be
> > > > > +  used instead.
> > 
> > Come to think of it, what is "default IC frequency" likely to be, and
> > how does it influence the usable baud rates?
> > 
> > > > > +- poll-interval: Poll interval time in nanoseconds.
> > > > 
> > > > Is there any reason this needs to be described at all? Is this interval
> > > > a minimum/maximum bound required for some reason, or just a sensible
> > > > value?
> > > > 
> > > > This feels like driver configuration than hardware description.
> > > 
> > > This is a exact value for driver in the polling mode.
> > 
> > That certainly sounds like driver configuration ;)
> > 
> > > Depends on desired response time and/or desired UART baudrate.
> > 
> > If this depends on the desired baud rate, how does this interact with
> > dynamically changing the baud rate later -- surely you may need to have
> > different polling rates for high and low baud rates?
> 
> I will change it to automatically calculate a reasonable value for polling.
> 
> [...]
> 
> Greg, please remove this part of patch from tty-tree.

Now removed.
