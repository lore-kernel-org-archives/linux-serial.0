From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: msm: fix checkpatch warnings
Date: Mon, 4 Aug 2014 11:36:50 -0700
Message-ID: <20140804183650.GB19594@kroah.com>
References: <1407162046-29729-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407162046-29729-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 04, 2014 at 07:50:46PM +0530, Kiran Padwal wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: braces {} are not necessary for any arm of this statement
> 
> WARNING: Missing a blank line after declarations
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> WARNING: else is not generally useful after a break or return
> 
> WARNING: void function return statements are not generally useful
> 
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/tty/serial/msm_serial.c |   26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)

That's a lot of different things all mushed into one patch.  Please
break this up into "one change per patch" so we can review it better.

thanks,

greg k-h
