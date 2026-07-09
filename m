Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC13E8335
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584390; cv=none; b=jCkEep+QZvGQMccJkVLnWThaepbGdlYo6AlExD61m7Y25Zvx+0SXhebyI15D2Bwk1KiszzhMRRVpFft+EcAlZum6XQug1E2tWBH6Z28IG4b7otLThYKBSG7zkVB0Um1OBasAXnE08vrXcaIDS6HSZqUbrPgsptxgQGVPy28+atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584390; c=relaxed/simple;
	bh=yDQEf9BtKxTDJbgc0mIhD/wVkQm9WSw8XFFIUvlhauc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPak1sjpjiaj4LWBSCK3s8G8Zmkfny/1tbC458fEfvxiFpvdXkVqTc1Yr08tEqG/2z3OuKJWBHieeHsc98SHfXPttch0xv60tyXJhGl/8+v1lzn6pXuSA9cG0Z5vxKX0GAy24ObCbkQwrfWAJxj7E2tqCrPjdag9VCzClFieXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bdad7c16a6so868509e0c.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584388; x=1784189188;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7YkvlVZCIdLN8XjZvxxlYwK/+A+2hPQX0zLp+4m2M0g=;
        b=maCfUsvYRcYRKGnO/4WXhl7oAFTnpypiYdzh4eO4u9yINmkVAngOw+UHMU6DsDZ6JI
         S61z2zPdN9s9YQBIWxk8VxPdBdw8znAE5CQ3hQrNj/Zznss5ubgNQuJH1iv0GsztyO1r
         fK4iyrwtrWC/Qq6Si9JJlKje8wghpeFw6BuposaxvU7vjWhh4kkknJedYLY0IrJwxWP6
         raRhgvzYjczPGBJdUFOUBlQ94mK4uPabHBj/7ClWvboTdi9RDONyJYGryVLUj0qszCmg
         4QC+dDNahb9UHI0sYOmoMPmic/SrtrsKEch1WT3FkUDPeZTLP9rJtq3OhjBMk4AxvSA+
         s5ZA==
X-Forwarded-Encrypted: i=1; AHgh+RpoQGpeiLNFMxSQ/kqhPUzaG+3ic5KoTs/dJQsqyGdQ+hT7iP+64CGYTFWeM+WDaz58pidMVMImuiF7qJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KBtIN12MOGioJyyaGYlxTpj25v/3kTsXedjyX3DSnAB+IO5L
	D4Xn8VlFs+YWi9ZZf95ls7/RRanoY8t60Lq0X81jH9N2OYFbmK5dYHG1whK3me1+PKA=
X-Gm-Gg: AfdE7ckSc5iGKVV9cwGzSRK1VpFn11mXucjEVX3pqjUPtHShxi/g2EngGcygNYxc+Is
	m1KxMDwwscgL1W9ohMW+WUtM55CSHqsWp9wLmdW/GrccchnEEP6sEWod4845gAAHvPZFtLuVE0M
	lOTyrTMtiEr+0Rszk1a8SOxZQ2nxGZ4qrVwVCufnx+Ci9kJyMuNt48N/BhNYrOjdDDyHqLOjN51
	u+KI1gNFlQDF4H555Pg7+QyQavOAUITmc1gYEzrU8tSC4LmopAFn51H1h5oH78q+sJad3/fppLv
	awouduL8rRKRi9GnMC3e9Mr6mgKydJGEL6WsQJ2JlQEKLIDlFehttmOFEtOe8hhHItbNDQzvaBt
	yUcW6NbWJjJwyvSTfWzHVzn5LCpdRyQl6bzO3S8EAIE5il2SlWPjy7W5yFsylUQgw8+w+eKzv+h
	nl3ZfC6okn/oLyzsiAdK3UWuqXbQebKz02XjHI89ikjUyJfgNa0w==
X-Received: by 2002:a05:6122:a0d:b0:5a5:4166:67c5 with SMTP id 71dfb90a1353d-5bf75d2eb54mr3582694e0c.3.1783584388085;
        Thu, 09 Jul 2026 01:06:28 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f66c4a5sm3071125e0c.5.2026.07.09.01.06.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:06:27 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-96387efc30aso772399241.3
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 01:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqEolR5NFDtI45cuVFIiqN/UaG9UpEXh2z3e0Ag/JrutenJS1h/NFx5vq9m/aMrmdAkI/+XQqzK8KR6U2A=@vger.kernel.org
X-Received: by 2002:a05:6102:c47:b0:737:bfe6:3b02 with SMTP id
 ada2fe7eead31-744e0369abemr3833351137.18.1783584387167; Thu, 09 Jul 2026
 01:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org> <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
 <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com> <CAMuHMdXbT_hPnf1msm4exUoEMxRPvU5gmQbzi74b9rk0EopRqg@mail.gmail.com>
In-Reply-To: <CAMuHMdXbT_hPnf1msm4exUoEMxRPvU5gmQbzi74b9rk0EopRqg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:06:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXF-DcLjbJjwmZo+pbLQeO9gs+2-+pCnw_DNvS=tZ=4iQ@mail.gmail.com>
X-Gm-Features: AUfX_mxhmsnKVXeQFzsMIkLR_dcANzAHBWL7Y9bbVqeFbQAcvhyyWgbcWozADO8
Message-ID: <CAMuHMdXF-DcLjbJjwmZo+pbLQeO9gs+2-+pCnw_DNvS=tZ=4iQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tty: amiserial: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 10:05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 9 Jul 2026 at 10:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 31 May 2026 at 09:04, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> > > rs_startup() allocates a transmit ring buffer that is used to buffer reads
> > > and writes from/to serial data register.
> > >
> > > This buffer can be allocated with kmalloc() as there's nothing special
> > > about it to go directly to the page allocator.
> > >
> > > kmalloc() provides a better API that does not require ugly casts and
> > > kfree() does not need to know the size of the freed object.
> > >
> > > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > > kfree().
> > >
> > > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >
> > Thanks for your patch, which is now commit d26ed502d0c7c05c ("tty:
> > amiserial: replace get_zeroed_page() with kzalloc()") in tty/tty-next
>
> Sorry, I replied to the work version: the applied patch is not this
> v2, or the even newer v3, but v1?

s/work/wrong/, where is my morning coffee?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
