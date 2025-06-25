Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5291F2BA4;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826049; cv=none; b=MFqeXLQdShe52zpnRRt/3gZWw8mcl30SjOdW84BB7pnEUc/GOKC9Ulrbq5l8GC6kUCwsFx3fZHR7W4QlQic9fR/cD1wGEZ6rmVtE2ZwNQgeU5xAUUGpwEqOa48KGakbj/eJ5nFzW1DZUQlnq6kIKddzcs1sJXZx6oUBO2Lx4zJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826049; c=relaxed/simple;
	bh=5eTiPvmnR/BcsEDlXlm3xp6IrvEz/5sGUgxOb9sg2Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB0rNtsk1wNYPgmGxZXRwtlzg1SBXl9JAeoZ4yoCwCERyw0VqGvhXVmaVytf033vYRuoxvNE/ECIztfipX+Ymgh/gbwBeaX9p+YJk4yXof5jOe9QhdjNodI42AFGFj4fLGVFY5Q2eJh+nJQnt1FmmcF4usoLDKpBK/cXD2+yVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4jdH5q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4jdH5q"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso12675882a12.2;
        Tue, 24 Jun 2025 21:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750826046; x=1751430846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WnlVrnYLoiCb/DNnCFCcmVPptby11wZpkMaZrO796g=;
        b=SF4jdH5qu4AvO94q58kLftt1LziNFHnW1D+bU0kMFwTFvynbOnmC5H3hHRDtyqs81q
         JZjSjchZkAvzmuj2qbEQkL5Kujo+BjKKq9pKNEmqFxOpwEVe8naeQtyAdkti3ypPmVmJ
         jjavmB/j7m4rK/YVLb8ABqy4ntr1jtZxTA2nJogw0ZfjgcWYDjxuP+2d6/DLChtqAZY8
         r9vUoiaIA5lhd4GsU+ahZq1Vo961eB55FCT6Yr+ulH6/Jv00kM6ZSz/Lw362IuRQkzwT
         DxXPHn+r3ojklSO7ovrZ9QkyWs1wJQtpl/cHmfmphG/0ao8qGN7iehfNgyhGS9UUsWpZ
         zUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750826046; x=1751430846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WnlVrnYLoiCb/DNnCFCcmVPptby11wZpkMaZrO796g=;
        b=lIEt2f4QHB8mwHBjY3RpolMakqPgNcRZvG3SXPOII8HHehpiP8uRZLgjNn3rWZIWKF
         5Epoc5xo7G3CSLbQ8FtEvv9gvJkIAz6iqL0u7JPASwrv5+zxdsObaSEHg5br66h35Ozp
         1C6N4zXaahFyFj0/NvgZFTF4Q8whdkhQvMVx5o5TkvaEqXtKGM8LoEE33zOQW3RaECJw
         LQc1G3n8MUzJfbzkzBd/LhGTT3Kc5xjo0ZshNHwKHO1+y7LhvAg+sdQZnbNsN7p0L1tt
         QAg/u5x9Ogy60GV/qo9ofM6aPr1/fkscm7ny8Ji7P6aiZcvcpvgaC4yJE9hd3/8eOC2p
         iOeA==
X-Forwarded-Encrypted: i=1; AJvYcCUyS7Qov/AxGgdwdKsRNowhy93JpirUI5h74ye6WhW+Lk25larYdfaEIMTkFz+cIiRu4zZy0FTA5V3yf00=@vger.kernel.org, AJvYcCVMF5486I/nzdUwrILJqB/7/OPYQn/OhHRB81gVG0v5T6SLmmTaAO82wzbkVIp1MdTT4cnS3XV2ugvRGOUa@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhkSgAhQIeJmV2b+hokBzk6+Oi4QRNj19Xoz9hP+DLEEX4JaS
	03FDd/oj/kZcGA4AsrRTFg7DQpY7r/4l6xidcHgP6JZztpE8nC6NqsBQduJbJmo3XGSgC7pS76H
	WBNSEXny2QAG6tpZAwYBod+rL66xQy8TeXTD6jtc=
X-Gm-Gg: ASbGncu7Eqp5Y74AV8VTSXLpIPtrYYUHAK24wxEkz6FxGc2Es6yFnlCcuRWEmV7BVSz
	R7g+UePo5m7M9e6bFLWIQwTNsoDhdmQzlR+d0PFOeYd8n1w/3yVXNHUypEA1tTvbeh6uXUhbVv3
	FHNyarbg6HJ7QGGVNlw3ubLVhAny5joSUovUKCToeuhGM=
X-Google-Smtp-Source: AGHT+IEZyVV8/xGNO5RZEIrAaX3cc08WOOHahlUckRGnt1SGXJkY7s6vRq93KSmUU6wvQNC95LJvgOMnUdscgS8rpNA=
X-Received: by 2002:a17:907:bc8f:b0:ade:a8f:d460 with SMTP id
 a640c23a62f3a-ae0bedf4adcmr145460866b.40.1750826045478; Tue, 24 Jun 2025
 21:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625031409.2404219-1-opensource@ruijie.com.cn>
In-Reply-To: <20250625031409.2404219-1-opensource@ruijie.com.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Jun 2025 07:33:29 +0300
X-Gm-Features: AX0GCFvZ3heNbPy9oisuEWWR-LekDgDe7fr9ZxxODfm7M8y7DFtT4dH6zLc2xfI
Message-ID: <CAHp75VcoYDw95rpa1QE1qBrpbxJ-o3OwzVLkYSS4uE6DCVDwwQ@mail.gmail.com>
Subject: Re: tty/8250: Deactivate the HSUART DMA for the DNV CPU
To: micas-opensource <zjianan156@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Philo Shao <philo@micasnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 6:14=E2=80=AFAM micas-opensource <zjianan156@gmail.=
com> wrote:
>
> From: Philo Shao <philo@micasnetworks.com>
>
> Intel DNV CPU reports an error, indicating that there is a possibility of=
 abnormal serial port functionality and the CPU may hang.
> The HSUART DMA will be deactivated for the DNV CPU.

Please, wrap lines around ~72 characters.

Nevertheless, we want to know a bit more, i.e. what kind of CPU
errors, how the symptoms look like. Also have you checked if there is
an official errata for this case? If so, please, mention the document
number, errata title and proposed / recommended solution.

...

> -       ret =3D mid->board->setup(mid, &uart.port);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D mid8250_dma_setup(mid, &uart);
> -       if (ret)
> -               goto err;
> +       if (id->device !=3D PCI_DEVICE_ID_INTEL_DNV_UART) {

Wouldn't it be just enough to skip DMA setup in the
mid8250_dma_setup() for this ID?

> +               ret =3D mid->board->setup(mid, &uart.port);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D mid8250_dma_setup(mid, &uart);
> +               if (ret)
> +                       goto err;
> +       } else {
> +               uart.port.handle_irq =3D dnv_handle_irq;
> +       }


--=20
With Best Regards,
Andy Shevchenko
