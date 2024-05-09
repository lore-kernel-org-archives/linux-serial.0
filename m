Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343B1292DE
	for <linux-serial@vger.kernel.org>; Thu,  9 May 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292089; cv=none; b=X5dWeHUKYGBURKp9fBXOeTHkq6xwlT0jhld7uwPOl1BUnM6v36V/+SU/xGB9xteiad8Uqbrus0LSirROoC1/UPq6Cr4LOqlDNs0MZIBgvTM2SytjmaGV+g5bY87+N+X5yI88pph9sVmfvJiEXVBOwqHt99dy4IKzD0lZL1g2XPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292089; c=relaxed/simple;
	bh=eTFM0lR+pV19/1K9nIEi52f8o0e9EXmBU+po3xooddM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4jLVE8iebmLGVSSEXnT6mGYH96jRGGu1RHNt+TqBpd+bKN1gHE+yoIA4YVNU+knhFSTNmUcJ2i+ua7uLUNM9AHkIC27P/Hxfxtu+DARHZDc/tjxGi6CujWbHfoSTLSw6YSDkeuEA7M/ntlaD4KVP08memnATaQt7imuUVV54nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbODzUHS; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbODzUHS"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b283d2b1b4so67373eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 09 May 2024 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292087; x=1715896887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZVCnwpSsnSCs9fQXtvRvnFquz+a/pLR0kXJSXFyRYE=;
        b=XbODzUHSPCAZhBqt2SCVvCf2VPGhkSGFf6gmm8wKt+o8qaLjb9NSt4jLzgQeNuTtXZ
         8ZFtmeiPDNW+yj5NFZcI3lKGFJ415mhpt633jFbucX/CfxJnIShu8DlonsMefnwe8kr6
         PWb/fJyhMm9NSMjE4Ockm2DWyRVlchgwTSundHb7eG1qTEKTrZv5lI59fpvYw2vGoFv9
         HhyS++rud5bRn3Tq5oYNEz8IOeeKc3viailTQ8ONN9z737Kpx7p3O3ZxTQ2NI/bYNcac
         vp36tYTk6jHTdYGRlLzdjmWYEHnhdVwZWfHc2oDjhut6qSH591SLoILXDINjOlyjjdV3
         NKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292087; x=1715896887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZVCnwpSsnSCs9fQXtvRvnFquz+a/pLR0kXJSXFyRYE=;
        b=EZeWNDfDubyk3pqEVWYv9NhuX3+AzPA9rJuaNhUJVsR7BYZ2nuIkhapvKQVcislwiY
         xtWqJBAHwujQ0mVCTKptPWW8VgYU03qhM1sumtWm6hBpj0R6FJWUZNCdiAFk8Fw9bKO6
         MylJfmEZax6Do8/dCyWEu2zTw0HdWwumXvQWBH+TwH7811zIM5AnQ7bh43X0HoaTIsZx
         ubLyuJ2iBhmh8XS810Yev9aOk3c2iBx29E20sAZBSWMvJz5MiEMYey0E+gPwz31M5Wns
         pX/SqexfzxsDE5MhPt2qqfJCRhl2ho9bCeYH7wtpSgQjKdyV1/C90wTawKlgChbe6eVq
         S0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUmJtgEIX3WqAttSrP7gZcIurMqsw3eHQw7yIPqolY0h0cEeBpvrnOMM+lxyYgPMOBtgQ5XjcyK8IQ+Te6rsXLjjKyKDEyhbWphPVO/
X-Gm-Message-State: AOJu0Yz8UYTSgtZcd7jRls9owc8zDy0YLqRsmLcUn3W2z4Pa8HppCdGj
	hAB4c8jHC2bWAjUjGltNB/a8Pm96Xg1ak/I2kNZeHFlxzJpCGH9TpKVWrR4Gjim0PQ2CslFVsra
	7nIkBY5WpLp4e3mEWB9tJGGW+rbcP4pcXBu/E
X-Google-Smtp-Source: AGHT+IFpfKHeAJ/sLsyM3Lqv/tlwttE2S4Wv1c320CoQA2YSLvZHSj8nXYLIh/V4Chy5bfd4fN2VsBQBoGoTLlan748=
X-Received: by 2002:a05:6358:7e41:b0:17e:bfb8:dd86 with SMTP id
 e5c5f4694b2df-193bb401498mr92029755d.3.1715292087108; Thu, 09 May 2024
 15:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com> <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org>
In-Reply-To: <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:01:14 -0700
Message-ID: <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 11:31=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
>
> And what is actually broken, given signed overflow is well defined under
> the -fwrapv wings?
>

well-defined code can still be broken.

We want to better safeguard against accidental overflow as this is the
root cause of many bugs/vulnerabilities. So, in this spirit, we
recently enhanced the signed-integer-overflow sanitizer and its
ability to function with -fwrapv enabled [1]. On the Kernel side of
things, Kees' tree [2] has done a lot of the groundwork to get this
sanitizer enabled and less noisy.

WIth all that being said, my solution to this problem in this
particular instance is not the most elegant, as you rightly pointed
out.


> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 9b5b98dfc8b4..b4768336868e 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -308,7 +308,14 @@ static inline void scrolldelta(int lines)
> >       /* FIXME */
> >       /* scrolldelta needs some kind of consistency lock, but the BKL w=
as
> >          and still is not protecting versus the scheduled back end */
> > -     scrollback_delta +=3D lines;
> > +
> > +     /* saturate scrollback_delta so that it never wraps around */
> > +     if (lines > 0 && unlikely(INT_MAX - lines < scrollback_delta))
> > +             scrollback_delta =3D INT_MAX;
> > +     else if (lines < 0 && unlikely(INT_MIN - lines > scrollback_delta=
))
> > +             scrollback_delta =3D INT_MIN;
> > +     else
> > +             scrollback_delta +=3D lines;
>
> NACK, this is horrid.

Agreed.

Does an implementation like this look any better?

static inline void scrolldelta(int lines)
{
        ...
        /* saturate scrollback_delta so that it never wraps around */
        if (lines > 0)
                scrollback_delta =3D min(scrollback_delta, INT_MAX -
lines) + lines;
        else
                scrollback_delta =3D max(scrollback_delta, INT_MIN -
lines) + lines;
        schedule_console_callback();
}

Accounting for the possibility of both underflow and overflow is what
is making this code a bit bloated but if this new approach looks good
enough I can send a v2.

>
> Introduce a helper for this in overflow.h if we have none yet.

We have these but for unsigned (size_t) types. I'm open to adding
signed_saturating_add(addend1, addend2, ceiling, floor) or something
similar.

>
> thanks,
> --
> js
> suse labs
>

[1]: https://github.com/llvm/llvm-project/pull/82432
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Ddev/v6.8-rc2/signed-overflow-sanitizer

Thanks
Justin
