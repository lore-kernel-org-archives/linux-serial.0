Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEC287265
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742637; cv=none; b=dShjxpGS4+Om/Map1o3S67S3alrHe/ByeMF0/kx8wy5ILS4W0XO+H//ZZF06bvmT583TUwUC9VQjKOmvJPBHPg3yE8uy8rMGlnqyBfHQMDYlfBS9Pz0dzy/VPOVX7Z5/S7hTf5es8oJkCjhF11B2rY0C5h27W85Gy1C61vSjeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742637; c=relaxed/simple;
	bh=miUYp13Tg68gtXfjxpodBeV3EU7nr6kyS9YRTomit/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLir5HwhHRmqPro0dOThGuSTk02CSolYlbUALsJJjzkmYbxt383pOXtIZuZY22jtcgccPLQCuZlyfUwnZlDHTJBeuwsZFKHc5k5wJp7Iv1WVqqpXEjH5wzDCxYmR0HHJ9da8Ge3YjPCMWvXuqxYqkluYTmuTov2mKe75lNU6D5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfd4a02638so763037137.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742635; x=1764347435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfme4CfywnSRg8zjFjN1q1faWbrMVER83csGlPhpKYs=;
        b=uzpS6IJV1E83ueqtsoDhaaF37SWb8KWYPMjZdkOv8nJnQNE21NviFLlh1gBl2HxuwE
         fZPkK4rOKpuZlQOYAuM7CaSkwOQdyVU1F8R7r6ouwzWYsVlOsQoBrpeboCdbnlHe5iWn
         kiikcS+rnksj2193tvAnH+wXom6fq11kcGUxZf6CXZvIXUm4YygkPwy4gggZaEQ1IXz/
         JCQk0li38QZEIboGVFS+lftJd/139NdmWeVz/01ULZZ6SFnfXeQJUKp4wP+rBc+wzyas
         yCzSZMiCAFcMsPGI0C7SxWJC0Tnupm+7z+hHtoWg/eYWWQMnYC/sQoSWnPssid9iLPJB
         +XoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+o4E954sMCa7tD6X4GSlTYf/vc3ff50suhBF4qO08Kj9aNXegjbt4Jggy/qPQy5Hh8Mt7cD3AZg7xmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8s2Gq8eR1QUIYAg5T9FOEAv8flj/b6Bv9zoBVJWwB6UaOTyH
	yLo6n0R1tRleQLwcglHuRtao9brt3CoeJyvT/OgDjVHZxhvFXvzBGKrfaMmS8JmN
X-Gm-Gg: ASbGnct1WKA3QOwv570qRJR8GFrBZJsb9YXFRgQSzhrXXHt/fxPwpOQE100tLw3KRGt
	SllOhDdkZz+WJmjF4d3t7xlRxQ9qBTYoEQl4vSixrrYOqTCaU/GfnrmYZpujF7lc5WscLh39ui8
	3Kts+vFXX/YarhEwNppfHb8nmUv5NZk9VB/VBGYGz69JGj9+C2MfF5CfQDXSm5xIMQV/5npMaJ/
	qBHff15o5bJiO/JOolOJ+0qIiiVoEfHqrn5HHgtPWKoJqFT0QAZQufVqwkb2YHry7zSCxFkVutZ
	Qtorhbt3XFYudjmXorabdQWbK7zUNydPKgw6kaTOK1uQ1mmu6cMwdHgD3kTRwgpMqw/QLYIehSk
	Iz49Puqd5ViuuBBFWUQMVGZiRC29uvhAh0dS1QGwmXZU4ZSgQpsX7ZOGvXs+56qLQ3qzKx1uK8l
	5m0hzyc2Li3/h23Dlmq6ix8RNwn2wB/cbPwijv5fqw9yauifz2
X-Google-Smtp-Source: AGHT+IEpXydpwHF/tLqWysIrXHk54GfdG7g6/i0Shh7sissqlbo5utGVLMj80g7yeLsRMdkpqj2Akg==
X-Received: by 2002:a05:6102:c03:b0:5dd:a616:69fc with SMTP id ada2fe7eead31-5e1de13b862mr890096137.9.1763742634935;
        Fri, 21 Nov 2025 08:30:34 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bd96889csm2475265137.5.2025.11.21.08.30.30
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:30:30 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfd0101905so807336137.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:30:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNtV17p10In4EQIUIK3qu62GsF5fKUc2Xfy754w9XPuAH/FPsaeulV5j/0+URXGz3/u0gTsO3t6D5O3sc=@vger.kernel.org
X-Received: by 2002:a05:6102:9d9:b0:5db:3b75:a2aa with SMTP id
 ada2fe7eead31-5e1de1a0867mr893336137.18.1763742629852; Fri, 21 Nov 2025
 08:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-11-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 17:30:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWaJ4Ou01FuKdXMd4WXNMSu4FeF3U7ykpmy4mN8GWcpCA@mail.gmail.com>
X-Gm-Features: AWmQ_bkY8NTotInu8fmLPPbpJHXT1kn4NeHzwLSDXbeLRL28njFMQmX7rlOiRTM
Message-ID: <CAMuHMdWaJ4Ou01FuKdXMd4WXNMSu4FeF3U7ykpmy4mN8GWcpCA@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] serial: sh-sci: Make sci_scbrr_calc() public
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
> Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
> RSCI IP.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
