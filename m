From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
Date: Thu, 16 Mar 2017 22:46:06 +0100
Message-ID: <6515939.2USCG1AhyO@wuerfel>
References: <20170316122653.19930-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170316122653.19930-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jisheng Zhang <jszhang@marvell.com>, Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thursday, March 16, 2017 5:56:53 PM CET Vignesh R wrote:
> Using dev_name() as irq name during request_irq() might be misleading in
> case of serial over PCI. Therefore use a better alternative name for
> identifying serial port irqs as "serial" appended with serial_index of
> the port. This ensures that "serial" string is always present in irq
> name while port index will help in distinguishing b/w different ports.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> Based on top of tty-next.
> 
>  drivers/tty/serial/8250/8250_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index f83b69f30987..78bf621d6827 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -213,12 +213,20 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  
>  		ret = 0;
>  	} else {
> +		char *irqname = kmalloc(20, GFP_KERNEL);
> +		if (!irqname) {
> +			spin_unlock_irq(&i->lock);
> +			return -ENOMEM;
> +		}
> +		snprintf(irqname, 20,
> +			 "serial%d", serial_index(&up->port));

kasprintf()?

Also, you need to free the memory after free_irq().

	Arnd
