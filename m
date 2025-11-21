Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EA2C08D0
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742540; cv=none; b=PX0w9UPu8b6wABcxNIJuuiKFvNA0k9+4uIth6JiaQKwFIdT9quB5udzxiWG2HB8TqCXKSYToq8B9WyWItki430QUzhJVYSRG7W2/+h57m8w/QdiMuJSgD4sCku3u/qIlOTY0b/pYKoQ3rIylJeG0zuBAZZ2lM2z3I8rrrSBm66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742540; c=relaxed/simple;
	bh=NWw8ik16PpwAnJNwq8h3jV3Uy7b4CaBzlirDZLOFbQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI2W8XyV+c6PlBIG7m8WHawhRoECgFeDakFHChNbEv0g7eCRknzdQ45NRNHxa3J5KmThIfkpJVrN7qeOWqnbos97WSeikg47lp7+0PsVIHeb0vZCYNqX4G2/XMUs9RBmjOZn0p2VfcGb4wjrmfTdKrOQIaQm/8qzVU9E2JhAJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5597330a34fso1518173e0c.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742538; x=1764347338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA6je4+07ukFpFFywGC1ltUCAr/0ji7NhVbYppEStBE=;
        b=hiP1uAqlMYb+2rkD8jxhPboW87p8vj5PA1SBAYkpDL+P7u8WNaOMmNVyljTMf9crtl
         XlMl8sLYeds5iSoNFQ77qb+jyUOCd39wc2e5JG2tCcNBG/zkzv+afeRg4ohDFAkMoivI
         6svpDBMS444NUMxhzLI1UyDzsVHhBAOD1LG7VTDH/A1gWyvpyYZ8KfDbYvHC9M/sWJUH
         KvyC/gK+lCtHu9Bx0B7fMX9J/rFVDbunbZaFgkWjsmwxPhr1wfbhUrhitEnnPb2T9CoJ
         2iPY2G63KGakCQ8X/E33K7bF6SSZW+dkjDYaEGjVNGsKWefbaRGN7bBXUQqmESTtd6TU
         WqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmizCsSg1aH6/sKqojz35bTWP21ICF1b4vQA3hxFPj96Mr8ObHTIk+H/IfihGgWg+AGknaduVCZYX8dAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCvv9DkaWQHbnQNHlFN9XerNBa6fBe8epJqWsd/i1TMZXb6SM
	HWZOUbdnbn8grM3ZxGTg34D5vyaqOBjBHYHaX2GWCgwPf/UiIJ+HiuTxSmOjalMb
X-Gm-Gg: ASbGncsOQLeDseQVgZoiqGzEnAmp8ydUeHiSiVK0zPDLxNnmHm5FvoooiKAg0uhpzNr
	XiMwLFPe1Hy2ElFHfgWqGg01Ji8hhpjgiIQ++reqk9ILUeq1OlKSMBntCqo4ks/wo1C+tvWXYZV
	Abq+v9T/0Br3Rdwa+hbqDIQfppU7AHY1JsJexu0IU036gGK1ndO8epwrTKo/RxzJEOVDqssnX2t
	jvKtd5jlERTRO02fSshpc18J38es8Z9pk9HGfmic6ApnygIqJUexkdMnbXFkKgJ/7Dj4RPdxo5U
	gqTwjzLMEjP2rLVrOfOLatrYz7k07MwG7AYPpcILRx7hMaFpLR/H2xVHlvcj3OX3nly30wlG7AH
	jbCpbRzfA3jQu42hPcMNtTaYWUsmlfcszCxKXn+SmAyDmnNpqBVI7q+HI1miLf0wcm74+V+P81O
	CcTn9EuuVgq5/sGUQRqcFcE6PFjaLwjrtIEJNMcENhBTjb0VNS
X-Google-Smtp-Source: AGHT+IH3L8ariR3FNWdgAbm0x62CLikt9etuBaywMa7rk80O86XGW2ZukiQWQ94q3Hb68bgKb4vvBA==
X-Received: by 2002:a05:6122:3bd0:b0:557:b52a:d553 with SMTP id 71dfb90a1353d-55b8d6f83e2mr1134873e0c.7.1763742537838;
        Fri, 21 Nov 2025 08:28:57 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f6017e2sm2658242e0c.5.2025.11.21.08.28.54
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:28:54 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93722262839so1280828241.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:28:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWin+WWvyYOdcUMq3adBj/wac+TMbLatBX1oIrDRba0RIgcx4gJMxpX0/suw0JzpRfk6mDcbfupbk7D2xk=@vger.kernel.org
X-Received: by 2002:a05:6102:5345:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5e1de22445dmr947156137.6.1763742533900; Fri, 21 Nov 2025
 08:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 17:28:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX41rq-sd6_g1oCrQVPpgb-MXakpJ9mEbS0K+FY8Q7NDg@mail.gmail.com>
X-Gm-Features: AWmQ_bnV2vaF4HR2BzUmue1a6MqXZNYW6rPMe3_j5Cfe-VvhmkJ46vgiHI0AFsM
Message-ID: <CAMuHMdX41rq-sd6_g1oCrQVPpgb-MXakpJ9mEbS0K+FY8Q7NDg@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: serial: renesas,rsci: Document
 RZ/G3E support
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add documentation for the serial communication interface (RSCI) found on
> the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
> to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
> to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
> has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> @@ -10,17 +10,16 @@ maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>    - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> -allOf:
> -  - $ref: serial.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> -      - items:
> -          - const: renesas,r9a09g087-rsci # RZ/N2H
> -          - const: renesas,r9a09g077-rsci # RZ/T2H
> +      - enum:
> +          - renesas,r9a09g047-rsci # RZ/G3E non FIFO mode
> +          - renesas,r9a09g047-rscif # RZ/G3E FIFO mode

I can't find the non-FIFO ports in the documentation?
Do you mean "Selectable to 1-stage register or 32-stage FIFO"?
Isn't that software configuration instead of hardware description?

> +          - renesas,r9a09g077-rsci # RZ/T2H
>
>        - items:
> +          - const: renesas,r9a09g087-rsci # RZ/N2H
>            - const: renesas,r9a09g077-rsci # RZ/T2H
>
>    reg:
> @@ -42,14 +41,36 @@ properties:
>
>    clocks:
>      minItems: 2
> -    maxItems: 3
> +    maxItems: 6
>
>    clock-names:
> -    minItems: 2
> +    oneOf:
> +      - items:
> +          - const: operation
> +          - const: bus
> +          - const: sck # optional external clock input
> +
> +        minItems: 2
> +
> +      - items:
> +          - const: bus

Figure 7.3-1 ("RSCI Block Diagram") calls this "pclk".

> +          - const: tclk
> +          - const: tclk_div64
> +          - const: tclk_div16
> +          - const: tclk_div4

Perhaps reverse the order of the last three, for simpler handling
in the driver: each successive clock divides by four?  (yes, I know
SCI_FCK is not immediately followed by SCI_FCK_DIV* in the driver)

> +          - const: sck # optional external clock input
> +
> +        minItems: 5

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
