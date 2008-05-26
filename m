From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [SERIAL] fix driver_name conflicts
Date: Mon, 26 May 2008 21:02:07 +0100
Message-ID: <20080526210207.5730e9cc@core>
References: <20080526172340.GA17703@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36455 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755068AbYEZURA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 May 2008 16:17:00 -0400
In-Reply-To: <20080526172340.GA17703@polina.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Timur Tabi <timur@freescale.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 26 May 2008 21:23:40 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Some drivers are using too generic "serial" name for driver_name, this
> might cause issues, like this:
> 
> Freescale QUICC Engine UART device driver
> proc_dir_entry 'serial' already registered
> Call Trace:
> [cf82de50] [c0007f7c] show_stack+0x4c/0x1ac (unreliable)
> [cf82de90] [c00b03fc] proc_register+0xfc/0x1ac
> [cf82dec0] [c00b05c8] create_proc_entry+0x60/0xac
> [cf82dee0] [c00b23dc] proc_tty_register_driver+0x60/0x98
> [cf82def0] [c016dbd8] tty_register_driver+0x1b4/0x228
> [cf82df20] [c0184d70] uart_register_driver+0x144/0x194
> [cf82df40] [c030a378] ucc_uart_init+0x2c/0x94
> [cf82df50] [c02f21a0] kernel_init+0x98/0x27c
> [cf82dff0] [c000fa74] kernel_thread+0x44/0x60
> 
> ^^ The board is using ucc_uart.c and 8250.c, both registered as
>    "serial".
> 
> This patch fixes two drivers that are using "serial" for driver_name and
> not "ttyS" for dev_name. Drivers that are using "ttyS" for dev_name, will
> conflict anyway, so we don't bother with these.

Acked-by: Alan Cox <alan@redhat.com>
