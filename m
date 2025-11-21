Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020282C0F97
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737085; cv=none; b=iZqX7W6XqQYeMmmgvhN6kYBKlRHuIBV00DWt5C4c4Uq1IYQ2czHpAE3rV7a+Lveun6p+N+LE533vQ360elasBeI/9bkM59O8rckbtMGbSW26nrkGeUQ6NCMnG+PtXLb0opdRK7co6rX1sQCQkWLHOuAVV4pJLwn7JMLUBObBXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737085; c=relaxed/simple;
	bh=z9Bsa1f1sbWqN7C4msF/pWLE5blDrixbOnRk9RzJyf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+DieCb28Ku/l56ZWwu38lOJAe/X06tdY4C4FDT/OhFzGdFcwdt5U6xzJjf4ISA3q3v2y+pTHiid01WjqmkaEIRx4VbQVzQBG/88tAHS7vS7YtlhS/Be/oKmCqafdVBF31c9Uxd23PVeQGnZUKXavITLmpYK5sJ/fOcgWYp0V2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-55b09d690dcso708741e0c.1
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737083; x=1764341883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfkyv/tryLawD4Q8sssLn/BjejOMHRpCzq6qtJXB0XM=;
        b=DxQ3hmlmgvZmeKq1Of94tgecFdIKNLCw569PEs4NVB32pa3Sth1Ckty7vtdYzHBisE
         LZyrRX1opHByLRlsL2PfSiGC78aVQF3+54PWJuHBZ/Dsnvr5yqdDxL7zZC3VzkxI2MCb
         xBMMZ+Z+QCKQ4Fts3uy66rP3xkZRXoNvbXaao3n9dn3Sx3tCxp1Mtu6lm9nfskRmGuvh
         SW4UIVh51kjyz4lDWKG15GFte7ZGascBw2SXN9WfrjihjRvD7IP8uJ6bBF4H1+Xr/pv9
         vV6CdOnfPBtU2eO+JfvOCnebMb9FDuo4iJK3lk4yVLm/XBsxsrrCiq5qjvtP0OgBAGfb
         Wc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsCM1zKvPJ4hU0uDUvFGmIun6/9Db/KZZvW8eRyWaMqTWQLqOICfYO6haBlufUkmTcOgQMB7GIOA92QNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82syZwEAy+/qDrx485DYMERJqeYZuzYBjNIbMyWS1UQ5Fdx0f
	LA8DLigx+DijE6/OcrnJbSc+wvxy+uOj1w7deV+9NgmiSDRuP3leh1ONPFJ6zIb5
X-Gm-Gg: ASbGncsdB+obYifTvNnxK8udk3ApyhG8alHottg7fI4Jg9IVBuMSU/9aRBVzXzPM69v
	MeAREwhU9EH7gUYKrpex3sSTlyOzcZu1Wvac098ScfqDJLBsTVp4mHZZDEnItRXyPVDax2i/r2U
	xwOtzj64Lgfe6fYs/FNVD93xECj36yWaDRZE3GiAfBACCuBu5cnEdm1bUEk6twGixoSfJEVRVg2
	/b1KD3UqKaQPie8v3qHqpNlvtNdYPgQBJWbPRW74eYLcvQb5OCMcou1B1Jovw/r+03CneH690e2
	/u4S4H0NPkxRxbLYLKzj5hnhVjM4U/0amXzWMRE8pdO3D+EmIEpY0AzfywYnufXapMELX+aHKn5
	h6vAg5fbLi6V/6GO5d4XFdENyyw0laQhq2EgIyb4+v25Hf/SHwZwHTCb2cgNk0NXtEVNtLfzOEM
	tuCwjAH21kMyWv/oOWcm39P6cahmsX2f3plnkVZPhdBjJ0ikuO30brJZ/cWIT9/xw=
X-Google-Smtp-Source: AGHT+IHvFxhwpxRrfdNpr5BNFmukFB1cWDTdJtRt4HiMVQiPASx06Hcuby3TKo8e76nwucYmlx29Aw==
X-Received: by 2002:a05:6122:17a6:b0:551:c3d0:acb8 with SMTP id 71dfb90a1353d-55b8d6dd810mr800869e0c.6.1763737082755;
        Fri, 21 Nov 2025 06:58:02 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7d2356sm2526395e0c.22.2025.11.21.06.58.00
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:58:01 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9372149216bso1299636241.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:58:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV46KmJZ2C6XKOuVOOiLpIhLmA9sr/ZAeyorl0kjVnMLYxpGBHYEGY32hmd5VDuRXnkpUmGWj8czXtmKfs=@vger.kernel.org
X-Received: by 2002:a05:6102:4411:b0:5db:d2b7:9511 with SMTP id
 ada2fe7eead31-5e1de48395dmr710558137.40.1763737080699; Fri, 21 Nov 2025
 06:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-5-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 15:57:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUd6_rWDaxGTjJVJjyfup3rt3vzUTMz4=iBXv+w=7zwQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnubWkdNicuBkriRW_L44RQUxMnm_IjfWKVeClWPt4dx3flq_ZzdcjFRkk
Message-ID: <CAMuHMdUUd6_rWDaxGTjJVJjyfup3rt3vzUTMz4=iBXv+w=7zwQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] serial: rsci: Drop unused macro DCR
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Drop unused macro DCR and its bit definition.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But I am not a big fan of dropping register documentation.
It must be reverted when adding RS-485 support.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
