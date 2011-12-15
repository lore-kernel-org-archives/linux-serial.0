From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] atmel_serial: fix spinlock lockup in RS485 code
Date: Thu, 15 Dec 2011 11:00:18 +0100
Message-ID: <4EE9C532.5050607@atmel.com>
References: <4EE9B42F.50004@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:12260 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1LOKAm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Dec 2011 05:00:42 -0500
In-Reply-To: <4EE9B42F.50004@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Alan Cox <alan@linux.intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Dave Bender <codehero@gmail.com>

On 12/15/2011 09:47 AM, Claudio Scordino :
> Hi all.
> 
> We have encountered a spinlock lockup in the RS485 part of the
> atmel_serial driver.
> 
> Here is the trace:
> 
> [   68.030000] BUG: spinlock lockup on CPU#0, dnp_master/244, c07e82c0
> [   68.040000] [<c002a790>] (unwind_backtrace+0x0/0xf0) from
> [<c012f8f0>] (do_raw_spin_lock+0x10c/0x148)
> [   68.050000] [<c012f8f0>] (do_raw_spin_lock+0x10c/0x148) from
> [<c015152c>] (atmel_tasklet_func+0x10/0x708)
> [   68.060000] [<c015152c>] (atmel_tasklet_func+0x10/0x708) from
> [<c003bfd4>] (tasklet_action+0x8c/0xf4)
> [   68.070000] [<c003bfd4>] (tasklet_action+0x8c/0xf4) from [<c003c630>]
> (__do_softirq+0xa4/0x180)
> [   68.080000] [<c003c630>] (__do_softirq+0xa4/0x180) from [<c003c764>]
> (irq_exit+0x58/0xb0)
> [   68.090000] [<c003c764>] (irq_exit+0x58/0xb0) from [<c0021084>]
> (asm_do_IRQ+0x84/0xa4)
> [   68.100000] [<c0021084>] (asm_do_IRQ+0x84/0xa4) from [<c002622c>]
> (__irq_svc+0x4c/0x98)
> [   68.110000] Exception stack(0xc341fdc8 to 0xc341fe10)
> [   68.110000] fdc0:                   c07e82c0 00000000 00000200
> c4818000 c341fe10 c07e82c0
> [   68.120000] fde0: 00000000 c07e82c0 c38d3318 c341e000 bebcee00
> 010a0b60 c07e83fc c341fe10
> [   68.130000] fe00: c0151d54 c023d9c0 60000013 ffffffff
> [   68.140000] [<c002622c>] (__irq_svc+0x4c/0x98) from [<c023d9c0>]
> (_raw_spin_unlock+0x0/0x48)
> [   68.140000] [<c023d9c0>] (_raw_spin_unlock+0x0/0x48) from
> [<00000000>] (  (null))
> 
> The soft lockup occurs later
> 
> [  126.750000] BUG: soft lockup - CPU#0 stuck for 61s! [dnp_master:244]
> [  126.750000] irq event stamp: 0
> [  126.750000] hardirqs last  enabled at (0): [<  (null)>]   (null)
> [  126.750000] hardirqs last disabled at (0): [<c0035e30>]
> copy_process+0x308/0xe78
> [  126.750000] softirqs last  enabled at (0): [<c0035e30>]
> copy_process+0x308/0xe78
> [  126.750000] softirqs last disabled at (0): [<  (null)>]   (null)
> 
> 
> The following patch (already tested by Dave, who also reported the bug)
> fixes the problem.
> 
> Regards,
> 
>     Claudio
> 
> 
> 
> 
> Subject: atmel_serial: fix spinlock lockup in RS485 code
> 
> Patch to fix a spinlock lockup in the driver that sometimes happens when
> the
> tasklet starts.
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> Signed-off-by: Dave Bender <codehero@gmail.com>
> Tested-by: Dave Bender <codehero@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Claudio, can you please send the patch to Alan with my "Acked-by" and an
addition to Linux stable just after the signature lines:

Cc: stable <stable@kernel.org>

Thanks, best regards,

> ---
>  drivers/tty/serial/atmel_serial.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c
> b/drivers/tty/serial/atmel_serial.c
> index 4c823f3..90c8e3a 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -212,8 +212,9 @@ void atmel_config_rs485(struct uart_port *port,
> struct serial_rs485 *rs485conf)
>  {
>      struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>      unsigned int mode;
> +    unsigned long flags;
>  
> -    spin_lock(&port->lock);
> +    spin_lock_irqsave(&port->lock, flags);
>  
>      /* Disable interrupts */
>      UART_PUT_IDR(port, atmel_port->tx_done_mask);
> @@ -244,7 +245,7 @@ void atmel_config_rs485(struct uart_port *port,
> struct serial_rs485 *rs485conf)
>      /* Enable interrupts */
>      UART_PUT_IER(port, atmel_port->tx_done_mask);
>  
> -    spin_unlock(&port->lock);
> +    spin_unlock_irqrestore(&port->lock, flags);
>  
>  }
>  


-- 
Nicolas Ferre
