Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264681C3F0E
	for <linux-serial@vger.kernel.org>; Tue,  1 Oct 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789834; cv=none; b=OJ1kN9SeMfOBekfQ+vpmuplnX85NJt8cktOx315Tr4TNzOsUgNc0uPWCwwheeorqXsjZiOx1A6Oj5WleZSPEGEYO0Ouq87viRTzryIDQEaBqUJfrlXUvnGPRvpAgOtgg99PQwjAIoxsQEyZbRbnPv7BiJzK25xMnIvV6HwwD2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789834; c=relaxed/simple;
	bh=l5Wzld97pvTNqpuXXv77vHPpekFjUq/zFH05krcoJrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1hHeZyZcYWU0tfSFq9zdDs0tq35rzCPmSW89m5SQ9JDPescGwhTzPoMem1o4KT4fWkG7UTQlkh0SX5NmV6GEqkWN3Yv6YloDAmnwASt2l4P2NJrO9fcH0/WJY58uKp7rapwodXOHCAsg/j+Cc3MhLV1/rN0Fz6meI94HoauBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dOX5FxJO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dOX5FxJO"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso28310451fa.3
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727789829; x=1728394629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BxySFYjgMYSgGj7gZxM0J6yslTcBL+xxt/8bGUkQxc=;
        b=dOX5FxJOnCOn4nCC/bKaZrwyU0qIsJRnJuNlySfTC1t6Xdq4icBRJkVK0JrtpHSjMt
         /WH23JaKVzS0cIBj1lG1hf1ovKU9nFLDwWH4m/j9vfI9rvDj2dP0zo+BbhOhCMw9vYkW
         rOgTRvpveUSDMUjV3VjZJBfG2IQIBPjaKhllScKc4+M72n3nCmglvOgugxeD7kNO1Hsx
         8VhxQgSLtsHALAuaKe4C0re7uYYN9OMUqTdWQIF2vC1BRHmhJbc0Tfu6v1S3Fw4RYtfB
         Ta4NwODnK5I7qxEFmMir7e9UG6Y60ZeP64nWj+s8teC+iB8QTTmVzmG38vRWZ0yCQQMV
         /iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789829; x=1728394629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BxySFYjgMYSgGj7gZxM0J6yslTcBL+xxt/8bGUkQxc=;
        b=FWlxyOsG/vkPPidxXVnTKiYdxrSJoZ2j7JfiPI8AYztrS97gQeRnhfLdOdT+FfWACq
         FTz/QUKFYlwbFtxBCPcPnlBogqkjQ40RfilS+tGPND4SmbHRKTwtYLWUIHn08iedhrNi
         6f8GbhEBih1G4IBexjbxA6i+g3QueALNsoIznIUrDKwdr/pa4MBIW+del6I9iKcDfreV
         +A49jI6I2k64kbiLhQ574Ijq2WFf8YcJoXhvm8j4sDyxCQq4wPKG6Ic/JEKFdxpFZHh0
         PqaHRu1E+u4571lZkUTzWL9rBiOOUyRqpIr+6vHXMidQk32Iw9DgKfvn+ZdKVdqeomlJ
         NMCg==
X-Forwarded-Encrypted: i=1; AJvYcCVKrqf7U70ndvHJQifx+h7w/zTNNfOShGUc4A/YfOQqyXZwoEnymS14zacUIdfbgydoxiJzBrLyeoc02cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiVnyB2RQK8Pp2bM/uXzA3Ph/sWXW7pvLfyMw7Lx912IdCKm1
	/bZZstPn6J5CQuLrZIe7AlO6NpEKNY6iVL3bB4Cq9t6G2jFZ7MITvbR+xSqVALECDnj97Wd+3U+
	oITssbE/Ve+maZvR29o1Fo8g/u/7dShuspYFYSg==
X-Google-Smtp-Source: AGHT+IG4QsZVp3c0GwViYHKYsqg+Yr9QOSGNd6d8be6G5dnaCzY4j5yVeg2oaXaLBwwed7H3SV9IsGiP8nhynNtnFfU=
X-Received: by 2002:a05:6512:39c6:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53994f50221mr6566227e87.59.1727789829000; Tue, 01 Oct 2024
 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-3-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 1 Oct 2024 15:36:57 +0200
Message-ID: <CAMRc=MeYSsh+MOrOHSabiHuyGOrZK330WuNXcGDtg-siJFya=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:51=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 9ea6bd09e665..b6a8729cee6d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1096,10 +1096,12 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> +       uart_port_lock_irq(uport);
>         qcom_geni_serial_stop_tx(uport);
>         qcom_geni_serial_stop_rx(uport);
>
>         qcom_geni_serial_cancel_tx_cmd(uport);
> +       uart_port_unlock_irq(uport);
>  }
>
>  static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> --
> 2.45.2
>
>

I already reviewed this[1]. I suggest using b4 for automated tag pickup.

Bart

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[1] https://lore.kernel.org/all/CAMRc=3DMd-B3MCdjBA6Z03Tn09Qdq_O=3D2Gij=3D0=
kr8HiLtpp11kVg@mail.gmail.com/#t
