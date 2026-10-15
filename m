Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DC3CE4BE
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055986; cv=none; b=W1SOqt2sj4wYNQnkqUw8IXAKqdkVs95XGfaQa+dj6ETRe6OkbDGhvpM9nnUPeQbAPdRhk7hFHkBdE1uS0QwVaUZ8II4O63oHrJPRbwRBVNnz9OC36ph6diC2XcxMhfq66/nSlsHLm3DYFqVZajJQgcojBoHQiojmf5clJPeYrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055986; c=relaxed/simple;
	bh=5lFr6N6uEmNx4LE4jroObbL0ac5PVnqi72D4Bu9Q8zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU5MNwrgawVXC5ZpZ4qZIPzYF6r3jrXSty0BLJ0FVaqhwgYLn4UkCZzPjacRvHPDcNInJeFcf7Hd8jwEKVgwLWsZnqlk4Cw1qmro/Hm2yNFnZsNuywtkfWQqBTyooB3rEirzNxk5mEq5Lz0aSt+meD/8IbdsWW6m4HaWui3CO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so1344656137.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 02:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055983; x=1792660783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2OmWvdxf6P4clpTOVRX+yvdQN7bAC/slAXj+OD7VnrM=;
        b=1N9fNIEFy+4MOrgOXq/8SAJSrSZEL2dBzN0IgOcnv23k5D5/RJLnSKekdNQzCaPswz
         0/kMu5M0NE+gokW9R2LNPdntzYHuxhTQFwwW0/IrmOsXaqtYzRnG8x917w7z0FHb8P0u
         VQlq+O3Avm/JpONqT7te/MZTOxauMLIaFPLouERwk4EM0HDLXuvaMMvCuPOBtqR8ZkOH
         HlRT/9q/dFcjLE2uvES6DDmlqOUJk4INRxUWj0zFCm1MruMeVNDubJ4Lmm9IT4CW4iXS
         REokKttogOQbmiUgUi+z8/GvrOIHThAf09WvIkdcNtcJHV/DeEOf616939MIuVHoJyaQ
         TFtg==
X-Forwarded-Encrypted: i=1; AKwUvBwLhe3ITfi5O6sy2i/Fk79ECqdMtdxivZ6Q9ONGC6sHoRCGMrLEcuc3Yil8QPaEFI6gUhyN7Ujya6NxTy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKreW2e9RPBqR1FG5IheC4SImC/MwG/KeEBYoqaVuphcXyyg4gJ
	KFJQMHg2U3r+44voIcgeetz2pXAE7y/QXWFVkTyJZJyVQ37NqsVpu4b0+3hPHwQPQ/g=
X-Gm-Gg: AYBFou1KRPTUX7bsqgYRyFRy+LuUOfVYdtehMCau7RjoT8q+85+XbI4aBBmi9RicoC3
	IfHpRDu5+EjKK+rlCPoMW8DKjdc8EvE1JeMJmmF151mGsXT1LPQq1yOUuIKyUMoyTXPy4ArBkLV
	mDkay5hrPrcXygeYa27Q5Z9VhNz+iRsj2ZtKY3dFWowWhGuU2XGdwx12R4twXw/r+p32zHdBxTv
	/jIu6I4LLD6FEjf82reUJGmeEHUmlVyu3m1CJREdKTObjdUtBZCpxb75+2uJr1BCHZLXMkZXmA+
	bRopRyWXcNP4DkvEQUEwA4VMBWGXyfqb0xWPfoaRa7ieM2zU/6VBNbltrS9bva2l78QIuNGHYJm
	v1ztcPRZMBGPmXGBAhkD1R03lhRX3yXbV+7CCBqPYad4jc6eRIfbRQhMF8xij7zkHemKA6W7+mL
	uFJ0PUKOOSIIz/hscH1wLv6uRajYDLs6HscS69duwCdURhmOdmY7NTMwSc8qim0iG+xTegRZBhW
	15MTWoMaJLZZtvLDQ8UfFMhomSbBeevLpZz1Byr
X-Received: by 2002:a05:6102:a4f:b0:7c3:9059:49c2 with SMTP id ada2fe7eead31-7cb373593a5mr4224102137.22.1792055983343;
        Thu, 15 Oct 2026 02:19:43 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354016d6sm13045455137.8.2026.10.15.02.19.42
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:19:42 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5d7daf06158so1785936e0c.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 02:19:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwhOo4XyASCjH9rLOXbVXcWQ18jEIstfyPme0JqTC3NapQ+Czwe9XhDitivZJMlS/GM/OoOITWAtYQv/SI=@vger.kernel.org
X-Received: by 2002:a05:6122:54f:b0:5cf:54f3:6106 with SMTP id
 71dfb90a1353d-5e91f5016ebmr5648393e0c.15.1792055982192; Thu, 15 Oct 2026
 02:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013120831.1046590-1-gerg@linux-m68k.org> <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll> <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
In-Reply-To: <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Oct 2026 11:19:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
X-Gm-Features: AclHuK98K0mB4QAA_fejEAQ7EVeEI9XZmFZLvangzoC3l8jcNy_b9wBdp9Fm0to
Message-ID: <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Wed, 14 Oct 2026 at 14:56, Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 14/10/26 21:24, Krzysztof Kozlowski wrote:
> > On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
> >> Create documentation for a new binding to support the Freescale ColdFire
> >> UART hardware block. This is found on pretty much all variants of the
> >> M68K derived Freescale ColdFire family of System-on-Chip devices.
> >>
> >> It is not compatible with any other known UARTs.
> >
> > You never tested this, so limited review.
>
> It is tested. It is working and running on multiple ColdFire platforms.
>
> >> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml

> >> +properties:
> >> +  compatible:
> >> +    const: fsl,mcf-uart
> >
> > What is the SoC name? MCF? Compatibles must be specific (see writing
> > bindings doc).
>
> Yes. MCF = "Motorola ColdFire". It is the SoC prefix used for naming of all
> ColdFire parts (which is dozens of variants):
>
>    MCF5206
>    MCF5208
>    MCF5307
>    MCF54415
>    etc
>
> Even when Motorola became Freescale they stuck with MCF on all ColdFire parts.

I guess you want:

    items:
      - enum:
          - fsl,mcf5206
          - fsl,mcf5208
          - fsl,mcf5307
            [...]
      - const: fsl,mcf-uart

As no new (possibly incompatible) Coldfire parts will appear, a generic
fallback looks reasonable to me.

An "mcf" vs. "motorola" vendor prefix might still be a discussion point ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
