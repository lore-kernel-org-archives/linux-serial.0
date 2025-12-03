Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BA2D0C80
	for <linux-serial@vger.kernel.org>; Wed,  3 Dec 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753731; cv=none; b=X+TAHrQFGLFAB+yw6LmcvrN5pqB8cvAmYq3pWgeV0ghvjlClHNkIYE1d2RH9Mcl8qa8JRgI0E5DTHdc5ygDdGNWNNjjqGEpDi8aRlgEavGkg49IP1OB5xUldg8uZli7pMscT0jo8d3ze6jmWX8Djv9sRMjNu9PQ1vD5GlSO/ZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753731; c=relaxed/simple;
	bh=uWIzUXjutZz2czN3Cqe+GmO3GY8RW8SwTuCI/T0QDLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBeKhg769tvbmswOZaFIWaaAXKSR4DC6OVm7FLBa1holv31dMYJRBKEOFdw7y43NMQwBQi2qsKvGD1EWGLgp4q185W+1W46yXMpETpJ48sDHZj3U/WBfAkK221A2ysGWqD44JB12tCaJgY+RrLgw6RGOw5IpBuUx6QxINh6AuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4hcrfp+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4hcrfp+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735b7326e5so105117466b.0
        for <linux-serial@vger.kernel.org>; Wed, 03 Dec 2025 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753727; x=1765358527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOUylXYS2FmiyEAC1tEGQgDufCHTQiYbhqXazn+reJ4=;
        b=b4hcrfp+JB20s/8v5Hmd124FwNXPanK0IlnaH8C/AhQ65Y/pdwq+qOHJs2KMvtC/Bw
         3TTBd+2b8Oo/wY1PAA8a1uRhZ6fYo70Cj/4nJSehlfJO1Ahxp2qKPiVW54D3zTpJ5yyr
         Bf2pBxv6HUnnQmgpEU1XWe8nhGkeTK26nWy6/oqjJAXdsg71pjnsWNpngsYovfani3Gy
         Iel5l5j2xwPuBp8yBUSP/27zE7X+07oJWNBxin4m6/31pUQooMpjPW55k2rOACUl/hh4
         DjmMnSFTUtNdoPKMGNIwYwECnfQ/QQnR4cFpEqC+YSjTPMVqu9w0AANphEiTEkSNDJQj
         MU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753727; x=1765358527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOUylXYS2FmiyEAC1tEGQgDufCHTQiYbhqXazn+reJ4=;
        b=uuk4uIHgUWX9QWaGUYMpvFrKxzrn/e8ZfhQe6Xm8DgXQ+5Cs1BRBY82nsL7PFC3nNk
         MTb7qYhPYxJ5/rRWui2m9tn1C0k+ulXA7q8Oh0eTn1QEAKXBzPel3m5PHWQA/KoiOqim
         n8TyGpwv4vI2C0mvM9dSgoSeGNVxFZVycvyACpwy4uvVsJC7uN2nSMMCNE8D5aSS9HJe
         Wc4hVQY8u0Ls+ctmNtQwXa928ix3yfE+bpNyRBxX51/Xm02Lp3ojPNSmTYaDiM/Zi9JM
         vOmM7wAe54bW1oY/kbkmplbuheGXlzYULoOwobh+TwiwLphL8Nysrm2LrOjPU2II7Ruz
         qw7w==
X-Forwarded-Encrypted: i=1; AJvYcCWlYifWqzWmGacZrawUOnhVd5m2Kn5scnLiL6wPiS15pGHOIDtPKq2CGdKBx1kd0xyNFAzFTjJ4TnP2Thk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzNEiwsktnRIG2RqBbKeDAs6LgqIyriqB2gDBZQnpiY0Fdhka
	6KHNuOHDdUGYXlvJ6WIxWDiptTk4wbmrxkRCkvXk29pX4gUdAtBHtEig3J6w4L50gaPmVzu6jPV
	Rddq69JJEWU8/ycyApXQIqKVT+4Dt+7I=
X-Gm-Gg: ASbGnct9JtUsOLQfvc7oSqLZoWxiE7v5/r6z3McaNcGBhW3kiMru0lCrBfx7NbJOtQl
	QSlimkZ6up3U+mp5x27YcoYvjF8kSR4FUTO83HHKR8/PrWisGci+Bp9P8k7uHuQt0XGTIFgi9GF
	+R+dIl7SM4sNLMkQah0LLjn1B5qDcofgw924yDm4nsDEvB8BrsodbF943pS7LexJcFklwWYtN8X
	Wi5Tl1WlLf2vd+lWu+nUp30rT9zMWGKiE7UVHH8GoRfYP7T+dDgGjDy0XSExpZhzo268/qsO6fk
	4rdKRAQWYBjpT6Aas2bVfww+lEciiD2+iBt4bcyDXzszlUwi67DkkDfGy8TkvxxNpPed02m/Irn
	tl4VQ1g==
X-Google-Smtp-Source: AGHT+IGsNjYt6aGF9tzzbZ68+tVm+k7Kh0QHAlH6jcNkQj3EPDRQ09tJbtQXKfXyYhAvqqdpLpYoWLrk0HsNbvKCvcA=
X-Received: by 2002:a17:907:7ea0:b0:b76:d4fb:c30b with SMTP id
 a640c23a62f3a-b79d661118bmr183006266b.27.1764753726583; Wed, 03 Dec 2025
 01:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-30-crescentcy.hsieh@moxa.com> <CAHp75VfAfd7Ubhh1YxYH2fYJMv3wXUvUzrJSC1=V6HQ-wczYJg@mail.gmail.com>
 <aS-mgjAQXR3OgmUF@moxa-ThinkCentre-M90t>
In-Reply-To: <aS-mgjAQXR3OgmUF@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:21:29 +0200
X-Gm-Features: AWmQ_ble36ZlDcoj87c9hZ5he6CvMPxwTVmoHzhJuAhsNeDgYtJret8gIbgVPOo
Message-ID: <CAHp75VfXSJFN9Ev8_bChvMuxP5T+u2wgd=3=aQnvjkHaNCF_ew@mail.gmail.com>
Subject: Re: [PATCH v1 29/31] serial: 8250_mxpcie: Add sysfs to control terminator
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:55=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@mox=
a.com> wrote:
> On Mon, Dec 01, 2025 at 04:40:51AM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:

...

> > > Example usage:
> > >
> > >     # Enable terminator on ttyS*
> > >     echo 1 > /sys/class/tty/ttyS*/mxpcie8250_terminator
> > >
> > >     # Check current state
> > >     cat /sys/class/tty/ttyS*/mxpcie8250_terminator
> > >     enabled
> >
> > This introduces an ABI without documentation update. It's no go.
>
> Just to confirm my understanding =E2=80=94 for any new user-visible ABI s=
uch
> as a sysfs attribute, the corresponding documentation under
> Documentation/ABI/ must be included in the same patch/series?

Yes.

--=20
With Best Regards,
Andy Shevchenko
