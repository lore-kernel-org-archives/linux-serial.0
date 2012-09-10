From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: mxs-auart: put the device when exit or error
Date: Mon, 10 Sep 2012 16:00:05 -0700
Message-ID: <20120910230005.GA15782@kroah.com>
References: <20120907024349.GH26709@S2101-09.ap.freescale.net>
 <1346985187-30459-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346985187-30459-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 07, 2012 at 10:33:07AM +0800, Huang Shijie wrote:
> We call the get_device() in the mxs_auart_probe().
> For the balance of the reference count, we should put the
> device in the mxs_auart_remove() or in the error path of
> probe.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/mxs-auart.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I already applied the previous version, so can you make up a patch
against the tty-next tree that fixes it up properly based on this patch?

thanks,

greg k-h
