Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC133E8335
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584359; cv=none; b=qcH84xckx4Or9aLFT8tKAssc+te4XZAMFDz7IwuoPSv2dB0Z1KhAK+4mRK207+Ya2+Y49SYZy2m/upRQbg5FcLswTGfENBede2PGerYk5JOhHJjTkS20POggjBU2Sa6vfnJyVY4UyXc0e+fWQn+xe2kayremY0NyqTdjmvVg1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584359; c=relaxed/simple;
	bh=BHqkKILPD7qBSPM6FM/XBcUeEBQUsOql5OfOulWhTNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSTGjHjXdBX8Jp5Ka3onYPFmMoLIKotUB9zfyJz1zSkI4OYIxrMXAH77qswyvpfsLfsJi7MkqLn/3+njhVKDj6er7ks8QeOiEO7yquY5jQqB3gg6ocw9EzG6h9d1rHn96ar1kad+Vh1jDy+FPsgFMu02Wo3vRmW+KYPDhdRiAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bf9466867cso62985e0c.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584356; x=1784189156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ygb6NgkOkKFoK+FjOqgp4ZXsd/Yj8LwJxppMpG1O8hM=;
        b=Dz7SbySK03MQAof6QIrVPWMV8pHJLY3LxWlOm5Qfz4wQypYmlj28EaCzvyH8e+AIjJ
         3FXvnNSfvAg8C9exxhsfX4u5zKKzCskjXhtNU71A/c6rvrw3OVUnJo0owmAYFh9GlXV3
         UL+FECI9Eg2GqTUIW4Sp1VQaFCuVF4Bp8vF8y6OgCEi6RY9gegTmmVA/hIVUwszAsBgR
         mcvFQuz3jKtn3nIxI7IGZcLrX+nai65j2lskvJXOvoDgfHDXRRie0N6j6puopGbEyznP
         0Vf/7cWJQYVK7bxSo8ZlUfsq0VzY47F13Wm1G4tNReYPb8juf7984qv88toqpVC8VUEy
         Yc1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrqLlsctuu55JoA89EY1e+Vn9BUHS8t5CIeB27JczOhxOhax6HI9YkJxWUJGxFLW4mWINzcfwkPSJnWPvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8y4yWl9S6cMnVtn5Y2Xq7p0ddiArw5tIHICHAfQj2Ke9Czwo1
	gu7nKiogkE2pc2PVnYLPIOOxQoR8SD4L8efs21rsr7jB51anbLutvFZGzFjXb0Gf19Q=
X-Gm-Gg: AfdE7ckkrGuOtgrGoe/vh1xBRwF7+mbQBAupDJAPjkJnvAPt8mQw5ZxlNzHUz6tQ4sT
	NUSGBrHokMFmKaR43fnYDk6wPu1NxE1UxwOJcZY2f0oIodb5La7vq67RO0GMh2RXyO4merc+vUh
	9TD8pVUyz57qLNgdsHiFGU5TkOZeLs2lUEJSzvfo6HtQoggXafVOcS9eVv+5l5/O6d7v7IHyOrj
	FAiSEM7CDPkkEg1rH4SIgO6SmNL6dRH3NvaOchxIosi+H0jartK/xuuDucrwipCzYHxgSDHGbQ0
	kN/DJdVQH44dNkUwt3aPCI2zuAV/bAtqPNOgu2g72dk5AetZ1bpi03HCYpjebQyHKg4eK5o4/sH
	r4R4877Rq820tZhtDX0BAI7VUz0ClUNShjYUTn61GcfkafrwoSRqmmAWOpavas9McoUzkr9YBVp
	H7l67XszFmCdAFPYmWgiDfPgdt2wOrgwRxOChoJTrmbxak3x9ERQ==
X-Received: by 2002:a05:6122:219f:b0:5bf:6b19:2762 with SMTP id 71dfb90a1353d-5bf75d6413bmr3068155e0c.7.1783584355731;
        Thu, 09 Jul 2026 01:05:55 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f8a4fc2sm3110633e0c.14.2026.07.09.01.05.55
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:05:55 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-73770fd1b65so436330137.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqFQU6QjZcnVZDoPUcjvFi2j0IWsps+NbW5XoTfbGcIdajVQr3u1C+rMNlHE58HDXgfoCjRYaJo9F/plpw=@vger.kernel.org
X-Received: by 2002:a05:6102:512c:b0:633:2389:3a82 with SMTP id
 ada2fe7eead31-744e030454cmr3833412137.28.1783584354697; Thu, 09 Jul 2026
 01:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org> <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
 <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:05:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbT_hPnf1msm4exUoEMxRPvU5gmQbzi74b9rk0EopRqg@mail.gmail.com>
X-Gm-Features: AUfX_myA12YrlCT3ttWesIwGD_4s0xHALOjnC8y6S8V61ejNj9VFzSCSvQ5Ey08
Message-ID: <CAMuHMdXbT_hPnf1msm4exUoEMxRPvU5gmQbzi74b9rk0EopRqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tty: amiserial: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 10:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, 31 May 2026 at 09:04, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> > rs_startup() allocates a transmit ring buffer that is used to buffer reads
> > and writes from/to serial data register.
> >
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> >
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> >
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> >
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> Thanks for your patch, which is now commit d26ed502d0c7c05c ("tty:
> amiserial: replace get_zeroed_page() with kzalloc()") in tty/tty-next

Sorry, I replied to the work version: the applied patch is not this
v2, or the even newer v3, but v1?

> > --- a/drivers/tty/amiserial.c
> > +++ b/drivers/tty/amiserial.c
> > @@ -443,23 +443,23 @@ static int rs_startup(struct tty_struct *tty, struct serial_state *info)
> >         struct tty_port *port = &info->tport;
> >         unsigned long flags;
> >         int     retval=0;
> > -       unsigned long page;
> > +       void *buffer;
>
> "char *", to match the type of info->xmit.buf?
>
> >
> > -       page = get_zeroed_page(GFP_KERNEL);
> > -       if (!page)
> > +       buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +       if (!buffer)
> >                 return -ENOMEM;
> >
> >         local_irq_save(flags);
> >
> >         if (tty_port_initialized(port)) {
> > -               free_page(page);
> > +               kfree(buffer);
> >                 goto errout;
> >         }
> >
> >         if (info->xmit.buf)
> > -               free_page(page);
> > +               kfree(buffer);
> >         else
> > -               info->xmit.buf = (unsigned char *) page;
> > +               info->xmit.buf = buffer;
> >
> >  #ifdef SERIAL_DEBUG_OPEN
> >         printk("starting up ttys%d ...", info->line);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
