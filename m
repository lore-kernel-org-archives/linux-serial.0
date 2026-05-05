Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0D2FFDCB
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973454; cv=pass; b=Ij6dBxjd4TUySnsjJ2hQLvpefItFG77AaY61e+oy7uE2I0HvPmlSsAdhbHTFkzh4x/JsYDT12gbGBiu62y8amomU5jfqmuGS75qI7H1o0C0hN0CtxvJtdRmEvBBYEZV1gcCBC1cmHiojx4c25FgBHsqDoQpBbuigIa0zDBeX3NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973454; c=relaxed/simple;
	bh=yomueT/n5g8Q0F2R+zn0VCfPYf6QJ8+/Ot/1qnMuyMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAyCHdQw2Y+p5WGbWPwIdj3JxBSGoEQfVTaocQjV6oi3coHyLy92aHpszo8MQfgti6bYx3rEq62nKSupxAbeDxKmLgmHOHrXXr4RsPq0+5iJNXQrwmpbJypaijMWdefpbzqNsyZ43Xx2x4hvrYqan3MYTGD1PAQCkwFb+sd2iyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lihGTNUQ; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lihGTNUQ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bc2a455fd55so256279866b.2
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 02:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973451; cv=none;
        d=google.com; s=arc-20240605;
        b=R/nyRwnbkaqk2DTaEaRvT4SudhUvPAXHzifp8pi5rN8sM3agNxu4OJXFZXEpn335Ic
         HO6l1tiADOI1vAav6ody+FOkqx3IT1K04dfXGAqizaIm3eYsyfZJOKvIj3Kv9i56EUws
         sL/W/mPcGQzl+y0Ec8YJFX8Fyulu+XptAQld2yOGiOEXwDoGj5+Ghj446zo4l1obtWaO
         /cSa42H3OtjSEMNPwICc170VP3faPB5dj3BtrFKTVX72YxrQFSLwRpNF5Dd8+EaZqhV1
         BbarL4+YF5GREifSrrjmFvyeJ1/Wcptn0CPhFe236KVI/4xcQLdy/ihPKSwQS/MW+oS8
         /WnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wj25xxzjHmPeJqZtL/snYGk7L0hDN7bgk2L1xqWFqA=;
        fh=VNFhtp1bz3lPM57ciQnKFyojCL7fbkd/GDOPIjeSlMo=;
        b=bKrgu4JNqlan3Xh32Nt1YELWQ/DvON9Nb2dnSM5PXc4d9zTAN0NIeHm2Or8SNw2EJi
         blWpX9bm92RIRxsgGwmCcmtmOTUoxdMAweL6qwcqBZgo+M7KOBhn8V4v51zNo0krEgDz
         9vabS+GwrlwGdf9UhvXVUTl5JWorTz9x2BfoHrkJXN79ub6KUKZlWxr3dRqnPvZplsqI
         OSzpxEV3W4euoBMfjjxXLJ19OZg8bbHFNr6qb5+oHtCz2t2KHTT4DZuKXa1qr5ueYTol
         zlcuzIyMmz0gWXZqosYqoNqQATX3be+LCyPs4FRS87StbAjs713hdo8p929Od9tyzgB7
         8jgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973451; x=1778578251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wj25xxzjHmPeJqZtL/snYGk7L0hDN7bgk2L1xqWFqA=;
        b=lihGTNUQHgrFy+b/mDQlrm8Nr3W1RQfwqkkQfPbqf0QhDndyw4ksQ8GYsiwt+4eFoe
         BawXrK7NFw65YnMX7JY3JKVI4aREuV7ERH4Bua5OwySufEgWj16ATi0dDxY8+pABIgPr
         +SKQcJZE73a+WW9hs2WrprVObPojRg5+mIg/3JB/Jq5uOBX1DhqgVyyg0nck2mNXxLOq
         AS4d5t5O5zrptOco59aN2BS/KTjqH3y20txole5OyPkbw88ebPRykMkVU89aHnj/gws4
         x0bPc5fsGLn9vlR8QlkL1rRu762k+m5JTJdSpGy7mGkIrVVAik1NU1sg/ZsA0wZPRUkr
         s6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973451; x=1778578251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wj25xxzjHmPeJqZtL/snYGk7L0hDN7bgk2L1xqWFqA=;
        b=K26LIDCbArl5yxqaVXmHL/CMTUpi+jF3y6EfVHXuzS/6SBOvkYi7a1vYPgK8VxyePk
         gkz4sg39qyGztv5AJ8JaDD4/g3b2HwGYGYDO6NRJYhUJmR5ZpDpHe5SkcJvUxyOPdKZB
         mCeXlof/JcSlGPHU8AQuky/hy7gucOso9B3CechepF8vi622klXxPVltkm0lloxAk2im
         6v6IXZkW54rl29JbxRpZmdhQ8n1ot7d4xYF4m5QTJAZkM6UokgnGHjwqVR4LPyxTLy0t
         3gnI5TftIFkDXWUxfxN/OFhSmwNVEHfiumAMmPVUwAF1s3mZp1eAzcWE3mK1bkSjV5pc
         1usw==
