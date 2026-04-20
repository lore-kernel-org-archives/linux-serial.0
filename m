Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B038423A
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669251; cv=none; b=Ad79coSIn+y9vpSDlZLGWE5LLZJRsaYGVI8Gezz0OsRYEUIdX8VwYBa7EnVx870Q6QWBPdWVEddWo7H/LdPQWkoXRxtqEL0zzl5jDNsy71cwzAx2dTuOXAQRs23d8Dmz63aPkuX1bffJWQfVRdiTD6Cy1o8oaYuFWG3olmBKo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669251; c=relaxed/simple;
	bh=9YsYoFWZ5uVZIOAojkdoivYvL26fn7lMSExr6OaM0JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA1ZobQajq88eQ6zkwrlh8eZ4FG5o+l4Y9H/zgow1Yfih0xfotF9y0GOZtpGQGpihgpzkzLZwwA2p2vbOX+eny3mxxHa5D1kGa2bvFfL4KpvKlUNWjIapJtIaO+1LCUG3+Wwu/3+vFtywxj6hYsFvs1wAR8x/Qg+qndQBSHswT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5637886c92aso1073188e0c.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 00:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669248; x=1777274048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYMTBcfScSAP5MKdjyS5TGaWJxqpbr65TFOlEj0C5Is=;
        b=fDw0Amwn0sOtGREXQXqceda9nfQYa4omIE29SboXJpygs8/qdI2JG2CoLJfBCiFXE6
         mZdJL/QJpXhaBik5fPcp7p9xEXAhjl1FTPOkDRO9KbzahlcSmk73YBmsWHMqVqExaKZk
         ZzIajTN4wCjCpt6LtTMbuhP5WrRCbrQsk0NdQSGyzqxj9ZKIJ6MoflG2a13t+71NrpHL
         XOSeA5Ct+yHxag5NRmVMP0HXzQeVUwyKceZ4LJZFRFjDP2VN8ejn4zEDVS3NJ9AlidtV
         1MPTYpjjEB5ZBX0hWJhywKaAz1U6uVo5TxjpiCyimWrB52djpL0GM2bOkxlrwn5X5hPo
         bLjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JNjkJ+c8ftfDIPKKuuW0j3m4A5Ikx9lkPaxBVjQJvqIqKwIXlbizRyEQxwwin7H+YN8waGwuJgmzoVO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUO4cOHOIDZBGb9kfA875U0v68QBI0oYjjUjaG1U4bKJdkDNz
	xbCUVlXJ9PMY6rf6Y1uc00DCQmN6+faA8gZbkr2+nWmLQzKuqdpfPDi06XKWA+68
X-Gm-Gg: AeBDiesL2xjhugmLOl5O+ozGcHW/1Urm4kkCYKxBheMiXPngHUWPhdOhq4ZT8CM9wQo
	eswrc52ZG5wfunJNo5YjFNOtVV2bBL3gxk1OqOqbIg6UyVPKAWPZYBg56NTKgvYXUWCBehOAzJJ
	TEz/C9aH4AeowA7dEylh0qdXoMME4DkWmQnp8u57AVTuUuxz9bU2nLNNxJ4lNX+1GMhTIvEevkA
	Tdl6jjB//xTUs1ANbm1uvEhxp0BTdI2Jk/HU4/toL1XWNHfeLTGaraHGtxmCT8E8Mj6euExKVXh
	S4jzDUDBWdo78XY5LGthvD9R3J702zTxlgkFfHlzgkpGOW7rJXnMPS9kmtGJl2+vDwOnBOwRGVM
	nCmRDDVJrX6mGF6YdrTfOrMUBrrfcuifUAMRYnETl89E4/m931H6zWh4NeT1Xu7mZttaLsvqeNU
	fdVAkwZ/CJGV6SvVTstOZOEirRHxdONiIT5Sx6vVPIeEF49U9HzT8PHwe/brNyIFmpjoMrILFb6
	2FrDBHpAA==
X-Received: by 2002:a05:6123:10b:b0:56d:b4d1:3c3a with SMTP id 71dfb90a1353d-56fa55c512amr5898930e0c.0.1776669248289;
        Mon, 20 Apr 2026 00:14:08 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa92f22a4sm5825541e0c.12.2026.04.20.00.14.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 00:14:07 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-60fecdd1efaso629864137.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 00:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9unxi23e3gLR0/mlK+GXAqDpdesHXJqQ8/FX/J969oY8o+HEWXDlf+p64uiYimsaMKj7kdmyoU+QSNJVA=@vger.kernel.org
X-Received: by 2002:a05:6102:3a09:b0:5ff:c5c8:2734 with SMTP id
 ada2fe7eead31-616f8ab6b43mr4465894137.25.1776669246876; Mon, 20 Apr 2026
 00:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417193603.3906568-1-hugo@hugovil.com> <TY3PR01MB1134667FC9A3920ADC444C21A86212@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260418103936.a3651d1606db7178fa7ff854@hugovil.com>
In-Reply-To: <20260418103936.a3651d1606db7178fa7ff854@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 09:13:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGR=YOLqBMSY_syvtYbAU216Q_+xC_f8gUujYhLjRWSQ@mail.gmail.com>
X-Gm-Features: AQROBzAIXHknwo18YOtj59EYmd36fEYWeF-kJpR-eCc-KPCWd-Wcf8_Qp_edtgs
Message-ID: <CAMuHMdXGR=YOLqBMSY_syvtYbAU216Q_+xC_f8gUujYhLjRWSQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

On Sat, 18 Apr 2026 at 16:39, Hugo Villeneuve <hugo@hugovil.com> wrote:
> On Sat, 18 Apr 2026 07:12:57 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > Follow example of rsci driver to avoid code duplication and useless max_freq search when port->uartclk
> > > is set to zero.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > > Cc: biju.das.jz@bp.renesas.com
> > >
> > > Biju: if you want, feel free to pickup this patch when you resubmit your serie for "sh-sci/rsci: Fix
> > > divide by zero and clean up baud rate logic".
> > > ---
> > >  drivers/tty/serial/sh-sci.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c index
> > > 6c819b6b24258..dcee8b69adab2 100644
> > > --- a/drivers/tty/serial/sh-sci.c
> > > +++ b/drivers/tty/serial/sh-sci.c
> > > @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > >      * setup the baud rate generator hardware for us already.
> > >      */
> > >     if (!port->uartclk) {
> > > -           baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> > > -           goto done;
> > > +           max_freq = 115200;
> >
> > I have thought about this change. but the below comment made me not to do this change.
> >
> > <snippet from Geert>
> > IIRC, baud == 0 can (only?) happen when using earlyprintk on a non-DT
> > system, where the serial console should just keep on using the settings
> > programmed by the firmware.  So any config register writes should
> > be skipped.
> > </snippet>
>
> I think Geert comments referred to the clock (port->uartclk) being zero,
> not the baud (the baud rate cannot be zero)...

I did mean the baud variable being zero.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
