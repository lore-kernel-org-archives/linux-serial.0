From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Wed, 7 Aug 2019 18:56:46 +0200
Message-ID: <20190807165646.GA6584@kroah.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
 <20190806184042.GA26041@kroah.com>
 <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 04:42:17PM +0000, Stefan-gabriel Mirea wrote:
> On 8/6/2019 9:40 PM, gregkh@linuxfoundation.org wrote:
> > On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:
> >> On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:
> >>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >>>>
> >>>> +/* Freescale Linflex UART */
> >>>> +#define PORT_LINFLEXUART     121
> >>>
> >>> Do you really need this modified?
> >>
> >> Hello Greg,
> >>
> >> This macro is meant to be assigned to port->type in the config_port
> >> method from uart_ops, in order for verify_port to know if the received
> >> serial_struct structure was really targeted for a LINFlex port. It
> >> needs to be defined outside, to avoid "collisions" with other drivers.
> > 
> > Yes, I know what it goes to, but does anyone in userspace actually use
> > it?
> 
> No, we do not use it from userspace, but kept the pattern only for
> conformance.
> 
> >> Other than that, I do not see anything wrong with the addition of a
> >> define in serial_core.h for this purpose (which is also what most of the
> >> serial drivers do, including amba-pl011.c, mentioned in
> >> Documentation/driver-api/serial/driver.rst as providing the reference
> >> implementation), so please be more specific.
> > 
> > I am getting tired of dealing with merge issues with that list, and no
> > one seems to be able to find where they are really needed for userspace,
> > especially for new devices.  What happens if you do not have use it?
> 
> I see. If I drop its usage completely and leave 'type' from the
> uart_port as 0, uart_port_startup() will fail when finding that
> uport->type == PORT_UNKNOWN at [1] (there may be other effects as well,
> e.g. due to the check in uart_configure_port[2]).
> 
> So I suppose that I need to define some nonzero 'PORT_KNOWN' macro in
> the driver and use that one internally for 'type'. Is my understanding
> correct? Will there be any problems if I define it to a positive integer
> which is already assigned to another driver, according to serial_core.h?

Ugh, ok, that's messy, nevermind.  Keep the #define in there, I will try
to figure out how to move all of these at once sometime in the future...

sorry for the noise.

greg k-h
