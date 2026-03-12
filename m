Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CB1A840A;
	Thu, 12 Mar 2026 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322926; cv=none; b=Jpv1ODUl/9BCylU8xW6QnA6GpG56viWua6q/rrLgNOOew4kiaFAd6OnV0Yk9V0XgdT93FUSkoaV7WiXStyCnNfcjdV7aJxs+Gr2VCx0YfgaNKjOLjCQiXOKxRpmHLpFTJeOgLcJ/t+4YPoDF/sN18dgtuak5irWZNW838obJW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322926; c=relaxed/simple;
	bh=Nh8+TKG1jdpZRWYGegx5vXclnymKMJ0qF/7oueCjy7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkUWuDIor76uEMgJS/7slUL7Cki29c5NtWti2RLzENieZG4kQqo+v35pzBtRtEHqObaAutMe1zj4hu9s3550xlqyjAb6Ee0AFnxgcc7AN7YcMyuryYnrihm5kL0hnMotY2C1ueXwipakN0rfv12vwW4VycdsuCOPBnXxhdikwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ALFDnh1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ALFDnh1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B3C4CEF7;
	Thu, 12 Mar 2026 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773322926;
	bh=Nh8+TKG1jdpZRWYGegx5vXclnymKMJ0qF/7oueCjy7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALFDnh1obGyfsewd8H4B11bmBBYd/EFqwlTTKwh4gX2wrpRjhBeACkZ8jhy9f6ef+
	 RVM1bd8XCsnkeQ28P6KYcSRjaoRlu/QjaJZulbIG2zdtlqfuw05wj5rz5sXlb2YZRE
	 gl0XN+ZrR2d5P+CUKdRm2MVNf9pjl9sKdxXZGrtE=
Date: Thu, 12 Mar 2026 14:42:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Filip Jensen <dev-Felipe.Jensen@duagon.com>
Cc: jirislaby@kernel.org, dev-jorge.sanjuangarcia@duagon.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: Re: [PATCH] 8250_men_mcb: port.dev unset can entail a null ptr deref
Message-ID: <2026031235-decay-macaroni-0ddb@gregkh>
References: <20260305162815.41818-1-dev-Felipe.Jensen@duagon.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305162815.41818-1-dev-Felipe.Jensen@duagon.com>

On Thu, Mar 05, 2026 at 05:28:15PM +0100, Filip Jensen wrote:
> The dev field of the uart_port structure is needed in the later call to
> serial8250_register_8250_port and unless the port is part of the initial
> registered ports (cf. CONFIG_SERIAL_8250_RUNTIME_UARTS) with a dev
> already set, it will make a null pointer deref in has_acpi_companion
> and could also later at uart_add_one_port call:
> 
> Oops: general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range
> RIP: 0010:serial8250_register_8250_port+0xd34/0x2030
> drivers/tty/serial/8250/8250_core.c
> 
> A proposal for a security check against this missing field in any driver
> for the 8250_core.c will be sent in another patch.
> 
> Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
> Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
> ---
>  drivers/tty/serial/8250/8250_men_mcb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> index 6373234da03d..259516078793 100644
> --- a/drivers/tty/serial/8250/8250_men_mcb.c
> +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> @@ -214,6 +214,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
>  		uart.port.iotype = UPIO_MEM;
>  		uart.port.uartclk = men_lookup_uartclk(mdev);
>  		uart.port.irq = mcb_get_irq(mdev);
> +		uart.port.dev = &mdev->dev;
>  		uart.port.mapbase = (unsigned long) mem->start
>  					    + data->offset[i];
>  
> -- 
> 2.34.1
> 

What changed to require this patch?  And can you fix up the same issues
that Jiri pointed out in your other patch like this?

thanks,

greg k-h
