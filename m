From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] serial: mvebu-uart: fix tx lost characters
Date: Thu, 15 Mar 2018 21:21:37 +0100
Message-ID: <20180315212137.57ca7c65@xps13>
References: <3B588D51285A4A4D8D39C94212E078262748ED@SPQCMBX02.exfo.com>
        <20180315165516.GA9519@kroah.com>
        <3B588D51285A4A4D8D39C94212E078262787C0@SPQCMBX02.exfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <3B588D51285A4A4D8D39C94212E078262787C0@SPQCMBX02.exfo.com>
Sender: stable-owner@vger.kernel.org
To: Gabriel Matni <gabriel.matni@exfo.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?R3LDqWdvcnk=?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-serial@vger.kernel.org

Hi Gabriel,

On Thu, 15 Mar 2018 18:55:25 +0000, Gabriel Matni
<gabriel.matni@exfo.com> wrote:

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
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> 
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>  
> Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com> 
> 
> ---
>  drivers/tty/serial/mvebu-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index a100e98259d7..400e1bc558b2 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
>  	u32 val;
>  
>  	readl_poll_timeout_atomic(port->membase + UART_STAT, val,
> -				  (val & STAT_TX_EMP), 1, 10000);
> +             (val & STAT_TX_RDY(port)), 1, 10000);

I think this line should be indented like the one you replaced.

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
