Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3D17A918
	for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586003; cv=none; b=AzMC4HpGuBaNvkXdlZeQRm17aqWvRji6sB3ix/Fuzcr8fGJOAi+wpdzfis3W31f4MrkgcG+NF1/ah7tOFBLs4E1CvcjjsOFRTg6TND9wLmLmmP0oIilMwQL+/2TtMdqE2q3N4oeL4inpcoo/rjitdv2qY2oExa08Ph7ystait6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586003; c=relaxed/simple;
	bh=C6BIJE5gYeC/g2Oak4zV9l7IfmZQnQtGYVUJTeQWod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7GVmhy5XQud+QdVgOD+Ff6ziSyprj5wN4PZyk6/sDYHpCsfxkLMR9jOvkvIELVFAL/rHEs05EU0u2QWpZTZwx9nk7RkjmwcIgPx2CDQ8mnBQefmjx2kVYaEfiWx67q/AJT+QkJXoBHYI6o7tqtBOd1l2CJZp3hflUIJ7BbELEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yStfJrlM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yStfJrlM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so45141441fa.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726585999; x=1727190799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=yStfJrlMhN4gbrtmJKgz2O1MF4AD9CH88Hy2nqW1pq8ElVywcJ9EWqGDOdgYxXttK3
         bpwNR7HMVpke9eioC5kp4efzUPDBtbLw/zwKnyiwwVTAUtoc+MnnWa/Bxdgmh/hA44HT
         BHGIcFBfWSANWEvCNbEIUIlgPA0j4hRcZKBaIr8Cc5ol4CGb5cAjzT7KNzezLATyMX+c
         V9FSbsT3RqhDYQgR65gGd6NEEakSeeB55APgcKITHi9TYhWNxuCYEfS/99nmVCfbM7Ra
         fv3smgOYTpVcrx0MNpN3lNBkS/txwcAoq6MUCn9iDgRrr08mWSWix2kSc8OyzXPobYka
         GWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585999; x=1727190799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=SxeJRRc/UQg+o+E+wp6FB9R3ioeUEONh3lrFpQJsnvQATvD8U93s0XO4d4700mMQIX
         XOKn5d3ssNGYRT+v84Y4F+Bk4iXx4JjzMjUeFcDUPIXsctIQ0coK+RVtbxtFOe4JI0Vd
         9hHp9g0X77ARUOA1F7cq14dHO/Mdi3ctXo6pJP8TkYRtsFM1DO5czayzqPq0VFJdGKGQ
         Cz4pYb4yXQpgIyzA2o6Qjq23DYFGFqh+/CMHRghf9giInQL4kdxPL6A5tuzq2YqDwX6A
         iXol/RYi8lYhya/CfUfgtCzKBRFnAlDh9QFpD22k28d0ujBbLTUCpgDQsInqZniu4fSv
         8kcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhMpqrpu8hPzooITjl/Q2wPt+BOECaiGRKtZMm0pV+R+ZCua/f+G08ufa6TnCb2mmXUNJtXesAaCFDsoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXG+4OUtJQT0gGjLDgz3d2y/kizZ8o8DomPzQBjIkv6uB1GUa2
	t4H+SqfnZH3e2ADo9nZtEuhi5Qbsunnp/hWVoagqlFr5GgQGZidFQilvqEA+1rfm2DdcEVJIY7L
	a6C+BazOnTNmWTpOEDCypgfBmbcmoByXr/fgnDjrZFsTBY0e+9og=
X-Google-Smtp-Source: AGHT+IEjk8ZHjlHyyFFjPJuCGwJFKhZ0kGO8bejy0WGDuXef54JZ6Xsqkq0B58+CUBKCRRCNpr78RpMazH22iNaAcZ8=
X-Received: by 2002:a2e:bc19:0:b0:2f7:5e7f:b4e1 with SMTP id
 38308e7fff4ca-2f791b4d3fcmr82055101fa.30.1726585998980; Tue, 17 Sep 2024
 08:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916172642.7814-1-johan+linaro@kernel.org> <20240916172642.7814-3-johan+linaro@kernel.org>
In-Reply-To: <20240916172642.7814-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 17 Sep 2024 17:13:07 +0200
Message-ID: <CAMRc=Md-B3MCdjBA6Z03Tn09Qdq_O=2Gij=0kr8HiLtpp11kVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 7:27=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
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
> The call to stop rx that was added by the same commit is redundant as
> serial core will already have taken care of that and can thus be
> removed.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 9ea6bd09e665..88ad5a6e7de2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1096,10 +1096,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> +       uart_port_lock_irq(uport);
>         qcom_geni_serial_stop_tx(uport);
> -       qcom_geni_serial_stop_rx(uport);
> -
>         qcom_geni_serial_cancel_tx_cmd(uport);
> +       uart_port_unlock_irq(uport);
>  }
>
>  static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> --
> 2.44.2
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
