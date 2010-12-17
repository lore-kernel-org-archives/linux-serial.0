From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] Serial: Avoid unbalanced IRQ wake disable during resume
Date: Fri, 17 Dec 2010 11:52:44 +0530
Message-ID: <31ed13d20cd8ceb25e914a60cf5bb588@mail.gmail.com>
References: <14261.10.24.255.17.1292503367.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53979 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab0LQGWr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Dec 2010 01:22:47 -0500
Received: by yxm34 with SMTP id 34so243218yxm.25
        for <linux-serial@vger.kernel.org>; Thu, 16 Dec 2010 22:22:46 -0800 (PST)
In-Reply-To: <14261.10.24.255.17.1292503367.squirrel@dbdmail.itg.ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Govindraj Raja <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Govindraj.R [mailto:govindraj.raja@ti.com]
> Sent: Thursday, December 16, 2010 6:13 PM
> To: linux-serial@vger.kernel.org; Greg KH
> Cc: Paul Walmsley; Santosh Shilimkar; Kevin Hilman; Greg KH
> Subject: [PATCH] Serial: Avoid unbalanced IRQ wake disable during resume
>
> To avoid unbalanced IRQ wake disable, ensure that wakeups are disabled
> only when wakeups have been successfully enabled.
> Tested on OMAP3630SDP/ZOOM3.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Greg KH <greg@kroah.com>
As suggested by Kevin, please update the change log. You could
also use the change log of intermediate version I created.

Also add a note the fix is suggested by Paul.

o.w
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> This patch is in conclusion to issue discussed in below thread:
> http://www.spinics.net/lists/linux-omap/msg41356.html
>
>  drivers/serial/serial_core.c |    8 ++++++--
>  include/linux/serial_core.h  |    1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> index 9ffa5be..7ec1e11 100644
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -1985,7 +1985,8 @@ int uart_suspend_port(struct uart_driver *drv,
> struct uart_port *uport)
>
>  	tty_dev = device_find_child(uport->dev, &match,
serial_match_port);
>  	if (device_may_wakeup(tty_dev)) {
> -		enable_irq_wake(uport->irq);
> +		if (!enable_irq_wake(uport->irq))
> +			uport->irq_wake = 1;
>  		put_device(tty_dev);
>  		mutex_unlock(&port->mutex);
>  		return 0;
> @@ -2051,7 +2052,10 @@ int uart_resume_port(struct uart_driver *drv,
> struct uart_port *uport)
>
>  	tty_dev = device_find_child(uport->dev, &match,
serial_match_port);
>  	if (!uport->suspended && device_may_wakeup(tty_dev)) {
> -		disable_irq_wake(uport->irq);
> +		if (uport->irq_wake) {
> +			disable_irq_wake(uport->irq);
> +			uport->irq_wake = 0;
> +		}
>  		mutex_unlock(&port->mutex);
>  		return 0;
>  	}
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 212eb4c..28b6698 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -361,6 +361,7 @@ struct uart_port {
>  	struct device		*dev;			/* parent device
*/
>  	unsigned char		hub6;			/* this should be
in the
> 8250 driver */
>  	unsigned char		suspended;
> +	unsigned char		irq_wake;
>  	unsigned char		unused[2];
>  	void			*private_data;		/* generic
platform data
> pointer */
>  };
> --
> 1.7.1
>
