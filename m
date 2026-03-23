Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D212FE056
	for <linux-serial@vger.kernel.org>; Mon, 23 Mar 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258173; cv=none; b=jqxe/UgUERq5WyJNeO9xOO8EQGLXNvpfcSM0H7CbkDK8JAjsdUO0EHikOFuQlDCbPORhS3l3R+iXeDpDb5/tGrFq2vBG5hdvFV8vCvRRGdkpUzFggKot09+eZJIYTayWqI5eUZpHwNam4Uo9GFf683zoLm5rh12OE6H2xgTtddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258173; c=relaxed/simple;
	bh=4lwhUNT9GXOVmm9cTFimd7JSHD0gkI5MbKrwplCgv0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOZVs96OJtyUiP2dXXTGdgVDZhSYJebgCdUrsw1L03hd7MWG00UyCNx2Qd4Bx2SCy3Zz7KLx4BDBVnBjSafg7ovmLAV8XK3+xQyvaSMOfccMb5mTnn1DOOqxOGmRVckBaaPPlw0EORyzHzrMMLHWBlx6t/sEUSP+lkWOeXR8Lqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SxboF6qz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SxboF6qz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 57D2C1A2F92;
	Mon, 23 Mar 2026 09:29:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21C285FEF6;
	Mon, 23 Mar 2026 09:29:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16B8A10371E62;
	Mon, 23 Mar 2026 10:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774258167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HtFy15itLGzLwxNiNWI7+ij1bS2Q37ajrwG17A30oWo=;
	b=SxboF6qzmWdCjfkaCQZfvJel6DR73V5hoEe/qvMCpeU+IoeNThHjEV+WwZvxXDY17O5Y2y
	A1H2ur9iztf3+HIeWmtepeTU9z1oQFQ5qI/+S7X0P2SB2UlMSvVBzY8h1Z3SBQhXZOaPFi
	JVHv4KVeb9HeFUYnbdGlJFE20Bo5CBJmYOHQtqMChikyUBWbf+wySXfUddzs1XQi9aRgQx
	xGdLJylgHGKZn1E7zDydcimyp4BQ34XrmqWazX7RPvkEkRIM7l/ERHC92ya5m9/EgrM767
	gzlqtzMoE7Jfi3MZBFYnOnzHelWXTHzDJ3Z1sqFwcijKf4Nhxc0/sH8Wfgr5XA==
Message-ID: <3bd295ee-1607-49db-a12e-5a4d4fc81c5c@bootlin.com>
Date: Mon, 23 Mar 2026 10:29:20 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel_serial: update outdated reference to
 atmel_tasklet_func()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
 ratnadiraw@smu.edu.sg
References: <20260321105956.8401-1-kexinsun@smail.nju.edu.cn>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260321105956.8401-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 21/03/2026 à 11:59, Kexin Sun a écrit :
> The modem-status comparison that used irq_status_prev was
> moved from atmel_tasklet_func() into atmel_handle_status() in
> commit 2c7af5ba65cf ("tty: serial: atmel: rework interrupt and
> wakeup handling"). atmel_tasklet_func() itself was later split
> into atmel_tasklet_rx_func() and atmel_tasklet_tx_func() in
> commit 00e8e65870cc ("tty/serial: atmel: split tx and rx
> paths").  Update the comment to reference
> atmel_handle_status(), which now performs the comparison.
Actually, it was in commit:
d033e82db9a5 ("tty/serial: at91: handle IRQ status more safely")
That irq_status prev/actual comparison was moved from 
atmel_tasklet_func() to atmel_handle_status().

And we don't need the rx/tx tasklet splitting history there.

IHMO, only the last sentence should suffice, but now that I've done the 
right commit research, you may add a reference to it :)

> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
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
