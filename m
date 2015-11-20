From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter
 in start_tx
Date: Fri, 20 Nov 2015 07:28:49 -0800
Message-ID: <20151120152849.GU32017@xsjsorenbubuntu>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564F0E75.5020100@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Fri, 2015-11-20 at 07:13AM -0500, Peter Hurley wrote:
>=20
>=20
> On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
> > start_tx must start transmitting characters. Regardless of the stat=
e of
> > the circular buffer, always enable the transmitter hardware.
>=20
> Why?
>=20
> Does cdns_uart_stop_tx() actually stop the transmitter so that
> data remains in the transmitter?

Well, I saw my system freezing and the cause seemed to be that the UART
receiver and/or transmitters were disabled while the system was trying
to print. Hence, I started questioning all locations touching the
transmitter/receiver enable. I read the docs in
https://www.kernel.org/doc/Documentation/serial/driver, which simply
says "Start transmitting characters." for start_tx(). Hence, I thought,
this function is probably supposed to just do that and start the
transmitter. I'll test whether this patch can be dropped.

	Thanks,
	S=C3=B6ren
