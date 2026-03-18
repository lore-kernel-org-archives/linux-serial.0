Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90437474E
	for <linux-serial@vger.kernel.org>; Wed, 18 Mar 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821812; cv=none; b=jX4jrB9EkwsrEih+4doPYl7tj2wroqEOnm04oQX2uzWu7AJ/GPEifijkXCpDBmzOntk54xNH93tJALUb7nXWNTKGjqu9COUw6k1V0fsJno7Pf+KPAMXe/DHzvG/EvffzhyxAXh4lHj7USLpBlf654aVIuQ3hawGeOyYRHezesFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821812; c=relaxed/simple;
	bh=KAICH7AyRNLHyx9na4VNik7GvrikW4tPpi3l7+AtXfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZepNgOSyQL7F+ckK3l8UTfs69vUs8vveRWvLVoTUKMscKdEF+SgRn7EGfDKdJiIwMCUDz7gvZdx/mdEQWDeCij3GrdBVwznSqEstkNEFHQF9eLINkxEfZ+nmys23A+7f1v0AR5+fNXqREuk9hCEWp6F4jBJhxmIFr/PPVjIom48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509149ab7d7so54436271cf.2
        for <linux-serial@vger.kernel.org>; Wed, 18 Mar 2026 01:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773821810; x=1774426610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLFVo6AiXNHbx6lUNUpPWDsgWE1jK824gYrpCYtdfM0=;
        b=CKbi3SmlBd13KZoURMxMvIxR/VxVnaz6yHc/a0GdgUlhj7o/R4jTjJxJqKmrWMaIgC
         fOWjyq1FUbQHe2uAyGD5NB0byozYjXUIHd3pTKnm++8B9IMJFi3tWnr+THHptfrUnj6l
         74TSXX8SQhntT2Xe4s3eYCPwdWugVr5/uBJACXt3jLx/XxBZwEd52NYXV71QbXjYP/a/
         OfoP5mJxyTXBJd8qOAfu5wOJnX3pl/3qis5vgCFd8Ll3B+ck5KgUtLoE3XcCW5uwxxsk
         uSiJ0S+U29o55bWUviHukdbTU9/ib8dP+F8fL0kYg51j//D2U6y3btB74J/4o6khjcTl
         zP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfwgWMldZFFG/fkU3yUxRNSSHaIYtxqNHQ9vOuePdlZj9xw0Y8ssuhRKNOLGI9V45Jz3QiS2X8kRvOkbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZc+R73m3D59eeDNlznKxS61ysJtCZEKaKGTiC7ClBvLtbfuH
	SM5tvbd6rv7tXEIhVRvHViU9WNUKOGAdwP68lWuyJWf3qsoJYsF+LexRo4l+gI0wdeU=
X-Gm-Gg: ATEYQzzvkVb5+yo9rCqcDdNxoX50xzZc5dud2GxWM8TbM3fG/XTD4nNPNIbTm8fas6t
	U23eyGp09DjVD5uLwG3yiEh6wzNISMNaXAfDimgiZE5WieJhxE8u0JH94OHzyJmjq0+a9cUzQju
	56LkGDIrizokq7UnuloBF6J3itrJiLzOvD99wt0un8ON4hZSd1dYNj4a5jUMn3xGBh8Zjvf4loU
	UCGMWKW6D4Jx6sVMc5+e1MvaA/uODFCBz9hmKeHdRTxDEScPIJw9e7yz/RRMp2pjFcAdWzcYxV8
	9ccQrq+uI8aM4e99qghcsrfma++xiqVch888Air+OR+bsDys/Vb211dU35zyaIqD6k+s1iIINpT
	/SZ+qWNk/mX+wCCt++Vni6QIDcFrkILVXj/qLtTerk5ew4EJUJDiEkRquEoa1FIfLHBKFTaiQbN
	RCp1NVqKKVpItUE8x5FCayYGC+WQTuH+KTANRlANG9EwE5xZde5uJpsgwN/IIlZ9+p
X-Received: by 2002:ac8:5f82:0:b0:509:120d:4311 with SMTP id d75a77b69052e-50b148c5ebbmr29136511cf.60.1773821809701;
        Wed, 18 Mar 2026 01:16:49 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b1348ae9dsm21005871cf.6.2026.03.18.01.16.49
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:16:49 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd767d2d70so156765385a.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Mar 2026 01:16:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ/y5hwPdKoIzdJj3jyasQG+v3LhFEkm4NogRue0KGYhLUXGpj9SiOiEd8inG0StCyR0TnQcjTiaTeMqI=@vger.kernel.org
X-Received: by 2002:a05:6102:945:b0:5f8:e323:580d with SMTP id
 ada2fe7eead31-6027d1284cbmr1153417137.11.1773821475435; Wed, 18 Mar 2026
 01:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317194442.468147-1-biju.das.jz@bp.renesas.com> <TY3PR01MB11346876072AAF91064B2700D8641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346876072AAF91064B2700D8641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:11:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUiomf+6O5eDUBAt-41D-Lhvnda7w_bbdj-EQppapjdUg@mail.gmail.com>
X-Gm-Features: AaiRm52dBzFdESjaYAuu__pn42Q-OWaaQ-EFK2jgv-IViv74in_nOyYaaSxkIRo
Message-ID: <CAMuHMdUiomf+6O5eDUBAt-41D-Lhvnda7w_bbdj-EQppapjdUg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 17 Mar 2026 at 20:59, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Please ignore this series . I missed to addresses for Patch#4. I have sent a new
> version[1] fixing it. Sorry for the noise.
>
> [1] https://lore.kernel.org/linux-renesas-soc/20260317195650.468330-1-biju.das.jz@bp.renesas.com/T/#t

You have sent two "v4" versions with different Message-IDs,
which are treated as different series by both b4 and lore.
Please bump to v5 and resend.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
