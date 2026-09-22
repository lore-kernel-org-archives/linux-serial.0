Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339203B7B7F
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096712; cv=pass; b=rabhhAKQn5ULSFIafF4wpEJZOyVGRGPd8nN/7o4l5jlQY8IlznKo+9ry/ljNWLX47VYPnvCRlvyXi6xqnHL0FI6aQmS1Jyh6a4Hmhthb0rpPsu7Dysw/LUcv1YZMAIP2uxNFglVkZ07B6YxdTLP2oRR7U77vGEtvQa/gzgHvhoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096712; c=relaxed/simple;
	bh=uCfoPjxjR/C7Aeh1yFqxZ6iJnnztXpFLI2jgnLQ9B+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuYkcGn8X4SxncgdtdL+w5uKeeqHvJFZvUG9xeSWcYYewPOKz49xCjKldWe5mO1hRgtWvqS2h31BCwFpfHVbZhYojXMrwL+Av/0rUa1CORWaZIWLBYy+K7tQqMwdgFzIwx+GmRCwdnwXUZ0czTkIl40KY1zBm1be6F3nQqHTTsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUUN3+ID; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUUN3+ID"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8e6bbso21496d50.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 10:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096710; cv=none;
        d=google.com; s=arc-20260327;
        b=ggU4w2QQ5/GTeVPpG3VlB8R1tEjQhrbpSyb9mPFDRHN0py+NCrSXrGiybMW0FG+/gX
         oQLIOJP7OxogwOhhCb/ne+O5P9X2+IeuksoZGEdpODZTVcV7c+Z3dFFee0w8GNdXpHiT
         nng9Mn6RcWdZgGd3glh6day/iHxH/+x/koc8LpQQU+ORlJ9vu+oSCqE+JIDxZmgcnEgS
         JpEtxmzlGVjA09t794dJH4Mg0Q2+4YUHmNumH4cW6Pb64mKt986vxnhinVoRfL9WA3DZ
         BFE2dwJWku1FTuIsOLg9UzyP1NjdEf0h7LZnOPoMQYJSf/55WV/2OEFa80JYCZQxG6ye
         33dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VvrlYJcLbqRjM8ANpbxGVHIhQgNGULkDhjB7f7taUvI=;
        fh=G0SrrrrIh8YPID/lQ5rxHVtDk0rQg+iFs4lECNBUhRY=;
        b=KET9P6Widp5Pvp49JisQENSeLGIeaWnqmxzhxRbBJv4l+8movfoWhM0J0BIS8Sj0tU
         YmsnoucIjCjP6u6f7RKoHSybAQiXn9TDmve83iHJ1nBV1lsADLXiLZ/p+iedqm2glw6Z
         wMT6qbuVWvEdV/WYuGEhkqatRQNA46tJrSM4kaqUfs8JCVPh9up3OZt1fMVWCwKjNt5k
         0yNB7oaSM2RLWGfc0SqP89xEUUFZ32U8HeyYSuGgY+ldewvqOjoBEkMT4a3z4J/rycES
         WvemgnOS6LSGQ2Qdig5JvghmMIoHEdhxUYZqABiAtEFPbonnGIubDvvhIzsvNyACnEGd
         HfAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790096710; x=1790701510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VvrlYJcLbqRjM8ANpbxGVHIhQgNGULkDhjB7f7taUvI=;
        b=eUUN3+ID1tWKMNvxB7+ZGAXHafHs9phrNABIagf1ZzWGfcfw3MZWuSyQB+kRx9u3mP
         6VfOGWlIT40BFFJyEUlicmBWLkGAGFDIK3wJh1GATxVGGjnxR4DlVTFO7nROQANq5C0j
         9GNKwxh9rZTPv0r79n77cHbm2PnLieBf+R8MU7s6y/aYR80t1Qz5duI9Mm47ghLJXe4M
         mplDcJyPIheZwMZPKRwWPoiwMnzSrI8uSXADaHJ9iCf94N7yPNOP4k9kbcRjsX9i5UqP
         eMMRAvANcOmrUFddQ48zI0b8zfwNNhjrChLJvgh2vcf1Btwp6QeEYl+pgcsfafLjvegD
         hLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096710; x=1790701510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvrlYJcLbqRjM8ANpbxGVHIhQgNGULkDhjB7f7taUvI=;
        b=Zh0PsiZbog45IN3FZk/VKJZBWlETb/2PlkW91Nzf+NYD6J4qexBAuKMDl+OGBV2XIb
         VAsIVDIy0CmIRYFmQFgXHrrTfDCweKYyrBYoVYFGqbWgBtRnfQFfGc8yVQrz+okDRUOf
         k/JsssnsUcGcwXLeGlJM8o1mJVE1PFKFHM2qYhaB0ZVo405ybFhD8IQr7M5WjPQAnMhk
         /YjjNQ2fGxPhiRuDtSKjbk2y90TashFALJxtZ8QDojCVEGgpCRBbaf3WehhNhRcFr55T
         EELNefeti6xBTFQq/u94fH4lDS6gBAtRkZbaLsWMb1nGxvdPUkXPYs7Ww+5Y+l9Y5fca
         c09Q==
