From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 03/10] tty: xuartps: Implement BREAK detection, add SYSRQ
 support
Date: Mon, 02 Dec 2013 15:42:05 -0500
Message-ID: <529CF09D.6060906@hurleysoftware.com>
References: <1382044093-29905-1-git-send-email-soren.brinkmann@xilinx.com> <1382044093-29905-4-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382044093-29905-4-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Vlad Lungu <vlad.lungu@windriver.com>
List-Id: linux-serial@vger.kernel.org

On 10/17/2013 05:08 PM, Soren Brinkmann wrote:
> From: Vlad Lungu <vlad.lungu@windriver.com>
>
> The Cadence UART does not do break detection, even if the
> datasheet says it does. This patch adds break detection in
> software (tested in 8N1 mode only) and enables SYSRQ,
> allowing for Break-g to enter KDB and all the other goodies.
>
> Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> I ported this patch to 3.12 and fixed some style issues
> ---
>   drivers/tty/serial/xilinx_uartps.c | 50 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 8c0745951605..5d5557af4d22 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -11,13 +11,17 @@
>    *
>    */
>
> +#if defined(CONFIG_SERIAL_XILINX_PS_UART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
>   #include <linux/platform_device.h>
>   #include <linux/serial.h>
> +#include <linux/console.h>
>   #include <linux/serial_core.h>
>   #include <linux/slab.h>
>   #include <linux/tty.h>
>   #include <linux/tty_flip.h>
> -#include <linux/console.h>
>   #include <linux/clk.h>
>   #include <linux/irq.h>
>   #include <linux/io.h>
> @@ -128,6 +132,9 @@
>   #define XUARTPS_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
>   #define XUARTPS_IXR_MASK	0x00001FFF /* Valid bit mask */
>
> +/* Goes in read_status_mask for break detection as the HW doesn't do it*/
> +#define XUARTPS_IXR_BRK		0x80000000
> +
>   /** Channel Status Register
>    *
>    * The channel status register (CSR) is provided to enable the control logic
> @@ -171,6 +178,23 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
>   	 */
>   	isrstatus = xuartps_readl(XUARTPS_ISR_OFFSET);
>
> +	/*
> +	 * There is no hardware break detection, so we interpret framing
> +	 * error with all-zeros data as a break sequence. Most of the time,
> +	 * there's another non-zero byte at the end of the sequence.
> +	 */
> +
> +	if (isrstatus & XUARTPS_IXR_FRAMING) {
> +		while (!(xuartps_readl(XUARTPS_SR_OFFSET) &
> +					XUARTPS_SR_RXEMPTY)) {
> +			if (!xuartps_readl(XUARTPS_FIFO_OFFSET)) {
> +				port->read_status_mask |= XUARTPS_IXR_BRK;
> +				isrstatus &= ~XUARTPS_IXR_FRAMING;
> +			}
> +		}
> +		xuartps_writel(XUARTPS_IXR_FRAMING, XUARTPS_ISR_OFFSET);
> +	}
> +
>   	/* drop byte with parity error if IGNPAR specified */
>   	if (isrstatus & port->ignore_status_mask & XUARTPS_IXR_PARITY)
>   		isrstatus &= ~(XUARTPS_IXR_RXTRIG | XUARTPS_IXR_TOUT);
> @@ -184,6 +208,30 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
>   		while ((xuartps_readl(XUARTPS_SR_OFFSET) &
>   			XUARTPS_SR_RXEMPTY) != XUARTPS_SR_RXEMPTY) {
>   			data = xuartps_readl(XUARTPS_FIFO_OFFSET);
> +
> +			/* Non-NULL byte after BREAK is garbage (99%) */
> +			if (data && (port->read_status_mask &
> +						XUARTPS_IXR_BRK)) {
> +				port->read_status_mask &= ~XUARTPS_IXR_BRK;
> +				port->icount.brk++;
> +				if (uart_handle_break(port))
> +					continue;
> +			}
> +
> +			/*
> +			 * uart_handle_sysrq_char() doesn't work if
> +			 * spinlocked, for some reason
> +			 */
                                        ^^^^^^^^^^^^^^^
Because the console write method, xuartps_console_write(), tries to
lock the port->lock. Double-claim deadlock.

> +			 if (port->sysrq) {
> +				spin_unlock(&port->lock);
> +				if (uart_handle_sysrq_char(port,
> +							(unsigned char)data)) {
> +					spin_lock(&port->lock);
> +					continue;
> +				}
> +				spin_lock(&port->lock);
> +			}
> +
>   			port->icount.rx++;
>
>   			if (isrstatus & XUARTPS_IXR_PARITY) {
>
