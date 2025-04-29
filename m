Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC20219EB
	for <linux-serial@vger.kernel.org>; Tue, 29 Apr 2025 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898106; cv=none; b=gj79xfEd4MimYAW4V7gSu8nfYAo6c7ZYQ7z39rtCQUyMcB1dOJPJ4zOzW/8ZDSUpwh8fOJFG0CpD1t/mmC0oWWXv5baVdjZa7u6uCa2JGaKXZeqQhd7IO8ooTN5R1z/K3wLiFcOMp5VOEmrbbXYOJUAbDcSBzcwQKYtg8SQPl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898106; c=relaxed/simple;
	bh=ciEaeHxgnREGIrwPwee4LaqjAnVYafV0jX/59qerfYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R29FDKSt7O0NAnLgIJ6ueb8aycPxyfzjr5IBbxlGXDqsO5pRN+qix4Ldo9lQfkrLJrO/wL8l4y4gzgKPr2OfqnjCG2dxVIP3pCVN63MICef3ilpwxjU97s2xJNEao+wS78OUic9dD1teXAo3CKBHiZvKmQljnOIvPa1/1RwmL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MfCdxAGe; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MfCdxAGe"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-606648c3f9eso648158eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 28 Apr 2025 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745898104; x=1746502904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0+PRveIJeGv5ra5sES3AX9a/1qV/HyEee+G6KrNPf0=;
        b=MfCdxAGeqOUK06oijHFxe3+m+LGjRnt7Ee7OkQg4Dtgh5jzA/J3HCxkAV85ZHJnFR4
         /WQOJBV1Er0f3QQHL+M8qg8YwyqdJlN+Mf8+WUVMMfGW9mM9vd5gQUIDUd9aSRbdiLNQ
         R17MkkQ6EA6h59v1wSW20uVo1LWQ9EdawUmb7KsV3z0GUYlF7flIrFn3b2HjKQ0oBX9i
         H9oBjfKHjYx1o7ygcmTKZkd2j2GFrAXaxTthCStD84CBT2ppOn33OxZ8edE0c4CZ48Jg
         QrxxQlk6WK64h0Viws9wy3g5O0lH7j0moOCvUgR+xUdAwoaJob0soCpm0TLdaNBleg5v
         3kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898104; x=1746502904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0+PRveIJeGv5ra5sES3AX9a/1qV/HyEee+G6KrNPf0=;
        b=aYBpA16nB7/7b2K9/cB1SZa6N493OKJkpq8GXXWlpp0r6erd0ggicP0drEDlidFESR
         c1rs0CkLqhHTfZL8yQfEl5zmIYOtnfv8fw3gg701jWcnDYjh1KN5ZKDero3qPUXjif7U
         EBfS/jPHms6KSDKadL6kuC2t4JCEvVzlkZN3yzvcLrPUVD6l4OyJbxq7tlNJdgg4dd8T
         67jmni9c9MAn4dtbeTWh8OgVNundUeZtja0m5ZnBQOHeJT8Q7pAg5yx1j+T/WNC+O5i2
         wp3u2XHTq3HMb7P+KrF77fU4cbrgfBnF5sRxN1AZsLk8a/V+vaDA64IsZXMUGUx5CPw7
         r7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsYrvO2E0mS/bY6UsHXou+++B6EQBevVLDSX7yVhsdfccF2mhiK9XYerUjsRiRjdQpn+pXtYpirjhhx30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMvN8d/84wtMjpmCj0SaNrQDMA++4PxXeUbsgc7OdoXcY3TB3
	fZFJxoMiO8BsyzSJ7DFiHhhhzbyANE1a+T59RVrhNZ2H5GFtf6Vr0HgLUmMru8j/ZlwEh8yajRU
	uf7q8jwBc3wHlK1Wb/U2N4/zrebbu4FnMcAOjIg==
X-Gm-Gg: ASbGncs8tRYIz6YQDPDST6PPcMAIDRI4iXXGMXQdy9FCRAcsMdT+KL3kfCP7Dr97FeR
	mI1kGKlssDkAt7fAt/z9eoxxZmztuAlxf600v+6zN2GZpEBkRTBrY7rjC2fWoGoUHMbAFyYX3xW
	LxdzaMM6oNuRRj6Co01He8Kc2lNdVntKHFy8Y=
