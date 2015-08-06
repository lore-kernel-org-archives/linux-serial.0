From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH v2 1/3] serial: 8250: Fix autoconfig_irq() to avoid
 race conditions
Date: Thu, 06 Aug 2015 08:53:36 -0400
Message-ID: <55C358D0.2090605@hurleysoftware.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <1438157443-19447-2-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438157443-19447-2-git-send-email-t-kageyama@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

On 07/29/2015 04:12 AM, Taichi Kageyama wrote:
> The following race conditions can happen when a serial port is used
> as console.
> 
> Case1: CPU_B is used to detect an interrupt from a serial port,
>        but it can have interrupts disabled during the waiting time.
> Case2: CPU_B clears UART_IER just after CPU_A sets UART_IER and then
>        a serial port may not make an interrupt.
> Case3: CPU_A sets UART_IER just after CPU_B clears UART_IER.
>        This is an unexpected behavior for serial8250_console_write().
> 
> CPU_A [autoconfig_irq]      |  CPU_B [serial8250_console_write]
> ----------------------------|---------------------------------------
>                             |
> probe_irq_on()              |  spin_lock_irqsave(&port->lock,)
> serial_outp(,UART_IER,0x0f) |  serial_out(,UART_IER,0)
> udelay(20);                 |  uart_console_write()
> probe_irq_off()             |
>                             |  spin_unlock_irqrestore(&port->lock,)
> 
> Case1 and 2 can make autoconfig_irq() failed.
> In these cases, the console doesn't work in interrupt mode and
> "input overrun" (which can make operation mistakes) can happen
> on some systems. Especially in the Case1, It is known that the
> problem happens with high rate every boot once it occurs
> because the boot sequence is always almost same.
> 
> port mutex makes sure that the autoconfig operation is exclusive of
> any other concurrent HW access except by the console operation.
> console lock is required in autoconfig_irq().
> 
> Signed-off-by: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Please resend this one patch to Greg as a non-RFC patch.

Regards,
Peter Hurley
