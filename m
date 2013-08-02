From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Fri, 2 Aug 2013 14:14:00 +0400
Message-ID: <20130802141400.8bf8fac5693ed315023a5af2@mail.ru>
References: <1375268145-13393-1-git-send-email-shc_work@mail.ru>
	<51F98562.9080307@wwwdotorg.org>
	<1375343473.135835596@f377.i.mail.ru>
	<51FA8D51.8030301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp45.i.mail.ru ([94.100.177.105]:41446 "EHLO smtp45.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030600Ab3HBKOf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Aug 2013 06:14:35 -0400
In-Reply-To: <51FA8D51.8030301@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>

On Thu, 01 Aug 2013 10:31:13 -0600
Stephen Warren <swarren@wwwdotorg.org> wrote:

> On 08/01/2013 01:51 AM, Alexander Shiyan wrote:
> >> On 07/31/2013 04:55 AM, Alexander Shiyan wrote:
> >>> Add DT support to the SCCNCP serial driver.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
[...]
> >>> +- nxp,sccnxp-io-cfg: Array contains values for the emulated modem signals.
> >>> +  The number of values depends on the UART-number in the selected chip.
> >>> +  Each value should be composed according to the following rules:
> >>> +  (LINE1 << SIGNAL1) | ... | (LINEX << SIGNALX), where:
> >>> +   LINE - VALUE:
> >>> +    OP0 - 1
> >> ...
> >>> +    IP6 - 15
> >>> +   SIGNAL - VALUE:
> >>> +    DTR - 0
> >> ...
> >>> +    DIR - 24
> >>
> >> I wonder that shouldn't be implemented using standard pinctrl bindings.
> >> I could see someone wanting to create a pinmuxing-based serial port
> >> multiplexing device, which would then need to rely on this node acting
> >> as a standard pin controller...
> > 
> > In this case pin-controller cannot be applied here.
> 
> Why not?
> 
> > The device has several lines of general purpose inputs and outputs, there is
> > no functional purpose of these lines as a modem signals. In the driver realized
> > only an emulation of these signals. That is, this property describes the trick.
> > I have no idea how to do this trick in another way.
> 
> I assume the HW design is that there are 15 pins, and there is a
> register or are multiple registers that define which pins are used for
> which purpose.
> 
> If so, that's exactly what the pinctrl bindings are for.
> 
> However, you're talking about emulation... Is this property really
> describing HW? If not, it isn't appropriate for DT.

What your opinion about replace this property by "quirk" property and hardcode
these values into the driver?
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
