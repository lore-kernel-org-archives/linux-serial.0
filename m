From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: Fix serial8250 initialization crash
Date: Fri, 18 Jan 2019 13:02:53 +0100
Message-ID: <20190118120253.GB5532@kroah.com>
References: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhe.he@windriver.com
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de, Jisheng.Zhang@synaptics.com, darwin.dingel@alliedtelesis.co.nz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 17, 2019 at 05:00:19PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> The initialization code of interrupt backoff work might reference NULL
> pointer and cause the following crash, if no port was found.
> 
> [   10.017727] CPU 0 Unable to handle kernel paging request at virtual address 000001b0, epc == 807088e0, ra == 8070863c
> ---- snip ----
> [   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac
> [   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0
> [   11.789301] [<80728450>] platform_drv_probe+0x40/0x94
> [   11.830515] [<807264f8>] really_probe+0xf8/0x318
> [   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c
> [   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc
> [   11.951134] [<80725958>] bus_add_driver+0x200/0x234
> [   11.989756] [<807273d8>] driver_register+0x84/0x148
> [   12.029832] [<80d72f84>] serial8250_init+0x138/0x198
> [   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0
> [   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484
> [   12.150722] [<80a49420>] kernel_init+0x10/0xf8
> [   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c
> 
> This patch makes sure the initialization code can be reached only if a port
> is found.
> 
> Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")

No need for the "commit" in this string, this can just be written as:

Fixes: 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")

thanks,

greg k-h
