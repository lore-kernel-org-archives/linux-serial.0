Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247A4399DB
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065611; cv=pass; b=QVwiI1V1FzG8dlTfOGnsGiqnSa1ARUQ7xbOYIi5LldspLJKPY1iPwRZF7zwJSDcYICPflORVpb4fc6KEgbprYkjD3RdEFtwRN5Ge5Oxctt7Bi4e8Q0ejLsZCqOsgFqiZpqoAyTVGal0I2PU34J0L1Y/FmJf24DFhFiheRPQxNgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065611; c=relaxed/simple;
	bh=SlMBK/x//7EkfXKjWd7M2czKBM057+nv1Ol0HgmEr7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd+iCfzeWtK9JjEdmeCJzOwgFXndblNpEbD5wIp91A/TYyBnAHEHKozkRkA9X2h5twsB3caA5c3iGN6dMDhudMm3mS0ADZhfAq+0gx6J1jmbQUfUS3nqFerULFgxPL0IaTsdlN6CKAw+IcLYK0UHiRnEvpsftiEg4vzKBozhaVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB++cd8w; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB++cd8w"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66fb93aee5eso3847858d50.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790065609; cv=none;
        d=google.com; s=arc-20260327;
        b=a5+1rtwqn+DsVvpYc9GAydbctGlK8cAr08Pc5U04DHhMk5RKe3tuTqVHh1gRoXsHaI
         fQoY8d+i4fgzXOuKidELYqa34nA9B+7WxMopY9X1/5RA0IsDRvKth98A2Ugk37sETujI
         ZWTUMMXAty2fEOBSJkUImztjsL1KH5geNAf1hPPBlehOSLf8DrA1zFuVFQh07pWpqQwt
         WjTVfuFov72qpdxk7rZT/bf32T5yyWWwQdrYDec+IrcjBaw4Z9r62uobPjLY4kYXbb7o
         b5tRwHV+oJLizVQr0K7PDBo/AO7Go8Wn1ihL4v3UtR2B4MkdcCFOkJkWoYaKilFX7O1k
         g22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PdirXgXopR+EmzkmKT1oO37cjAZTsZxri/hGCJCiazk=;
        fh=u6bqWXtR4NsXRJCOqWoyPF2Z+aIsivGecZpr3ogINcw=;
        b=PTqd3CVu4DRMblSjghSZ/XSHBN/hSc0CR4oco2DyvJ4dbtzWt+ZwFA5/IXNP+jrKKP
         N63jJZRUVpEZClJy06d4G9O5dK/Mto6zd6P4SE2qN2Bd01YPzTz7ClxF4HIiOBRZhy9R
         NMrJSvvJFOzyQTXdGt3lsaAGg6BeJgNYeNsmxZ/2AhZbBERfyrYy++wlNStqqiljLPUW
         3+lTAXaKRH7i4SZvyhhVImCzUb1Uc5M1/Uc4IqZa9bxOz8/nfjqp3jrLw7h+YzBsAvhQ
         6EBxNGEiLiW2Ic8U8vVy4PWhmHFn201eGUUM9dDtk+YjLVMtFgP7xW6ZXoqLXuw6rrr0
         3J4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065609; x=1790670409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PdirXgXopR+EmzkmKT1oO37cjAZTsZxri/hGCJCiazk=;
        b=DB++cd8wlPd4/px4t8hAVOGbk3w7Zg0RB5w7O+vlPYBB1OlZtyVZE3o/FHnFfqKKOF
         z6FMShOVj65KllyIdxiBsI7FRMXCuXkWrbchcsqyySLNVzAzzF7pgpWOJkNU6/1Du9ea
         /gKPwNDMJopnBbbRdmYsNgOCTpUkNLTm7EKo7sEpls4iny5z+oBFpt27KX7LrlqqKdTb
         tHxFQ9PvvkjSk+ZoY2obc9WGGR+FY5b71JSI/35Eu+fnpLlaaqPP1Hk2uLMrXmTMe2C1
         momQ79ftAh4hDyhSpmp08g/1peEqJPXwrPs9rho/nJk/NINGm5RWpMyDu43p21EDunVa
         aevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065609; x=1790670409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdirXgXopR+EmzkmKT1oO37cjAZTsZxri/hGCJCiazk=;
        b=hwdAxT/1uCAmLUlKju2R+ahFbVOd/4i+vsiy8soQ0y7TYgnUzihJBa/MT4EAs9M1/N
         QqVq3S6adEvg66g/BPD5Ma3Q1apz1J3MO4NN9x9xuSeqLPJREfuZrCUa8fEgBz7G+Wsj
         zKPWl8Hfv7fxuIq7Oa8d5axlv5XuzJzQUsi7LxQOfzSiWhM8UaJ7ygdTxn7BvFO8QKLR
         619dYO6jUgRJeL87NOkxi5WWDbPhgALvj7BwxWRab9qdULNbv4Ud/iETenQ/7MURT75I
         UZIKxFgf+gYkkX+3/ZpsQ7v4AKf7FRKX/TNI0UhExLhAcmY97QuWcZ20juRYC2iWF+F9
         SdoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYRVinChHEWWcbQBlbu7DMd57Eq8P2deYi6wHeEbPFSckN6JV7RQzeWNKRrYL8Wukyyroh44YI+9MbBkU=@vger.kernel.org
X-Gm-Message-State: AFuF++kE/UrMFjNb6B2Bwm118CTjbnLZCdNOtC8WDSgcIsnWcGBWGtk9
	Z5VhbAxpsvJpN/oPbekausCZeJ/jljaPv7DntTDGDmQiC/eRIlorOh6ynKfkZRN0JSg/A841fRA
	Q0KlO0tPkZ6nPJft399w5wQ88q7wetuk=
