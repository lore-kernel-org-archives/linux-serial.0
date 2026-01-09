Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3401E633C
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965303; cv=none; b=lFq/ztHcw/Ywv6BL9EhUZpp8vKli5ttU5OIhSl7u5QpXpdsl1lXoE5ZSrc/OedHtwaNnb9czb6NhebVnpdgWD90l4k3prwvOT2INTlGCWCI8+7EMhh3UheCwWyT8Bx3fHraJd9/v/J4cVW2YPRxhm8Kd6tw4pJP9rqUZmu/oMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965303; c=relaxed/simple;
	bh=1L4cZo3EX6X2INs8QItbxpM2uckTHwqOzvEIQWAvQCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg/bQuy03poyTl50U3lA7dwJL6O1Hdv8lltAOGwynA9bpAz8N5b7VnXS4nU3EU6wnjvS1mpSs/en+LIw6cPZbpUO7TppPEcdefuGySl0T28f3OVkkoOfPbArXvurmJ1O/wjYKdeiRKX1k33uWf9XF9rSs+iptQmomBD4dAAVNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5636dce976eso124791e0c.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 05:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767965301; x=1768570101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNFPugqE664J76/2PrjHrid00raf31+fo6rdSr79tJE=;
        b=rLozLgw4wipZqAoi40YFCrGYB2bdF2JwzCAGUSgvr7bUhoRic+v0NkAvZqK1/2yIKK
         FKZNQ320N2SsbN5yR3SIuNCsDjTECQzw6M3+u6CBltE9Bp4qL2RM/ASn+EmOc2qBW6Ew
         g2BwQAhrx7yNklDEDvcxuhy03kxPEflsaCEcXbbxJReJTWajiqypSxRc4SQwgEboSL8/
         L9uxloS3faPfzaCe0J0wlohzWZ5j8TiOtBQheKXmz7DWS0vdjicBzK4+X7QhbXvAkyu9
         S82LWUDsqgZ9vxB6kSd0sSRfd3nBHFwg0ZlRxZurGGIxshJBOdHXhEWJossoTKUqHEGG
         VI/w==
X-Forwarded-Encrypted: i=1; AJvYcCXSLpWIDl5f0kejRLfzHUViAggkrfGzq7CGxfZtfuHGrZTzs+pYwaJmuHQvsWTF421V2aKajAC5FrGCvXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos56LdDPMMQGw4U/Z98Q+7TYBzT4skiFMf8nCfhNwZ84++cDX
	Xprebq+XV7p18rW8AzXYa6sJGdm5A1WFDu/UXS+b4skBa9Vmek92TTDvNsYbC+lR
X-Gm-Gg: AY/fxX7/S40a818mYx8qbkaHrpehLB8xESbwDo6O6rYoRVSR6D0Edrm1XEp3gkPmaDJ
	my2Elccrnt72WGmF7SGZ25oZv9d9+kpYOCOJy9cRflQzu7A5WoBta1XvwTeyzA2tw6DvZRdyZzr
	Qt0rI+0N5+XLA1rGjzn9btcWQHpIHq02IRdXLr9DIzB6q7KGUGoCwnrY6WPUHKsletFzrhkOS0q
	FLkYQR6qWZayHf/W4Tlt+Pu74g9TsVkpB8erJ0eQV/VDrvrI8fe/v0YUNRFV75y0v//J+HgG3aO
	kdXf4d9p0sj+j6BZuxsDNkHqc9Pa7ti12lQNpaumo0hyICxOsxs59Q3jKkYeJ1I4MCPb2F7/+Pf
	gLaEw+Rbf30PdpjAFaKYmzRVd9IisdR263fWgez7Qjtk5cJdHr8/iazh/P8G2g/RlHtsSxVNEKO
	2PoZI9NuZLzmY/Y1LiCtM9jtOrqjUlNzBCdQJau7J5Kbfb/XoI
X-Google-Smtp-Source: AGHT+IFt+wy7NWOReYHNsWLR4LPIRH4vCPcueIenHI0fEMXGB4rZmls2VTmqHQnrSOrdM8kX+WOQug==
X-Received: by 2002:a05:6123:54e:20b0:55e:8569:4dd1 with SMTP id 71dfb90a1353d-56339d8a269mr4035928e0c.1.1767965300452;
        Fri, 09 Jan 2026 05:28:20 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5635bd72c7esm4005499e0c.12.2026.01.09.05.28.18
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 05:28:19 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93f63c8592cso2006646241.1
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 05:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWl1MKTZXCrVgFkwwnF5lssyG2VfrAFVkoBjpHofpy/flm0TGkMB2j/TSFYh56rFHqweyITcL1qgj2Jjhw=@vger.kernel.org
X-Received: by 2002:a05:6102:4485:b0:5ef:233e:6b25 with SMTP id
 ada2fe7eead31-5ef233e6e06mr1027510137.13.1767965298725; Fri, 09 Jan 2026
 05:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109123828.2470826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260109123828.2470826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 14:28:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWz6_NzvjZNMLk+Bqoa0NR2CKNFwDXynfmrTZgOGsqxTA@mail.gmail.com>
X-Gm-Features: AZwV_QjPN-Mv2BgxTufNwYwKmRE2uazISkHQ_FJOwRqpRjGwaHZxOt7DyuKNXD8
Message-ID: <CAMuHMdWz6_NzvjZNMLk+Bqoa0NR2CKNFwDXynfmrTZgOGsqxTA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Fold single-entry
 compatibles into enum
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Fri, 9 Jan 2026 at 13:38, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Group single compatibles into enum.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -20,6 +20,8 @@ properties:
>        - items:

I the "- items:" can be dropped, reducing indentation of the block
below.

>            - enum:
>                - renesas,scif-r7s9210      # RZ/A2
> +              - renesas,scif-r9a07g044    # RZ/G2{L,LC}
> +              - renesas,scif-r9a09g057    # RZ/V2H(P)

This block now indeed contains all single compatible values, but it
is still located in the middle of other multi-compatible entries.
What about making it the first block in the "oneOf:"?


For the contents:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
