Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1711221F0C
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765937185; cv=none; b=L2ZTrhr1WKTf2tHvoVSKlmOQQZa9uIHlliRvSm8L8WpGshJ/E1Qlban8xrQrhRqq42FA7S2uD4/ua6obYuAzliX5jVjkevnSVSmpVokaZ/xErr9RqSdkmAiKbnb4N2x9YznomDPsoCj0v1E6HPs9IzR+K4+hquKii3FnOq377so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765937185; c=relaxed/simple;
	bh=6D/RvGr+Byo9QF6bP9/bKjr88t5+qZCl7V0ljTkIQxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPgvIvC5cJgDKSD5fSEnNb165WnxA1jhY6naumZwC1h/KhN5ZX7rwpfYAibrVSwUN4mhLZVzt9u4rXOFOdcn5qATDeO39bCvZa8aGXfoTgHUx+L3uo20fHV1M1T+JMnxkhnfnjqGWxSClZQRSNz2vU+Hm0a0CwZM/S2wpNqHSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IhscHFIz; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IhscHFIz"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64476c85854so4685757d50.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 18:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765937181; x=1766541981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OfiOZIpxg0tDEyK2KQTYkmCtCk2RA8OzRoQCSq29r0=;
        b=IhscHFIz4B2w3L0b5routyCYwNZKsYK5hfMjKJ/Yrijwt+1SgXBanPRHzeCW6dmIrF
         GuF7IxO45UpEYpniYezkiaqD7R85o/R0UAJeRKBPLbfvb3XfxxhRw88f28CiOerT3zhW
         s1RACYWcwKI5RCj5FIT+aHSG7eBHsM8MFzHeZw/rH68W+DIPfzBOXCGbrJIlDJDv6i15
         G8g2qMY9T8wG1CVx0yQ/nAkA8zqulsDLVmbG7mIjyWcjbpB+2klB6HXqQEj+KaAAkeif
         Sn5NF+Yw0Nfp/HDnOZhDWAJrQwIw0jWKqk3fHoZgFMV/Zl094gBEupj0zsfJoDr7bMDS
         SfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765937181; x=1766541981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OfiOZIpxg0tDEyK2KQTYkmCtCk2RA8OzRoQCSq29r0=;
        b=whnxyEVs24kxlJQ21nsHoesJEOcDM+fP4BoQIKQ+cGncSeQM86H67KmfCH9dpR1CBE
         R9RdJtcHM0WYjIcDZr1k2KnDu4x7T66wbBIMkWhWKJDZOMmB4v1op8/dkK2Gkoz18HUI
         a9lfhjB0xmoAP8n+U0d0pf6SEmwVphs099HRQ1ykF7vM5wWgknzzYBwwmyytGOhQksIg
         pJlBjMGw2lnvY1rAZOGYBxEQIc7JGPBfjdpq8xZjwNopLF4fvzl0+qnY33fpKqOJNu7b
         TlCDJgMZOFJJaJCbswVdrsjKK+Yf9c3OdAGWYWz/Cb1k37aPCYk2MoaeSrWYgtuINkml
         gxbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYZwoNJZxEA7YhkyOsMKI/n/pF70d8A/DSZWmHACLzf8Ir8GKc1C3ZJaG0KKCP6wRYAHN0ONcTm48+tcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQs5vBh1zeOXOq055g4xJw09tEIwfFgLpJCtud2BiW0jRCJsz+
	lIPZ4NQI7N/53ITmZaWsioiwfMlzgADWh6XJLFlLN509P02/qBWdocxD484UJJ/lNEdPKpdujWG
	Icg9zB2efbdP0jKyDyfnwUmx5l9FQ5EjnvDT/5PZBWw==
X-Gm-Gg: AY/fxX7+mi9BhC5UNEHh+rBhi3/qrq29kdIthWdOqrWpC7PGbtB5R0a0D4lttB3qMli
	BymOpIX/ZlxcGux30+IxZcil/sqBWTfG5h8ZO8HrAxzIE5IRs/O6/YiAsK0am0MqToh4pyoK0F0
	JL54lfmeDaU1gqtHDSIroA8t6e4xgDP1Ca+ICu2GkOw3YxjUfOMr1uilSFpBBtZqG0M2oAwEDBW
	gVVokfp1eiVd6C+H3GkBhNQX5VBvaM4qP7oI+FFov2d1xTsyf587PCorOqZKQUPRnn+hJh7Z7mi
	kqrnsDPz2uIBkfVzcuT8wpGc5ons0PJg0ixq5JBVRE3I
X-Google-Smtp-Source: AGHT+IFjkXFLSpb32ATeMly6o52Ldy94ZE2+rmmrjPmVwuAfzYm/nWP3oN74EKDLdVk0KisKe/00zmf/rjIbLwNuY1U=
X-Received: by 2002:a05:690c:7088:b0:78d:687c:8583 with SMTP id
 00721157ae682-78e66cded17mr282776567b3.20.1765937180750; Tue, 16 Dec 2025
 18:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-1-a0d256c9dc92@riscstar.com> <20251216150748-GYA1937017@gentoo.org>
In-Reply-To: <20251216150748-GYA1937017@gentoo.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 17 Dec 2025 10:06:09 +0800
X-Gm-Features: AQt7F2qw6wE-Ygw0dsVQyWLoaQf00ZTdNYPMUaVd6F0gE6fbGRiPsUhouMY1MOc
Message-ID: <CAH1PCMYQhDf9eNRQYTaL3KjBCUC+ygXFKTOVqULdp0UNAM=wXA@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: riscv: add SpacemiT X100 CPU compatible
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:07=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> > Add compatible string for the SpacemiT X100 (RVA23 compliant) core.
> >
> > Link: https://www.spacemit.com/en/spacemit-x100-core/
> >
> no blank line here

I will fix that.

> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
>
> with that fixed
> Reviewed-by: Yixun Lan <dlan@gentoo.org>

Thanks Yixun.

>
> --
> Yixun Lan (dlan)
