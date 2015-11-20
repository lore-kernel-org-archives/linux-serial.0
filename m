From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter
 in start_tx
Date: Fri, 20 Nov 2015 09:05:26 -0800
Message-ID: <20151120170525.GW32017@xsjsorenbubuntu>
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

=46ixing up the patch, I looked at this one. It might actually do that.
Without having changed anything. The doc says: "The driver should
stop transmitting characters as soon as possible.". And the
implementation is really not draining any FIFO, but just disabling the
transmitter. I take your question as that this might not be this way?
Should stop_tx drain the FIFO first?

	Thanks,
	S=C3=B6ren
