Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721703DCD9A
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584248; cv=none; b=o1E0rcPBjWmXZhFMkWomXO96NK7cSLvtD0YV6wL3/P02jeIGOKvZyKai9aRp1Uqb3/kP6dwSqtTr6bw9H2VpAOMi/juXPBMrcSNhpBPlUx55V/Cl+4pflqE1NsC0LOVG74c4V2GztFgflCl2+3/GmNMvhkTEHZmX8SEeRtT4/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584248; c=relaxed/simple;
	bh=ihYWtNaN94O+bAheFYZwm+XaJhDB+RCMGsVPS51Ctao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIDxHGVdo7TkMss4CbzKB7R2lMixcRElujk/GJ+2nggch5sjULcJrNsNp1lrunSh9t53lMu/OuUWPXoUaiRPbiUArp480dEg6yy01sdlIdTxsD4lOiSNuzGXdjsM3EvIujF1d+1yhnscFURv6tu8Ao6cmpW9yJWs1dUFXmxVVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-738a5cc517eso1046860137.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584245; x=1784189045;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yNJ0CPi6whzhd05Ug8Zp7I8ZdqXAVuZLf2mnR6sqHTI=;
        b=JKX/E9ye0rtkR6UJ9R9f0RpoB88MjSKVhpOgyeNWMbC/0AM4u3tlX6SadectMZn2Az
         xUoLGQgC9SoQuEo1v+uIbsA7zcSUu9XamKGVrPU2ZSsG3Dr/6vcvWiZ3aFxLKsjgsOho
         Mf/OJH1QdaFAaxIT7kFHcR9v3D8rz75FH6PRglRvHJkapJJtE4SkNFtQGlr+DO0V31t3
         OG3HZkMrr0ZdW5+edPlQm8/HJPY505C2snx5o1RCL0qIAflZe9srWHGJsiatBLPt16nU
         d9XPM2q1EyZJEQlQiUkwdEPso/OGO6+ShCxtlPotTq4NhAu3aD5p5eIo53o3mxwTNJH1
         /U+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7zr0iFckHiYDW898hTya5xcVHiVBEC3Bagi6PtUoqminyUGdPZWAv0jgDX2K96jMCsfd2H6qddSDV9lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Q9lO6XDvHarY3vBip9H/upRSS1llu4apKPcfqkcc4waXzBTz
	lQA4OxolxXf8+SdePFIU/kGRAqzaV6B8+AuQ+C6zdZpdub1P2pakalBvBBhqtXe8gQs=
X-Gm-Gg: AfdE7cmffpjORAlyk7gnzj5/LCR7vjIZh1YHfDezhwXL1xUync87MAatPmN2Gg6uU/V
	N7C10abWpWorGE/l6bp0Awh8DJH9FPgDav8l+zYjI030/tG5sJiWUwm6sEpm3cPnGQ3xcv+b51+
	JWaOat7ua+miGFLt2kFPuadmoOcMhjF20Wkc/pdHBOkpaQYRcnonO/GyW/KE5iAPUEXhxvT9++C
	KGLwtXZ7EgLCWCD2rPGnmyqi4dsfpPSmS9SP/zcs+QjEDOnXlb1sjwiMWPa8LQD6LF+eXv2v+Dm
	rzZLstSiROPlKjwr3emndUd11Zhz9vdZZXB6pzzphv78ytGzOpGAEQdvTIX9epQnuLVbl69/wlS
	NOqHYJWAmkbjKqLwAX8Fanm6Mp+rgZL965jupH5E4gs+2TkO2OaJXVYshz86Ud2fdwSRw0ciByd
	Pxz5Mp8x9yRAsNpKIVrAFFKY7CCWCjEbf1xLHb9r0SqcDwJEqYJQ==
X-Received: by 2002:a05:6102:3e93:b0:737:d2e8:d64b with SMTP id ada2fe7eead31-744e03ca766mr3975926137.20.1783584245318;
        Thu, 09 Jul 2026 01:04:05 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed663ded3sm2774546241.12.2026.07.09.01.04.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:04:04 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9691ba8bc8aso797928241.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrj0HjojJXW4Bhdxwz0WVDr8j27s0/XEEcgO2jtA22TxQEHjCcRJaoCClPptdEeAmZIiepkLJ0mxo6HZ4E=@vger.kernel.org
X-Received: by 2002:a05:6102:c47:b0:737:bfe6:3b02 with SMTP id
 ada2fe7eead31-744e0369abemr3827978137.18.1783584244666; Thu, 09 Jul 2026
 01:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org> <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
In-Reply-To: <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:03:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>
X-Gm-Features: AUfX_mz0QeF12JvS07xaiPbV1Hu_Z54v9ARU9pRFij_0pmo3eygFx3vrDpgxzV8
Message-ID: <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tty: amiserial: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

On Sun, 31 May 2026 at 09:04, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> rs_startup() allocates a transmit ring buffer that is used to buffer reads
> and writes from/to serial data register.
>
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for your patch, which is now commit d26ed502d0c7c05c ("tty:
amiserial: replace get_zeroed_page() with kzalloc()") in tty/tty-next

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -443,23 +443,23 @@ static int rs_startup(struct tty_struct *tty, struct serial_state *info)
>         struct tty_port *port = &info->tport;
>         unsigned long flags;
>         int     retval=0;
> -       unsigned long page;
> +       void *buffer;

"char *", to match the type of info->xmit.buf?

>
> -       page = get_zeroed_page(GFP_KERNEL);
> -       if (!page)
> +       buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +       if (!buffer)
>                 return -ENOMEM;
>
>         local_irq_save(flags);
>
>         if (tty_port_initialized(port)) {
> -               free_page(page);
> +               kfree(buffer);
>                 goto errout;
>         }
>
>         if (info->xmit.buf)
> -               free_page(page);
> +               kfree(buffer);
>         else
> -               info->xmit.buf = (unsigned char *) page;
> +               info->xmit.buf = buffer;
>
>  #ifdef SERIAL_DEBUG_OPEN
>         printk("starting up ttys%d ...", info->line);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
