From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 02/10] serdev: add serdev_device_wait_until_sent
Date: Sat, 8 Apr 2017 18:57:40 +0200
Message-ID: <20170408165740.GA20058@kroah.com>
References: <20170328155939.31566-1-sre@kernel.org>
 <20170328155939.31566-3-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328155939.31566-3-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 05:59:31PM +0200, Sebastian Reichel wrote:
> Add method, which waits until the transmission buffer has been sent.
> Note, that the change in ttyport_write_wakeup is related, since
> tty_wait_until_sent will hang without that change.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv2:
>  * Avoid goto in ttyport_write_wakeup
> ---
>  drivers/tty/serdev/core.c           | 11 +++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 18 ++++++++++++++----
>  include/linux/serdev.h              |  3 +++
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index f4c6c90add78..a63b74031e22 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -173,6 +173,17 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>  
> +void serdev_device_wait_until_sent(struct serdev_device *serdev, long timeout)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->wait_until_sent)
> +		return;
> +
> +	ctrl->ops->wait_until_sent(ctrl, timeout);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);

Is this still needed now that we have serdev_device_write() with an
unlimited timeout available?

thanks,

greg k-h