X-Forwarded-Encrypted: i=1; AFNElJ9kyz4AF97aXixBoftdyTVCFr1sRaukIUf3/5j4iVJh9bxxgS/a9k5lgWw+cBGt5isG4ntuNo7FO1ZuK94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SuQ71hMR6FA2b4ZfYA4mbmEdJ5pdvKIh1JZlE3WCN1Y+My4X
	taOOuhBSpRbPc/G6Gy2qTXN+uV/m9V6RLJlMd3Kt54/7f9zwBjdu7ULfqT9O6+G/uTPE26vsoPt
	0q4oaglrSabhSMYDj/3gpnX5QAQtnraM=
X-Gm-Gg: AeBDieuGp1ijRkV/r+T05Mybl9iG30Xs1mj15xrUtOYk57fU7tJb5vg5yy8NKRG1q4l
	bq4H1ebWJG4VGykCT+H8muGy/ZpJGBzf3Hgx99jMqvPrFbiTNCYoJHJMxkp4hmFXb2sESeswoyL
	ggOpCq4S5+MTbbP8oG8XhT8hh6GEeXl4tEiaUdVhf+V3aYHQixXK1jvHQJ21qi/7Sm07ktzJcTd
	gd+ImcpOJBB3MzIjafYW6VvOBvAeCNNg5krhdBKgVYNTHBbA0zc1XjrqR2Jat8r2YSp06IVQ7+o
	ByGVz+xRq1zj747Tbf1HJw0/w+xyio3n2QpsKCVBV3Pn524dJFv6LhDNYDFeD93Sad/8R+ZIhdL
	clXKR3LZr2JCkYFSj9g==
X-Received: by 2002:a17:907:9483:b0:bc2:a9b8:155b with SMTP id
 a640c23a62f3a-bc2a9b815e8mr335364066b.27.1777973450998; Tue, 05 May 2026
 02:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-15-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-15-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 May 2026 12:30:13 +0300
X-Gm-Features: AVHnY4KV689C4oxNonx0GrJmrbZTLOn_VxDn2J0Qse1r_T9eg7kxJGg5achH3qE
Message-ID: <CAHp75Vdf1-Ew7F+XRB0UfyiiyC2LczfP8Rc8wUn=4C99hO=_UA@mail.gmail.com>
Subject: Re: [PATCH 14/15] serial: 8250: allow UART drivers to override
 rx_trig_bytes handling
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:51=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The rx_trig_bytes sysfs attribute currently relies on 8250-internal
> helper functions and assumes a fixed mapping between trigger levels and
> FIFO behavior.
>
> Some UARTs provide hardware-specific RX trigger mechanisms that do not
> fit this model. Add optional uart_port callbacks for setting and getting
> the RX trigger level, and use them when provided, while preserving the
> existing 8250 helpers as the default fallback.

...

>  struct uart_port {

>         void                    (*pm)(struct uart_port *, unsigned int st=
ate,
>                                       unsigned int old);
>         void                    (*handle_break)(struct uart_port *);

> +       int                     (*set_rxtrig)(struct uart_port *port, uns=
igned char bytes);
> +       int                     (*get_rxtrig)(struct uart_port *port);

Seems to me a suboptimal location for these. Why not moving up to be
closer to other getter/setter pairs?

>         int                     (*rs485_config)(struct uart_port *,
>                                                 struct ktermios *termios,
>                                                 struct serial_rs485 *rs48=
5);


--=20
With Best Regards,
Andy Shevchenko
