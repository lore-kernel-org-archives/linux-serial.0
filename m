From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Mon, 4 Apr 2016 21:02:40 -0700
Message-ID: <20160405040240.GA24639@kroah.com>
References: <1459827166-13861-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459827166-13861-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Noam Camus <noamc@ezchip.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 05, 2016 at 11:32:46AM +0800, Kefeng Wang wrote:
> Commit cdcea058e510 ("serial: 8250_dw: Avoid serial_outx code duplicate
> with new dw8250_check_lcr()") introduce a wrong logic when write val to
> LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used unconditionally.
> 
> The __raw_readq/__raw_writeq is introduced by commit bca2092d7897 ("serial:
> 8250_dw: Use 64-bit access for OCTEON.") for OCTEON, so for !PORT_OCTEON,
> we better to use coincident write func.
> 
> Fixes: cdcea058e510("serial: 8250_dw: Avoid serial_outx code duplicate with new dw8250_check_lcr()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> Keep #ifdef CONFIG_64BIT to ensure it built under arch lacking readq/writeq.
> 
>  drivers/tty/serial/8250/8250_dw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

What changed between all of these versions?  Always document that below
the --- line otherwise I think they are all the same and I'll just
delete them all :)

v4 please.

thanks,

greg k-h
