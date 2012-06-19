From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V3] pch_uart: Add eg20t_port lock field, avoid recursive
 spinlocks
Date: Tue, 19 Jun 2012 23:04:46 +0100
Message-ID: <20120619230446.2b933b3b@pyramind.ukuu.org.uk>
References: <34b5e216a6dbd83d282dad22c2644136c652c34a.1340139586.git.dvhart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36428 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab2FSWBP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jun 2012 18:01:15 -0400
In-Reply-To: <34b5e216a6dbd83d282dad22c2644136c652c34a.1340139586.git.dvhart@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Tue, 19 Jun 2012 14:00:18 -0700
Darren Hart <dvhart@linux.intel.com> wrote:

> pch_uart_interrupt() takes priv->port.lock which leads to two recursive
> spinlock calls if low_latency==1 or CONFIG_PREEMPT_RT_FULL=y (one
> otherwise):
> 
> pch_uart_interrupt
>   spin_lock_irqsave(priv->port.lock, flags)
>   case PCH_UART_IID_RDR_TO (data ready)
>   handle_rx_to
>     push_rx
>       tty_port_tty_get
>         spin_lock_irqsave(&port->lock, flags) <--- already hold this lock
>         ...
>       tty_flip_buffer_push
>         ...
>         flush_to_ldisc
>           spin_lock_irqsave(&tty->buf.lock)
>             spin_lock_irqsave(&tty->buf.lock)
>             disc->ops->receive_buf(tty, char_buf)
>               n_tty_receive_buf
>                 tty->ops->flush_chars()
>                 uart_flush_chars
>                   uart_start
>                     spin_lock_irqsave(&port->lock) <--- already hold this lock
> 
> Avoid this by using a dedicated lock to protect the eg20t_port structure
> and IO access to its membase. This is more consistent with the 8250
> driver.  Ensure priv->lock is always take prior to priv->port.lock when
> taken at the same time.
> 
> V2: Remove inadvertent whitespace change.
> V3: Account for oops_in_progress for the private lock in
>     pch_console_write().
> 
> Note: Like the 8250 driver, if a printk is introduced anywhere inside
>       the pch_console_write() critical section, the kernel will hang
>       on a recursive spinlock on the private lock. The oops case is
>       handled by using a trylock in the oops_in_progress case.
> 
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> CC: Tomoya MORINAGA <tomoya.rohm@gmail.com>
> CC: Feng Tang <feng.tang@intel.com>
> CC: Alexander Stein <alexander.stein@systec-electronic.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Alan Cox <alan@linux.intel.com>
> CC: linux-serial@vger.kernel.org

Acked-by: Alan Cox <alan@linux.intel.com>
