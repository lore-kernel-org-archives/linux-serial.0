Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DE3CFF68
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088836; cv=none; b=iwZjVg4EV3f5dMetZtk3mdMwiLbm/UnwZX2gdLetBJpjdyOvEcY3fgTciKp7RJ7hTOLQBhF69Cyu3XAAI6Ufirlb5aDY/U4ONdJh6GVLJvCtY/Jq1DrL4BmqazUSHRj9shPRl+or2UHf5wZp0haFbKtW+iSVVzoDP8Z8WW8fpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088836; c=relaxed/simple;
	bh=PkXI1TlmjIikITrBeMVxTgyNmbfUK04gnstBQ8LT/SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/kzcwg0ap0jGk4OvkLEuz7coHCw2OrEHHQKVQUx/LjwdwdmRCiBKUgt6KbXdDJLlKeKkMyWXQMY5YpgyD+1kMiUXAo7nlTJaASxzUv0IWks6EcdfGdL32mOaU/YFbNLCs46ufrHN6rr5kavmd3XcO8/7/UHSBV+RZoHVeqLKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=h5I26kyQ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="h5I26kyQ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0969A240029
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 09:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1779088826; bh=HsCQcaBl/J5SnD9OVdDsExA6U4aXBq1UPmmg8tgJyV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=h5I26kyQKCoFpo1K3oXXPDgjrNi2cYOFOKpAC0YzXO3olpabdlTHqQTT/+qmPOxjP
	 b3FNu5SyMMhHyg3y3qzmRt2R5dkZhaw4HuJFXECmgr+Lsu6AoEApgCIdGwDIGbJtLq
	 EjBgaFN+7KOazMyLub42oDM7sK5TjeMS+R6tUJo7Uz+eI1NfOwrc+m1QRGUjO1raB1
	 cBQmaVIjxHdUBjHce59JmHeKjEBxfdaQJWe8o8P6SPi3zkmr6evTKp00Ke2W9ZQmH2
	 lKALp2TWpP4gZDT7WB5fdwLH1gNgWEqRszgil0eH9q32TK0CiBQieWpmzbbf69WKKT
	 gr130iC07ZM8Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gJq2c2sxsz6twZ;
	Mon, 18 May 2026 09:20:24 +0200 (CEST)
Message-ID: <466b32f4-29f9-4f64-ad38-27f770f981d7@posteo.net>
Date: Mon, 18 May 2026 07:20:25 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] tty: serial: atmel: Ignore chars when CREAD is cleared
To: Rakesh Alasyam <alasyamrakesh77@gmail.com>, gregkh@linuxfoundation.org
Cc: richard.genoud@gmail.com, jirislaby@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <2026051106-obliged-dismount-d85f@gregkh>
 <20260511165913.36467-1-alasyamrakesh77@gmail.com>
From: Richard GENOUD <richard.genoud@posteo.net>
Content-Language: en-US, fr
In-Reply-To: <20260511165913.36467-1-alasyamrakesh77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rakesh,

Le 11/05/2026 à 18:59, Rakesh Alasyam a écrit :
> Ignore received characters when CREAD is cleared by adding RXRDY
> to ignore_status_mask.
> 
> This replaces an existing TODO in the driver.
> 
> Tested on hardware.
Could you be more precise?
Which board(s) did you test with? (e.g. sama5d3_explained, custom...)
Which SoC? (sam9g35, sama5d2...)
With DMA, PDC or none?

Regards,
Richard
> 
> Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>
> 
> ---
> 
> v2:
> - Add blank line before comment
> - Tested on hardware
> ---
>   drivers/tty/serial/atmel_serial.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 5d8c1cfc1c60..5c756dc904b0 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2184,7 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
>   		if (termios->c_iflag & IGNPAR)
>   			port->ignore_status_mask |= ATMEL_US_OVRE;
>   	}
> -	/* TODO: Ignore all characters if CREAD is set.*/
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |= ATMEL_US_RXRDY;
>   
>   	/* update the per-port timeout */
>   	uart_update_timeout(port, termios->c_cflag, baud);

