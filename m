Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB234676D;
	Tue, 24 Mar 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336142; cv=none; b=ny9CbwHQqKCo2zEIOQ0fLi0TxqZy1hQOArk1uGq8srioKgUY5LK4eQfpOUUF7/QwCTof6YolF5pMFO27pQPGC8NqB/t6A9s4jXPPSZuSdFtidFZSxBd6HnHGoLHx7iSHNNOs5bLBOiWtmJmkJH+AwYthdCxPVtEYaT1ceOa431g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336142; c=relaxed/simple;
	bh=rAsdQ929Is/ltl7/CQ4c/1wzx/c2dhzJPgYaMTJdfCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmecez9aAcyWL2xrgP+sTnsJ2V87uVJfdGbqeIDlPAsHBkn/PqhRGG9QXInzcFsLW9rsO3Hdy1L43vuqxN9s3+NHPfsrShnrsEh0raJ2c60UPWYiYQ6D3Su+GAEK5TH5Q5IM0cgqrpxjnNMtxKJiWcJfuRWG4YIYBtWO5tFdMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZMUuE5m6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZMUuE5m6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA7971A2F03;
	Tue, 24 Mar 2026 07:08:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE74C6011D;
	Tue, 24 Mar 2026 07:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54BD410451149;
	Tue, 24 Mar 2026 08:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774336126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GIkhEVZgzQ5l9z+TpFF/vXtfyDLL3bNPkDPBRcbRDA0=;
	b=ZMUuE5m6NiK7jvGLCp/w4wTzG7j7jdnQvFOfbav/a0tPLKNczRh9ZsPa6mAgO1KFstWGSf
	Vn7lM10TwpQzSlHCnmpksnT4knUpUChGYxZoKiDQVY/ubDgiaAe+n32/h6Y99AFbr/8ASx
	LL9PDmy87nyX4DKh3GIA9HqqlVrTUK41OfRP5xrIY/8J+Yx9rHPsSZbDktBWPEU3GH32DG
	0jajmfGku+NnK9Vj0ixCOcIEwanLUKeFcW0w7x+a0rRTZlPlpwjne/+8w1fHQHkdBZUvGS
	tEe1yNkuEG88uBszSQApsxtYsnI7mpcUoteXhHy+E3qshTi1t6/3OKXoLwPjSQ==
Message-ID: <89bc9543-9fcb-4563-b6ff-01b186231ce8@bootlin.com>
Date: Tue, 24 Mar 2026 08:08:40 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: atmel_serial: update outdated reference to
 atmel_tasklet_func()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
 ratnadiraw@smu.edu.sg
References: <3bd295ee-1607-49db-a12e-5a4d4fc81c5c@bootlin.com>
 <20260324024857.3244-1-kexinsun@smail.nju.edu.cn>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260324024857.3244-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 24/03/2026 à 03:48, Kexin Sun a écrit :
> The modem-status comparison that used irq_status_prev was
> moved from atmel_tasklet_func() into atmel_handle_status() in
> commit d033e82db9a5 ("tty/serial: at91: handle IRQ status
> more safely").  Update the comment accordingly.
Double space here, but I don't think it's necessary to send another 
iteration for that.

> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
Acked-by Richard Genoud <richard.genoud@bootlin.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 08dd8f887956..5d8c1cfc1c60 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1927,7 +1927,7 @@ static int atmel_startup(struct uart_port *port)
>   		atmel_uart_writel(port, ATMEL_US_FMR, fmr);
>   	}
>   
> -	/* Save current CSR for comparison in atmel_tasklet_func() */
> +	/* Save current CSR for comparison in atmel_handle_status() */
>   	atmel_port->irq_status_prev = atmel_uart_readl(port, ATMEL_US_CSR);
>   
>   	/*

Thanks!
