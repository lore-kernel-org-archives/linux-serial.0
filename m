Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC213E02A
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554840; cv=none; b=hgbtLsFW4i1b6IbH4wXTjOOwK7MonKCAN+R657v5TmsTQxfrKQjpNsYBap6U8XnK18RpmK5t2/vn8hjf13r1wRS27LPM+wiJyyhxtQKv9O28SqDjSXFbGqd3RI6gK6Rql/aZg+eG4+VGwP9lbY5KZQzqAYyMOdTtpxDj0YE7hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554840; c=relaxed/simple;
	bh=XxJg1bVSF5nlQjxwTRlYWHO6MsUilq5FSYVO7QvMtaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnhDMlnAv2T9SryVN+PkMAs7SpaW8KrleFrDSnag2P7wh6+ICW3hpA9bnITxbFsN0Avlbutvv8ej7abreYJ8IO+kjvpQ5kQD/MQMF+XfxKmCSpYsqStkCvq6kXZtojnUmpKsGOayLuQPpNq7p/YTzN1hrqtjCjUoHK6r2nOZESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJUhGek6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJUhGek6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735b89501fso454414166b.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554837; x=1765159637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVMTOb1Zwp19W7fEJmu1tSOQB9gIdgM6p8CZdZBN8tY=;
        b=FJUhGek6vwDP4U5rIv9BtuNjhG7TWreiy25/AkjHq7lZ4Iv5wL15xXEIWbNCHKGsH4
         HqQ7IRaIOF8eBiBZP75+2w3v8vLVZ2MStn2OIkfmIBZkOLJIYvE4D18evfdfS46o2vy6
         csYp8Fv7LZ3QDgXiiT9FcSOHnxrxwzfTXLbRnafZICDZTy3SZGII/QSqBeRFzzwO2aAU
         bxoNKyw/qLgAH9SeRmG8QPcqKPeh4zn/1nMpRYdvSRIbuu6ABWcF9g28+9m05+pEbmAg
         HZ6D+ZaZomTr3s05WbpzRBHwc0X7LI5XbbImhINV9GUKxVX6D6Cip/qebuvwoMxoH/8O
         0kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554837; x=1765159637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVMTOb1Zwp19W7fEJmu1tSOQB9gIdgM6p8CZdZBN8tY=;
        b=sLATB5mPBPpqS/cWf5Zvo9Mg3Kseo7JQfv7fld/iP/YIi5akcdixRtPT0FVYzRohD6
         R4PzZZxRUWWL+HbdKHPND/pFXEcYoFWVBLze6UpdqBIgGCzgxUtce7BW7nj2s0RCdFOC
         QturtEhEO2cHijwPddLM7HPrwc1DNDnAiGjgKcZ2DCB1Sxb2+l8gDFf+OZdHbbDF0IGh
         MuOAM3ecxW483od5KxYsIoLtatjGKNgOlWF9NLBLZFw5xSXhqwe7YGiXK45mgRi5F2wd
         hmz/hGTlHV63qhzt2w5kcv0PMTM8OkSPdEkgN/+nQoz8wLgfhfcVGSmAc4yqsPzD7s6G
         pMPw==
X-Forwarded-Encrypted: i=1; AJvYcCUwaGQBTS6e9QzGst1OSFFTR8upAmUM3BiB7a8vxb+at6dIR1SFowd68huUMASNf2DzwWDSTCgiaWjUA8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MnsDYe5wd1oNgWcdnLar8oWGmOZKMdrh0t0knzVK2xrdLx/a
	4yuoNVwa5lmpVRBJ6KH3GYH3Dc60wBvhz5bdIW8L4TvuMHKWK1pPaC+cJFnpxvKmcDYGQaellF1
	HQo/ZYTyN4bZB61/P97lC/Elf9L1aFw47MWgo9xk=
X-Gm-Gg: ASbGnct4dRF3KDObnEBDijPwLnJe5FTxZQ/qGu01pffoApVPYcrJpEyZcoOHWh50ipf
	WWkQyruMYT3+mOEQC5wYVg4L/fD9Sbi0bJtq7P64IGDNsFGFAe9zGOspwn0/QcVCViI81rsPNxQ
	QcWrl52Eg9O2E2BXZkWk8rwz2wQJsRSOgwLc9nqKocEPmXBmgYCzI4Qa5NOzR6HiK4ONiLecV+9
	4BvmjfyFusNVKqRTvg/92Yz0xwXVwhXXe+hPsz4/78k3JUZoPNiHsAnum/7xmMeZYo4P5G61PCw
	G+xa09qzYxry9hcj+Y7VuBEEI06CHmc7VYE1Lccms4UUhjuP+uLfhAyiqxUjYezhQqqZ7J4wDvU
	CA6EpLw==
X-Google-Smtp-Source: AGHT+IH6xGLhjRKpF/G3MT48tLuXTnP3KS9fQuk5GFvx3m1TIz3jC+pWiqUFw93WXt4guusJfwMvi4nkXXqobygFaBY=
X-Received: by 2002:a17:907:3f11:b0:b70:b077:b957 with SMTP id
 a640c23a62f3a-b76c53c0a72mr2524190566b.15.1764554836541; Sun, 30 Nov 2025
 18:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-25-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-25-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:06:39 +0200
X-Gm-Features: AWmQ_bnwUrH1jq2u1Wv_ZfC6AaoIhUXlTkd_VA1xsMZ243pkBiTq-0YpNZcPkQo
Message-ID: <CAHp75Ve8tgYZAJB=ECq2O1ZZshFaD6EHvSH7hUt4XjQK445Wzw@mail.gmail.com>
Subject: Re: [PATCH v1 24/31] serial: 8250_mxupci: defer uart_write_wakeup to workqueue
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> When the TX FIFO drops below WAKEUP_CHARS, mxpcie used to call
> uart_write_wakeup() directly from the interrupt path. Move this into a
> per-port work item so we avoid doing TTY wakeups in interrupt context and
> reduce IRQ-side work.
>
> Changes:
> - Add per-port state (event_flags, work, cached uport pointer).
> - In tx_chars(), set a TXLOW event and schedule the per-port work instead
>   of calling uart_write_wakeup() directly.
> - The work handler test-and-clear the TXLOW bit and calls
>   uart_write_wakeup().
>
> This keeps IRQ handlers lightweight and avoids potential locking or RT
> latency issues while preserving existing behavior.
>
> Note: removal path must cancel pending works before unregistering ports.

...

> +       struct pci_dev *pdev =3D to_pci_dev(port->dev);
> +       struct mxupci8250 *priv =3D pci_get_drvdata(pdev);

dev_get_drvdata();

...

> +static void mxupci8250_work_handler(struct work_struct *work)
> +{
> +       struct mxupci8250_port *priv_port =3D container_of(work, struct m=
xupci8250_port, work);
> +
> +       if (test_and_clear_bit(MOXA_EVENT_TXLOW, &priv_port->event_flags)=
)
> +               uart_write_wakeup(priv_port->uport);

> +

Stray new line.

> +}

--=20
With Best Regards,
Andy Shevchenko
