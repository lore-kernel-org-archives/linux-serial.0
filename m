Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B35155345;
	Fri, 29 Nov 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876959; cv=none; b=JjLghC0ANBpSivBS6ErJ2SRwlgwAvFOcUehEu8JoZDKy6kAR6PZfx6RQYxu3Naxd2RuZ8TSGQBIBDUbms9IDGJlvQvIQbc2Bm66zOX4lYS6JxctKfkF/F++j+eFPbhIHfsrdFRtCcpvvTLjACvB5pIpPnb6GRidMDQOd29/ZmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876959; c=relaxed/simple;
	bh=7ZpyTF/Rwz9DM3tIvFc5vhQ1fTGkPShbTMlMb0/iVsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7xywS5aeWyNxvFZMRu/iNIGP21b1Yv/Xc8BV90Mfsj6RYVxacqu48dKUOzJM7YJNVpWNR76iYJbz3FiV+6I5tO1Ef4T5hBqZAgToCJi7YUocogFL7/mt8ozI0uKxdVQdJ0yF3pNKLA/lx1cynRdZ1Wyx8lhiO8IO2ZUilsmDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51532deb867so413461e0c.0;
        Fri, 29 Nov 2024 02:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876956; x=1733481756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz4i8+hIryKOg+hkDrUGtXlPZUU0hx+Rc6UUOljWAf0=;
        b=rDHReeDPqJEhoia98YAtQc8sgaJFvDadJ26ZaUYhMsNYRdGrLBT8n1uQq7XJxTyXJ/
         5Ro2TwJbqpMDKA5kbdwXyWGDwj55oUSt0Wja4sIv6gAMmeN6cbXxHVOQq+zdbeqIDqyk
         nrBLnih65+0pFcKuH5hY/tjB61WKdpcjcUHFbzYBo2SCjT6ajxwSilZNX/4nCzszo4bL
         IDgS5NBihe5wqbCpcHNoc2mn3+DQbTk1SudOCkaSDxs4hOPaRmXjL1iLS+r3PeWzO2DT
         1gilU0uZpFvIrvQQOhXE80bh87qIl7saIty3GfxYV49fdaPQxZkqlkkUczQLa/bddpoY
         WPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5O1OjtS3HuxqUy1KJxqWwBX4jpVxK6jb9GrSRPlL3OB8uvugtmA1uWZ7Ew7jnUTwQjrJPK+IVn4pl/Wk=@vger.kernel.org, AJvYcCWGaB6Oi6S4eZ2pdWaavMSCT0GtQuHKQwhp+SKh8pUJ62Y5/0W6HUDVEJ8VHkcjCFddXEnS86BP2RnhtrFb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5P7ok2j3dZ9aawnvJAcs/hUIeZd7TZOy/dOmDfH5KFFRxG3U9
	asrAPVXnNSTaTQSXw3Anv1uW6nwWIqekDywDZ3Qu/U0jKHg5wscwTshSdurld5I=
X-Gm-Gg: ASbGncsn/irHsoUZWKNp3UnojM2QsgljjaRRwcBs07DpL8KAYS7Gw2+y6D1n3GWnq63
	iGQPn0Lea7d7WZgQSstOYzRBrY7fM0d8q1vZmoaTGfTZ7Jel3zZspeORgJay8zO4ZZClSmykEYP
	uU85696z3hXgv/KUVlp8Ue3nFeezTcnfSQ+LckJ3t2fgn42tzmjj16gn4V0u/b6WhT6Hw5gat0l
	wg51sRTTt2v1NRGPXMvX0+Prh98E8Bp2oen3i3cPG4EiQ+z8qnthS94F4y3ku7uJoFjKIjRboU/
	gjQBib0sIc+7
X-Google-Smtp-Source: AGHT+IHuTJNm9lMGiUwPp8kaef9NY1g0n5CaDi8UI1YjDEJi8oFJl5FmQsfL4ikvj+p0qzUg8PaDpw==
X-Received: by 2002:a05:6122:8c13:b0:515:4fab:2f8e with SMTP id 71dfb90a1353d-51556ae31e9mr12625720e0c.10.1732876955898;
        Fri, 29 Nov 2024 02:42:35 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156cd231d2sm478028e0c.27.2024.11.29.02.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 02:42:34 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4aed6fdf04fso401525137.1;
        Fri, 29 Nov 2024 02:42:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnnmg0esluOvFBgS1XBNLupivJV/91t8+vrz8ULrblkV6OFFZNEKawHHjevXCqgFBHr1rh7Prj6tlt+1f/@vger.kernel.org, AJvYcCWQlqqzyfHo2RqbgfvEMkR3MD5DJz7BPvlXkZxqBsnju4daViQFi0WoqeF8lYsjkT19mzuYHShD69qfaGU=@vger.kernel.org
X-Received: by 2002:a05:6102:d94:b0:4ad:4ce6:709 with SMTP id
 ada2fe7eead31-4af448f6a3emr13108148137.6.1732876954639; Fri, 29 Nov 2024
 02:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0lCihhE75lE9Zjd@kroah.com> <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>
 <2024112952-headphone-vastness-3814@gregkh>
In-Reply-To: <2024112952-headphone-vastness-3814@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Nov 2024 11:42:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9j-=hEgvth0L=AS+BgdFwgFfOkt=xbB7RCP=4UAvocw@mail.gmail.com>
Message-ID: <CAMuHMdW9j-=hEgvth0L=AS+BgdFwgFfOkt=xbB7RCP=4UAvocw@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

CC Claudiu

On Fri, Nov 29, 2024 at 11:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> On Fri, Nov 29, 2024 at 08:58:28AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Nov 29, 2024 at 5:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > > The following changes since commit 42f7652d3eb527d03665b09edac47f85fb=
600924:
> > >
> > >   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/t=
ty-6.13-rc1
> > >
> > > for you to fetch changes up to b5a23a60e8ab5711f4952912424347bf3864ce=
8d:
> > >
> > >   serial: amba-pl011: fix build regression (2024-11-16 09:52:55 +0100=
)
> > >
> > > ----------------------------------------------------------------
> > > TTY / Serial driver updates for 6.13-rc1
> >
> > [...]
> >
> > > All of these have been in linux-next for a while with no reported
> > > issues.
> >
> > Oh, how do I love this boilerplate...
>
> I hand-craft that every time :)
>
> > > Claudiu Beznea (1):
> > >       serial: sh-sci: Clean sci_ports[0] after at earlycon exit
> >
> > "BUG: spinlock bad magic"
> > https://lore.kernel.org/all/CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7Lrq=
v5dWZWYA@mail.gmail.com/
>
> Ah, yes, sorry, missed that.  I assumed that it would be fixed soon, do
> you want me to revert it instead?

Let's hope it gets fixed soon.
It's not super-critical, as earlycon is not meant for regular use
(although lots of unaffected non-Renesas platforms do have "earlycon"
 in their DTS chosen/bootargs, sigh).

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
