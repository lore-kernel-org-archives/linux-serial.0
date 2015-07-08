From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/2] serial: 8250: Fix autoconfig_irq() to avoid race
 conditions
Date: Wed, 08 Jul 2015 19:35:26 -0400
Message-ID: <559DB3BE.5080306@hurleysoftware.com>
References: <55717224.9060104@cp.jp.nec.com> <55717294.8020905@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55717294.8020905@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

On 06/05/2015 05:57 AM, Taichi Kageyama wrote:
> The following race conditions can happen if a serial is used as console.
>   Case1. CPU_B handles an interrupt from a serial
>     autoconfig_irq() fails whether the interrupt is raised or not
>     if CPU_B is disabled to handle interrupts for longer than it expects.
>   Case2. CPU_B clears UART_IER just after CPU_A sets UART_IER
>     A serial may not make an interrupt.
>     autoconfig_irq() can fail if the interrupt is not raised.
>   Case3. CPU_A sets UART_IER just after CPU_B clears UART_IER
>     This is an unexpected behavior for uart_console_write().
> 
>   CPU_A [autoconfig_irq]      CPU_B [serial8250_console_write]
>   -----------------------------------------------------------------
>   probe_irq_on()              spin_lock_irqsave(&port->lock,)
>   serial_outp(,UART_IER,0x0f) serial_out(,UART_IER,0)
>   udelay(20);                 uart_console_write()
>   probe_irq_off()
>                               spin_unlock_irqrestore(&port->lock,)
>   -----------------------------------------------------------------
> 
> If autoconfig_irq() fails, the console doesn't work in interrupt mode,
> the mode cannot be changed anymore, and "input overrun"
> (which can make operation mistakes) happens easily.
> This problem happens with high rate every boot once it occurs
> because the boot sequence is always almost same.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
