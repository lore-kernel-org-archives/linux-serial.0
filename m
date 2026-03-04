Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881243ABC
	for <linux-serial@vger.kernel.org>; Wed,  4 Mar 2026 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612683; cv=none; b=hyyKp0+DjmACUoa/XAfnxE5uSDHwFNSw6EoJJ0KAr3dFDkKTcqTgCsdN0DaQlunE6E9z1kMGg5hHFnMBY+mAXl5VPlEx88/d9ruP0AivIWq9Xaa+SUfWF7lhe9cUvx8uc2Hc1Fw4nexJmxMpsEiIeqAEAZp5WPZFd8rKPxpyBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612683; c=relaxed/simple;
	bh=hvVf8TlLuGjoIz83VTaI7zq1/9ObEux431OnwSCmqt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rla10oIhsnfJTYbztRuWgEJgij3DFcWOReWlVCi8HIzQF7di9KC84ZiwGtIdGxi3RT6LJDMMuhUVRUWWQGNK6S/lfcvk3kPzqnNDmKXGUjTKW0NA9CrrsfmewX5aAGk5OxCldWlSSbF5giVZht6QmWFnHkHK4s/JJMBzhM8bMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1980070241.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Mar 2026 00:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612681; x=1773217481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7u7uhYwMdf6c4DLmq4MuB0mDDGy2FQPNLYh8zUmWGI=;
        b=gaN7BhTPkY3vhDQZNoP58dLOkwZdUqH3kxQgvGzQzdNAM8udydsGUvV/Ev7HY8WJoK
         DJK14eRFFr+kKDa9qOvNQzB9HK81pttfXoz3dFuy1fgSPnzYbzpfbChPBHJxGnTlEL9h
         Qloimj/0mhkPqHx8xAPL7I18LpiCgkq60fi3sMyGORJEtJjakcC4Ku8+3u0OTixuedkO
         e9VKLPQMTESIZvYVAF8JE58mBCwaE23Kjt0k3voq7hVTmDyvl97tEQRxHgCNwbUQr1ao
         UAlXbXJ54C3afgdAhz6lgzALH5G2jNiffRLQQM1b8LAGjITB2NYLrjvJNffLUiBNzuV6
         4DdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRJx5eTf+qOmjFTZJJ595B2c5ESfI1tmbhkpakrTZHa5iTbhtF/LeueJbphwD2oC2qSJN39PMLPszV/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBClG1Zo/XTeCjrFfFgrBZuYSzNtj7FkmXeKOd1yXESCoUUH2J
	KlqWu+DOVy1AcC6juY80o6+vjy9PFO4N76grTzDO5DV9bHKxC0BXq+nJCqcQW0jD
X-Gm-Gg: ATEYQzxYstT4FbwPBIh1q3Z5Xjp/9LHEP3qL6Oe9LFbInFgKy++yDz3stZpLpceI32k
	5rvna/LVRF0i0GejvsJs6gxLSaQOnihg/lJVlswDm3uSMdFdzZV0Bl6akuLqsMQlf8yw6ctYcEg
	ZyAeF992bGrZgGr1sYMDtWWVZ1l6g7rhwf2ZS/WWy9LwatuzRRrPn8MtL968lmUvgBLN8U0/Id9
	J8W6w8DpRtg3Au8mf9GhxdyZ3WPtKTuBJ6i8Z1e6kDKRLXoTPMQuUQDC2d3d+U/uvGxP2JAzvF3
	534LnpIym3A0ZUqZJjePid6bSyIS1yybeTszODM/5TWQfkFldci7NK1VrWemWvLXHyN+znPFI3T
	vzycTKDNeGgAzMekIQtesUtCV2r6yyrtTH3zovWVqBd+xHcvmJEAghW2C84IvQ7Xdye+p+tFEFC
	J7iE7nfcBzmLyoI5EW4qHqllRyCQTG9emfXeWU2rUgkIqIj05RAApFpxKxpmoI
X-Received: by 2002:a05:6102:5093:b0:5f5:2ab7:cef4 with SMTP id ada2fe7eead31-5ffaac13651mr473635137.12.1772612681467;
        Wed, 04 Mar 2026 00:24:41 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffa1fbd888sm2307703137.0.2026.03.04.00.24.41
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:24:41 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ff0f61abfcso1768624137.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Mar 2026 00:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNbGbjdyLbJom1XOHuM2FoPZTlMMrcBJ2ay8eCWXJ5VMDJLxOFU67ZzX/FbnpIhW0nr2bISMgclWvH3vE=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ffaaa86250mr500406137.7.1772612680850; Wed, 04 Mar 2026
 00:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com> <20260120125232.349708-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260120125232.349708-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Mar 2026 09:24:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVd8w5EZHbdfzvV_Y6WF-UnAKXroBdZvN4nVXicQq8z-Q@mail.gmail.com>
X-Gm-Features: AaiRm512q2K67vjOqf-uWH841QxdlHR7tR8K1fivAq3UZU-sn0m1djMQb1Zv69w
Message-ID: <CAMuHMdVd8w5EZHbdfzvV_Y6WF-UnAKXroBdZvN4nVXicQq8z-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Jan 2026 at 13:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add SCIF binding documentation for Renesas RZ/G3L SoC. SCIF block on the
> RZ/G3L is identical to one found on the RZ/G3S SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
