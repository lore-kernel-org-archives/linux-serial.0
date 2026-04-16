Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C93B47F9
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340808; cv=none; b=bO4pcQnGXuuv+6VxliqsLA+U7Wu8WC9VVVzsGz3p74/v2y/5Rn05iy5stFatqeKWjylslczks1ps2+CEK5WKLjocasgvwALyIrFX5CuplYcAt3cSDz21u3KkA1wI1qDhxPf7NFstCEJPGC5aU2BxD6yHJL+6Magj3v43xcQe0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340808; c=relaxed/simple;
	bh=KmYdZxcdwgYmEk917iXqSBkndf7zVbCrBpuHdVwqfbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq9QcT2q/QFuwMoWIiicMMaT2Dpqt7fTvKsUu3BaT3RXdvUH5I0C5n58zEg8n6lZpd+2QwtZObNypLbDWYi4/tGxA7b4eRw3rjjuW2yQb0LBKvNkjo3BBm7Ym6/C8GwOoLKWmQwx6+QVaXHWFWjMNs0MBI62FEahOxJ/sV7o+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5673804da95so3204138e0c.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 05:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340806; x=1776945606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF47gy5v8W39QMxMPFAcvgyR6D05W/M2D8Oqivy/q84=;
        b=sS1AXZUwNbYJ/S8SY2bG8ehK+/IhUV19sfNlqDRmFJZaKr5UsPzHNE2Ku9ITf5aEJW
         CayitBar9HpSLMt/BAFz+tAtm5nyICQJQ0FnEHAl9gtnx8wC11MQXtRm+40n00OwgVLc
         vgLsNiVuJQ0I8W2K1yWZNENETJ/NXZQMhFXs/8cJXCI11dFj2V8ex3znp7Wzoe4VHsRA
         p83RaSAdIFtpy93C3YeDQXXmX2sKc0XfZ+8gYRfYPLGhMEPdepbnaYI+z2xUZLt4o8GK
         p5V46ZQlPZwKgi4a+6axbnSQYZb67Hi20fYLK2/5g1aGr6UrX6x2+xGixlcvtFy/lvU8
         kPPw==
X-Forwarded-Encrypted: i=1; AFNElJ80ZDUuR70VEaTwXn9fFVD2GiXPovKOsWCgvR0F7R98AAulB4OLzgVYhaU7OKR3cg71lKiV3mSyuA2v5Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSphJ5UuHrbbeQa+1hjeGnKRzZGQY1fvu/HKY3/jN7FeMd58MZ
	E7kGRpZTy3k0bVbbV+DzEfmxnQm+XhqBHwYSgT1m+fR3zWlNLuAAw3lvdTuHm5FZ
X-Gm-Gg: AeBDieu0bB94fKmBm2FVnMcyQXgZwgrQ1430OEdEEzJKsQTIU9mr0ke44JL3BLycGH+
	9I7OB/1XPGsTs5H8ybykNUyYaOUhvcZfV7AnErgDG6EF6KbHL7v9VlE0vGshDrjojs1vh45wIMA
	tMEFFbWiVhdVlH3sWvwOCk9n9p9rpIrfyvD5F7EMWPegOsaNYuF438+3TfZA4NQrqdWjJ/qtibS
	KqamX5HqRhBKoYFIjWSOH5xz7mWSkiT1EC0Lm1JaTa0f1WjO0gILKRYTK3SeoA88xyCToDqEfco
	z3+DLP4TBj2Jx2aLgMv8avXuoNZPNGuTU+N0/6s/n0Ti3Xy4hbLy0UXJUfA6fRvArvkuU5AU0uf
	Pztqd317TpL+wWTlTPgYYUnbwBd/OWCmRicJvKNZ+bM67UnxY1tSlb/22oBe7Xx1ieKdlZAs7UH
	Kr/wMV3/AHJQWWNz6Iw3kOecl4ZeG11yI9ArhigqLeybm5s6lPwaNQjhx0CTxeNcVXAggKnnU=
X-Received: by 2002:a05:6102:6e8a:b0:5ff:e769:44bb with SMTP id ada2fe7eead31-60a013658bemr8017182137.30.1776340806215;
        Thu, 16 Apr 2026 05:00:06 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95864f494dasm2261202241.0.2026.04.16.05.00.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 05:00:05 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso2113270241.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 05:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+R1UqnrXuPsne7v/li0DXlWXRbQ31SiUrcDIV37g0Iv0pOuVyI+0NZx04bTnrzPthviNxoqbqyANytG7o=@vger.kernel.org
X-Received: by 2002:a05:6102:3050:b0:604:e063:4fa8 with SMTP id
 ada2fe7eead31-60a00e430fbmr9729727137.26.1776340803703; Thu, 16 Apr 2026
 05:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040807.40546-1-zenghongling@kylinos.cn>
In-Reply-To: <20260413040807.40546-1-zenghongling@kylinos.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:59:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOua7nRqf0g9BGhesQ7VHUZnJD-f9nynJTjfpW=DsQtg@mail.gmail.com>
X-Gm-Features: AQROBzAkC2utjgevhSJzIOhx8DL8v-pNoiK8_7MJPyLo25tg1-YeHkhpKXIrd-Y
Message-ID: <CAMuHMdUOua7nRqf0g9BGhesQ7VHUZnJD-f9nynJTjfpW=DsQtg@mail.gmail.com>
Subject: Re: [PATCH v1] serial: sh-sci: fix memory region release in error path
To: zenghongling <zenghongling@kylinos.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, zhongling0719@126.com, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Zeng,

On Mon, 13 Apr 2026 at 06:08, zenghongling <zenghongling@kylinos.cn> wrote:
> From: Hongling Zeng <zenghongling@kylinos.cn>
>
> The sci_request_port() function uses request_mem_region() to reserve
> I/O memory, but in the error path when sci_remap_port() fails, it
> incorrectly calls release_resource() instead of release_mem_region().
>
> This mismatch can cause resource accounting issues. Fix it by using
> the correct release function, consistent with sci_release_port().

Thanks for your patch!

> Fixes: 2667bd6673eb ("serial: 8250_port: simplify serial8250_request_std_resource()")

That commit does not touch the sh-sci driver.  Shouldn't that be
Fixes: e2651647080930a1 ("serial: sh-sci: Handle port memory region
reservations.")
instead?

"git log --follow" does a really bad job here, and doesn't even see the
offending commit, due to the actual change happening in parallel with
the move from drivers/serial to drivers/tty/serial.  Fortunately the
"git blame"-style output in the linked report below does show the
correct commit.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202604032356.SzEjYkBC-lkp@intel.com/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3024,7 +3024,7 @@ int sci_request_port(struct uart_port *port)
>
>         ret = sci_remap_port(port);
>         if (unlikely(ret != 0)) {
> -               release_resource(res);
> +               release_mem_region(port->mapbase, sport->reg_size);
>                 return ret;
>         }
>

My first thought was "Isn't release_resource() just a shorthand in
case you already have a pointer to the resource?", but that indeed
seems to leak the resource, as it doesn't call free_resource()
(see __release_region()).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Still, I'd like to see a second review opinion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
