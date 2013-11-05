From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 5 (tty/serial/xilinx_uartps)
Date: Tue, 05 Nov 2013 11:00:49 -0800
Message-ID: <52794061.2000300@infradead.org>
References: <20131105181617.228320b251ab24cce48d3b1c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20131105181617.228320b251ab24cce48d3b1c@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/04/13 23:16, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20131104:


on i386:

drivers/tty/serial/xilinx_uartps.c: In function 'xuartps_isr':
drivers/tty/serial/xilinx_uartps.c:247:13: error: 'struct uart_port' has no member named 'sysrq'


-- 
~Randy
