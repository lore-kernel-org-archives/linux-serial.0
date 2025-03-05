Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A261F9421;
	Wed,  5 Mar 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202358; cv=none; b=edPuMuGTl5ZxGUnqLfToGBC2welpichOqRofRd64pHnHV7ql1CtUwGJnASJwuRQ60C3IkVGYKCm+RYZAwo4xpChtXfz3lZLR7uSRRJARblzpOyXpANx8bKtzIGf1WrBnTxi3fRfvpR+TTyzZHft4ksg9TO7CvETghCqZA55vy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202358; c=relaxed/simple;
	bh=qh3H0f1tockEN0SXx0qziDHNUYVqtaHpeJWvQ+FB0r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnxvrnnlnyPqny090K6+yN7rbD1nGprxDPrvQoqykC+Rep3iqrg6qVFiczkR5+rdnCznhynxOuDphuP504QoEfQ/mXyQcEHRxcKe8OkUSaOCURo9fKgSOzpczWpTQnzTdaBeQmRGRnHokrNqQUipR58FlT1wTh8wnFqqUuxJRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRWFveZ6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRWFveZ6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab744d5e567so213084766b.1;
        Wed, 05 Mar 2025 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741202355; x=1741807155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2KNP9IGq8tGz6XYyH9w/L+2vHmsbJyLAKltw3DCNUo=;
        b=fRWFveZ6mGFt2v9BsZ0jjckPjQaYX+tpQ9Aisfe95rVtdzo80VT/k6JAOpulyDExqi
         mQgXS/B84f5W0uanEHfkqMGQGRde1o3MgelnBkP4XqCCR3d9u05Myf13wBXiBink9+sJ
         E3XWgOCHAgkNz6qHeyaZUV+qzPwBHynrqPQ/eA9kPp94y1iLkHb3QZNECl3tUieBcypk
         K2y2/FVlQaRhnfLFVuZZZh80D2wYwcL/I/jqUczLw5tUvESJQgNbbcn90TdDFLUiJeQt
         saiGFD9rTV9tyG0+3UoXAZTQaqOCYvezKl+LC1gkT4wMH8l515Mojfl8rmy7Rscq3JrO
         xt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202355; x=1741807155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2KNP9IGq8tGz6XYyH9w/L+2vHmsbJyLAKltw3DCNUo=;
        b=DRzYr2GdO7SsE7KQf0AJbuJDuFMUzhSjcdXILyJR62HlELka5nJsLRbqu9j3DsmuOP
         1wq5w3eI8hRp+wPyQOvpQbM1iedqJtPgKGsLnjDlYvDGvr145hJRPSir3Es/cbnOUWG/
         +BYUphWxZ1sKuV/HOvxLep26ighQ4Ib9iYBjVzmPBKa57pgaKP3mkDnaJ7XRMgi5vg1/
         5xq6PQy4L59xNQk2vqvYN7V1TxltBgbkkiu+UNOpRAQwgq9zZFU+dZ+/ixbuR/0nP2v3
         yzaE1+Ov9FxIf5IMCGxwKI+XLgIAek24cOAhtu7e0t2MDkHx2E8aq4YvxhhmiwjV1mua
         qkZA==
X-Forwarded-Encrypted: i=1; AJvYcCUyRhgo+X8D/1kw2Bz97a013dLZqaHCxGun/SqViLwkjaU3oEIaaQROlT6UWZ4WERUtE7x08YD8+7ojl64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wZn8Y3XBxm04+1r2Hv/WYc4LztJV6QjdLeMBitoU++U3Kmfi
	9jc2psjuuTAa3H821b5Yj9lDfuPP0v1iGywM3qujtBkCQ+c6Muv58GydVj/ItnBQdg13T5XE0fJ
	pkxIFhITO2e7QV1jIgLsSSLRkHQw=
X-Gm-Gg: ASbGncue0L29uuMnuQeVV3N1mLAd9Wy9ZNbPyiYMp91TtO/bziDCKfpBDjIyVI0/SwR
	52eZMLok01aanjGRB9LEjsG8vgmhA3P2Kg0VNaYUzvQshoRWFe4DNM+9yddfGf8JtXBsZV0edos
	KtcgQznEISeDv6RUaUF2qjkL5yKm39
X-Google-Smtp-Source: AGHT+IE/CAbAzjr6Sc1ZN5KHuLoUNYCntXegehi11W3KX5IVixqLnqnwpNG4XVa+4Inwd+AAcOo/eRuPu7IM17s/a4c=
X-Received: by 2002:a17:907:7243:b0:abf:27ac:2cf8 with SMTP id
 a640c23a62f3a-ac22ccf805bmr47285366b.21.1741202355196; Wed, 05 Mar 2025
 11:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305042930.3453265-1-adamsimonelli@gmail.com> <20250305042930.3453265-3-adamsimonelli@gmail.com>
In-Reply-To: <20250305042930.3453265-3-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Mar 2025 21:18:39 +0200
X-Gm-Features: AQ5f1Jp2f_iav-b7aRWmDxgqn7KviavkBuka-5o2Z7EzPAzBUwyh-fHhs6JaxQI
Message-ID: <CAHp75Veuo9L8Y7=9XKCeFHzhtNK9x4pQ19kcMoAkL-0mFPq1Hg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] ttynull: Add an option to allow ttynull to be used
 as a console device
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:30=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>
>
> The new config option, CONFIG_NULL_TTY_DEFAULT_ CONSOLE will allow
> ttynull to be initialized by console_initcall() and selected as a
> possible console device.

...

>           In order to use this driver, you should redirect the console to=
 this
> -         TTY, or boot the kernel with console=3Dttynull.
> +         TTY, boot the kernel with console=3Dttynull, or enable
> +         CONFIG_NULL_TTY_DEFAULT_CONSOLE.

I haven't checked what it looks like in menuconfig / nconfig / etc,
but I think that CONFIG_ is redundant here.

> +         If unsure, say N.
> +
> +config NULL_TTY_DEFAULT_CONSOLE
> +       bool "Support for console on ttynull"
> +       depends on NULL_TTY=3Dy && !VT_CONSOLE
> +       help
> +         Say Y here if you want the NULL TTY to be used as a /dev/consol=
e
> +         device.
> +
> +         This is similar to CONFIG_VT_CONSOLE, but without the dependenc=
y on
> +         CONFIG_VT. It uses the ttynull driver as the system console.

Btw, do those `make nconfig` and friends render the options?

>           If unsure, say N.

--=20
With Best Regards,
Andy Shevchenko
