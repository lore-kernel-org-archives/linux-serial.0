Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47A1F4281
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661111; cv=none; b=aL2F8Qd0TzWWXMytPRQXdJf4jQMSE3exy3oPw/LBcHvI7TwXFfm4eRlla9pH/FX2iTgZGYshGlnfmm++a7jkH+l54fM8vK/YxBBZjuA1I49Uf9yUd7a/M1clBHuDYrcp7rU8cqOlnJilYs2DxAF+nLy/OuZ9wZoQcF/olExxt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661111; c=relaxed/simple;
	bh=/TkujDozKxSiomVQ1kjd5orWK1kwjosIJos+z0RQDbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3Kcz6PCHA6tKc/RfEy4NN0rBoc0oeeZuEaCI1GBSonDgIEU3mRednQ8emn45mcqXS4zmHjcR1S5cs29qPuUUUtZFVCZxUbzUdE2fUK6X/vMmVQAGcbncjMgC96WNV6aJp0fsy+FNwgz/w8J7aCrXW8h4pdhkWNzaLiZBMcUz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZRzSso1a; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZRzSso1a"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ebb468cbb4so2186913fac.2
        for <linux-serial@vger.kernel.org>; Sun, 22 Jun 2025 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750661109; x=1751265909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiGvqzgxfrcVU0MUcCdZEqfJUZSc8k0kFm0WvBbaaOM=;
        b=ZRzSso1aPqUjmBKfSuZSapdhcOQHAX63zKQfsCWnQvcw3BYJC0+kpCCslOwPS4GMcV
         fKq7kilBGGsFrTtELpCDv8KLyU8JjQbs9ZNLDvjT+wqruN/sFF7i6mx6gQi2vw7vYUim
         rANVe35ImQ8FrbAMgSLshab3B0m9tYDtG1pp9e7RTRJ3PeK0ACb+c15yZIn7y0bT6R0p
         lOD/x4PQ5PKUoVJuHvTl3SJ/hxwHrfbIywgSstc9F61UfVauc5d+XPaGUl0ZOHM0WbmP
         LnwahkbK7pg3huLZWk9wdNy11mjuTySrDIj0o2itkZFJDhOmHCfbmqzYsbyY/BDdOQj3
         r9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661109; x=1751265909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiGvqzgxfrcVU0MUcCdZEqfJUZSc8k0kFm0WvBbaaOM=;
        b=ATibb+eGNM0fOeDuS0BdRfAuuRWp4vKdlUPSqK+Cdn4qLJx0tr5f6qktH8ONzm4djW
         EbEYE3rFNxTMh3j0paM2AZD1HweV6yasau1/77+mV1MGb8/qwnPzA2Fl0Ldr3uAc87E2
         rciZ+kfVShPOz8SCMSrGkx/6CNG1UoPqDyrpGw6GLKKZTnQbmOeaPF03kBFgtRlb8bFk
         /Ii2sJUG1uw9Hgg8b7C4iuTtE/tnnqVbwL/glkotVTDlcUJhDGQPlINZq6m634ck1Kzs
         6xsQ6MGs9G0zgs5ieqLbC/H9knS+7bqUgLnggyPFeYVsamHkq58QK91vg9cVMa0kNg0s
         Edgw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMz0s7hlNi6A/XdiO3TJ+h/5Ayc7u2QVV9jfCXkk8f6wwEL+cUrUPJo0WYHvL6M3Y8Tk4ezsuPkyK8/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76YA3aGrj1bYfV4PL13MdDzYssLwf+mwRiVienqocDLr/scDa
	C+gQrFuhj3KVTnNBpiAbiqfH939j0AT/UI57DCqAboWLe41jL2n01JIj8xV9h3grjc3Tb/Oa0q9
	otTEpHvR/wDFbWcb1PLb9JvFNioQOCqOD3G8l4dzfwg==
X-Gm-Gg: ASbGncuF4SWj9fWDcLnxeKms465dWX2CoNJhyoVIu3eZK5YCpjYsPdn2JKULnhCaF2D
	jawGWD2wx5qi0be2UCwxTYh259mAEOW2fDovQKrfDZKuwcWikyEv3SswkptOdDz6mjO+Tu6COj3
	DkWfDaWN5FbleyeM1qYRggYvN8J1+A+6fOqKl7za5eS4TSZsE4npGLEfzs
X-Google-Smtp-Source: AGHT+IEsROQ4g1XebHU5WJSIBFGfsEnm1J4yObsw35QVyM6q3zvuGIzdlIgW3k7FPb7n50t30U9LGsgFIFHK0I1vcpM=
X-Received: by 2002:a05:6871:4410:b0:2d5:ba2d:80ed with SMTP id
 586e51a60fabf-2eeee55c6f9mr8708294fac.25.1750661108981; Sun, 22 Jun 2025
 23:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-5-cuiyunhui@bytedance.com> <844iwak3u5.fsf@jogness.linutronix.de>
In-Reply-To: <844iwak3u5.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 23 Jun 2025 14:44:58 +0800
X-Gm-Features: AX0GCFuV_vdrWkWKU4wlKfc83D3r43Okwcov9xmDIR12kxIZUK-a9-q9Zy-5GWc
Message-ID: <CAEEQ3wkqY5K42n8H4xOia-Dv2mPUUK3wHT7je1YLM1jMys2BMQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 4/4] serial: 8250_dw: assert port->lock
 is held in dw8250_force_idle()
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, Jun 20, 2025 at 8:14=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > Reading UART_RX and checking whether UART_LSR_DR is set should be
> > atomic. Ensure the caller of dw8250_force_idle() holds port->lock.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index 082b7fcf251db..686f9117a3339 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > +#include <linux/lockdep.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/notifier.h>
> > @@ -117,6 +118,9 @@ static void dw8250_force_idle(struct uart_port *p)
> >       struct uart_8250_port *up =3D up_to_u8250p(p);
> >       unsigned int lsr;
> >
> > +     /* Reading UART_LSR and UART_RX should be atomic. */
> > +     lockdep_assert_held_once(&p->lock);
> > +
>
> It may be possible that during panic the port lock might not be held for
> console printing:
>
> serial8250_console_write()
>   oops_in_progress and failed trylock
>   serial8250_console_restore()
>     serial_port_out(..., UART_LCR, ...)
>       dw8250_serial_out*()
>         dw8250_check_lcr()
>           dw8250_force_idle()
>
> A similar incident was discussed before [0]. In that case the result was
> that the lockdep assertion was removed.
>
> John Ogness
>
> [0] https://lore.kernel.org/r/20230811064340.13400-1-jirislaby@kernel.org


If so, we can drop this patch.

Thanks,
Yunhui
