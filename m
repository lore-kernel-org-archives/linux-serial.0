From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3 v7] serial: 8250: Add MSR/MCR TIOCM conversion
 wrapper functions
Date: Tue, 18 Jun 2019 09:50:46 +0200
Message-ID: <20190618075046.GA5710@kroah.com>
References: <20190617145952.4848-1-sr@denx.de>
 <20190617145952.4848-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617145952.4848-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 17, 2019 at 04:59:51PM +0200, Stefan Roese wrote:
> This patch adds wrapper functions to convert MSR <-> TIOCM and also
> MCR <-> TIOCM. These functions are used now in serial8250_do_set_mctrl()
> and serial8250_do_get_mctrl().
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> v7:
> - No change
> 
> v6:
> - New patch
> 
>  drivers/tty/serial/8250/8250.h      | 54 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c | 25 ++-----------
>  2 files changed, 57 insertions(+), 22 deletions(-)

This patch does not apply to my tty-next tree.  Please rebase the series
and resend.

thanks,

greg k-h
