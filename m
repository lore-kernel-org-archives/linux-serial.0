Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D31607B4
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760677; cv=none; b=RBpD3unV0jTPrLRZrUb2yJqOsAz766p6lgDYrUupw/bJdXxCxU8IunGrX5LYxRh2NzoJ30GLjTagddYhvAO23+uFVPNokLruRxtvn0a0fifbv3XSByhNnYKj02C33DvNUHUDrgZPDNvKxQPTnGoBAbk4P6LN5BnRNfjArL3jJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760677; c=relaxed/simple;
	bh=Gs+mQPXGzcil0DwrzkENLHclp7k55yBKVwwVYjg+evA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4EJx11mLTv0cS0L6fD7v/hQsEGKV6+aEuqgy+kgOjvUSeLnB3FnIzGFNRiJSzzXfSZb/59a5/ipB3FLJcRL4/N9f5HBWx2guj6cPFE8BcNIehDWh00iKWyiWH5id3FPuZ7tJ7j0WP/GxCqFEfWa21OPwZaM5gcB645IXpueaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TlTD7Qka; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TlTD7Qka"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa7so27020031fa.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737760670; x=1738365470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSjQCxfURjm/N120rDPiEtMw0TSoItdzlmo/GpKazxQ=;
        b=TlTD7QkaQdCcumD/xjuJUiuhRxvUBUNjF7/5lxsy+gH0Zhh95rD+OSKbfm957TueI8
         kly+pEdcxQiQnHp7SnbE85VtPHQQgBgLA+8DtYW5CQRzYTELuqijmWB7vPGHmx3WGNiX
         iJfm+7KjEG0BiYVrtJCuYPoFKczOgTPY0lDyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737760670; x=1738365470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSjQCxfURjm/N120rDPiEtMw0TSoItdzlmo/GpKazxQ=;
        b=Pe0yPNE3Z5psFRTaCK8TcC1fItKkdtkuGLPro25bK6jgSxWx2xzCjXRllhnPSMeSjN
         dpfbengdsoAKwmUQ+Qw+nM0iMAWJaS6iHBEhUQIpVSZp6VoyHV+Z/WXDUd1gYM7++1ag
         obf6JdDEA1McOw4hVwV6TSON71wY+uJC87xvr8Le7pAWuByQjRPLvPk2Q7ACDBI/Igcz
         hpb+RM0I//7RYfeOMrpE972hSxu1ylLKFGVyTOs9Z2c40zR4VhdoJegf/L4JhIhkh68g
         Tymn+xg0H7JSQRmS/cDzh0HxuFtTYyP2gUxgNPD2bOPU+VIkQ1wKAKCtslriqLu2DO9P
         X5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX/J+Vz0HIKO/Gg1kRW+dFfOTYIjAFcx0wBAyDzy3JjmbKrCI9nAJA2aPxJhkSOsYKfn54LLoA5c1Gd+9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUrUBEnbLHHR9zaQ9/SYHWAS+R+ra8H8h6eMC6wNJAhrN4jcp
	O8QJLsmdQnaTtIfO9WG4yjdjBgd5S3FugTMVjeDAej9waV5UqbP69sUn0x14q8nGwvmdCRJYPvP
	OpQ==
X-Gm-Gg: ASbGncv2d1FZgaMhUwBMLPYAqkckSftYLWIOT+rCkY3vs7NZXoPThZREFk+Ryf5617u
	dEzH8+iFB1q2YZuAds43AhsGZufSApRIfdXdWYz/1X9vyKEXqqHS2ABgrKIbBwdf7cRKGpbQt6o
	dDPS3szd+u3JRacLwDrxD3WbclcdQrKvMYsHzS5hX/jKTUhtNyr+aU/fakCHaCbsT4hrM4naIPe
	QOfor7v48WWQmSs9gb8JszdXDOFA8xTDHgZmvy4V1Mu+Qc8oWw111ne4o7bEC1y42AXYfxS24Bm
	lB1cNTiNm6A3NXdCSia9PVdbowvxvbqh/AfZ0gHcNGXB
