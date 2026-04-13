Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93304A0C
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075889; cv=none; b=Q1l4ZvpRbxVfQbhlXVzcI9UbQ/GzDHzmWU9a4CMWPZVJ2AoZo5Q6SHaPjgYM2gAk9xUV8QCRTnz+RsTn6acNuz9NPsyAWtqhKFDYADWoifhAMHqwpoOXBWpECgNw1tOP6LwUV1Q2FdwgzrvwLboPmVh7wcIdu9QWleerRTqARvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075889; c=relaxed/simple;
	bh=Eor44UFAH5H4RemegiLZ43tjKUuq5dDu3O+Ni5StuYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ0LXJj0YvoNz3GS85Zh7g2jL5cJAy0+q08PQUvBft7s6UtcNepSGOReK68r1A1GLSMHtzpDQ5d2l8WKveFVJABPhZ6rRrw5NuZtIJ0G7OFankJgd2nlk19MnKTjz9Lp5Z22wkKpWi0DFzNrM535YNonuS1EZiiqEI0Zk8NQM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso342483241.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 03:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776075887; x=1776680687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4KUBtrImslyF5rFkM/EbkpM7rzbhtbeCUUEpWux9yA=;
        b=PJCjFVpGcOJVQvPDXz5Tjy6cUKqXXQhutygTmgWEjf+eAxYioZK0HJ6EtvcoBoEFim
         BFGyMF51GpzK5SDWox+fw2LAOp+FQ4SWS1WrhdJd6WSEbpg9hy5GfMJfBc17S/VtwGcz
         TqEbjSW9T2BtL9O5iScXehCUde/i6t1JkEm7ZWx1oCi9+fIn4N87NXDLQ9B0gmE2F3BK
         pfLdyoMnuOr2o9eCfiqRIvfoRNe2h+gaCzq4IVuBnZzCeMqRteqxBMZVGjMuyEnrNPUt
         iGlL2buOLIiLJwTB38JEuMplacC4MylHusVTqdv+NwK3LTrB68nYkR6T8M3gGNDxC1U0
         NWZw==
X-Forwarded-Encrypted: i=1; AFNElJ/4QrLLW6Zv02VCV3A0OkIi622nzVcNCioS2lzX78HeUmYDC16shFLyZpOjgGOZDZneo0ImPl3FhdF7oa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOI4ZMUN6lUpXlfD8Yp5m4yNDa73Fr3zczMdP4R6NLqVU9iFjX
	McBPl6JuY/K5eQA1N/ex06OU9nOW9SW+vx4v9dyiuH4sTqrgAIxBJGm6xFZsotfV
X-Gm-Gg: AeBDietVA+JGAg2NBHEgQHs0v1rgenyNNlO7U6HD34z35C3Y5g0U4fcot5Of/F1Z94k
	gyTQ+wSUSGYdPiD6BDYINBSbQaMQ7TBSF4sCc4wkVcxlYlkbaH+fyhfwxPWgc79fc5/GVFuvKPg
	Z0CNLuUspOpdXhAdvyt+fEX5ZxMg21NWueDzl2XuSgGwqGn9KLVR07ENvCj85V64j7P6NzEP94o
	27P+xUkx5BBuWhHltL4AdaYfb3qhFvZSm13JPMswO/MPDWMTY7pgA/i1Dnp6YPSNzcYvLbmA2h2
	oAMpaF1AlQrOfYwK4q2I2s94QIBVEf4NGsajiXwdoMHuWc+eVYHb1IMAjKwRHJu8F6Us1rkEkJZ
	h32uxhH5U0LyuGai3psFRxEBBkkU41plemD0GAeVAiNGWtrFwFKJxv8KnO2n3iNobuYb24aXPf9
	2Ydz84MwbNkZ6XB3G2Q+CI1FU6MlHYzDG27MpO6jIN8r6O4f0q3tnl46Nk0AnzEfXpAGcpoWE=
X-Received: by 2002:a05:6102:3e23:b0:609:af4a:371 with SMTP id ada2fe7eead31-60a00e44326mr4965278137.23.1776075886730;
        Mon, 13 Apr 2026 03:24:46 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9568c185a71sm1345652241.7.2026.04.13.03.24.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:24:46 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60fd9b71745so158046137.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 03:24:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9vHTMHdg6DUcsoLiHB+9nzLl6o6nyNSE4+ytUOr6VTU+Qp2HlFWpE7raPIEIxqZ0iArgPknOAHHn1pK2c=@vger.kernel.org
X-Received: by 2002:a05:6102:5708:b0:601:f386:9ed2 with SMTP id
 ada2fe7eead31-609fe89d49cmr4547894137.7.1776075886054; Mon, 13 Apr 2026
 03:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
 <20260408142105.310210-2-biju.das.jz@bp.renesas.com> <20260408123039.922a75327fd7672df3bd61da@hugovil.com>
 <TYCPR01MB11332B594964DDF0763499184865B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <20260408125142.24cd94f094ba3ca512e7f346@hugovil.com> <TYCPR01MB11332859E901171C91C543061865B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11332859E901171C91C543061865B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2026 12:24:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW770zLQt5NiUZffhg3ztXzvM8iT=byBzKJEU9Gm8OykQ@mail.gmail.com>
X-Gm-Features: AQROBzDBodXP0e_hAmML3Ltl4OzkR-OaOnhBTE3J5of60uPbdsEAiAqntLXmLgA
Message-ID: <CAMuHMdW770zLQt5NiUZffhg3ztXzvM8iT=byBzKJEU9Gm8OykQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: sh-sci: Avoid divide-by-zero fault
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	"wsa+renesas" <wsa+renesas@sang-engineering.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, 8 Apr 2026 at 19:25, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Hugo Villeneuve <hugo@hugovil.com>
> > On Wed, 8 Apr 2026 16:35:44 +0000
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > Biju <biju.das.au@gmail.com> wrote:
> > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > >
> > > > > uart_update_timeout() computes a timeout value by dividing by the
> > > > > baud rate. If baud is zero =E2=80=94 which can occur when the har=
dware
> > > > > returns an unsupported or invalid rate =E2=80=94 this results in =
a divide-by-zero fault.
> > > >
> > > > baud is returned by uart_get_baud_rate(), so this is not returned b=
y the hardware?
> > >
> > > You are tight, Will update commit description.
> >
> > How can uart_get_baud_rate() return a zero value? If I am not mistaken =
even for the B0 case, it will
> > return 9600?
>
> As per the comment and code, this API can return 0.
>
> * If the new baud rate is invalid, try the @old termios setting. If it's =
still
> * invalid, we try 9600 baud. If that is also invalid 0 is returned.
>
> In drives/tty currently only 1 driver is checking the return value
> and it calls panic
>
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/tty/serial/apbua=
rt.c#L214
>
>
> I believe we should call panic, if baud =3D0, instead of proceeding.
>
> Geert, any thoughts??

IIRC, baud =3D=3D 0 can (only?) happen when using earlyprintk on a non-DT
system, where the serial console should just keep on using the settings
programmed by the firmware.  So any config register writes should
be skipped.

On DT systems, even earlycon uses the bitrate from chosen/stdout-path.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
