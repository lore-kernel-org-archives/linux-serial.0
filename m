From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH 5/6] ARM: ks8695, serial: skip manual tx IRQ ack
Date: Sat, 20 Apr 2019 12:06:26 +1000
Message-ID: <c928a87f-9311-d70a-f2df-ce9621ab8716@uclinux.org>
References: <20190415202501.941196-1-arnd@arndb.de>
 <20190415202501.941196-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415202501.941196-5-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On 16/4/19 6:24 am, Arnd Bergmann wrote:
> The TX interrupt is marked as edge triggered, so it will
> already be acked by the top-level irq code, and does not
> need the ack in the driver.
> 
> Removing this avoids a nasty dependency on the regs-irq.h
> file that is otherwise reserved for the interrupt controller
> driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/tty/serial/serial_ks8695.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
> index b461d791188c..6c5e9900e69d 100644
> --- a/drivers/tty/serial/serial_ks8695.c
> +++ b/drivers/tty/serial/serial_ks8695.c
> @@ -21,7 +21,6 @@
>   #include <asm/mach/irq.h>
>   
>   #include <mach/regs-uart.h>
> -#include <mach/regs-irq.h>
>   
>   #if defined(CONFIG_SERIAL_KS8695_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>   #define SUPPORT_SYSRQ
> @@ -52,8 +51,6 @@
>   #define UART_GET_BRDR(p)	__raw_readl((p)->membase + KS8695_URBD)
>   #define UART_PUT_BRDR(p, c)	__raw_writel((c), (p)->membase + KS8695_URBD)
>   
> -#define KS8695_CLR_TX_INT()	__raw_writel(1 << KS8695_IRQ_UART_TX, KS8695_IRQ_VA + KS8695_INTST)
> -
>   #define UART_DUMMY_LSR_RX	0x100
>   #define UART_PORT_SIZE		(KS8695_USR - KS8695_URRB + 4)
>   
> @@ -207,7 +204,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
>   	unsigned int count;
>   
>   	if (port->x_char) {
> -		KS8695_CLR_TX_INT();
>   		UART_PUT_CHAR(port, port->x_char);
>   		port->icount.tx++;
>   		port->x_char = 0;
> @@ -221,7 +217,6 @@ static irqreturn_t ks8695uart_tx_chars(int irq, void *dev_id)
>   
>   	count = 16;	/* fifo size */
>   	while (!uart_circ_empty(xmit) && (count-- > 0)) {
> -		KS8695_CLR_TX_INT();

I haven't looked at the ks8695 in quite a while...
But I recall that this was very problematic at the time. Without this being
done after each character it was very easy to get the transmitter to "hang" -
and stop wanting to send any more characters.

I'd like to test this before acking.

Regards
Greg


>   		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
>   
>   		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> 
