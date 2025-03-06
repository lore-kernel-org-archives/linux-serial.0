Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620120F078;
	Thu,  6 Mar 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268477; cv=none; b=rDiOKm5l0PTctfH/KcA4bu7SxenVPjWJAggx9X9GEMuodDERQpq0CoGo6vfECzZQTbd5VmUqDY4N0Sxul6cMQsbD3Tljw63uCmWNfrllBKy1hLV/FWz1RTVsZMeivCqO5cDLbtZsElOilPUcaE9KLYtWuuo1gVwzh2PhfOS8pqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268477; c=relaxed/simple;
	bh=kso5cP7xwJNe5Ka/g82nAcrWB6XOwpD33ie4Y1C+CZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h82bSRxpS+spOqEDHQL21fze+KyJpFcVfWg+d/mauvB8SjEF7g7hJqQACz4eeEQJKUgsHwS3U69OYrVPiMmNbycdeoPieU5E4VkDmYhqbqvDIMN/uGDnLXA3lPJPO7p4MMB0SxFf1jxmSYVu7rlzL6trWQiIxGo3eNhThsTNsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGsu4Pv9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGsu4Pv9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f254b875so5090386d6.1;
        Thu, 06 Mar 2025 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741268473; x=1741873273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eSiHtDnCwoaAQVNN2+HAR2Vap6CN8XdHaNLvoyT/HA=;
        b=NGsu4Pv9iNrnDJ6XYsjsJWpBKcUvAP1i5V1MgyV8or2nyAL5VfeTCZE8kUClN7Duyn
         aCgsFDLqeI/Cnt0rf7I4xFgJObp+hOIWto9+3vXFlHsyzkY9nxzqyGbE0KT6kN4go7Ag
         1KAYw2s1KkNZ6gt8bP6kNWGrCwgLQuQxKXK6FJzolBhUg/PizDTPIdnapIWLdJAtrgQ/
         ogSGkas0JrTS9lQ1NlCQy52d9jftVy7GOCrPHCOoBHJQ4qhbaBp+QrmhwGDEPcur7DGz
         mzRvGscdAv/ObjzEyXMpniKPbObsqq3MsMF6WYIxfMvBk1RiY6YT6QsJvZYCS+glr5sa
         qJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741268473; x=1741873273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eSiHtDnCwoaAQVNN2+HAR2Vap6CN8XdHaNLvoyT/HA=;
        b=K8S7BcVpgZRQaZEEHOGG+qvaGS0pXZTqifiBRfWnWkcFpwdgTT2phjQ697ETpPkUtY
         fmmVvwNuP4tYn9Jhh0XJbFjnGuNduU8bx0D2ltXKpFjMAfkgjxyavxvHhBnme7RgCT5t
         SBo7m833aFmd+AKZKIj79HKVu7icisnTxm+68L1/CJFEOmABhDFg4Vc347RxbJjnuxxy
         fKl1Z6qkiGw30GksID4sL3JBZm1w0YzKPTbagyuXNar7rPFodwCTNO0IObpjxbHYeMTo
         2HjoN49/MwB9RItmqMkA2ME6iMg6Y1JRlOpVW6oRpUuaVhmSEquB1gwQlYMWtiCVgTeD
         1v9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIjdNkcGSWvXnWUyfEugmZiG0fTtuwHFKXNm+ScZGlMQtkL2XMhtjg38sdN/dHKQlhELC32SCJIq6XOFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5Fm82QKgMDKXrg55qXMYF++WZvCgsd7AE+eGf6IF1kxn5NGN
	RZNMtFuQgY/aaKY4DyihieJ4I3B0qyCOm1e4g8mpRX0jVssGRU/a
