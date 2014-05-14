From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for May 14 (tty/serial/men_z135_uart.c)
Date: Wed, 14 May 2014 09:31:10 -0700
Message-ID: <53739A4E.2040009@infradead.org>
References: <20140514182649.33e63e49@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:32999 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbaENQbQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 May 2014 12:31:16 -0400
In-Reply-To: <20140514182649.33e63e49@canb.auug.org.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johannes Thumshirn <johannes.thumshirn@men.de>, linux-serial@vger.kernel.org

On 05/14/2014 01:26 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20140513:
> 

on x86_64:

CONFIG_SERIAL_CORE=m
but SERIAL_MEN_Z135=y.

drivers/built-in.o: In function `men_z135_remove':
men_z135_uart.c:(.text+0x5bc53): undefined reference to `uart_remove_one_port'
drivers/built-in.o: In function `men_z135_set_termios':
men_z135_uart.c:(.text+0x5c3b5): undefined reference to `uart_get_baud_rate'
men_z135_uart.c:(.text+0x5c415): undefined reference to `uart_update_timeout'
drivers/built-in.o: In function `men_z135_handle_tx':
men_z135_uart.c:(.text+0x5c8f4): undefined reference to `uart_write_wakeup'
drivers/built-in.o: In function `men_z135_intr':
men_z135_uart.c:(.text+0x5ce28): undefined reference to `uart_handle_dcd_change'
men_z135_uart.c:(.text+0x5ce51): undefined reference to `uart_handle_cts_change'
drivers/built-in.o: In function `men_z135_probe':
men_z135_uart.c:(.text+0x5cf96): undefined reference to `uart_add_one_port'
drivers/built-in.o: In function `men_z135_init':
men_z135_uart.c:(.init.text+0x26e9): undefined reference to `uart_register_driver'
men_z135_uart.c:(.init.text+0x2766): undefined reference to `uart_unregister_driver'
drivers/built-in.o: In function `men_z135_exit':
men_z135_uart.c:(.exit.text+0xe4): undefined reference to `uart_unregister_driver'
make[1]: *** [vmlinux] Error 1


-- 
~Randy