X-Google-Smtp-Source: AGHT+IG5ci6B5SGRnj5pLYAYfFL9KEsIpDuJ+uBQbMAsX3YQOzYrP4myfn6jwEITB+ISfSXWXshZCQ==
X-Received: by 2002:a05:651c:2325:b0:300:33b1:f0e7 with SMTP id 38308e7fff4ca-3072ca6af5cmr100937751fa.10.1737760670086;
        Fri, 24 Jan 2025 15:17:50 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bacaa2csm5053251fa.30.2025.01.24.15.17.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 15:17:46 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so2775386e87.2
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 15:17:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3Fnj11bKVUrYL3k+9PQRwh/seoGMGGPxM/kiRJ17rZD6FvWItFFGrPj9knz51+10YxjQx2Nl5+PGJxoc=@vger.kernel.org
X-Received: by 2002:a05:6512:6c3:b0:542:28a9:dca2 with SMTP id
 2adb3069b0e04-5439c269841mr12558697e87.39.1737760664298; Fri, 24 Jan 2025
 15:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153955.33518-1-tjarlama@gmail.com> <20241211153955.33518-2-tjarlama@gmail.com>
 <CAD=FV=Xz2QqqTT+1Rmqq8hVEqQeF5-X=vgXKOjFe=y9FQVuDAQ@mail.gmail.com> <CAOfKSRMBYp6dSbhRqQXm09QUoJTaLjQr0XFqzqGVGeJ-KKoMuQ@mail.gmail.com>
In-Reply-To: <CAOfKSRMBYp6dSbhRqQXm09QUoJTaLjQr0XFqzqGVGeJ-KKoMuQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jan 2025 15:17:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VVHNNE3jK+_Vh5ydxysqMnHdZujG7y9=Gxrms8D_msBw@mail.gmail.com>
X-Gm-Features: AWEUYZn5qEtP1U9GOHM2S8c3LHoKvZnC1WnJRVkmjviAh_Ztkivn_ls9Oth-ddg
Message-ID: <CAD=FV=VVHNNE3jK+_Vh5ydxysqMnHdZujG7y9=Gxrms8D_msBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kgdb: Add kgdb_mem2ebin function for converting
 memory to binary format
To: Amal <tjarlama@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Amal Raj T <amalrajt@meta.com>, 
	Omar Sandoval <osandov@osandov.com>, linux-debuggers@vger.kernel.org, 
	linux-serial <linux-serial@vger.kernel.org>, kgdb-bugreport@lists.sourceforge.net, 
	Daniel Thompson <danielt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 13, 2025 at 8:09=E2=80=AFAM Amal <tjarlama@gmail.com> wrote:
>
> On Fri, Dec 13, 2024 at 12:55=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 11, 2024 at 7:40=E2=80=AFAM Amal Raj T <tjarlama@gmail.com>=
 wrote:
> > >
> > > From: Amal Raj T <amalrajt@meta.com>
> > >
> > > Add a new function kgdb_mem2ebin that converts memory
> > > to binary format, escaping special characters
> > > ('$', '#', and '}'). kgdb_mem2ebin function ensures
> > > that memory data is properly formatted and escaped
> > > before being sent over the wire. Additionally, this
> > > function reduces the amount of data exchanged between
> > > debugger compared to hex.
> > >
> > > Signed-off-by: Amal Raj T <amalrajt@meta.com>
> > > ---
> > >  include/linux/kgdb.h   |  1 +
> > >  kernel/debug/gdbstub.c | 31 +++++++++++++++++++++++++++++++
> > >  2 files changed, 32 insertions(+)

FWIW, it looks like Stephen has already responded to your V3 and the
protocol might change a bunch. I'm not going to do a detailed review
on it at this time. I'll comment on a few of the things below, though.

One other note is that you should have done a "reply to all" when
responding to my review feedback, not just a reply to me. The
responses should be archived on the lists unless there was a specific
reason to exclude them. Adding the lists back here since I don't see
anything sensitive in your reply.


> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index 76e891ee9e37..fa3cf38a14de 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
> > >
> > >  extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
> > >  extern char *kgdb_mem2hex(char *mem, char *buf, int count);
> > > +extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
> > >  extern int kgdb_hex2mem(char *buf, char *mem, int count);
> > >
> > >  extern int kgdb_isremovedbreak(unsigned long addr);
> > > diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> > > index f625172d4b67..6198d2eb49c4 100644
> > > --- a/kernel/debug/gdbstub.c
> > > +++ b/kernel/debug/gdbstub.c
> > > @@ -257,6 +257,37 @@ char *kgdb_mem2hex(char *mem, char *buf, int cou=
nt)
> > >         return buf;
> > >  }
> > >
> > > +/*
> > > + * Convert memory to binary format for GDB remote protocol
> > > + * transmission, escaping special characters ($, #, and }).
> >
> > Why exactly are those characters special? What considers them special
> > and so why do you need to escape them? I guess you really just care
> > about avoiding # and $ and you're using '}' as your escape character
> > so you need to escape that too?
> >
> > Your function comment should describe the escaping method and ideally
> > provide a few examples.
> >
> >
> Added relevant links in the commit message and commented two examples
> in code
> > > + */
> > > +char *kgdb_mem2ebin(char *mem, char *buf, int count)
> >
> > One of the two buffers seems like it should be "const", right? That
> > would help document which was input and which was output. I guess
> > "mem" is the input?
> >
> > "count" should be "size_t"
> >
> This was copied from `kgdb_mem2hex` which uses a similar template.
> Should we continue using `int` or just this function need to be migrated =
to
> `size_t`

In general the existing kdb/kgdb functions are not always the best
examples. I think size_t is correct here. Indeed, if you look at what
"kgdb_mem2hex" does with "count" it passes it to
copy_from_kernel_nofault() which takes a size_t.

Feel free to post a (separate) patch fixing kgdb_mem2hex().


> > Presumably there should be two counts talking about the sizes of each
> > buffer, or at least some documentation should be in the function
> > comment talking about the fact that "buf" needs to be twice the size?
> >
> >
> > > +{
> > > +       char *tmp;
> > > +       int err;
> > > +
> > > +       tmp =3D buf + count;
> >
> > Could use a comment that the buffer needs to be 2x long to handle
> > escaping and that you'll use the 2nd half as a temp buffer.
> >
> >
> Done, commented in v3
> > > +
> > > +       err =3D copy_from_kernel_nofault(tmp, mem, count);
> > > +       if (err)
> > > +               return NULL;
> > > +       while (count > 0) {
> >
> > If you change `count` to `size_t` the above test won't work because
> > it'll be unsigned. Still probably better to use `size_t`, but just a
> > warning that you'll have to change the condition.
> >
> >
> > > +               unsigned char c =3D *tmp;
> > > +
> > > +               if (c =3D=3D 0x7d || c =3D=3D 0x23 || c =3D=3D 0x24) =
{
> > > +                       *buf++ =3D 0x7d;
> >
> > Don't hardcode. Much better to use '}', '#', '$'
> >
> Fixed in v3
> >
> > > +                       *buf++ =3D c ^ 0x20;
> > > +               } else {
> > > +                       *buf++ =3D c;
> > > +               }
> > > +               count -=3D 1;
> > > +               tmp +=3D 1;
> >
> > count--;
> > tmp++;
> >
> Fixed in v3
> > > +       }
> > > +       *buf =3D 0;
> >
> > Why is the resulting buffer '\0' terminated when the source buffer
> > isn't? Adding this termination means that the destination buffer needs
> > to be 1 byte bigger, right?
> >
> > ...or maybe the source buffer doesn't actually have any embedded '\0'
> > characters and you're using this for termination to the other side? It
> > would be good to clarify.
> >
> > In other words, if the input is 2 bytes big:
> > '}}'
> >
> > The output buffer will be 5 bytes big:
> > '}]}]\0'
> >
> Don't think null termination is required in this case.
> In this case, the `gdb_serial_stub` already initializes the buffer with `=
\0`,
> and `put_packet` iterates over the buffer until the first occurrence of \=
0.
> This works for `vmcoreinfo` query. But for input buffers with additional
> `\0` characters need to be escaped, to make sure `put_packet` parsed the
> entire buffer.
> > > +
> > > +       return buf;
> >
> > What exactly is this return value? It points right past the end of the =
buffer?
> >
> > You seem to just use it as an error value (NULL means error, non-NULL
> > means no error). Why not return an error code then?
> >
> Other encoders also return a `char *`. However there is no error handling
> anywhere, the return value is discarded at the caller side.

As per above, existing kdb/kgdb code isn't always the best example to
follow. Personally I'd rather see an error code returned unless
there's a good reason not to.

If you really want to return a pointer like this, a bare minimum would
be to document it. The kgdb_mem2hex() function you pointed to _does_
at least document what is returned.

-Doug
