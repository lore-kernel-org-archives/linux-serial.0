Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DF136E;
	Sat, 18 Jan 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737185651; cv=none; b=M7kXsXjLxKc5HgJz9LKY1CLd5c85QPYvkg2XgwNm60nMcvJJYAomRXJUeWNeuR7kWH1ZD9It3gLLbOLAB6L9F0N6klW9OpFCU/T+w7jh4+TPNcBKt3GzVEVMEbVx3MNtV85qsF1j+PM+NZ+F1XH2D6UiPYA7NxFZBvH5jpPWc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737185651; c=relaxed/simple;
	bh=+617MChcs9i67iVPR/ganCjVbRyDob252rGnbqiX69g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyDWuZcLY283KJTGhFqwRP0QC/aneyFFKDp1+EXgcYJmcaMKTg37npUW3T6zwtzvG5oSe7lwwLz5rRt8E6b0Am6MODUl1ooItZtHuM8vK2lmc5/oTwOK7Z0MqOoIUDn8YYG/L8fxbmMgtJbxQ+beG7H5KPBIAIokK9uOi6VQK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNptRiWF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNptRiWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5473DC4CED1;
	Sat, 18 Jan 2025 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737185650;
	bh=+617MChcs9i67iVPR/ganCjVbRyDob252rGnbqiX69g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNptRiWFipoe66oBxS/gvEVWSjgY6FFsTIhDiaOSF9TugYs2ySAJes/nYYefB2eZf
	 SiCQ9EQccjx8qNTtR4qEzRw2RJ289UmeiPE/QAjN8FRbGVABHIwG5tOGT4kDAPJslQ
	 0tn5T5o9xxyQUaKla2YsaeU8LH/efQZY2meFhDEs=
Date: Sat, 18 Jan 2025 08:34:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [PATCH v2] serial: sc16is7xx: Extend IRQ check for negative
 values
Message-ID: <2025011855-ashen-gigantic-f832@gregkh>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117171822.775876-1-andre.werner@systec-electronic.com>

On Fri, Jan 17, 2025 at 06:18:22PM +0100, Andre Werner wrote:
> Fix the IRQ check to treat the negative values as No IRQ.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> V2:
> There are no changes to the patch itself. The previous patch submission
> had a very weird structure within the discussion thread:
> https://lkml.org/lkml/2025/1/16/398
> This is simply a new thread opened for better handling.
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 7b51cdc274fd..560f45ed19ae 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);
>  
> -	s->polling = !!irq;
> +	s->polling = (irq <= 0);
>  	if (s->polling)
>  		dev_dbg(dev,
>  			"No interrupt pin definition, falling back to polling mode\n");
> -- 
> 2.48.0
> 
> 

What commit id does this "fix"?

thanks,

greg k-h
