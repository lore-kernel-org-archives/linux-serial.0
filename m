Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66C47DD65
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167761; cv=none; b=p8qh+1rd/8opAANsjO51XyoVTT8UqswcD9lVsy79o/FdOfX6sVELW0zyPuwTzWJGfYt5gskglYeKjv1eXWI63RVgkVpGX4Nqg876QDaRfEOGWY7wfEad4LEp6FUWi3Yt2mCX25ffT22yw1nzM4SDKUwZzvzEISjEvavYYORnX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167761; c=relaxed/simple;
	bh=vD6zZI/B0mlJOFVNQEvM8JURDPMTLRtupngSRJ42Blk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ6oN/gSA8eQjnh6e4pU7uhRMExedGDfcprdqXsr+0ob7O8hoI57Ri3x7tZnqXMXMye5QS8f0PdfTxHc/vpa+EAX6vqO4T9IeHvSzgJ751QlkNFr0QChS85wg3eaoEjlgsI9iue3oS6fbrjNZMS+gtdHmTR8gDccmm0IFbkZgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lbjtYE85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lbjtYE85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7011F00893;
	Wed, 23 Sep 2026 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790167758;
	bh=/+zX0QSH9Nz9su1gZ2QriQyclLg1VXDg3BSBlql556w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbjtYE85B6NnTDEXdm6/P5DwSKuKB0Ogvqi/DIUS7jnkzKZesaeXwc04PE6y1xiQ4
	 RzXNnHnZoE1GccNoT18iABho0safG/cn5tduRt98gX1NhkLvMa7kP2mJW4NNDAUk0s
	 6NrqftZWJaZtUeIdSwVCbAvAGwnTAln+ex5MgsnI=
Date: Wed, 23 Sep 2026 14:49:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: pxa: fix comment typo
Message-ID: <2026092343-onset-embroider-d3a4@gregkh>
References: <CAF9RqJ7-yZCq+U7hULCe+8xYLHkgkDww0bF49vyu915xUYkoCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9RqJ7-yZCq+U7hULCe+8xYLHkgkDww0bF49vyu915xUYkoCw@mail.gmail.com>

On Tue, Sep 15, 2026 at 05:56:02AM -0700, Ruslan Vagner wrote:
> Fix the spelling in comments. No functional change.
> 
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 10fc8990579b..b43db70820fd 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -99,7 +99,7 @@ static inline void receive_chars(struct
> uart_pxa_port *up, int *status)
>  		 * Specification Update (May 2005)
>  		 *
>  		 * Step 2
> -		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
> +		 * Disable the Receiver Time Out Interrupt via IER[RTOEI]
>  		 */
>  		up->ier &= ~UART_IER_RTOIE;
>  		serial_out(up, UART_IER, up->ier);
> -- 
> 2.54.0.windows.1

This is corrupted and can not be applied.  Please do not use Windows to
send Linux kernel patches, that is not going to work and you can't
actually test your changes :(

thanks,

greg k-h
