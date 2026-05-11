Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F836405A;
	Mon, 11 May 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512528; cv=none; b=mBOVkeRjB6o11r2AjoAcXG/o/xl6g0CEadZqwL5QbV3sAZOZy1B2zb/fbqNPvqQ4U6CVZPiHL8gmMaSoK4hs5onFb9uW54Nqz+l7YK2NrzVNijarEvZbcoOpeh5oPoKLyLpDGTUgc+z0FmFDI6w2qGR3JkbXLys0c4psvk7zS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512528; c=relaxed/simple;
	bh=kiQ1KGh1vkw6B0tM1aB7RVquVoGizeaJ6PTbjJrzJi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+d5xmOg+5CbqQ+MdS6kSuGufrzpoULXLHU0c1XbGrnxDcnH4Vvrqc3fn9d0IFfLsVMEVO6R0mYlhx4E7hnhyturKIroX3Wqwub1THISV37R5Y3Noymqo4z4NppDDNcnqmVvPZeOTBHrike0boeEX77pa4a9HrR0jcpeyqB107o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fF78SGo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fF78SGo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235A2C2BCB0;
	Mon, 11 May 2026 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778512528;
	bh=kiQ1KGh1vkw6B0tM1aB7RVquVoGizeaJ6PTbjJrzJi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fF78SGo+n0nWnyeemwvkmwbUoRZtF6GaPx3KAbwnMmVkVvGGz8iwzPAcDJnyCCcS2
	 nIBfL+gZkcxHsUPQ8qUFvrz1kLN3d7rrB6N+xkUw5yHsoGzRnu8cSPHXHUO00ZIJho
	 UCYWVoN8Zgldg97HRcxEWLm5AEgQ6NH1iGYEkAZ0=
Date: Mon, 11 May 2026 17:15:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tobias Klauser <tklauser@distanz.ch>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] serial: altera_jtaguart: handle uart_add_one_port()
 failures
Message-ID: <2026051100-snugly-grafting-257a@gregkh>
References: <20260428064511.8934-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428064511.8934-1-mhun512@gmail.com>

On Tue, Apr 28, 2026 at 03:44:57PM +0900, Myeonghun Pak wrote:
> altera_jtaguart_probe() maps the register window before registering the
> UART port, but it ignores failures from uart_add_one_port(). If port
> registration fails, probe still returns success and the mapping remains
> live until a later remove path that is not part of probe failure cleanup.
> 
> Return the uart_add_one_port() error and unmap the register window on
> that failure path.
> 
> Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/tty/serial/altera_jtaguart.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> index d47a62d1c9..15588b6dc3 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -379,6 +379,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
>  	struct resource *res_mem;
>  	int i = pdev->id;
>  	int irq;
> +	int ret;
>  
>  	/* -1 emphasizes that the platform must have one port, no .N suffix */
>  	if (i == -1)
> @@ -418,7 +419,12 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
>  	port->flags = UPF_BOOT_AUTOCONF;
>  	port->dev = &pdev->dev;
>  
> -	uart_add_one_port(&altera_jtaguart_driver, port);
> +	ret = uart_add_one_port(&altera_jtaguart_driver, port);
> +	if (ret) {
> +		iounmap(port->membase);
> +		port->membase = NULL;

Why is membase being set to NULL, that should not be needed, right?

How was this tested?

thanks,

greg k-h
