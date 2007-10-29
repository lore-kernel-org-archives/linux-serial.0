From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Date: Mon, 29 Oct 2007 15:28:25 +0000
Message-ID: <20071029152824.GB3953@linux-mips.org>
References: <4720A11E.5060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:52594 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbXJ2P3J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2007 11:29:09 -0400
Received: from localhost.localdomain ([127.0.0.1]:15753 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022687AbXJ2P3I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2007 15:29:08 +0000
Content-Disposition: inline
In-Reply-To: <4720A11E.5060101@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jan Nikitenko <jan.nikitenko@gmail.com>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

On Thu, Oct 25, 2007 at 03:58:54PM +0200, Jan Nikitenko wrote:

> UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
> irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
> when more characters than uart's fifo size were to be received by the uart.
> 
> This problem can be experienced for example when uart0 is used as a
> serial console on au1550 and more than 16 characters are pasted from
> clipboard to the console.
> 
> The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
> a check, if the irq number is other than zero.
> Because UART0 on au1xxx platforms uses irq number 0, the
> is_real_interrupt() check fails and serial8250_backup_timeout() is used
> instead of uart's hw irq.
> 
> The patch redefines the is_real_interrupt(irq) macro, as suggested in
> the comment above the macro definition in 8250.c, in the
> asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
> This allows the irq number 0 to be used as hw irq for the alchemy uart0
> and fixes the overrun problem.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

So applied to all of lmo's -stable branches.

  Ralf