X-Gm-Gg: AYBFou0IkyilWt/4C13Wa7ajh/f8Idt7thhC8cm8Rh/uIPi6al5qig49CclWZ+9dW4c
	lK0oHTwsz6ZFJTKu/eFePrErun5G8Z4vaXg1Hvwvm6CkHQ5fDB3O8lS7W8UXKoFydYs3iHY+hVK
	Ny5Nppi4oBtr4B336sZwADRNCsacXeWgEdY5AKMDxC+9yrmOteA3WjJy+0WMyDzn+uXOETcF582
	b1Mr9v9+/mdLbF0NX2l8o0GAfwsupJcJMnMw1Z3hRqNNavPwe7kKG2T0W2VC+R0A6de5WhqZnO6
	0jkkrwGNueaIraXHBtVygJtjM9Oi61sVJWnZQhwAMFWtc/XN4C9HCw==
X-Received: by 2002:a05:690e:144e:b0:672:b10e:c5e8 with SMTP id
 956f58d0204a3-672b11e0a0dmr2026530d50.28.1790065608896; Tue, 22 Sep 2026
 01:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922053151.11260-1-ginger.jzllee@gmail.com> <GV2PR05MB11941F04066D5CA3571C7919A83832@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB11941F04066D5CA3571C7919A83832@GV2PR05MB11941.eurprd05.prod.outlook.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Tue, 22 Sep 2026 16:26:37 +0800
X-Gm-Features: AcwNN1XpiJeYMhWmTQMLoNXwKiAu4mLHl-KsqnNx2WXQXtnFT1aXwtVv6P9uaMM
Message-ID: <CAGp+u1Y+Xy0jguEaBQ96keiKQbJv2jpn_OM0fAefCLZWAd-yHA@mail.gmail.com>
Subject: Re: [PATCH] serial: max3100: Fix a data race on s->rts in max3100_work()
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Maarten Brock,

Sorry that my previous reply did not use plain text, so I am sending
this email again.

Thanks for your reply. Then, in that case, how about just directly
wrapping the reads of
s->rts with s->conf_lock in max3100_work()?

Sincerely,
Ginger

On Tue, Sep 22, 2026 at 4:17=E2=80=AFPM Maarten Brock <Maarten.Brock@sttls.=
nl> wrote:
>
> Hello Ginger Li,
>
> > -----Original Message-----
> > From: Ginger Li <ginger.jzllee@gmail.com>
> > Sent: Tuesday 22 September 2026 7:32
> > To: jirislaby@kernel.org; gregkh@linuxfoundation.org
> > Cc: linux-serial@vger.kernel.org
> > Subject: [PATCH] serial: max3100: Fix a data race on s->rts in max3100_=
work()
> >
> > max3100_work() reads s->rts when it processes a pending RTS update and =
when
> > it transmits a character, both times without holding s->conf_lock.
> > max3100_set_mctrl() updates s->rts under that lock when the requested R=
TS
> > state changes, so the two accesses race and the work handler can progra=
m the
> > old RTS state in the hardware.
> >
> > Take the value of s->rts in the s->conf_lock protected snapshot at the =
top of
> > the loop, like the other configuration fields.
> >
> > Fixes: 7831d56b0a35 ("tty: MAX3100")
> > Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
> > ---
> >  drivers/tty/serial/max3100.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.=
c
> > --- a/drivers/tty/serial/max3100.c
> > +++ b/drivers/tty/serial/max3100.c
> > @@ -236,6 +236,7 @@ static void max3100_work(struct work_struct *w)
> >       struct tty_port *tport =3D &s->port.state->port;
> >       unsigned char ch;
> >       int conf, cconf, cloopback, crts;
> > +     bool rts;
> >       int rxchars;
> >       u16 tx, rx;
> >
> > @@ -251,6 +252,7 @@ static void max3100_work(struct work_struct *w)
> >               s->loopback_commit =3D 0;
> >               crts =3D s->rts_commit;
> >               s->rts_commit =3D 0;
> > +             rts =3D s->rts;
> >               spin_unlock(&s->conf_lock);
>
> This is not going to help. Now s->rts is read _earlier_ under the lock an=
d then
> the lock is released. So s->rts now has even more chance to be modified a=
nd
> the old value to be programmed.
>
> >               if (cconf)
> >                       max3100_sr(s, MAX3100_WC | conf, &rx);
> > @@ -258,7 +260,7 @@ static void max3100_work(struct work_struct *w)
> >                       max3100_sr(s, 0x4001, &rx);
> >               if (crts) {
> >                       max3100_sr(s, MAX3100_WD | MAX3100_TE |
> > -                                (s->rts ? MAX3100_RTS : 0), &rx);
> > +                                (rts ? MAX3100_RTS : 0), &rx);
> >                       rxchars +=3D max3100_handlerx(s, rx);
> >               }
> >
> > @@ -277,7 +279,7 @@ static void max3100_work(struct work_struct *w)
> >                       }
> >                       if (tx !=3D 0xffff) {
> >                               max3100_calc_parity(s, &tx);
> > -                             tx |=3D MAX3100_WD | (s->rts ? MAX3100_RT=
S : 0);
> > +                             tx |=3D MAX3100_WD | (rts ? MAX3100_RTS :=
 0);
> >                               max3100_sr(s, tx, &rx);
> >                               rxchars +=3D max3100_handlerx(s, rx);
> >                       }
> > --
> > 2.43.0
> >
>
> Kind regards,
> Maarten
>
