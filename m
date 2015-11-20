From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter
 in start_tx
Date: Fri, 20 Nov 2015 09:29:31 -0800
Message-ID: <20151120172931.GX32017@xsjsorenbubuntu>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
 <20151120165804.GV32017@xsjsorenbubuntu>
 <564F5574.4070407@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564F5574.4070407@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2015-11-20 at 12:16PM -0500, Peter Hurley wrote:
> On 11/20/2015 11:58 AM, S=C3=B6ren Brinkmann wrote:
> > On Fri, 2015-11-20 at 11:30AM -0500, Peter Hurley wrote:
> >> On 11/20/2015 10:28 AM, S=C3=B6ren Brinkmann wrote:
> >>> On Fri, 2015-11-20 at 07:13AM -0500, Peter Hurley wrote:
> >>>> On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
> >>>>> start_tx must start transmitting characters. Regardless of the =
state of
> >>>>> the circular buffer, always enable the transmitter hardware.
> >>>>
> >>>> Why?
> >>>>
> >>>> Does cdns_uart_stop_tx() actually stop the transmitter so that
> >>>> data remains in the transmitter?
> >>>
> >>> Well, I saw my system freezing and the cause seemed to be that th=
e UART
> >>> receiver and/or transmitters were disabled while the system was t=
rying
> >>> to print. Hence, I started questioning all locations touching the
> >>> transmitter/receiver enable. I read the docs in
> >>> https://www.kernel.org/doc/Documentation/serial/driver, which sim=
ply
> >>> says "Start transmitting characters." for start_tx(). Hence, I th=
ought,
> >>> this function is probably supposed to just do that and start the
> >>> transmitter. I'll test whether this patch can be dropped.
> >>
> >> I don't think that patch would fix any freeze problems, but restar=
ting
> >> the transmitter even if the circ buffer is empty may be necessary =
to
> >> push out remaining data when the port is restarted after being sto=
pped.
> >>
> >> IOW, something like
> >>
> >> 	if (uart_tx_stopped(port))
> >> 		return;
> >>
> >> 	....
> >>
> >>
> >> 	if (uart_circ_empty(&port->state->xmit)
> >> 		return;
> >=20
> > Thanks! I'll change the patch accordingly.
> >=20
> >>
> >>
> >> Below is a (work-in-progress) serial driver validation test for fl=
ow
> >> control handling (it may need some tuning for slow line speeds).
> >> Usual caveats apply. Takes ~40secs @ 115200.
> >=20
> > I'll try to get that running on my system.
>=20
> The test below should pass too, but I know it won't because this xili=
nx
> driver isn't handling x_char at all.
>=20
> Aside: does this h/w have rts driver/cts receiver?

I would have to look up the details. But, IIRC, the HW has all the
modem/flow control signals. But on our SoCs those signals are only
available when routing the UART through the FPGA part, which makes it a
rather unlikely configuration since most platforms want the UART as a
low level debug port that should not depend on any FPGA bistreams.
Hence, I suspect it might just be a limitation of the driver.

	S=C3=B6ren
