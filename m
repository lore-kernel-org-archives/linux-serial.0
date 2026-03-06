Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1252F1FE4
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805786; cv=pass; b=tYiJ2bypj7ZVdn3J0ZtFKvG71ivkoy/uZrdLWOpP9KcUBYOnDLLpbNmNTqZ2bBncI+Ol4TWjMONZSVHRukLpejOyvJIdp4STNRi0oPTYkalX6cY74Ud4gzhDExckUCVPxBHQXczV6FkMZRZH0+Nj3og3qzoYtJPu9dSQVnTBpLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805786; c=relaxed/simple;
	bh=Wsx4vB+t2mTQSdJEGwZihx35l+trvJCdqv6s8OAnPjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDk81RIKySUS59PD6Xs6hXukA4qgsr5++NvNBAqw+qr3qtVYVxPxSTITZp3ayOMT1P0+pUss+20FTyw7Il/2JiNC/+ExJiXsyeVrLT2gYNKH8H4qd2UQJFzQ8xlAwd7vS6u05mkTks5HcEuIAivIPiP3b1jH7Z2i+rZCCt0lxFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZGPIxOh; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZGPIxOh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986c7b8076so101156497b3.2
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2026 06:03:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772805784; cv=none;
        d=google.com; s=arc-20240605;
        b=h/Jwn8/+xoxt2Kyif7IvWM1ryA2ke3bHrNzaPNqjQSMVxFDh7pwCk+YoHRP/nGl0NO
         32502m+UMS16/zu6dOSJxPaMg7JIY+JyDlHDkXM8C6PcKLnPyk4r2Hce8SAVjyB6e9nN
         demhyRSWieLfSSsrntAGAx9yvxqWnWpJWt5sGRnV9/z7yLX2dr9dqAeS3azmn/RO7hWv
         0kyVt+BbG0ZFCy5Zj31Jgv7Q4/1Ac8lTn9Gp1QLsPP8Mknr98wdI3ZKgaLqYeWgBY+As
         d/dQevc5PNnMZgprJOJC7RjHgp4QeSZ3a4USh5cowqCmqGOisp+A6kIg1ni2XGG7v8R2
         vEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
        fh=1S9avJVN6HNcChKFkJ52Vt3QBgWYaF4LPJDI7WIHnxg=;
        b=lc0ycYJ8O03k7dubx0F8xFDgfW6AsKJI1qEOuTUvLJD+RoUBgqsEn7j8u/SGupG5BI
         8bKsQZoSze1TY2nSb5oA9mMkq8gPm5ix2w2nf1KhLfGU1zm+R4mQPeMeMA2NaKaROKHj
         vRGNGkgGx/1BdpjpxlE0zPQEkjjJHmJqPxyeQOhcLHWuU5H5i7suAMulBFvOjx370NyA
         uso5e1yeIFDAVdtslKPePRRV29Xgtu9KN0O5CXQIrhugW60N2NrYvl8yxd1mx1Fh+p9f
         sup+2cyALog6bo3Q97MC7xEhiZ0rZvD0zoUgB3P4QiqwY4i2k+RaKLjmt39Xu6CxSD7P
         jw8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805784; x=1773410584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
        b=CZGPIxOh3w9oDO/EQ+kldGZnriCDWSfk6Y2blVRdAKl3q6wAGKCoZUsFb4agR9a5Gv
         9YNu2VMMGZK6wrHl8uM3QzhnxOrHEzwrxvcbxRHtYootq9M4ZVOBVKlRb3LQ+H9QAIUf
         GMqtfmwGwowZzWr7uVKcsG10NMLOg8NxoJlM/4H6TeDtuH8EAf37QRG0+NzAl64k02pO
         0DZXOnaulFslyTApfPSIB3fQaidqitmi/6/PruiKvA3pgiaVaATKnGOLw+5u+LE5xN9y
         mDpU+NEDzJVdhHpOsLH4tIi/HXCZsJYbb2s35ohb1LFX6DITYQ+3pqupVgNnHq7mG71F
         R0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805784; x=1773410584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKF5k211NtUeIcGa6uptRsEXiW/hV471fc5S/IDch2A=;
        b=vPmmhxecvsG9FptJRoczaGrd0fnR5b1Js/jp9mxWkRBHx6DCNz3Y+uF916hB4+LnAM
         Q4RrfdqK7JnAfrIhCxEtteRvepyduTlumHVHUq6LQ9SzVJuMhhM/UwzobqpnJZGhNq3k
         0UwE+Hg2TbEzSEzlCDIcfYxfT8+PhJGLgDVGuv2/aKLxAHKXwhk8nQcDlMMmRXvfHz8O
         MEKoyPmZiXYGhzERzRmLYxKQZ8kXddJf/BAWDQ1qW07K/UjAIuQAXBdkTjGuR0ADL5DL
         jDL7bT3ZJIi7scTPVjh723ouUmQ90grc69Et6ElooEnrZCHIroTSUl55TOjY52KOxq1a
         /Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWlFaaY6Dxxztu1z2jejFR3B5WiGCwyCMFPeFeVV4HT0B/P4EfVVOg5oUTqqJHJmkM4sCqUQ+lHpZg0K9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMm0T1p6SVdqkfA3yDhxFGDKifnQcIxoQZu3j+iXmJ2fh6ymYh
	ZcJqtlgF7j5Dw4CHTTFpI2fehTMI2FbpsaKHjLYdMhUy0ohYifX3Wd76ubX/pjngt3YsarUyqSM
	iLyAtq0YGFwubPe49uXhP2Ht5WACLkrU=
