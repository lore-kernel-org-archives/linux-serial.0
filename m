From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: mvebu-uart: fix tx lost characters
Date: Tue, 20 Mar 2018 10:32:08 +0100
Message-ID: <20180320093208.GA22194@kroah.com>
References: <3B588D51285A4A4D8D39C94212E078262748ED@SPQCMBX02.exfo.com>
 <20180315165516.GA9519@kroah.com>
 <3B588D51285A4A4D8D39C94212E078262787C0@SPQCMBX02.exfo.com>
 <20180315212137.57ca7c65@xps13>
 <3B588D51285A4A4D8D39C94212E07826278BDF@SPQCMBX02.exfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3B588D51285A4A4D8D39C94212E07826278BDF@SPQCMBX02.exfo.com>
Sender: stable-owner@vger.kernel.org
To: Gabriel Matni <gabriel.matni@exfo.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 16, 2018 at 01:45:32PM +0000, Gabriel Matni wrote:
> From: Gabriel Matni <gabriel.matni@exfo.com>
> 
> Fixes missing characters on kernel console at low baud rates (i.e.9600).
> The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to ensure
> that the transmitter holding register (THR) is ready to receive a new byte.
> 
> TX_EMP tells us when it is possible to send a break sequence via
> SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
> empty, it does not guarantee that a new byte can be written just yet.
> 
> Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700
>       serial port")

Can all be on one line.

And should this go to the stable trees?

> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> 
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>  
> Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com> 

Trailing whitespace?

> 
> ---
>  drivers/tty/serial/mvebu-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What version of this patch is this?  How do I know which to accept?

Please properly version your patch, and include the changes below the
--- line like the documentation says to do.

thanks,

greg k-h
