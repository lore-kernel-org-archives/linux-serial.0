Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379D1EFF80
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661471; cv=none; b=dT6NxDu9IkKwHgqYLiWAIx4TkbGE1QVLxEAgcT5ZRRZT8sTp2Al3r40hGaIPdgiRnDAWqYR0Klbex66ItnrHpiH0QCs2QcRqh/onXguQo03K59mRVH10jFzqBmWDiBu6mZawfVHxb9BYqUvy4yhJ1Ifj9urKi2msDtg8wHSRGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661471; c=relaxed/simple;
	bh=lhQGL65mh+Pd502kBKUo7LWS+tonpAtFK6baX7q3Z5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvZhLS4R7SEk0r9Q7n75HAO9sEjAqqrliuqks9HOq0aNGj8vzf1mIgt4BA9poPd2Z5ssvgE6P1iKiT874LZjbn5JRIJt2lT9qrWGo3cdHLblY6sy/077k309an5sP9jJiw3kAYTO6DIJ5LIvHpGurLIkWKSsy1rllEWrwPCaDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vr8wGqDU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vr8wGqDU"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-735a53ef4feso2878682a34.0
        for <linux-serial@vger.kernel.org>; Sun, 22 Jun 2025 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750661469; x=1751266269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XN2FIHGyxKqo7Vxe/X+1qL03gs1S2ayoffuSd1pCQs=;
        b=Vr8wGqDUyMqeW7KaVNJRMSnLNkIHSHFe819PUVQSrtCVn5Ax8UfKWYOtEiz0oxKq/t
         PiAsApIE06VkTof4CygWY/ZJ4lIGHMYQbKSwq8sYJHNN58WjK+PZUE9gr2A4LI6feLZk
         nCY/PaQUkfYI1AuIGB9lEd+PWymnMHfc5H2DMwvs+ug0HII1W8/SSZQEsBeKU/SmvFjB
         7PBTFBgccErNUUP4SY2F3MR1f87D7FEWyFmrWmgFc6+FD/riCiSZh9plC+bIJ/tNApNn
         7wSJZNJEejjf75o633HwKkPJqxsg3zBAYuA0e7oOSGlSyRTcQ0+Td0vVPfZeeS8mWmWn
         dKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661469; x=1751266269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XN2FIHGyxKqo7Vxe/X+1qL03gs1S2ayoffuSd1pCQs=;
        b=McZoEQd3+VQ16uqAKlURvVlrLda2c92lDf4wjOYADrjWAE1MCfT2jPEbgXxCWDen/p
         ttCQ+5S+eYu4y4/Ta1sV47c3iyl/Gwy9WiXVB36BGc+Q7HK9uWtOkud+p8aAf6gwIG34
         ZyWc+NTNDwlO+C22uxaBM+Dt/3aKkRD1tbiGlfW10wt6AnysPEZwfHx1N6HOI5d0GtmB
         C9/d/gsM+PQ+6Y/SpjzRU4o+Dka2sJScpgDnT9wOVIauzxOqjQp5gohEdIboo1dzswbo
         5gdyTO4efl1DzvgY4mK4sJNKR2GBtbkiCb/alq9ZsEAQxjWtHwIxX63BAi2yN/JxUpwn
         ZrJw==
X-Forwarded-Encrypted: i=1; AJvYcCXh0t7Pfhx3r9BjxCKPGROQZQJPHcdcDA4yuZedjgj9gx/UDre2G9WYPTQFJnqvf5fKpTEC0WsBZ8JZ1HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxP24CI0HNtcTRjPGKFyjYTu5duAe2Jad7pU7SZSs+aK7OFa8
	TdyD7v3U6Y4zHdmajVDWAFRDD/Y5+p4j5HorDs8KeIiG1i3O3hOn8wNQ3HJbPKwbQUi0frVpNQ2
	UJ5VtYvPG/D+6IPr4G16oW9RFzlobnL9vTbsbsGs23A==
X-Gm-Gg: ASbGnctjNwreZ0UtgNcw4iVnFuRdeVLWt9Q+nY0uvNsRBzedPT1zMQk5bdzMcnOdIgO
	kgZjtwGR2evZHgBbN05qUN2KWJ3TNRgW10jcjFQEyGj2zPep5RKxg3uRb+Z9C0RGwLg6x1lUI8C
	eHi8lJqb1RaD5HyCS3slNpMVOUto9uKWOrTXXT5Yy70eFCaw==
X-Google-Smtp-Source: AGHT+IGOV6fpgwYZJ6XEnF4sLNCaNQGSB5sJXkVwP+WXMIFKWHOnQMzCU+ZxWDVUQTD+jKi2/yjYIRUi5SZhE5W361M=
X-Received: by 2002:a05:6871:4385:b0:2c2:b85b:71ff with SMTP id
 586e51a60fabf-2eeda503740mr7793669fac.8.1750661468781; Sun, 22 Jun 2025
 23:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com> <20250610092135.28738-3-cuiyunhui@bytedance.com>
In-Reply-To: <20250610092135.28738-3-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 23 Jun 2025 14:50:57 +0800
X-Gm-Features: AX0GCFt1d6G5MQ0HyOTZZcpXJqXia_qBDrWAurYF7bjFv7DaYN68DdS9hFxackc
Message-ID: <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, cuiyunhui@bytedance.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,


On Tue, Jun 10, 2025 at 5:22=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> The DW UART may trigger the RX_TIMEOUT interrupt without data
> present and remain stuck in this state indefinitely. The
> dw8250_handle_irq() function detects this condition by checking
> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
> detected, it performs a "dummy read" to recover the DW UART from
> this state.
>
> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
> while the FIFO is enabled and UART_LSR_DR is not set will generate a
> PSLVERR error, which may lead to a system panic. There are two methods
> to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
> UART_RX when the FIFO is enabled, and the other is to read UART_RX when
> the FIFO is disabled.
>
> Given these two scenarios, the FIFO must be disabled before the
> "dummy read" operation and re-enabled afterward to maintain normal
> UART functionality.
>
> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus r=
x timeout interrupt")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 1902f29444a1c..082b7fcf251db 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
>                 uart_port_lock_irqsave(p, &flags);
>                 status =3D serial_lsr_in(up);
>
> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> +                       /* To avoid PSLVERR, disable the FIFO first. */
> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> +                               serial_out(up, UART_FCR, 0);
> +
>                         serial_port_in(p, UART_RX);
>
> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> +                               serial_out(up, UART_FCR, up->fcr);
> +               }
> +
>                 uart_port_unlock_irqrestore(p, flags);
>         }
>
> --
> 2.39.5
>

Any comments on this patch?

Thanks,
Yunhui
