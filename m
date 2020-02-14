Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C00C3B1BF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF752465D
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710543;
	bh=9WH9ZaHy9w29wIPWXd72IJO3cxBpozbYlmMVDdm5NJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DoTc8GMwikU0pKNf6UG1wx3y04KZ/9rBh5lCGlbzRrsa+4L83gV8eRvAspieDZSah
	 agf6M2zNxzEgzpdNqhexBOT3zGhXci/WyYIYW0bXkX1GY69BSk9UPMDwUkxuTjogbc
	 wdB16jBOnfeJ7X+3XLLL5X98iqIhRD4kfZ0tFyxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbgBNUCW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389461AbgBNUCS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:18 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF5A24680;
        Fri, 14 Feb 2020 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710538;
        bh=9WH9ZaHy9w29wIPWXd72IJO3cxBpozbYlmMVDdm5NJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oB3VmghKi7X0IxZ7pQWILEDbCWzFGMTZpQ5bnbWrXHmxKme2z39MbUjZxmjc86z4Z
         qCRgIcq5N8Ycj+y+JhlTQ33CR+E1V4g62p8O2Q5/HyKEkbX67AHl/0sSEtVF7vIqHh
         AwoCF4OA/Hae2Dr0mMRPBsK+uaK8y8n+/ZFrLTrg=
Date:   Fri, 14 Feb 2020 08:28:47 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/8] serial: core: Allow detach and attach serial
 device for console
Message-ID: <20200214162847.GB3987177@kroah.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-5-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:43:35PM +0200, Andy Shevchenko wrote:
> In the future we would like to disable power management on the serial devices
> used as kernel consoles to avoid weird behaviour in some cases. However,
> disabling PM may prevent system to go to deep sleep states, which in its turn
> leads to the higher power consumption.
> 
> Tony Lindgren proposed a work around, i.e. allow user to detach such consoles
> to make PM working again. In case user wants to see what's going on, it also
> provides a mechanism to attach console back.
> 
> Link: https://lists.openwall.net/linux-kernel/2018/09/29/65
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-tty |  7 ++++
>  drivers/tty/serial/serial_core.c    | 60 +++++++++++++++++++++++++++--
>  2 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
> index 9eb3c2b6b040..e157130a6792 100644
> --- a/Documentation/ABI/testing/sysfs-tty
> +++ b/Documentation/ABI/testing/sysfs-tty
> @@ -154,3 +154,10 @@ Description:
>  		 device specification. For example, when user sets 7bytes on
>  		 16550A, which has 1/4/8/14 bytes trigger, the RX trigger is
>  		 automatically changed to 4 bytes.
> +
> +What:		/sys/class/tty/ttyS0/console
> +Date:		February 2020
> +Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +Description:
> +		 Allows user to detach or attach back the given device as
> +		 kernel console. It shows and accepts a boolean variable.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7564bbd3061c..0415bb76efa0 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1919,7 +1919,7 @@ static inline bool uart_console_enabled(struct uart_port *port)
>   */
>  static inline void uart_port_spin_lock_init(struct uart_port *port)
>  {
> -	if (uart_console_enabled(port))
> +	if (uart_console(port))
>  		return;
>  
>  	spin_lock_init(&port->lock);
> @@ -2749,6 +2749,56 @@ static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
>  }
>  
> +static ssize_t uart_get_attr_console(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct tty_port *port = dev_get_drvdata(dev);
> +	struct uart_state *state = container_of(port, struct uart_state, port);
> +	struct uart_port *uport;
> +	bool console = false;
> +
> +	mutex_lock(&port->mutex);
> +	uport = uart_port_check(state);
> +	if (uport)
> +		console = uart_console_enabled(uport);
> +	mutex_unlock(&port->mutex);
> +
> +	return sprintf(buf, "%c\n", console ? 'Y' : 'N');
> +}
> +
> +static ssize_t uart_set_attr_console(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct tty_port *port = dev_get_drvdata(dev);
> +	struct uart_state *state = container_of(port, struct uart_state, port);
> +	struct uart_port *uport;
> +	bool oldconsole, newconsole;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &newconsole);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&port->mutex);
> +	uport = uart_port_check(state);
> +	if (uport) {
> +		oldconsole = uart_console_enabled(uport);
> +		if (oldconsole && !newconsole) {
> +			ret = unregister_console(uport->cons);
> +		} else if (!oldconsole && newconsole) {
> +			if (uart_console(uport))
> +				register_console(uport->cons);
> +			else
> +				ret = -ENOENT;
> +		}
> +	} else {
> +		ret = -ENXIO;
> +	}
> +	mutex_unlock(&port->mutex);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>  static DEVICE_ATTR(type, 0440, uart_get_attr_type, NULL);
>  static DEVICE_ATTR(line, 0440, uart_get_attr_line, NULL);
>  static DEVICE_ATTR(port, 0440, uart_get_attr_port, NULL);
> @@ -2762,6 +2812,7 @@ static DEVICE_ATTR(custom_divisor, 0440, uart_get_attr_custom_divisor, NULL);
>  static DEVICE_ATTR(io_type, 0440, uart_get_attr_io_type, NULL);
>  static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
>  static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);
> +static DEVICE_ATTR(console, 0640, uart_get_attr_console, uart_set_attr_console);

Again, DEVICE_ATTR_RW() in the future?

thanks,

greg k-h
