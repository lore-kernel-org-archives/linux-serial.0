Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB551814F
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069626; cv=none; b=OtuzvLRxcsqUaHCzDZjGeECfK59y/Pn1dNkEpsaj5r9i+JBk4IxV13vn225i4jHkAYd+Cp6EQeiBQL/kDrKoNETMImV1q0IiXqtkc4jQUNsbu+17IGCDl3HL4XyLXfTl6rVyqgHq4us9SK4c1QSu0bb00vB7e0BBWOEPcNwEpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069626; c=relaxed/simple;
	bh=fttiZBNkYD6sTLyS2zJ73b2MnknfJszx/6K5lwFPaaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/qFL1RGDjoe6rIgDLrOzpYUYIKs4O1C540pEWrBBrH4x07n1wBpxwyWqETK806D6tlk8QAwGRiXDB3PFLTcHzGChFKp9Q10aZy6swXv2d31wS8wfgFSFQ++QWIMuR790NjTHCjufHW1eD0QgszvOxAd4ht3fyRvLtxc7ZVJ9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e519c39196so1642883e0c.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 06:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069623; x=1792674423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CSztrjFXDe2HY45Azvb46Y0IflWP3zkhLimwwlwMXh4=;
        b=CkxC75eNyZwwVQpudUPU1yI749rR1WJcw2p76qfFVqg1UDptoAFtjGidzTFvKnkNdT
         GW/ZAjgMQl1gq/y4ee/IJolIM3QqBh6l/jBoBDnTQt5oc9Nlh2I7eMDDSwaAUHJO6uQz
         vKR2Syxww6jqItt2XjoAUpBS78+L5XCBVimiefDPixtAWWet5AIkd3kLsXy06XzdZNfv
         0ojXf/4pw0hwY3ZbaJMeZgWUMd7Jtu2fhEeQpdllpLJKotSLE8boxWysIPcojttEMqPI
         PewxzdDIbdykrr4vuJU9DgP7WjKCrLUvXuLZOk7zeE1jypb/1bn/hb7QvyaPkXc7CoTZ
         VGYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrIRTFUJzvOagIOULHaIT+iZPYjsWSmEUdn3crxs8pv1/XHW4M2RDWVOhxKej6+3PaKKXl/dp9q3+TjCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEOY1kRxhPD1FUvwS7zrIH6J+RwoZQCrdCt74tm2d89YSnaPQE
	EJJbtIkXsZAsXAU8/JeOYZ6C5CWi1xdN8IkALOjFeTksxQWgM9xKd2qerPLpRxgFuGg=
X-Gm-Gg: AYBFou0RO5ZpjaFriE0LOUKfTeD0YUPC2Hcma5R4T8zG0a7ghMUJ52ofs/4hwUZJT3n
	AMbFhl9dey+5ZzW8sY8q+Lc1cqCNq5OjYeNPKs4wuQ8oJGuCWGArb1H0Gg52D+lBU4P2koEv0Kh
	MLncGjlWiHsG3ZxezWzapI1Gk0vMb9HKTSMP4xhtoZckBHCLsiOvKNMkkRfnYUlIZCZU1eBqmOY
	EM7pQcLdxVI93EdTnI1WWUYHg0QHbfGDE5WmxHilxqP6c+Y571VLDj5TxjPyVKk1+GBikZe7QIa
	yMJAW/fxZY4JaKiEcA0BAQRtTv+moHdvQwrP/c5yT95QBZq9Z+vNmvHxwA4F0y5ATdcanPfTiAE
	EuoTyKdd5bRF9lqi4D2hfbpQf8XQdxOe9qf8u2cBwe4Wa+YVokfx/Fn7hcQZvaBlpjJ45ZhesJe
	s8uYBpil0R704mgOmBvq2cXLyVdvWCsuleSMYCfNo5cZ2QEbNkUPebLHvyW229NeNAuPWDNtlo5
	gUaQjZWf8eskpN9RGfFYp/bRjyAlL8VOQjvk1v92A==
X-Received: by 2002:a05:6123:2e6:b0:5c9:e022:f642 with SMTP id 71dfb90a1353d-5e91efc3525mr6169116e0c.0.1792069623425;
        Thu, 15 Oct 2026 06:07:03 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea962bd243sm181367e0c.5.2026.10.15.06.07.03
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:07:03 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e948e56af3so1624101e0c.2
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 06:07:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzkUFKFdEciII9qVR1xbF22AmgLPhLUi8Ot0Z9HkeuCePReTfeR8dSxnbqqpQojC/Q2eEfZCQsagROeAJ0=@vger.kernel.org
X-Received: by 2002:a05:6122:218f:b0:5d9:82c1:b343 with SMTP id
 71dfb90a1353d-5e91f250d84mr6152791e0c.1.1792069622761; Thu, 15 Oct 2026
 06:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013120831.1046590-1-gerg@linux-m68k.org> <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll> <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <20261015-adamant-realistic-bettong-a24c4f@quoll> <4e9b365b-7c5a-44f4-bfaf-d24e9162fd94@linux-m68k.org>
In-Reply-To: <4e9b365b-7c5a-44f4-bfaf-d24e9162fd94@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Oct 2026 15:06:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW84xXV=msd7Sc3BY+50e-gxFxc5dKL7anhrU893NFVaw@mail.gmail.com>
X-Gm-Features: AclHuK-L4YrCSikdmKp4uyJvcLx1JbdRSylRALstebroE1ucg4vSZgEb4WIoJHw
Message-ID: <CAMuHMdW84xXV=msd7Sc3BY+50e-gxFxc5dKL7anhrU893NFVaw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Thu, 15 Oct 2026 at 14:53, Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 15/10/26 18:56, Krzysztof Kozlowski wrote:
> > But as proven already on the lists, no it WAS NOT tested. You have clear
> > a warning.
> >
> > Otherwise you claim that tests shown errors and then you decided to
> > still send it with errors, so then th enext question: why do you send
> > code which your tests tell it is wrong?
>
> Sorry, I have no idea what you are talking about.
>
> This series of 5 patches was tested before sending, on multiple targets
> that use this code (obviously all m68k/ColdFire platforms).
>
> Just in case I missed something I re-ran testing with a fresh 7.3-rc7
> code base. All 5 patches applied cleanly, with a clean compile. My testing
> showed no new problems in normal operation. Granted sashkio did find a
> couple of error case checking issues that you just do not normally encounter
> in practice (but I will of course fix those for v2).

make dt_binding_check dtbs_check

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
