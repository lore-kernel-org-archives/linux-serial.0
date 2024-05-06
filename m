Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5213BAC7;
	Mon,  6 May 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007175; cv=none; b=o5YNBXn1kICCohuMdGkTkcXBPLQ1sMzrrGGiOY/S1HHBLCcISvOfnSTSyuLsKuiDVmSv0Q5RjFbXCpJtZodmunDeMOJ61jmKiTGmyJ/OlbU5ApRnAqLCdjX0nxelK4FBwN4O7WCOwiT95bgdyPsQGDJVj4ICr1M6BrE3jTGMNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007175; c=relaxed/simple;
	bh=DI3yNIsp/Iy/OvjzwTd2lIhn+/AKCMGXGRVuoRh7YNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYCbisPSuMdsV/v0v9HEoJAzY5ZMudW1ncY6t1z5eHTio+7nHaihQR5evH2Gaxnl1kiVlFuIRjTN9/o6y81pQg7cx+LkpPp6CgYgjFoOOLgq5n/qybuYmk79Xcu+hDe1ZNHoQkiC+PAUVytJxXJPvnAbiAv28zJ9mUAAqPz0RDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt1VKLCm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt1VKLCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715007173; x=1746543173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DI3yNIsp/Iy/OvjzwTd2lIhn+/AKCMGXGRVuoRh7YNc=;
  b=Tt1VKLCmXmJILT7ybTdryRfPamk73mKNxVGPitzc9Efucr9mdZ9wd4P6
   4258ztuetL9bBtWAYqgR9gspCUs5v+3Kcw7RpUCJtcfbfyRwnxexWx7T9
   2iQB7/h158UO7ZHaFCoh+Rt4wPpGasM2e5h1qNH4VCKoWv92xv/3qHeS5
   0/Y6WjrULYg9PY9KAD0dpk7ObJd/7xVM1y2kCE/XiWWPo8ouTwcxMHNyy
   kE79lyJHpRA72Dk/LcFYOawRcwVC8p/h2RGr0DneQhW0NfuX94tf2Pa/X
   Dhm/dGVc1LDS7a0RNt5ZlOS/k/X53rehuasu6DQQnF41lIPmJgixPAXtf
   Q==;
X-CSE-ConnectionGUID: DAMuflN7Rku1jGhDiAaw5g==
X-CSE-MsgGUID: qhOGIYHNToWWsEqaoco/wQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28281051"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28281051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:52:51 -0700
X-CSE-ConnectionGUID: 3pyUBm5tTby3wGXV81kkWQ==
X-CSE-MsgGUID: g+t1Na37TrqOmFoQyIM5CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28150764"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:52:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3zhv-00000004jRC-2J9G;
	Mon, 06 May 2024 17:52:47 +0300
Date: Mon, 6 May 2024 17:52:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Tony Lindgren <tony@atomide.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v3 0/2] Defer probing of SAM if serdev device is not ready
Message-ID: <Zjjuvx3t7UYQPR_y@smile.fi.intel.com>
References: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
 <85ac363b-d129-4525-89aa-d4528b8188a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ac363b-d129-4525-89aa-d4528b8188a7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 06, 2024 at 04:41:19PM +0200, Hans de Goede wrote:
> On 5/5/24 3:07 PM, Weifeng Liu wrote:

...

> If a serdev_device_driver is already loaded for a serdev_tty_port when it
> gets registered by tty_port_register_device_attr_serdev() then that
> driver's probe() method will be called immediately.
> 
> The serdev_device_driver's probe() method should then be able to call
> serdev_device_open() successfully, but because UPF_DEAD is still dead
> serdev_device_open() will fail with -ENXIO in this scenario:
> 
>   serdev_device_open()
>   ctrl->ops->open()	/* this callback being ttyport_open() */
>   tty->ops->open()	/* this callback being uart_open() */
>   tty_port_open()
>   port->ops->activate()	/* this callback being uart_port_activate() */
>   Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.
> 
> Fix this be clearing UPF_DEAD before tty_port_register_device_attr_serdev()
> note this only moves up the UPD_DEAD clearing a small bit, before:
> 
>   tty_port_register_device_attr_serdev();
>   mutex_unlock(&tty_port.mutex);
>   uart_port.flags &= ~UPF_DEAD;
>   mutex_unlock(&port_mutex);
> 
> after:
> 
>   uart_port.flags &= ~UPF_DEAD;
>   tty_port_register_device_attr_serdev();
>   mutex_unlock(&tty_port.mutex);
>   mutex_unlock(&port_mutex);

> Reported-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/20240505130800.2546640-1-weifeng.liu.z@gmail.com/

> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can you move Cc after the cutter '---' line?

The patch makes sense to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
but Cc'ed Tony just in case.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/tty/serial/serial_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ff85ebd3a007..d9424fe6513b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3196,6 +3196,9 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	if (uport->attr_group)
>  		uport->tty_groups[1] = uport->attr_group;
>  
> +	/* Ensure serdev drivers can call serdev_device_open() right away */
> +	uport->flags &= ~UPF_DEAD;
> +
>  	/*
>  	 * Register the port whether it's detected or not.  This allows
>  	 * setserial to be used to alter this port's parameters.
> @@ -3206,6 +3209,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
>  	if (!IS_ERR(tty_dev)) {
>  		device_set_wakeup_capable(tty_dev, 1);
>  	} else {
> +		uport->flags |= UPF_DEAD;
>  		dev_err(uport->dev, "Cannot register tty device on line %d\n",
>  		       uport->line);
>  	}
> @@ -3411,8 +3415,6 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  	if (ret)
>  		goto err_unregister_port_dev;
>  
> -	port->flags &= ~UPF_DEAD;
> -
>  	mutex_unlock(&port_mutex);
>  
>  	return 0;

-- 
With Best Regards,
Andy Shevchenko


