Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949D1CF81
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430829; cv=none; b=AU9V0bEhmSd7SmWshhKopKhJYxI9aBBjNLcbynniVdPkrquSmofPRcMs86OMS8dSuiz5OFSoQQh8pOnKn5uEMsvEgIVw2Xrgw6H8H3mQQeN49hxrw8fYK9dysetHm8lVIrNwteb3w7eeQ6RMONbVz/epmLtt3mjgWL+X0LgqqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430829; c=relaxed/simple;
	bh=gKxv+UOkndb8j78LrufMKusgJzXZYbUdkxVdxRFLmFw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ARn7PhQr/C63fqj5O4xSO7aphsHtxyOh6TOvZz86ArvjnuKiLkG2rw750ZhBR8a7kuEU7jrUS6btADpschrGClxycE5jMO464UQf7kmTjDdT+NXTAklhi+lAOOhtU4BLMmeQi3epzXm+Q1672/DEshXVvhpH071DB5FpZY8BCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/VmS92e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/VmS92e"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28e82c1f7e4so512049a91.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705430828; x=1706035628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzOK6W+G74uDiUdt7KMX09h88wCbiDkSJ1x7zb5kpR8=;
        b=H/VmS92e0erTpXmGD81gSrxVcTk0/E3TPlie1vM0yirrS3OPF/MYKVkm9/DANEpyC3
         qPa7+0I9QmPX/E83nVDWVVu69KdcWFzlK5G2vok/To+IjK6i6vAgmc9MHKaTNjRFrgCI
         OpW10FStEqWJhcYh06CY/4gxvqHbMhQpVB1zoWl7geKl4W6FAmxtvs40kGXHozIf1pD/
         43wGvnv2VuGu4Y0KFVBHsaw4xf9Sz1JELwu3d7edutnBTRJZlk1vI3g+zd9wl+C3MpRI
         34b6IgnLOge1/BU0zERd9iDRCPDD7qflyJWAYH86n0vQQ61OF4GWmbjKVMs8NYtrSUfP
         RHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430828; x=1706035628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzOK6W+G74uDiUdt7KMX09h88wCbiDkSJ1x7zb5kpR8=;
        b=jaXev+p/MVcgIESpeBdcN4ErwPb5ive2t21zQAt14RD4qzesX2jOQCWM67gRbdEOJk
         bjXu9fZwVVx/xUJChLX5h0qVVsr0LLksGad2jPHbwW0iazATQWT1HFQI0wr4dH/U+/b1
         pYXqrca/OAJEuc4veq7NkZf2YPP8sm6QcWuUFejxEUv0owQFWzAqVLihFN7NP9Y9Ep4r
         B8oMcjs2Qu+EIpzyKfRx9KVaVXYilgIMaxgldvNW0rKSjRVkaMph050nbmX4OH0ARwYn
         c9TjDYCnfNxJ/7exVh71/+uZIFc3uR0IsQeuu9RsvwLMjynYf+wGZAkYyoGG02Ne/78r
         ipzg==
X-Gm-Message-State: AOJu0YyrTQiSEON87JR9JJnpmQpocWU8Be59Hj3uvX8q6sQovOvHORfS
	7m3LDCw9dbnvwBaJ/YlJJNs0vIni4wMY0dRy/0iyqdYCR2JWvA==
X-Google-Smtp-Source: AGHT+IGlHP8xv65eTrLYbxdWE98VqFYwvntUR3EJnNTNFNpHq0PTKvD5rL7yNMdrMiTPUx/B9MF63dK3fN9Vv0S008o=
X-Received: by 2002:a17:90b:3547:b0:28c:f4ba:a92d with SMTP id
 lt7-20020a17090b354700b0028cf4baa92dmr3598577pjb.40.1705430828065; Tue, 16
 Jan 2024 10:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-13-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-13-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:46:57 -0600
Message-ID: <CAPLW+4knt2P5yEJMRJsKydGUaa8RSMLxdVy-Kjq=bkGw9tA8Kg@mail.gmail.com>
Subject: Re: [PATCH 12/18] tty: serial: samsung: use TIOCSER_TEMT for tx_empty()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:24=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The core expects for tx_empty() either TIOCSER_TEMT when the tx is
> empty or 0 otherwise. Respect the core and use TIOCSER_TEMT.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index f2413da14b1d..46fba70f3d77 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -990,11 +990,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct =
uart_port *port)
>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
>                 if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fi=
fofull))
>                         return 0;
> -
> -               return 1;
> +               return TIOCSER_TEMT;
>         }
>
> -       return s3c24xx_serial_txempty_nofifo(port);
> +       return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;

And because s3c24xx_serial_txempty_nofifo() might actually return 0x4,
and at least uart_get_lsr_info() tries to clear exactly 0x1 bit, this
brings functional change, which I think is in fact a fix. So a
"Fixed:" tag is needed here.

>  }
>
>  /* no modem control lines */
> --
> 2.43.0.472.g3155946c3a-goog
>
>
