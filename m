Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66F30AADC
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737303; cv=none; b=khPkREQ6sOmcMqcJLMDrdJBfonlvxa3fMu/UOKRdC3o+GiGDBlN0qDQ771E+tYfzgQ6s09oUzGg643xl8VhqX4x91Pop2eG0XrahK0Dqk+lq1ByTeDuCozpQeFIPrUyFCLdFkYBNdL/2v5adHXfOKsbr2pldTyBHtmP4Rf7tYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737303; c=relaxed/simple;
	bh=vI3VJBqMB6UVFPD9Ba7gDnFi+751P10wK1XAYBA0uLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HleLIudLCNJBu+I350wcsQA/1+duNWYw0zKMHHK+vCQZIsvqix7WMb0az7vf26pkufZeO7LbWKbdDtH7VTsXvyCaIswQzvw0AS1RVrhRt7tmKzWLwygxASJcpP8yNV5HWl02brfm7Yz7LDCxzpfJu/wbu1yGJ6asta+2HpdJCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9372634aca2so655051241.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737300; x=1764342100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hu9/ZOjaCVFQuFvvSTQPc5EwpvfeC5sctnt4yJdwpo=;
        b=JMoD2Nfb411+mnGBFfsakfUdCtgr2nAn7SjoCATKi3Hi2mgecwPmLH920rkhnmJqyP
         vF4KU8l7eEAOcOQ/IhJtybhJpFElzxIez6kS2gS/UyK6dhkL4IBnB39yE0rglrAdJBa9
         XZuEfssUyc2luobuDdQXkGu1d+x7c+GX5oRTJtdPQotDb+DaX8adjKd6/4oebxNaWYOu
         KHZu8dorAPigH2iBjmUKHrKiyZg70fBu2sSZPGZgQa0sjelidBe7oO2Sg4IFgfHqYeL+
         2VOkoFrd8rAZ5KRpCGLvAowwkjJH7kc5VP0D0LMSz76cGKTiRvB6hwg/WYl8+1cyp2Rq
         VzVA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxBjbag5RWFIR9ohscR80oBvX1wY4DVmRJtafypxPLjV/3auZQgECbwqG4eN6iI2nvUOBJwp051/cK14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuItA6AqZqK4vGOU6tkg95q2/z7Nrf8Ghgz9GWvKYd9S5S9FB
	WFN4qnFhNufxsjwra2yTZpY/g2o9PJ47XHgnwMVWSigwi2spzTulg/2mJKboP6p/
X-Gm-Gg: ASbGncuneojp/zkv8BLktl1V3mb81qDYvfy757pcTGW5UKEBJb0ScP/WQ+dutymTLbu
	YBr45aHGVMB9igAPva1LNtB/YY2cR/9cTmiqOe7Qt5PQ9ZYKFrSKsE16lBj/qGFaqjM+bNZXIE0
	+d8RkoUhraYH/yKRyutVmlJ0kJjaP3qBbxp0WwqPOaQrphIEjddc3pYIII8DdzXJROA8gxPUYEY
	0UXWSQvqXmmWcb/7d7mpx5oA4ssPOGt3rcPnTwtKkIk82hvfGnbbOZ03vi+W2rYKoYp9wnFo8kH
	zwjFUHvWepjfbQQTfNkRw5eUFyjzQSMJdBKSaJtOjNj2FimKYq3MEENzASbY8idnUjQ5kMQzecl
	fefgtiedjhN1dZTVpXuQQ3toh4FLi9kwtsPE22DivhcPHpvT/Kec+Yqud16/YejWDmZRZKN7iGM
	Swr01CcgXGuEOgM7YRzG00fr7F/SLaQhdronb2ym2mlYmo6BbWeO59
X-Google-Smtp-Source: AGHT+IHLbj8MVE0r29OhthcZRrthWprnRA6EZVKbOQQFHkgpdH931fDKZr5txp+7W6CYil3Eve7xGA==
X-Received: by 2002:a05:6102:946:b0:5db:a6c1:5b13 with SMTP id ada2fe7eead31-5e1de3a39cemr790844137.33.1763737293901;
        Fri, 21 Nov 2025 07:01:33 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bddab1bfsm2207549137.13.2025.11.21.07.01.33
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:01:33 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dd6fbe50c0so886343137.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:01:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZr5OoiOkpNhPbwxkQotMMgvq1ZKuItTrJ+SH7nOwh9xOg2JRPHJV6J2akeq9mG+hl9S8tcp5Ge30OTyg=@vger.kernel.org
X-Received: by 2002:a05:6102:644a:b0:5d5:f6ae:38ce with SMTP id
 ada2fe7eead31-5e1de41851dmr731948137.45.1763737292917; Fri, 21 Nov 2025
 07:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 16:01:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEvF1Yj3UQdiOGSUS5XvebTGgxNYL6aXO=eot4pVWTfQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkASQlYZ1Tl7IpB3SsrSPHfV8TVI0-GSyVXBwHUiWQ3H1THbLLQ3yOuRbE
Message-ID: <CAMuHMdXEvF1Yj3UQdiOGSUS5XvebTGgxNYL6aXO=eot4pVWTfQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
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
> Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
> existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.
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