X-Forwarded-Encrypted: i=1; AKwUvBz2ds+G5+Vfb39jSgf2imxGA+ayOf5PkY4b9FUhgmgbACRg1RN81bhf06aA2Oo7/e/D7nn/zznm2rfgiD0=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ5BrxoaQ8MXBjFVLPcnAIqC4Q/iE9z775vFVAewKgVfPrMaq/
	v2ovK2isc9CHmZvltK1kiVnCgInLjJsTnKwrtKvezOHsQ/tEjB/3lxMv8z683RchsWjCKdew4Ii
	bW52Wxxf984cfOqZBrIJ37uz+AMP5uHA=
X-Gm-Gg: AYBFou2Z3fFv1hxddjZS1T/kiMJrA6sgiCB9PZTFlJ0Og6H9nWEdhkoYM9dootKKzYi
	HxLfb7BKqfERIZA+VDAzUgyryt7h/uffckcSQGf6IZRluJZD+Znq0ERchkp6+d23TyTz+sapB3m
	aXznIjwWQxEKdIsuNZ0coc729PV9fhQlg+JCojzLwMax2M+6f09eVeVSJAtK3fBwAI+bPzI6Klt
	ltHUGctN4tHVBpzfv0ZwRqfNpMqW6vr1Q/nODeXJpjy/qPA84AoWsErU22j5ORGTS0B/rlitrGp
	5L41+4cvlAbGgCcH/WBvtuRrEfcb3qirtbBTfvNfLkcfPQlluoo2y1KJe5iO6KOP
X-Received: by 2002:a05:690e:1550:20b0:671:5338:6703 with SMTP id
 956f58d0204a3-672d59cf574mr51442d50.34.1790096710157; Tue, 22 Sep 2026
 10:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
 <GV2PR05MB11941F04066D5CA3571C7919A83832@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <CAGp+u1Y+Xy0jguEaBQ96keiKQbJv2jpn_OM0fAefCLZWAd-yHA@mail.gmail.com> <GV2PR05MB119417F5BB121B71DC5E27E2883832@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB119417F5BB121B71DC5E27E2883832@GV2PR05MB11941.eurprd05.prod.outlook.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Wed, 23 Sep 2026 01:04:56 +0800
X-Gm-Features: AcwNN1XpSA7AaoWlgSLOfxT2x1xOjm5w2OiBhSnUfRvdcUScnQ0qgcgyq7fgTG0
Message-ID: <CAGp+u1Y7LmqSWXmA9NdZo2nU6kSjkOYqEGicprpE_BoyR=8VTw@mail.gmail.com>
Subject: Re: [PATCH] serial: max3100: Fix a data race on s->rts in max3100_work()
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Maarten,

Thanks for checking. I have created a new patch per your suggestions. Thank=
s.

Sincerely,
Junzhe

