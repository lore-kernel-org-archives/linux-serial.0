From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v3 08/10] tty: xuartps: Move RX path into helper
 function
Date: Sat, 5 Dec 2015 13:49:21 -0800
Message-ID: <20151205214921.GN4900@xsjsorenbubuntu>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-9-git-send-email-soren.brinkmann@xilinx.com>
 <56632177.1090605@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56632177.1090605@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2015-12-05 at 12:40PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > Move RX-related IRQ handling into a helper function.
> Fixes a problem where every char received after a parity or frame err=
or
> in the current isr will also be tagged as a parity or frame error.
>=20
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Thanks. I'll add your text to the commit message.

>=20
> NB: the sysrq problem in cdns_uart_isr() with needing to drop the
> locks is because cdns_uart_console_write() tries to take the port->lo=
ck.
> The 8250 driver handles this problem by not trying to take the
> port->lock if port->sysrq is non-zero. See serial8250_console_write()=
=2E

I'll look into this. I'll see if I can include that in the next
iteration of this series or do it later.

	Thanks,
	S=C3=B6ren
