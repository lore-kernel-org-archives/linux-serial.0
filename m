Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587A78281
	for <linux-serial@vger.kernel.org>; Thu,  3 Oct 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986026; cv=none; b=Iui44RF2HjiEmL78ebr2BiS1OyjvgqGnE303cq9tebueVh7Dh8ytz42sxg/2hZtcPvUK4WVXemmZtjCs7dFFRhV7lAlqzk9P1bGgW7UVTKjPAOI8Gxmvpw0PEPIW3TAp8zyg1nasv21tncKOBwKCHjSWoChKNQ/qUS5KPbsjwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986026; c=relaxed/simple;
	bh=TnhcYpa/NRBNowU8LjRQnpY1dIEz8TtqcanEbYw8s+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjxvh+5ZhJJQmC57QEdzXZlfQ+SmBO0+aM/iUNvsLZStEFeYD0At991a9qUTj4A2w8o6ELc2c6eCCrVXFQx92Vhr+iTjRTOSP8+kAInjBuEuYIPLOz2lJiwAXPrfrc7Ypp4gAqQRQmMGH4XzW6O3ai5vVDw6wQYR+SHFNvJfy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WRFy0XIh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRFy0XIh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53991d05416so1725969e87.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727986021; x=1728590821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKF05LoiruBsD6AHIRVSBunf1dIpsE0purL42isX/Q4=;
        b=WRFy0XIhIZWYM/HRcMdHhZ+w47m12HgWZI9vSOAPyvGHOGuwOFg/LTB14t4+EAJ2PL
         Y1nXHrz7vNGtbExaa3/pT/llj5DyYxPrkTIh6Rl5KIlvo4m8eLgSu+G+CW1bCaTHOZLX
         6ru7GoenElM5cPfQm57jlghm0jQ87VFLHhmSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986021; x=1728590821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKF05LoiruBsD6AHIRVSBunf1dIpsE0purL42isX/Q4=;
        b=LStgXDnrbXpyvlWMnqTJYWDYnlXcOEWOA0NcYu0/6zCVBXyAzgqONXKLLUt4onSDwX
         Hde3mGBRrCHC+2gOQWCpx2FgW/bVaXeEDZEyYuGdXhCQVshJq0buy2yaETF9UiJmJR0Q
         be96b24edZ1+usnBUx/7edyFq9vdwEj7UglhVKr4wpFcAFkER6NanNs8sOOF/rGKYk3o
         tc7osmhSDZ1OZc61SLKq9NdAVbL0HcoNvitRogqLcdf2ETbcGuPw3ybAeugSk02PToaS
         SB5lf+j4DwhZv+FJoOYc83cnSaXqBGhx7v9glQavyDkPQPp+MLY05/qZWbSkfGCFIGRx
         HZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsxkdRe41yiEfWE15UcLW3uL1feOx5cEPG6zI5fLgd1jHL2eGpHdrQvw/ys7KDvLQ44GeMFWkcPZ/BI98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRQkYgLjq+fWvmL/L5a6i6+paOx8mVkImr019xX+iT4vi1P2M
	YANzOIhuL/clmn+dGEyzFaVvoe3DRAWcxzBIpyh1NAzRm29I4BVsSCrQEddzXfszRiiYHOjNKhV
	RyFHE
X-Google-Smtp-Source: AGHT+IGOYs1ZzkdjIl67fuDcKerV8TfBOcoduuVdGLnyN7X3bErO5eGVkcEEjy521Bu7u0HrqEJigg==
X-Received: by 2002:a05:6512:b98:b0:536:55cc:963e with SMTP id 2adb3069b0e04-539ab9cf28bmr513430e87.44.1727986020519;
        Thu, 03 Oct 2024 13:07:00 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82a3b14sm253060e87.208.2024.10.03.13.06.59
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:06:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b589032so2278631e87.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 13:06:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbbU8IXtim4ncf0SWrG2dTkuWLHnCpyJG7pCYTDdeRRNcb9Bo8JbXD7uIApqh34vvIzircngMK2WZyv6Q=@vger.kernel.org
X-Received: by 2002:a05:6512:3d07:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-539ab8659c5mr452850e87.13.1727986019089; Thu, 03 Oct 2024
 13:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-7-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-7-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:06:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9fEQ-g_LWK18SfZq4ZmFN_QbrBCwKRx3BTc0i-UXEcA@mail.gmail.com>
Message-ID: <CAD=FV=W9fEQ-g_LWK18SfZq4ZmFN_QbrBCwKRx3BTc0i-UXEcA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] serial: qcom-geni: drop flip buffer WARN()
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the unnecessary WARN() in case the TTY buffers are ever full in
> favour of a rate limited dev_err() which doesn't kill the machine when
> panic_on_warn is set.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 5b6c5388efee..8bc4b240bf59 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -570,9 +570,8 @@ static void handle_rx_uart(struct uart_port *uport, u=
32 bytes, bool drop)
>
>         ret =3D tty_insert_flip_string(tport, port->rx_buf, bytes);
>         if (ret !=3D bytes) {
> -               dev_err(uport->dev, "%s:Unable to push data ret %d_bytes =
%d\n",
> -                               __func__, ret, bytes);
> -               WARN_ON_ONCE(1);
> +               dev_err_ratelimited(uport->dev, "failed to push data (%d =
< %u)\n",
> +                               ret, bytes);

Not that it really matters, but since you're fixing the type of
"bytes" to %u you probably should fix "ret" to %u too, which means
changing the type of it? Officially tty_insert_flip_string returns the
(unsigned) size_t.

As a nit, I'd also say that your error message shouldn't assert "<"
unless you change your "if" test to "<". It seems safer to use !=3D so
IMO the printout should also say "!=3D".

I'd hope you're not hitting this error a lot because it means you're
dropping bytes, but getting rid of the WARN_ON and changing to
ratelimited makes sense to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