On Tue, Sep 22, 2026 at 5:25=E2=80=AFPM Maarten Brock <Maarten.Brock@sttls.=
nl> wrote:
>
> Hello Ginger,
>
> I had missed the meaning of s->rts_commit, but it is this flag that indic=
ates
> s->rts has changed. So your fix is correct after all, but the commit mess=
age
> can be improved by mentioning s->rts_commit.
>
> I suggest to read s->rts into rts before assigning crts under the spinloc=
k,
> just like conf is read before cconf is assigned.
>
> Side note: personally I would not have constructed this difficult
> s->rts_commit flag but combined s->rts and s->rts_commit into one byte,
> making an assignment atomic in itself without lock.
>
> Kind regards,
> Maarten
>
> > -----Original Message-----
> > From: Ginger <ginger.jzllee@gmail.com>
> > Sent: Tuesday 22 September 2026 10:27
> > To: Maarten Brock <Maarten.Brock@sttls.nl>
> > Cc: jirislaby@kernel.org; gregkh@linuxfoundation.org; linux-serial@vger=
.kernel.org
> > Subject: Re: [PATCH] serial: max3100: Fix a data race on s->rts in max3=
100_work()
> >
> > Hello Maarten Brock,
> >
> > Sorry that my previous reply did not use plain text, so I am sending
> > this email again.
> >
> > Thanks for your reply. Then, in that case, how about just directly
> > wrapping the reads of
> > s->rts with s->conf_lock in max3100_work()?
> >
> > Sincerely,
> > Ginger
> >
> > On Tue, Sep 22, 2026 at 4:17=E2=80=AFPM Maarten Brock <Maarten.Brock@st=
tls.nl> wrote:
> > >
> > > Hello Ginger Li,
> > >
> > > > -----Original Message-----
> > > > From: Ginger Li <ginger.jzllee@gmail.com>
> > > > Sent: Tuesday 22 September 2026 7:32
> > > > To: jirislaby@kernel.org; gregkh@linuxfoundation.org
> > > > Cc: linux-serial@vger.kernel.org
> > > > Subject: [PATCH] serial: max3100: Fix a data race on s->rts in max3=
100_work()
> > > >
> > > > max3100_work() reads s->rts when it processes a pending RTS update =
and when
> > > > it transmits a character, both times without holding s->conf_lock.
> > > > max3100_set_mctrl() updates s->rts under that lock when the request=
ed RTS
> > > > state changes, so the two accesses race and the work handler can pr=
ogram the
> > > > old RTS state in the hardware.
> > > >
> > > > Take the value of s->rts in the s->conf_lock protected snapshot at =
the top of
> > > > the loop, like the other configuration fields.
> > > >
> > > > Fixes: 7831d56b0a35 ("tty: MAX3100")
> > > > Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
> > > > ---
> > > >  drivers/tty/serial/max3100.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3=
100.c
> > > > --- a/drivers/tty/serial/max3100.c
> > > > +++ b/drivers/tty/serial/max3100.c
> > > > @@ -236,6 +236,7 @@ static void max3100_work(struct work_struct *w)
> > > >       struct tty_port *tport =3D &s->port.state->port;
> > > >       unsigned char ch;
> > > >       int conf, cconf, cloopback, crts;
> > > > +     bool rts;
> > > >       int rxchars;
> > > >       u16 tx, rx;
> > > >
> > > > @@ -251,6 +252,7 @@ static void max3100_work(struct work_struct *w)
> > > >               s->loopback_commit =3D 0;
> > > >               crts =3D s->rts_commit;
> > > >               s->rts_commit =3D 0;
> > > > +             rts =3D s->rts;
> > > >               spin_unlock(&s->conf_lock);
> > >
> > > This is not going to help. Now s->rts is read _earlier_ under the loc=
k and then
> > > the lock is released. So s->rts now has even more chance to be modifi=
ed and
> > > the old value to be programmed.
> > >
> > > >               if (cconf)
> > > >                       max3100_sr(s, MAX3100_WC | conf, &rx);
> > > > @@ -258,7 +260,7 @@ static void max3100_work(struct work_struct *w)
> > > >                       max3100_sr(s, 0x4001, &rx);
> > > >               if (crts) {
> > > >                       max3100_sr(s, MAX3100_WD | MAX3100_TE |
> > > > -                                (s->rts ? MAX3100_RTS : 0), &rx);
> > > > +                                (rts ? MAX3100_RTS : 0), &rx);
> > > >                       rxchars +=3D max3100_handlerx(s, rx);
> > > >               }
> > > >
> > > > @@ -277,7 +279,7 @@ static void max3100_work(struct work_struct *w)
> > > >                       }
> > > >                       if (tx !=3D 0xffff) {
> > > >                               max3100_calc_parity(s, &tx);
> > > > -                             tx |=3D MAX3100_WD | (s->rts ? MAX310=
0_RTS : 0);
> > > > +                             tx |=3D MAX3100_WD | (rts ? MAX3100_R=
TS : 0);
> > > >                               max3100_sr(s, tx, &rx);
> > > >                               rxchars +=3D max3100_handlerx(s, rx);
> > > >                       }
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Kind regards,
> > > Maarten
> > >
