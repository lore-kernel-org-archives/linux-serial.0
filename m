From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 16:30:31 +0100
Message-ID: <20120427153031.GA27792@n2100.arm.linux.org.uk>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com> <20120426111116.GF24211@n2100.arm.linux.org.uk> <4F9A4417.7080107@freescale.com> <20120427082245.GJ24211@n2100.arm.linux.org.uk> <4F9A6AEE.30005@freescale.com> <20120427095003.GK24211@n2100.arm.linux.org.uk> <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49662 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760294Ab2D0Pax (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 11:30:53 -0400
Content-Disposition: inline
In-Reply-To: <CAMiH66FoEYEqudAOx7Y8GpgjfT-gX2qOi0BjG0-X8xH8u24kSw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: Huang Shijie <b32955@freescale.com>, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

On Fri, Apr 27, 2012 at 11:18:15AM -0400, Huang Shijie wrote:
> On Fri, Apr 27, 2012 at 5:50 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 27, 2012 at 05:46:22PM +0800, Huang Shijie wrote:
> >>>>> 1. How do you deal with transmitting the high-priority XON/XOFF
> >>>>> =A0 =A0 =A0characters (port->x_char) which occur with s/w flow =
control and
> >>>>> =A0 =A0 =A0the tty buffers fill up?
> >>>>> 2. How do you deal with flow control in general? =A0IOW, what h=
appens
> >>>>> =A0 =A0 =A0when the remote end deasserts your CTS with h/w flow=
 control enabled.
> >> If the remote end deasserts my CTS, it means the remote will not s=
end
> >> any data.
> >>
> >> My DMA for RX will expire in the following steps:
> >> [1] the UART only waits for 32 bytes time long
> >> [2] the UART triggers an IDLE Condition Detect DMA.
> >> [3] the dma_rx_callback() will release the DMA for Rx.
> >
> > Err, hang on. =A0I think you're totally confused about hardware flo=
w
> > control. =A0Certainly you're not using the correct terms for what y=
ou're
> > describing.
> >
> > The CTS input normally controls the transmitter. =A0In many hardwar=
e
> > assisted hardware flow control setups, the deassertion of CTS merel=
y
> > prevents the transmitter starting a new character.
> >
> > This shouldn't have any effect on the receiver of the same UART at =
all.
> >
> >>>>> =A0 =A0 =A0How does your end deal with sending RTS according to=
 flow control
> >>>>> =A0 =A0 =A0conditions?
> >>>>>
> >> If a CTS is received after we sent out a RTS, it will follow the s=
teps:
> >> =A0imx_int() --> imx_rtsint() --> uart_handle_cts_change() -->star=
t_tx()
> >>
> >> The start_tx() will create an TX DMA operation, and send out the d=
ata.
> >
> > The generation of RTS (connected to the remote ends CTS signal) is
> > supposed to control whether the remote end sends you characters. =A0=
RTS
> http://en.wikipedia.org/wiki/Flow_control#Hardware_flow_control
>=20
> >From the wiki, the generation of RTS (assert by the  "master end") i=
s
> used to send data
> from the master to slave(the remote), not control the remote end send=
s
> me characters.

Well, there's a lot of confusion over RTS.  Most implementations of it
are as per this paragraph on the above page:

 A non-standard symmetric alternative, commonly called "RTS/CTS handsha=
king,"
 was developed by various equipment manufacturers. In this scheme, CTS =
is no
 longer a response to RTS; instead, CTS indicates permission from the D=
CE
 for the DTE to send data to the DCE, and RTS indicates permission from
 the DTE for the DCE to send data to the DTE. RTS and CTS are controlle=
d
 by the DTE and DCE respectively, each independent of the other. This w=
as
 eventually codified in version RS-232-E (actually TIA-232-E by that ti=
me)
 by defining a new signal, "RTR (Ready to Receive)," which is CCITT V.2=
4
 circuit 133. TIA-232-E and the corresponding international standards w=
ere
 updated to show that circuit 133, when implemented, shares the same pi=
n
 as RTS (Request to Send), and that when 133 is in use, RTS is assumed =
by
 the DCE to be ON at all times

This is what is actually used by all NULL modem cables, serial consoles=
,
and many modems can be (sensibly) configured to support it.  Many
modems can be configured via AT commands to respond as per the above
paragraph too.

And this is the hardware flow control scheme implemented by the Linux
Kernel for CRTSCTS, plus the hardware assisted hardware flow control
provided by industry standard UARTs such as the 1675x and later UARTs.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
