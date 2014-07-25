From: Bill Pringlemeir <bpringlemeir@nbsps.com>
Subject: fsl_lpuart/VF610: Division by zero.
Date: Fri, 25 Jul 2014 18:14:02 -0400
Message-ID: <87ha256q8l.fsf@nbsps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yuan Yao <yao.yuan@freescale.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

I have this 'dmesg' with ttyLP1,

Division by zero in kernel.
CPU: 0 PID: 187 Comm: getty Not tainted 3.15.0-rc8-04600-ge74a685-dirty #465
[<80013b18>] (unwind_backtrace) from [<80011e3c>] (show_stack+0x10/0x14)
[<80011e3c>] (show_stack) from [<8019a11c>] (Ldiv0+0x8/0x10)
[<8019a11c>] (Ldiv0) from [<801f0ad4>] (lpuart_startup+0x1e4/0x398)
[<801f0ad4>] (lpuart_startup) from [<801ef2e8>] (uart_startup.part.18+0x84/0x1e8)
[<801ef2e8>] (uart_startup.part.18) from [<801efd40>] (uart_open+0xe4/0x14c)
[<801efd40>] (uart_open) from [<801d586c>] (tty_open+0x1a0/0x5d0)
[<801d586c>] (tty_open) from [<800a1008>] (chrdev_open+0x9c/0x160)
[<800a1008>] (chrdev_open) from [<8009bd0c>] (do_dentry_open.isra.15+0x1b4/0x270)
[<8009bd0c>] (do_dentry_open.isra.15) from [<8009be98>] (finish_open+0x20/0x3c)
[<8009be98>] (finish_open) from [<800a8bfc>] (do_last.isra.66+0x404/0xc60)
[<800a8bfc>] (do_last.isra.66) from [<800a950c>] (path_openat+0xb4/0x5b0)
[<800a950c>] (path_openat) from [<800aa900>] (do_filp_open+0x2c/0x80)
[<800aa900>] (do_filp_open) from [<8009ce50>] (do_sys_open+0x120/0x1e0)
[<8009ce50>] (do_sys_open) from [<8000ed80>] (ret_fast_syscall+0x0/0x30)
random: nonblocking pool is initialized

I looked at the vmlinux objdump and it is here,

static int lpuart_dma_rx_request(struct uart_port *port)
{
...
	sport->dma_rx_timeout = (sport->port.timeout - HZ / 50) *
				FSL_UART_RX_DMA_BUFFER_SIZE * 3 /
				sport->rxfifo_size / 2;

The variable 'sport->rxfifo_size' is set in lpuart_setup_watermark() and
this is called after lpuart_dma_rx_request() in lpuart_startup().

It looks the same in the 'tty/serial' tree?

 https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/tree/drivers/tty/serial/fsl_lpuart.c#n768

I tried some simple changes but then I get no serial output, so I
thought it might be better to see if I am using the wrong git trees or
if the fix is more obvious to someone familiar with the code.

I think that normally everyone runs the console on this port and
'lpuart_console_setup()' is setting 'sport->rxfifo_size' before hand?
Or I don't understand why no one else is seeing this?

Thanks,
Bill Pringlemeir.
