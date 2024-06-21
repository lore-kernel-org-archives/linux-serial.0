Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27813152E0A
	for <linux-serial@vger.kernel.org>; Fri, 21 Jun 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973461; cv=none; b=O3E3Lu+sLbKSiGzUZJC6Q1xs+doFsY7xXRS/5nURxOuNUodJMTi6Ho2MWNHl3e6cWJES4+tgpEeBGgYa4J6illKuJseF7owGd/9GwOuwg1LnXxEyQyaOMFOJORpdIuv/Fp/wVFaLvTxz1Off5NX2R8ombY++RZxCGaWOhXL0xT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973461; c=relaxed/simple;
	bh=ucGBNSY5cLhxSCcr2l1oye2DVnHmbbMRC+prxXPLvqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMrFsM50Ubx6qvktrsPrIhNDAZfcSy0+WeM1Gc4LvvdH40ecJaH5LxvuK2qmd2dTc7aoV0L8cqckWzJOZ/tofvLA2tJW0LWG0Es1KJ0dknYeis9LtEEM+GCm9mWfieM+mFc7ZjrYKj0UtTtXsCMCusQWFoq8EJomJCdV1u85YKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WSv578Hi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WSv578Hi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso257041fa.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Jun 2024 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718973456; x=1719578256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ7xhLx/NPL19GrCC3b6EYi+DH6zLU+tizNYvDxMgL8=;
        b=WSv578HiSF0b53guJrBEkcLuZ843Q0dN/wlSS0b2UhvK+vq7fZDFZm7VyKtYEjuGiG
         YLKNyQDE+bp519WDdadQb5Zg70+5R+t8+HqGmNGgUUdI6xv7pmS18JJIdBDTvzjwutxW
         j9DA9uS++tbOwkcdLvbW6eAsZuCJ+YkF3OPQRG6XCnjFMIp5qwmGkVwThycGvSFlb5wV
         BiJlQJCwwLlUG3LaomYiURS4hzIB3EcbLJZoj8J4PzhpTitk0hqPEdSBpKEgEWmBg0fh
         Qf2zX71w0OX9Y2IIULhnwVIHzaasIV5hoWOmc1ZNwlI14WaR4jbGLVgLGcTOSfH6TfK7
         P0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973456; x=1719578256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ7xhLx/NPL19GrCC3b6EYi+DH6zLU+tizNYvDxMgL8=;
        b=UHdDiBbpNwedjRUVdzNaX8pGCX2LOQE+pJhg5rtcpM+RvA9JOSt6vR406MXOcE4xZ8
         +0VhdpQNoGmHmNnovw3P5orJoKsbDXKG5q5oxCXk4UKq0NaxIAW0NrC1+JIivIhKPRTT
         9PQtrTTSdYiA/GMi+HCKH7drMR7BBKSSEA5zv3WANLu0dUY9tLD7RJm3hNpfywEhKrka
         /xS9NIjVTzInbUF7C3AEcSC7s8G6tRffBwK7Y0Dd8CYuS4f7Zs1LypwaBO16clg2yICU
         J/qHgBhIUQKHQYv7xO2Isyes4pSMp9iMXhdud6j32s7JJgx6q3nPmGs6BWLZNpNrF8sV
         IzOw==
X-Forwarded-Encrypted: i=1; AJvYcCXrsLrFSPJu/JegLOMQghKKOrjJIz3RCA/KnqPwf/VrucpjJAL9jDkfaquoWyCGJdn6hiSmTQU275Ke8oB/sJVjyqWIXt6OKixeuycU
X-Gm-Message-State: AOJu0YzBbkZzaTNImz3tL0Z3PsgrJztm8eOsXJs16RFqK8IDkM4uyZ4m
	Kr0WNmHlR4Pp+eokgr0f06yFF/zwYbYTMVXvL1H97XqWcXAaCqBFLo+hMP82Ye8=
X-Google-Smtp-Source: AGHT+IHWhMY+R5rYPYKLHQgcL7L8rEMwsrZbeOOm0QIpCgEhM5DPDA6TIdgrpLdPY4KDJY5mbC2Y6Q==
X-Received: by 2002:a2e:2e0c:0:b0:2eb:fe31:cae6 with SMTP id 38308e7fff4ca-2ec3cee126dmr64557801fa.37.1718973456371;
        Fri, 21 Jun 2024 05:37:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107b5c8sm1296692b3a.6.2024.06.21.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:37:35 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:37:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] serial: core: Add
 serial_base_match_and_update_preferred_console()
Message-ID: <ZnV0B4wakVehASn4@pathway.suse.cz>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <20240620124541.164931-5-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620124541.164931-5-tony.lindgren@linux.intel.com>

On Thu 2024-06-20 15:45:29, Tony Lindgren wrote:
> Let's add serial_base_match_and_update_preferred_console() for consoles
> using DEVNAME:0.0 style naming.
> 
> The earlier approach to add it caused issues in the kernel command line
> ordering as we were calling __add_preferred_console() again for the
> deferred consoles.
> 
> Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Looks good and seems to work well:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

See an idea below.

> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -204,6 +205,42 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
>  	put_device(&port_dev->dev);
>  }
>  
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +
> +/**
> + * serial_base_match_and_update_preferred_console - Match and update a preferred console
> + * @drv: Serial port device driver
> + * @port: Serial port instance
> + *
> + * Tries to match and update the preferred console for a serial port for
> + * the kernel command line option console=DEVNAME:0.0.
> + *
> + * Cannot be called early for ISA ports, depends on struct device.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int serial_base_match_and_update_preferred_console(struct uart_driver *drv,
> +						   struct uart_port *port)
> +{
> +	const char *port_match __free(kfree) = NULL;
> +	int ret;
> +
> +	port_match = kasprintf(GFP_KERNEL, "%s:%d.%d", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);
> +	if (!port_match)
> +		return -ENOMEM;

The name is going to be compared with:

struct console_cmdline
{
[...]
	char	devname[32];			/* DEVNAME:0.0 style device name */

It looks like an overkill to allocate such a small buffer. It would
be perfectly fine to use a buffer on stack.

Well, we would need to define somewhere (likely in include/linux/console.h):

#define CONSOLE_DEVNAME_LEN 32

and then do

	char port_match[CONSOLE_DEVNAME_LEN];
	int len;

	len = snprintf(port_match, ARRAY_SIZE(port_match), "%s:%d.%d",
		       dev_name(port->dev), port->ctrl_id, port->port_id);
	if (len >= ARRAY_SIZE(port_match)) {
		pr_warn("Console devname does not fit into the buffer: "%s:%d.%d\n",
			 dev_name(port->dev), port->ctrl_id, port->port_id);
		return -ENOMEM;
	}

The advantage is that it would warn when there are longer device names.
It would help to catch situations when CONSOLE_DEVNAME_LEN is not big enough.

It might be done in a separate patch.

> +
> +	ret = match_devname_and_update_preferred_console(port_match,
> +							 drv->dev_name,
> +							 port->line);
> +	if (ret == -ENOENT)
> +		return 0;
> +
> +	return ret;
> +}
> +
> +#endif
> +
>  static int serial_base_init(void)
>  {
>  	int ret;

Best Regards,
Petr