X-Gm-Gg: ATEYQzykmzgjCP+m3rpHBKKMrM8PCDf0A/189ppVkwJIdGQUZp6yYOXAr/BIuyNQVxZ
	bfKAQFiwLQLZh7JAuLCIPV9po/6bEugYdX67J5DgiJyOXCD8bu1XDA4TjUXGuPq0fguOn4BRTqH
	QrYOI0EIf9ben0AV5tlDvcP3Cd2otxenRddI+EqY1KCBtPNQ8XKVs+oWo2k+SP2TFQkEqJEjI42
	o5n2BjBbtLRTMzeTvlX5rdqaMEjEtwk64ybB2PBz6Wspx/YZh8Zw/odbqJX7aQEV2/MYY0+u08A
	ehmZ
X-Received: by 2002:a05:690c:f03:b0:798:740f:6af1 with SMTP id
 00721157ae682-798dd6e9b55mr17942317b3.24.1772805784050; Fri, 06 Mar 2026
 06:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
 <20260306015022.1940986-4-jim.cromie@gmail.com> <51fed793-869b-4a5b-b90f-2ba80c13d773@kernel.org>
In-Reply-To: <51fed793-869b-4a5b-b90f-2ba80c13d773@kernel.org>
From: jim.cromie@gmail.com
Date: Fri, 6 Mar 2026 07:02:38 -0700
X-Gm-Features: AaiRm51wLCC9Sug6nG1UgnDvIstzQQFHwne8N2p7gQVCpTt4Mc1sv69X0Jjm7fU
Message-ID: <CAJfuBxxe5uJc0=nLC45JMp1dcQhyiyyyNuv06jZJX++YJaN58g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] drivers/tty/serial/serial_core: ratelimit uart_wait_until_sent
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:32=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 06. 03. 26, 2:50, Jim Cromie wrote:
> > Ratelimiting these pr_debug()s can reduce the console flood during
> > bulk dynamic-debug activation, in environments where a serial console
> > is used.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   drivers/tty/serial/serial_core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 487756947a96..6db465619c70 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1790,8 +1790,8 @@ static void uart_wait_until_sent(struct tty_struc=
t *tty, int timeout)
> >
> >       expire =3D jiffies + timeout;
> >
> > -     pr_debug("uart_wait_until_sent(%u), jiffies=3D%lu, expire=3D%lu..=
.\n",
> > -             port->line, jiffies, expire);
> > +     pr_debug_ratelimited("waiting on (%u) jiffies=3D%lu, expire=3D%lu=
...\n",
> > +                          port->line, jiffies, expire);
>
> The changed message does not make any sense.
>

Ackn.  Given the narrow rate-limiting purpose,
I should have ignored the checkpatch warning
and kept the message as is.

In any case, my test setup didnt actually use serio,
and didnt get flooded by it, so I dont know that this
single change would be enough to fix it.

I withdraw this particular patch.

>
> --
> js
> suse labs
