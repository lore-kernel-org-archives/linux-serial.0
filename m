Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186D3246F9;
	Mon, 22 Dec 2025 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384538; cv=none; b=rLTJn9uzL0uThELrEdqTTSeYVCl2OR61yA1QC+E4dHdWFwJ82mIYZtJw8k2Ce+wipNU8zZKkGI6HxZddxpyxp0QCZCkPGXf3gLKgrniF46vOUZemtL5hSEPEyLT+h4z9Mc2GAnzqXyshInJKMdX4d+97mKdXmuPHjS9Ya/5YZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384538; c=relaxed/simple;
	bh=tcPJ9xF3IDrVxvtAxhyKUbQpSiO2G2lCeKR+IxIsgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jav62RA8K7ryG7QJoOIFrH0N+pgmFcUVIf7stBrhp7a1VUEUgW1/Hi7URAfyEE33YGjQUMrEBX9Xaz3D2PIZlVWeq0FPvMCdxKVRRpuwUgv1SYaZQcrpg+Yxaa5vbLSW3+FcyUbfUy3+yCvR0qboFtJgvKXP7pIRJFewVyv4HwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwRavLEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwRavLEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E27C4CEF1;
	Mon, 22 Dec 2025 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766384537;
	bh=tcPJ9xF3IDrVxvtAxhyKUbQpSiO2G2lCeKR+IxIsgfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwRavLEXhiWipBRxzCkRLRPj6eT4dJTEs+4jsH5NxWwVa6EHAvWWnVgnu0CU+SGIv
	 rxcZp8NOfGhfx36CVjLCA+MJJ6cLQW0BVGqDPY3SDTGrcW1Nfa0ZbZ5CvEjwUEasN1
	 1VnDcgtdunSMeuDfueoHR/VokNFnu+zsypsqXelM=
Date: Mon, 22 Dec 2025 07:22:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] serial: digicolor: fix use-after-free on driver unbind
Message-ID: <2025122232-grass-stoppage-6645@gregkh>
References: <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Mon, Dec 22, 2025 at 12:55:02PM +0800, Junrui Luo wrote:
> The digicolor_uart_console_write() function accesses the global
> digicolor_ports[] array to retrieve the uart port pointer, which
> can lead to a use-after-free if the console write occurs after
> the port has been removed via unbind.
> 
> digicolor_uart_remove() leaves a dangling pointer in the array.
> 
> Fix by clearing the array entry in digicolor_uart_remove() and
> adding a NULL check in digicolor_uart_console_write().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/tty/serial/digicolor-usart.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index d2482df5cb9b..5861be2072c4 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -397,6 +397,9 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
>  	unsigned long flags;
>  	int locked = 1;
>  
> +	if (!port)
> +		return;
> +

What prevents port from changing right after you tested this?

And who is calling unbind on a port?  Why?  That's a debuggging thing
that a developer could do, it should not be part of any normal system
operation.

thanks,

greg k-h