X-Google-Smtp-Source: AGHT+IGIgJEMeJpTxwUkX18+O5XPbZJXJ0/AybPYKgwiz6zA5rIL3rjZAhe/VIyzWBb8u9hXh5Kv3oYzdwm/JWcLxmQ=
X-Received: by 2002:a4a:ee0e:0:b0:604:66b4:a8f2 with SMTP id
 006d021491bc7-60658e8dbc5mr6346871eaf.2.1745898103701; Mon, 28 Apr 2025
 20:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-4-cuiyunhui@bytedance.com> <57d75d55-81e3-445f-a705-e8c116281515@kernel.org>
 <9d4e7002-48fe-4fa0-8e23-7c2160419910@kernel.org> <CAEEQ3w=MOSU2mNo8qq8qz9KE9M0Zb55xeS9aw1263osXtP+8SA@mail.gmail.com>
In-Reply-To: <CAEEQ3w=MOSU2mNo8qq8qz9KE9M0Zb55xeS9aw1263osXtP+8SA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 29 Apr 2025 11:41:32 +0800
X-Gm-Features: ATxdqUG4oyBOi0YvndKmwL4h6eShdN7sURspXkVL2sh3dzFP_Xt_N1ugSNVE4LY
Message-ID: <CAEEQ3w=zAzwnbQaSC3JBMcGODt0xzud-fuYvVRA9=C-2tEX_Rg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: Jiri Slaby <jirislaby@kernel.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 7:17=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi js,
>
>
> On Fri, Apr 25, 2025 at 2:43=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >
> > On 25. 04. 25, 8:41, Jiri Slaby wrote:
> > > On 25. 04. 25, 8:24, Yunhui Cui wrote:
> > >> In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
> > >> before reading UART_RX when UART_LSR_DR is not set.
> > >>
> > >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from
> > >> bogus rx timeout interrupt")
> > >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > >> ---
> > >>   drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
> > >>   1 file changed, 12 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/
> > >> serial/8250/8250_dw.c
> > >> index 07f9be074b4b..1e364280a108 100644
> > >> --- a/drivers/tty/serial/8250/8250_dw.c
> > >> +++ b/drivers/tty/serial/8250/8250_dw.c
> > >> @@ -273,6 +273,7 @@ static int dw8250_handle_irq(struct uart_port *p=
)
> > >>       unsigned int quirks =3D d->pdata->quirks;
> > >>       unsigned int status;
> > >>       unsigned long flags;
> > >> +    unsigned char old_fcr;
> > >
> > > No more unsigned char, please. Use u8.
> > >
> > >> @@ -288,9 +289,19 @@ static int dw8250_handle_irq(struct uart_port *=
p)
> > >>           uart_port_lock_irqsave(p, &flags);
> > >>           status =3D serial_lsr_in(up);
> > >> -        if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> > >> +        if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> > >> +            /* To avoid PSLVERR, disable the FIFO first. */
> > >> +            if (up->fcr & UART_FCR_ENABLE_FIFO) {
> > >> +                old_fcr =3D serial_in(up, UART_FCR);
> >
> > Wait, read(FCR) actually means read(IIR). FCR is write only. Or is DW
> > special in this?
>
> Indeed, the valid bits of the FCR are write-only. It seems that here
> we can only do serial_out(up, UART_FCR, up->fcr); What do you think?

I looked through the DW databook and found that we can use the SFE
register. However, it is not guaranteed that all UARTs in the dw
series have this register.



>
> >
> > >> +                serial_out(up, UART_FCR, old_fcr & ~1);
> > >
> > > s/1/UART_FCR_ENABLE_FIFO/
> > >
> > >> +            }
> > >> +
> > >>               (void) p->serial_in(p, UART_RX);
> > >> +            if (up->fcr & UART_FCR_ENABLE_FIFO)
> > >> +                serial_out(up, UART_FCR, old_fcr);
> > >> +        }
> > >> +
> > >>           uart_port_unlock_irqrestore(p, flags);
> > >>       }
> > >
> > >
> >
> > --
> > js
> > suse labs
> >
>
> Thanks,
> Yunhui
