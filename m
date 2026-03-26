Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F237E2FD
	for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536480; cv=none; b=ej2Lu/q4uwY/FwbzroWLQdaPB4HyIbj5zhh2fhP0g439hp59orY0WTx2/u9oqtBGsXJH/5s+jNTpGOza3XFZn+s72LPOkC7bcVOvxsMBt1DVTVIPFSgMuDnh8Dx6c+5smqGaBSQfeBaeX8ZqwhlH7aSoYvSKFlxcqIdOZpiIv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536480; c=relaxed/simple;
	bh=Mz7743cLHKjDcfZBNnXTh/3101R4N8P42GWsc5M0tE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PORzb99iPK/qvb+d+Y9s+EcTb1gBH3oNtFzBnQ/X/SVip9OQJpIUq+b2ZQ8LZMWenPZKWCukF+GhvaISo/wcUBkfn5dNmne2f1bt7KjAsdtO2QAqhoBSatLNyJdZON0q2U9r9NoiZFacDUZCxGEBJcCwgTWhd/ZIQ/o84WMuyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6611f41eebcso1371329a12.2
        for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 07:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536472; x=1775141272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE2E786ICpZIcnAV4rwWupP+nyLC84JrXsMF73F6KhE=;
        b=qRy/IvsaBlC/pksXpTBrP/whKlHipioDSS4yt/nctGeKUQ0CuP5CQIoRqSZCwhN4KA
         oSMItSH55HLTX6SSVbjfCLWwZYPbRbkJrg/8vM5UlsvAGzsMtJOg6QuGZOdYqs8H071M
         rr7jJGAtvNn+UHcQ2bpvR7SMBxDvTg95M+X84aj0ZjNzUySXqxt0VkusC7CmW8AWMepn
         etdfzjv4oo2wMVq7Y6u8PRlgR2hWnVWVGsEnzpnBLYoJ8QzLyXGdcsfjYFZ2jQtT+XiN
         LWOGQbvfaP0OlrJwTAiU2aPYcqKPJaPHMX2RQ1OG5ckNWN243+VroSZz6t/4wa0MtIG1
         x+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXBtw3TKcshlU9Bh41SdLhIBq3mravkjTceZYLcoXucbgyfMwDAheXDA+WbJss0j65Nbuu/rhBQMnIhL4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOTWKqA0Uyd8/Ty2KrE+ZnBmbPj80oXRPOs7O09orZf109jR6
	ldVTMQYlyPSZrJhTLOJa7VK2hqHdljX40fXUB+SlNcpOjCZnxO0lyANDGUdd9FI/jQc=
X-Gm-Gg: ATEYQzyrZn/44bxjTIgtQTTehi8UQ1LwXDjbVfM6mU9gnNqpjLJa5rnCUsmxmgi1/A9
	0KyNHYuwcXR0BRxHR1MclYpRV2FbZIFmEW7CvRy3rs0QwUNXRpTbgWBPYvVEGFEgEXoT2liE1kN
	hXQDGKqfSaQplJXMQrVb8o/gkCm3PVYxUqve9BR6LN8+sc5KPJUB20oF/D1xvVjEPS18fL8KR9R
	wdD5HFbD2d8ca+j+bjsudS383ROWJ+IYzOrPNbmNKtZgY8l4Hko3IYEnHmsNwiB/L9uU7vIPJq1
	dqyaY7IC6cEVbnPkwWqQNo7tW58ZID8aZT7lMH6xyYLDt4HQArD2nACocnkod8/MuzB3EmoYWiZ
	z5cdi///FMnMk5ldARuly4oTamcsPN5fTEVezvPnhzjsmK9iAx0UzgF6e8Wzr1yWEWOTkmqktgO
	W9YrWMTt2OJ4Sc1vNtAqy2yx4nvGaaoULwdY9Tz3qmARoxi1wNBMBOUOh2DM38
X-Received: by 2002:a17:907:8690:b0:b97:e4a9:baa4 with SMTP id a640c23a62f3a-b9a3ef39891mr610450766b.0.1774536472015;
        Thu, 26 Mar 2026 07:47:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b20264ed6sm129384266b.20.2026.03.26.07.47.49
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:47:49 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b05026e82so1304153a12.3
        for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 07:47:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVegwszbZ1NN/aFYzzP2DSOLyVZR8F/wh75ruQYePeFl14tGUdfRYGvZlJK65rSCLnBs8prjdi3thM2WrA=@vger.kernel.org
X-Received: by 2002:a05:6402:400a:b0:663:6d0a:6f97 with SMTP id
 4fb4d7f45d1cf-66a826e17a4mr5435034a12.27.1774536469098; Thu, 26 Mar 2026
 07:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312082708.98835-1-biju.das.jz@bp.renesas.com> <20260312082708.98835-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260312082708.98835-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:47:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUV9XEQQb6bX40UoeNrs1DsueLWXcyY8wMGmrW54xPD8Q@mail.gmail.com>
X-Gm-Features: AQROBzBG2_5XR9iswvQhc2D8hUfkOYm4fbALofzpvMNtbuFoQlJK3H7uau0MO3s
Message-ID: <CAMuHMdUV9XEQQb6bX40UoeNrs1DsueLWXcyY8wMGmrW54xPD8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 09:27, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document the serial communication interface (RSCI) used on the Renesas
> RZ/G3L (R9A08G046) SoC. This SoC integrates the same RSCI IP block as
> the RZ/G3E (R9A09G047), but it has 3 clocks compared to 6 clocks on
> the RZ/G3E SoC. The RZ/G3L has a single TCLK with internal dividers,
> whereas the RZ/G3E has explicit clocks for TCLK and its dividers.
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
