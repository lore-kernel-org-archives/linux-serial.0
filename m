From: Stefan Agner <stefan@agner.ch>
Subject: Re: =?UTF-8?Q?fsl=5Flpuart/VF=36=31=30=3A=20Division=20by=20zero?=
 =?UTF-8?Q?=2E?=
Date: Sat, 26 Jul 2014 14:08:38 +0200
Message-ID: <1aa4c71fa7441f217f33e7be9a8fa1b9@agner.ch>
References: <87ha256q8l.fsf@nbsps.com> <87d2ct6p77.fsf@nbsps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.102]:47471 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaGZMIX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Jul 2014 08:08:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.kmu-office.ch (Postfix) with ESMTP id D163C3EA097
	for <linux-serial@vger.kernel.org>; Sat, 26 Jul 2014 14:08:05 +0200 (CEST)
Received: from mail.kmu-office.ch ([127.0.0.1])
	by localhost (mail.kmu-office.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2+fmAH8ib8-2 for <linux-serial@vger.kernel.org>;
	Sat, 26 Jul 2014 14:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.kmu-office.ch (Postfix) with ESMTP id 2ED063EA0AA
	for <linux-serial@vger.kernel.org>; Sat, 26 Jul 2014 14:08:04 +0200 (CEST)
In-Reply-To: <87d2ct6p77.fsf@nbsps.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bill Pringlemeir <bpringlemeir@nbsps.com>
Cc: Yuan Yao <yao.yuan@freescale.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org

Hi Bill,

Am 2014-07-26 00:36, schrieb Bill Pringlemeir:
> On 25 Jul 2014, bpringlemeir@nbsps.com wrote:
> 
>> I have this 'dmesg' with ttyLP1,
>>
>> Division by zero in kernel.  CPU: 0 PID: 187 Comm: getty Not tainted
>> 3.15.0-rc8-04600-ge74a685-dirty #465 [<80013b18>] (unwind_backtrace)
>> from [<80011e3c>] (show_stack+0x10/0x14) [<80011e3c>] (show_stack)
>> from [<8019a11c>] (Ldiv0+0x8/0x10) [<8019a11c>] (Ldiv0) from
>> [<801f0ad4>] (lpuart_startup+0x1e4/0x398) [<801f0ad4>]
>> (lpuart_startup) from [<801ef2e8>] (uart_startup.part.18+0x84/0x1e8)
>> [<801ef2e8>] (uart_startup.part.18) from [<801efd40>]
>> (uart_open+0xe4/0x14c) [<801efd40>] (uart_open) from [<801d586c>]
>> (tty_open+0x1a0/0x5d0) [<801d586c>] (tty_open) from [<800a1008>]
>> (chrdev_open+0x9c/0x160) [<800a1008>] (chrdev_open) from [<8009bd0c>]
>> (do_dentry_open.isra.15+0x1b4/0x270) [<8009bd0c>]
>> (do_dentry_open.isra.15) from [<8009be98>] (finish_open+0x20/0x3c)
>> [<8009be98>] (finish_open) from [<800a8bfc>]
>> (do_last.isra.66+0x404/0xc60) [<800a8bfc>] (do_last.isra.66) from
>> [<800a950c>] (path_openat+0xb4/0x5b0) [<800a950c>] (path_openat) from
>> [<800aa900>] (do_filp_open+0x2c/0x80) [<800aa900>] (do_filp_open) from
>> [<8009ce50>] (do_sys_open+0x120/0x1e0) [<8009ce50>] (do_sys_open) from
>> [<8000ed80>] (ret_fast_syscall+0x0/0x30) random: nonblocking pool is
>> initialized
>>
>> I looked at the vmlinux objdump and it is here,
>>
>> static int lpuart_dma_rx_request(struct uart_port *port)
>> {
>> ...
>> 	sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
>> 				FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
>> 				sport->rxfifo_size / 2;
>>
>> The variable 'sport->rxfifo_size' is set in lpuart_setup_watermark()
>> and this is called after lpuart_dma_rx_request() in lpuart_startup().

I observed this division by zero too, I recently sent a patch for that.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268772.html

Greg already added that to his tty-next tree:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/tree/drivers/tty/serial/fsl_lpuart.c?h=tty-next#n1309

I also observed that DMA did not work yet, hence I a created a second
patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268773.html

But eDMA in general was broken too,  this patch solved that, hence you
might want apply that patch too:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268199.html

All patches are lined up for 3.17, so things should be smooth from that
release on.

In my last tests the driver worked more or less reliable, as is, however
I think the RX path still has some problems regarding DMA: The function
lpuart_dma_rx_complete never gets called, 
lpuart_timer_func receives the data later on. When setting
FSL_UART_RX_DMA_BUFFER_SIZE to 16 bytes (for UART0),
lpuart_dma_rx_complete was called, but then receive did not work
reliable anymore. I had not yet the time to investigate this further.

--
Stefan
