Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C938C2B9F8
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CA461400
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhEYIPZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 May 2021 04:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhEYIPW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 May 2021 04:15:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DFDC61400;
        Tue, 25 May 2021 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621930432;
        bh=RF4PC/HxG1yjkdGQ9/OAUEh6Ea/yHdbQroJUlBlW9pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sm07AWbhKMzadIi0AlQDzQcdCEmpwMJ6R3myifNMhLh6rnVe20y17E50wefNOWM/S
         D2hpbNinWSrLgeuskZi0R8BlVrDvmK+AS2UfKuTKm1f1oRl1nFkItkznVM+YAx7KDC
         b59x1iq6S8J1Anmjpf5HDct/LS2jDyBuy06iMIbs=
Date:   Tue, 25 May 2021 10:13:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, jacmet@sunsite.dk, git@xilinx.com
Subject: Re: [PATCH 2/2] tty: serial: uartlite: Add runtime pm support
Message-ID: <YKyxvlL0CMkVSvlq@kroah.com>
References: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1621929844-19727-3-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621929844-19727-3-git-send-email-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 25, 2021 at 01:34:04PM +0530, Shubhrajyoti Datta wrote:
> Add runtime pm support.

We need more than a 4 word changelog text.

Please be more descriptive as to why you need this and what it is doing.

> +#define UART_AUTOSUSPEND_TIMEOUT	3000

Units?



>  
>  /* Static pointer to console port */
>  #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
> @@ -390,12 +392,16 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
>  static void ulite_pm(struct uart_port *port, unsigned int state,
>  		     unsigned int oldstate)
>  {
> -	struct uartlite_data *pdata = port->private_data;
> +	int ret;
>  
> -	if (!state)
> -		clk_enable(pdata->clk);
> -	else
> -		clk_disable(pdata->clk);
> +	if (!state) {
> +		ret = pm_runtime_get_sync(port->dev);
> +		if (ret < 0)
> +			dev_err(port->dev, "Failed to enable clocks\n");
> +	} else {
> +		pm_runtime_mark_last_busy(port->dev);
> +		pm_runtime_put_autosuspend(port->dev);
> +	}
>  }
>  
>  #ifdef CONFIG_CONSOLE_POLL
> @@ -734,11 +740,37 @@ static int __maybe_unused ulite_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused ulite_runtime_suspend(struct device *dev)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct uartlite_data *pdata = port->private_data;
> +
> +	clk_disable(pdata->clk);
> +	return 0;
> +};
> +
> +static int __maybe_unused ulite_runtime_resume(struct device *dev)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct uartlite_data *pdata = port->private_data;
> +	int ret;
> +
> +	ret = clk_enable(pdata->clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable clock.\n");
> +		return ret;
> +	}
> +	return 0;
> +}
>  /* ---------------------------------------------------------------------

Blank line missing.

thanks,

greg k-h
