Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABE1D69C
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431827; cv=none; b=NVWSI5SarDZjekCG2vQ6z7NGstqhC4+oKuKd/JzLSJW3Dui4hsIj+avEbT7squuvFqHjjFNAAEBu8+6MPZyB+c6g6cngDT21lSmM/oVfxPJHr/jpUtCb12uKwXLhN7OXNky1SAHBe0gK+UMmE4CZmMjpunIO2YowpwJHastuOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431827; c=relaxed/simple;
	bh=VZA7GkqNOsfGprEcp87CCflAFYwG+5mMjyW9KlFZQn4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UvhbUPFXBlHgqLRm8a71+Rk4N9TL+2MNafymHCpdfYTsyevOvjnc+tdoSKaq67RNzZ/bZEWQ/B/OgGusy/BNnUIyIKhPO6q17+5Ec2B0LIFi+y9kaV9ICwQiix7zn/Gp0OH/NQDtuZXdC7dMnRNOB4XXS/sOZtu7KwQ+urLhyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wl1DsCKo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wl1DsCKo"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28be024282bso6789915a91.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431825; x=1706036625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFfdvwq+VA0URYaPaSoMqo8iUhwVlg2dLRJaPWnJEaM=;
        b=wl1DsCKoZi5lhSn6aBjbNo4OCibtXReGj6Ct0mD9Ssrx1fhtqwdO1xKqXlBs1tVAwl
         49a2sjup+mlL/Q+84agOxNIPABuSoEK5H/PaaeHy8EsFhTBXAyojP2dfd1P+liju6OHa
         JDMME0y4wY5ZTt+FNaHXSLtXfaB21/ikaDeztQu8J5q3g/3/6H7v893ZdjCUHK59Mf34
         lmF8kLDYsjHgIi8B8g1VvFBiy8iFcY9wgfvkRhyeCIwH9XQHTfBpn5xOzAZIqKsUNqdN
         xqf+ky7WAXIqnRiatDZdWfdHodbBZdkyQ1D2pKSxvCUkKJXYB1VrsmrDdIum0NzmoKIA
         nWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431825; x=1706036625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFfdvwq+VA0URYaPaSoMqo8iUhwVlg2dLRJaPWnJEaM=;
        b=LeCuZyY4U2ftN7vhHIDBqYf2c1RZCSRjAmFXUqt8sbRr1CF0C7+9utqkgbiJEZCjML
         LzCJ9/34zMhCsDIP5YmAsoU0NNSMkopfg6DAHzduebBHJhyeDCr8qbWfTLjgthRrfNOd
         g6T5xuGKBKnz/tkvXrs3iR3ezSgLl1+QsHvanLdUv6J5WFdIaECwfb164M8/uXJbvVUf
         RcbbFjTJDVSrZmJvhXYBe9XIRnuIZ51RLtEhYFpQPDB97MHr7swxX9q5qegTHiYk1XzF
         m64vQbHf1ZCGVBRp247e4Dhi4wI2q2zIXz/WmNofCbX5xwgoSNWefnXqC9BNzL4L+ls9
         ICxw==
X-Gm-Message-State: AOJu0YzGdtEL1RXAWfdK6ZNDINkjBwnJoTHhtoAviopvHdty7d5IXmq9
	ei2uiwWPZ7b/e6O4RCWNpvd/v1aqyfJX261PDu/2wLuS481jLQ==
X-Google-Smtp-Source: AGHT+IEPnUs5s+u4n2M6rGcq0735SPknT/v+moyBMuh8kF4qV4x/ZF7cpKSU/gDRB07cac8VXhFT6ikMNp/8rp5YiPo=
X-Received: by 2002:a17:90b:70e:b0:28b:fa2e:ca56 with SMTP id
 s14-20020a17090b070e00b0028bfa2eca56mr4085660pjz.29.1705431825086; Tue, 16
 Jan 2024 11:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-18-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-18-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 13:03:34 -0600
Message-ID: <CAPLW+4k091328krLB_KdHyobG-pR--Rt5WaN6c1ccpgdV8ry7Q@mail.gmail.com>
Subject: Re: [PATCH 17/18] tty: serial: samsung: shrink port feature flags to u8
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> There's a single flag defined as of now. Shrink the feature flags to u8
> and aim for a better memory footprint for ``struct s3c24xx_uart_info``.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 5df2bcebf9fb..598d9fe7a492 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -90,7 +90,7 @@ struct s3c24xx_uart_info {
>
>         /* uart port features */
>
> -       unsigned int            has_divslot:1;
> +       u8                      has_divslot:1;

But that's already a bit field. Why does it matter which type it is?

>  };
>
>  struct s3c24xx_serial_drv_data {
> --
> 2.43.0.472.g3155946c3a-goog
>
>
