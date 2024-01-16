Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86C1CD29
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429298; cv=none; b=cNvhVDVZTqd39xo17frYRWknqpKKvSgay/yeBEzGL8ro8yaoGqUEHuHnCrz5y8BzY9Yg4LpNHnLg0ucK1fjER/MOWlDy6xqfJiBTUDpjE1T7r75aD8EiEmTInzAw6POCQ2Vl+dlHFmBc58YCvzgGvv02Vveg/BDPfeyluilO99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429298; c=relaxed/simple;
	bh=iGtilefM/gHGUZFo8PnOopvTKNySbPwZh2/Qz7KBUmA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZrzX5tgKmsIpzJ7TTWJnOYOZfGGp8YEOir1h4HPTXQnSMqs5caEhpgsCijMIdq0+XSIoAjNybTnh+/Vw+rJvFDu2ydp7aovZ0mzznZ1rdFv3V5TAqp++1axeVsOu+qbZuqMSf2Wb3aI8N+gjTJvo2+fjDMjZ3vhK39nAAtWG6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQ6sLM2u; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ6sLM2u"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28e724d9c47so644930a91.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429297; x=1706034097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJipabZ4zYazV9lmvPELaW28mg+mGYQPV3OWXJ3l8Lg=;
        b=TQ6sLM2uV/PtTURW4b5q+1sq0c8VHyX0LyJC/8bqwJmaO7dbxAYGctcl0Hu+Lp6AHq
         rgL/WQeVkGbL7MHjCYPb8jsQXGlckhtMXRQMH7UffadiN1essyf/AMnissPDyJvK+X7J
         tklzASBDvFEOLgNbfit72lUKYpftxmKjI6QkyivkLvtQ9n2b57+W4cBWSuHBfP9wfBXI
         86c1fTgJua8pPh2dBSwNsJ245NvIUs4OTUyKAZyxyV1S6v5FHnxYrGdSLErYOJ+Yq+2T
         zTDXeiszorLzW18N6o8JeR4OTu9/IxjtbCAGydwz/cJB6qJVrVC+cuKaV0XdeqUBemxm
         s2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429297; x=1706034097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJipabZ4zYazV9lmvPELaW28mg+mGYQPV3OWXJ3l8Lg=;
        b=ncW+VHA2BOIpz0OFpEfpOF1wvF56daRqUw/7c4P8zGqKrcqApK2AC9Fv+yTD0Ku1V1
         TTKTG0JPjNLyH0cwhUIwY5J4JLS5UbIEZtKREH1XPM9jYmZ4l3RSq5SO5pUB+Y5FHuZ/
         qQ7YAkJDqsYpYhRWj3u8HhdgwHIrtSnhVIN+zht5P2pVgJNjSsnxV39LOc5xZ/c1ql/4
         hvHoV2tLKyO5Za/OXYAPa1u6acO+18wlHE72wfpV4Gb17GSLIK75L04R3jh3/w5mbjQv
         8YfOxhP24z2ATZxBTDRrkF9ObHDs8GwRLTgZ0B6Mw7jHneCCGV/oO9nAXcwDS1vcUcqy
         eNHg==
X-Gm-Message-State: AOJu0Yw9i+/9zMdAt8NK032Uo1pVTVIhuCvaDZYpH5sj3ksVZiGtppEM
	KbD4f1BOvflL9v4TUdV/veTmj9nzEcSlxW397tMJZdkV+GrUzA==
X-Google-Smtp-Source: AGHT+IGD45n2Kmp+42UAAvN1CntcTMHyFOTUd0Yzi86RjPsn4J8yQSUWK55vtqIj7sCnDXiqs0FpmeClEfHPtw8H6Y4=
X-Received: by 2002:a17:90a:d193:b0:28e:79ea:924d with SMTP id
 fu19-20020a17090ad19300b0028e79ea924dmr948652pjb.92.1705429296877; Tue, 16
 Jan 2024 10:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-11-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-11-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:21:25 -0600
Message-ID: <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> ``max_count`` negative values are not used. Since ``port->fifosize``
> is an unsigned int, make ``max_count`` the same.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 90c49197efc7..dbbe6b8e3ceb 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *=
dev_id)
>  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourpo=
rt)
>  {
>         struct uart_port *port =3D &ourport->port;
> +       unsigned int max_count =3D port->fifosize;

What if port->fifosize is 0? Then this code below:

    while (max_count-- > 0) {

would cause int overflow, if max_count is unsigned?

>         unsigned int fifocnt =3D 0;
> -       int max_count =3D port->fifosize;
>         u32 ufcon, ufstat, uerstat;
>         u8 ch, flag;
>
> --
> 2.43.0.472.g3155946c3a-goog
>
>
