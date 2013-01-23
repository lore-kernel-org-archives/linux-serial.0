From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jan 23 (pch_uart.c)
Date: Wed, 23 Jan 2013 15:28:38 -0800
Message-ID: <51007226.1040604@infradead.org>
References: <20130123174336.47c0113740a14da7f6a92187@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130123174336.47c0113740a14da7f6a92187@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/22/13 22:43, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130122:
> 


on i386:

  CC [M]  drivers/tty/serial/pch_uart.o
drivers/tty/serial/pch_uart.c: In function 'pch_uart_hal_read':
drivers/tty/serial/pch_uart.c:572:11: error: 'struct uart_port' has no member named 'sysrq'
make[4]: *** [drivers/tty/serial/pch_uart.o] Error 1



when SERIAL_PCH_UART_CONSOLE is not enabled.

-- 
~Randy
