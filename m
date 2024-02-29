Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693AA6D52F;
	Thu, 29 Feb 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244049; cv=none; b=f+r3ETLq0RXONqy4IT0+9uUyede7LfFRwRPcT5z737aS8mTuvD95GrBPyALtLMkZMnIYpjqCwe+J88ixAMHHHVIz3dOornlKFHSwPF7qELCrdEa0BPh78tYiwEMERvqJqo7BVz1UgHCbublK2fDdElzTaKKLti21WFZQFHIEX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244049; c=relaxed/simple;
	bh=Otvi24GU73XCeo3Jc053Uc3VjmLPm1+czoFS3dRaPro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iay0hDzD3LQSpnkkXsC0H94Fv6drF9slgihcbCtaNPXWQPOiBQLWgY5cUMLwmEJZxRYTlxcRXVL9i/wp2O9oxVz/+Xt6I7G96kRYZovBr0n31XVJK5VuxzZuj13q2NfbeD/moLR/d+gul5QZZQ6RnvuR4SUN4XPT44lciKIynRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/s5U4z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/s5U4z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6F9C433C7;
	Thu, 29 Feb 2024 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709244048;
	bh=Otvi24GU73XCeo3Jc053Uc3VjmLPm1+czoFS3dRaPro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/s5U4z1gKMD/aFql4qJbtRtuDDHC2VPe+By7Vkog4myAQWbXIECVGWleGyAsI8LT
	 tKYuniW/iTIqprbU5M8iiK43bHBW+IQaD00Z6edRsSLLIqCxKSCdlnjDD8kQ5nwQbS
	 P5yqkIpvFFuOmYSAI7iBOB7UfAhyaFbaxKO/A5JI=
Date: Thu, 29 Feb 2024 23:00:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: GuanBing Huang <albanhuang@outlook.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, albanhuang@tencent.com
Subject: Re: [PATCH] serial: 8250_pnp: Support configurable reg shift property
Message-ID: <2024022916-captivate-state-0255@gregkh>
References: <PSAPR06MB49522EB50BDE08A5D9D0DACEC95F2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB49522EB50BDE08A5D9D0DACEC95F2@PSAPR06MB4952.apcprd06.prod.outlook.com>

On Thu, Feb 29, 2024 at 07:51:54PM +0800, GuanBing Huang wrote:
> From: albanhuang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.
> 
> Signed-off-by: albanhuang <albanhuang@tencent.com>
> Signed-off-by: tombinfan <tombinfan@tencent.com>
> Signed-off-by: dylanlhdu <dylanlhdu@tencent.com>

"interesting" names, can you not just use your native encoding to make
this easier?

> ---
>  drivers/tty/serial/8250/8250_pnp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
> index 1974bbadc975..25b4e41e9745 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -473,6 +473,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  		uart.port.flags |= UPF_SHARE_IRQ;
>  	uart.port.uartclk = 1843200;
>  	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
> +	device_property_read_u8(&dev->dev, "reg-shift", &uart.port.regshift);

Is this property documented somewhere?  What happens if the property
isn't there?

thanks,

greg k-h
