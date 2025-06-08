Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF617E;
	Sun,  8 Jun 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749400222; cv=none; b=lEndkRfHwDhfGuNICAcSSzZwP+2qgpE03vD8q5Bfei/Hy7eOytoZ9HPOIySuFQtK9dH/KEVe9jYWLj/dHEtpDFy6Svkuw4shwt9cBeeog2NlFz+Hsky1cnAkAubsP06J7MmX37UJh0RWrw7qJf0hr5N9OhJFlWQDdRBjkG8Dq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749400222; c=relaxed/simple;
	bh=KKCobZU0yXS4VapKICqzmCPWDXyQK5S0HNaDg/mE+oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubDC9mpmWJ1LEnNwlZU2UawKBOcll33021F8y+jdH3zJHBLnxFKyyTaRNWHbrNLrIA8RsIRtLwLXcaWhFLlDuOlKmdMBAQwzhJCSuEvkib8pDbf4L0plm/BR8j3L0uHZ1vzqNYlMVzz7F7wiy2F0NudRlefYYrPtOJHuu/vOE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oFVoGBz2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFVoGBz2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=+tcecrk7heh9FwxWkRvFliEQqq76xVf2B8trKQMClRs=; b=oFVoGBz23sF9Y/j3f7L80zFCHo
	cwG0C1wd/Y1AsHPWTh8zC8LiiUb6bKYipPyKMXpelG2pIpusv8zzFp/HGcR5mLtRVY/jFepL5M8Kz
	ikc3toLcoYlOyREW0jlpELC7XjisknD8mP9/VBX/mf+kVm1azO4hbO8mzbvpO3QLvG9/TCSmIOeE3
	R1WT137yuwusXSTrOwyp7BYB8IrFBtLIz97aGM5r+vQuaAkfX5UhXH8XUxmYGuEGuG95m/1UwKNwi
	EXKQtPJ5y6Adl/SicNxarjcUvUzDkmI4zF7rfIxc+OdOF/iwbhoCaPsGPPteIlmac5WHj6LDk94TV
	NzDpPKcg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOIuJ-00000007Myt-2K3N;
	Sun, 08 Jun 2025 16:30:03 +0000
Message-ID: <1736ad95-566d-4c87-835e-257a091fac59@infradead.org>
Date: Sun, 8 Jun 2025 09:30:00 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Remove unused uart_get_console
To: linux@treblig.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 corbet@lwn.net
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250608154654.73994-1-linux@treblig.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250608154654.73994-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/8/25 8:46 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> uart_get_console() has been unused since 2019's
> commit bd0d9d159988 ("serial: remove ks8695 driver")
> 
> Remove it, and it's associated docs.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/serial/driver.rst |  7 +++---
>  drivers/tty/serial/serial_core.c           | 27 ----------------------
>  include/linux/serial_core.h                |  2 --
>  3 files changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> index fa1ebfcd4472..c1db6a1a67c4 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -24,9 +24,8 @@ console support.
>  Console Support
>  ---------------
>  
> -The serial core provides a few helper functions.  This includes identifying
> -the correct port structure (via uart_get_console()) and decoding command line
> -arguments (uart_parse_options()).
> +The serial core provides a few helper functions.  This includes
> +decoding command line arguments (uart_parse_options()).
>  
>  There is also a helper function (uart_console_write()) which performs a
>  character by character write, translating newlines to CRLF sequences.
> @@ -76,7 +75,7 @@ Other functions
>             uart_add_one_port uart_remove_one_port uart_console_write
>             uart_parse_earlycon uart_parse_options uart_set_options
>             uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
> -           uart_try_toggle_sysrq uart_get_console
> +           uart_try_toggle_sysrq
>  
>  .. kernel-doc:: include/linux/serial_core.h
>     :identifiers: uart_port_tx_limited uart_port_tx
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 1f7708a91fc6..c15e005047bb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2131,33 +2131,6 @@ void uart_console_write(struct uart_port *port, const char *s,
>  }
>  EXPORT_SYMBOL_GPL(uart_console_write);
>  
> -/**
> - * uart_get_console - get uart port for console
> - * @ports: ports to search in
> - * @nr: number of @ports
> - * @co: console to search for
> - * Returns: uart_port for the console @co
> - *
> - * Check whether an invalid uart number has been specified (as @co->index), and
> - * if so, search for the first available port that does have console support.
> - */
> -struct uart_port * __init
> -uart_get_console(struct uart_port *ports, int nr, struct console *co)
> -{
> -	int idx = co->index;
> -
> -	if (idx < 0 || idx >= nr || (ports[idx].iobase == 0 &&
> -				     ports[idx].membase == NULL))
> -		for (idx = 0; idx < nr; idx++)
> -			if (ports[idx].iobase != 0 ||
> -			    ports[idx].membase != NULL)
> -				break;
> -
> -	co->index = idx;
> -
> -	return ports + idx;
> -}
> -
>  /**
>   * uart_parse_earlycon - Parse earlycon options
>   * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 914b5e97e056..cfd891357573 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -1101,8 +1101,6 @@ static inline bool uart_console_registered(struct uart_port *port)
>  	return uart_console(port) && console_is_registered(port->cons);
>  }
>  
> -struct uart_port *uart_get_console(struct uart_port *ports, int nr,
> -				   struct console *c);
>  int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
>  			resource_size_t *addr, char **options);
>  void uart_parse_options(const char *options, int *baud, int *parity, int *bits,

-- 
~Randy
