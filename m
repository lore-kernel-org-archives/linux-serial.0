Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48012E22BE
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731115; cv=none; b=o0P9GDpUg0zkbXzzzuCy4MrmDmO3I/f2vLSHdj9NUYT4IVZD/fhZhWwi9UIdr9ohhQjo58WXkU9i9tbdzze7nfhFiTcDVC41m1rie2VF1UY5NinOBFFzblh2ewDuN3W2yQm3PaDvYuYpOVw4PweiT/D5grXNB0W1RDWJltoUCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731115; c=relaxed/simple;
	bh=ul7h+XS6GRSBMYFmPhQ6YeIMEuayPqL/cWHKXtbASjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTHwEM1obffNJQMdQdKKqfCFICM0aD9gxBorAtB8I71RvsiydHPsIVpPgR3ZO9TM3ken9ezBmwULU3hJQI9wQ7XIn8ImAlv4Z1kGnEuaO8sCVQ+dsGteJ8sRkdfOcgML5yPxuzIfteCmDfV7+NVpQBSDBakFcihiFrFS47rZu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5db394cf0d1so3400519137.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 02:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731111; x=1762335911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUXGCcljy1WS6CKdaLlHjT9lGZyhiLJv69Z5NYW430U=;
        b=XvgGM0x07JBcRtmmWQUXIduYTps16PfLOHKjv1PVrR6sTPGKloOfdmv8xo9qbWxe0y
         kgD9HsnUjY/y2TtEhQCmQNNUihd5T9KDronQR/Fzk6BeUTzrFyf6qWZb7IMCK1NmPTkO
         zlC2rMuCGVBfbBsQYJnVi3UqX9eJ7XDnpGoCsbUDKlOlJLlx/W0U2CmCJ90zIYIz09Ev
         pRO4ATRTl8JCVzfuLEvZFG/K6m6nfjK+GRRgqa8mmS3Ngtbr919cY5gESW56rJX8qQ+C
         cswUWugmWtXN0Aux381jdycc3L1kP3b82yYrD/Vh37Lbml/Cg67Woh1b4sr0dF3xszj7
         DhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+wLNjhAdfDWPqOUUX6RFHO/R8zOya0S+9EYxGbs/PcvwV4jx/Wxs6+4awbG19jOcbiNZJHK+B8eIqM/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpA3zB41pBXq/C6gx4B8GWhCib7OU9mdlb1nwSvJxlRHaqUg4
	SNK4WWYSzmn8aizewWSblbOfnRESJVZj1gbrbFefB94aoaE3C69cZyzAsw1pLqx6
X-Gm-Gg: ASbGncuEB7AMfbYQtkLxKr358ojqWeKHq5FyOiQ99qCQ05x7iNxcaHKe/SlszJZtO2d
	6tsStlgt7KzKFoN/AIblJGnezb0cktworBkHp30kdO/jpwEyLaTFgN+T14VQr0ab+FMGTkzOXVx
	wj7dw7LU6qRg9FyDtp/Fn8G5o8dfz4iticRWktlfCusFZaZpcuULZb6RxwsHnySsGg5VS8e+WNt
	roxJZPmkrcip3UBMYb7BK9viCU/4kI845W7ambkk0KDYkYlZoBh8nX63X2dn8NpT05B3c2f1dnc
	9CEh17Ok5LHeUIq+ng+LHM81PWzP8HXXp7ksP4LIvjjwrMOAxEFPtaFfM8y9uuB9zL8zc96AyTw
	/EC03fNrKqmBIpxJ41rIthFtyUlTPskCWCoGEoU5p7U8s1b0A51lEW1fYjk9BWEEtxGWamJGcid
	d4q1x4MwAne/rbdpwRqMxrfEJWaPY13ndfMU/hx4u5zo/1noHR
X-Google-Smtp-Source: AGHT+IGiz7hpin072B6mNyZOcfyIEP0rHRL6o4q/rTsjz+H6S79iZTMxDU4NNHNCaaNcjGEdNhTR6w==
X-Received: by 2002:a05:6102:149c:b0:521:57e7:3b19 with SMTP id ada2fe7eead31-5db90661052mr561992137.25.1761731111124;
        Wed, 29 Oct 2025 02:45:11 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934ca2b8a10sm4741968241.0.2025.10.29.02.45.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:45:10 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-934bbe85220so2110095241.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 02:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfXUu73EpOY3AIpjOdlwtHwHYCeg3ZxJFTVdnCenV02iFPIPIOEFeIzH7KGdbRSNTjQi2RzELq4ohkW0A=@vger.kernel.org
X-Received: by 2002:a05:6102:2910:b0:5db:3111:9330 with SMTP id
 ada2fe7eead31-5db9066385fmr535126137.27.1761731109576; Wed, 29 Oct 2025
 02:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com> <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:44:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaxk5mEDFJ3uWwdZYqkhd_jCRjVB55MJmHRZxyWGE=Pw@mail.gmail.com>
X-Gm-Features: AWmQ_bkf4dSdvLrN2gk-FVgCqZ8SF2_j8HOolSnL2gtCu3wVMEe_dcdoAdns_ts
Message-ID: <CAMuHMdXaxk5mEDFJ3uWwdZYqkhd_jCRjVB55MJmHRZxyWGE=Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Oct 2025 at 09:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Drop "uart-has-rtscts: false" from binding as the IP supports hardware
> flow control on all SoCs.
>
> Cc: stable@kernel.org
> Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit message to make it clear that hardware flow control
>    supported on all SoC
>  * Added Ack from Conor
>  * Added fixes tag

Yeah, this was introduced when renesas,rsci.yaml was split off
incorrectly from renesas,sci.yaml in v7.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
