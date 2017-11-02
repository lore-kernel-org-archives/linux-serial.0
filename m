From: Denys Zagorui <dzagorui@cisco.com>
Subject: Re: [RFC PATCH] serial: 8250, redirect IRQ processing to kthread
Date: Thu, 2 Nov 2017 14:11:40 +0200
Message-ID: <361d961d-83b2-6f30-d90b-0ff883f12164@cisco.com>
References: <20171031141746.18720-1-dzagorui@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171031141746.18720-1-dzagorui@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,
There is known issue that annoyed people at least
a decade during using virtual machines by printing
many of this:
  "too much work for irq.."

There were some workarounds:

- serial: 8250, increase PASS_LIMIT
e7328ae1848966181a7ac47e8ae6cddbd2cf55f3

- serial: 8250, disable "too much work" messages
f4f653e9875e573860e783fecbebde284a8626f5

Last one was reverted later
12de375ec493ab1767d4a07dde823e63ae5edc21

So maybe we should redirect IRQ processing to
kthread and make this process more friendly for
other by rescheduling sometimes.

Best Regards,
Denys

On 10/31/2017 04:17 PM, Denys Zagorui wrote:
> Some serial 8250 devices may work with very high speed.
> While was using QEMU KVM was observed speed
> 1..100 Mbit/sec, it fully depends at host machine.
> It may affects on responsiveness of system due a cpu
> would be spinning in 8250 driver at burst. So added
> opportunity to put this processing in kthread.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>   drivers/tty/serial/8250/8250_core.c | 29 +++++++++++++++++++++++++++++
>   drivers/tty/serial/8250/8250_port.c | 10 ++++++++++
>   drivers/tty/serial/8250/Kconfig     | 10 ++++++++++
>   3 files changed, 49 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 1aab3010fbfa..7b498d2e882b 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -58,7 +58,11 @@ static struct uart_driver serial8250_reg;
>   
>   static unsigned int skip_txen_test; /* force skip of txen test at init time */
>   
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +#define PASS_LIMIT	32
> +#else
>   #define PASS_LIMIT	512
> +#endif
>   
>   #include <asm/serial.h>
>   /*
> @@ -135,10 +139,16 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>   		l = l->next;
>   
>   		if (l == i->head && pass_counter++ > PASS_LIMIT) {
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +			cond_resched();
> +			pass_counter = 0;
> +#else
>   			/* If we hit this, we're dead. */
>   			printk_ratelimited(KERN_ERR
>   				"serial8250: too much work for irq%d\n", irq);
>   			break;
> +
> +#endif
>   		}
>   	} while (l != end);
>   
> @@ -146,9 +156,23 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>   
>   	pr_debug("%s(%d): end\n", __func__, irq);
>   
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +	enable_irq(i->irq);
> +#endif
>   	return IRQ_RETVAL(handled);
>   }
>   
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +static irqreturn_t serial8250_hard_irq(int irq, void *dev_id)
> +{
> +	struct irq_info *i = dev_id;
> +
> +	disable_irq_nosync(i->irq);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +#endif
> +
>   /*
>    * To support ISA shared interrupts, we need to have one interrupt
>    * handler that ensures that the IRQ line has been deasserted
> @@ -217,8 +241,13 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>   		i->head = &up->list;
>   		spin_unlock_irq(&i->lock);
>   		irq_flags |= up->port.irqflags;
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +		ret = request_threaded_irq(up->port.irq, serial8250_hard_irq,
> +						serial8250_interrupt, irq_flags, up->port.name, i);
> +#else
>   		ret = request_irq(up->port.irq, serial8250_interrupt,
>   				  irq_flags, up->port.name, i);
> +#endif
>   		if (ret < 0)
>   			serial_do_unlink(i, up);
>   	}
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index a5fe0e66c607..16e647473c4d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1827,13 +1827,19 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
>   int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>   {
>   	unsigned char status;
> +#ifndef CONFIG_SERIAL_8250_THREADED_IRQ
>   	unsigned long flags;
> +#endif
>   	struct uart_8250_port *up = up_to_u8250p(port);
>   
>   	if (iir & UART_IIR_NO_INT)
>   		return 0;
>   
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +	spin_lock(&port->lock);
> +#else
>   	spin_lock_irqsave(&port->lock, flags);
> +#endif
>   
>   	status = serial_port_in(port, UART_LSR);
>   
> @@ -1845,7 +1851,11 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>   	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
>   		serial8250_tx_chars(up);
>   
> +#ifdef CONFIG_SERIAL_8250_THREADED_IRQ
> +	spin_unlock(&port->lock);
> +#else
>   	spin_unlock_irqrestore(&port->lock, flags);
> +#endif
>   	return 1;
>   }
>   EXPORT_SYMBOL_GPL(serial8250_handle_irq);
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index a1161ec0256f..58a0f324cbea 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -202,6 +202,16 @@ config SERIAL_8250_MANY_PORTS
>   	  say N here to save some memory. You can also say Y if you have an
>   	  "intelligent" multiport card such as Cyclades, Digiboards, etc.
>   
> +config SERIAL_8250_THREADED_IRQ
> +	bool "Make serial 8250 interrupt processing threaded"
> +	depends on SERIAL_8250
> +	help
> +	  Some virtual devices can work at very high speed (like QEMU KVM
> +	  serial 8250). So when burst happens this processing will capture
> +	  cpu.
> +	  Say Y if you want to make processing more friendly for others
> +	  processes.
> +
>   #
>   # Multi-port serial cards
>   #