X-Gm-Gg: ASbGncuzyvR034xlwYfmh2ZZ9EVUrBCvrkiM7XS4Zx4KjRevparVAB2q9k9I+zOrId4
	odZy1uDP/x+a4fgcnuZ6qdbBrIH9YsXkWfN7M2bsMTw3rHCOuTAufShv/hOuz+FZY8TpTDgSdM0
	V8EbAJUX5iWznWCk5jK+ZbAVWr5WLJRZmDLitzWDM0jVDL9F6fGh3qPeEFd0VIxoB9NdUR0Jf7x
	x8yA9PHcysS2p1txy9Bqsuv2vqbYGrGahSrSkLe52s2tU+CRVewpNehBJZX+/Pq4pYdKZ7sgyjv
	XsWId/WRiWzK6LIwz0JRAIYh/71FnfwpnrnytJZzMlmisQivSUAhRxk7T1bjkVng8w==
X-Google-Smtp-Source: AGHT+IEJUIoDYStRwVBSqk/ZUotn5eGZ4etjhWSLpQ+IX0DyXLXEHDjYvduu1Jp5lVa61HBRTfsPTQ==
X-Received: by 2002:a05:6214:1d28:b0:6e8:97d2:9999 with SMTP id 6a1803df08f44-6e8e6dc82bcmr113786126d6.28.1741268470941;
        Thu, 06 Mar 2025 05:41:10 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:65b0:b1a1:de51:e0d4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f708ffc6sm7273346d6.27.2025.03.06.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:41:10 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject:
 Re: [PATCH v7 2/3] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Thu, 06 Mar 2025 08:41:09 -0500
Message-ID: <4217265.X513TT2pbd@nerdopolis2>
In-Reply-To:
 <CAHp75Ve9RDSLwsEt4a7ugtYNQokiRjyO6BR_rJXvf7r41C2hmw@mail.gmail.com>
References:
 <20250305042930.3453265-1-adamsimonelli@gmail.com>
 <4264609.3VsfAaAtOV@nerdopolis2>
 <CAHp75Ve9RDSLwsEt4a7ugtYNQokiRjyO6BR_rJXvf7r41C2hmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, March 6, 2025 2:06:14 AM EST Andy Shevchenko wrote:
> On Thu, Mar 6, 2025 at 3:30=E2=80=AFAM Adam Simonelli <adamsimonelli@gmai=
l.com> wrote:
> > On Wednesday, March 5, 2025 2:18:39 PM EST Andy Shevchenko wrote:
> > > On Wed, Mar 5, 2025 at 6:30=E2=80=AFAM <adamsimonelli@gmail.com> wrot=
e:
>=20
> ...
>=20
> > > >           In order to use this driver, you should redirect the cons=
ole to this
> > > > -         TTY, or boot the kernel with console=3Dttynull.
> > > > +         TTY, boot the kernel with console=3Dttynull, or enable
> > > > +         CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> > >
> > > I haven't checked what it looks like in menuconfig / nconfig / etc,
> > > but I think that CONFIG_ is redundant here.
> > >
> > OK, I didn't know what one is more typical. Doing a loose grep for
> > "^<tab><space><space>" and "[A-Z]_[A-Z]" (excluding CONFIG_) seems like=
 there
> > are more help text lines that mention other config options (~622) than =
include
> > the CONFIG (174). I will change it
>=20
> Thanks, it's better to follow the common practices.
>=20
> > > > +         If unsure, say N.
> > > > +
> > > > +config NULL_TTY_DEFAULT_CONSOLE
> > > > +       bool "Support for console on ttynull"
> > > > +       depends on NULL_TTY=3Dy && !VT_CONSOLE
> > > > +       help
> > > > +         Say Y here if you want the NULL TTY to be used as a /dev/=
console
> > > > +         device.
> > > > +
> > > > +         This is similar to CONFIG_VT_CONSOLE, but without the dep=
endency on
> > > > +         CONFIG_VT. It uses the ttynull driver as the system conso=
le.
> > >
> > > Btw, do those `make nconfig` and friends render the options?
> > Seems like `make nconfig` works, as well as `make xconfig` I will attem=
pt to
> > attach a png screenshot.
>=20
> Thanks. Have you checked the search? I believe it should work with and
> without CONFIG_ in the same way.
>=20
> > > >           If unsure, say N.
>=20
>=20
Yeah, it shows up if I search NULL_TTY_DEFAULT_CONSOLE



