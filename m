Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A772773C1
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743002; cv=none; b=ToBOGQ49GdNcHhlZ+n5QIW54dyNmC5p9tBBmLm+WZwdWkApuG0M0nXgzezr9+ttbwcalTw3YwwiYsR5LUuRUjPMejb3arDgdKVXbEqMf3V0tZO5nNDq2uRe58v/znzFBuRe3R3OdjYCN+Ik9RowD55i2OrHBypSJy5sWBKk+etE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743002; c=relaxed/simple;
	bh=lhJnTFSYaqFxGiDJ66CKnPLw5yyRjVIh8xHdvbto7PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t30XDlqHPi4SrFKs4KSBMf7DQV1qpnToIpBUKmwI2X5m54pipTgP9bmnjWcqEt5kgsyUIMWZdHCHtthLnKAXCwhtf7amFs3zU31yd/l+MLsPlXPpgvhtD/gHwFqMAkfnTOScqNSWoZsP+yOoCIDk6RChIIUipyLht06alt6ai7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e2eeb85822so1195178fac.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743000; x=1764347800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12RgMynb+6XJB9cmwgvbL3fWVOlbNJIbw6uaCnaFT2M=;
        b=a7aoNlXBeD4m7dt8RH7SQzU4v0iCpETfcrx13EvJ72T2ipfZCFEpDIpm/cO2OfFfYD
         /UAS1F7vI2UFjGl30Y0t5YliS/w8w1giGEQ4w3rzS1vS7+PEJ/ICCmXBBk3mbv7SEFSa
         V+qZ8/RB+Dby7ukRIY29hkYW756Wqveh3v0P5NuivkadoycuYUEOGxRR57f2PpKRjyRR
         wLAE6+CxN8iOVBxnSdQCUcJi/rOsiDFAcsDyZs89ARZqfScwTi2ycfy64VKer6UFCTh1
         rNWhRvtoFpwaKC+JKEkSa9jl3COYzMSuw5ot/dgBcjVbMR7nSzoKwKOxK1Ih3nHVP/5s
         xAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyt2ztITF6KG1fif0H2rFjqmubPwOdzlkY8gJCpXSNYlcl5yh2FNM7iOCYuK+en+CCGwk6GXKOQgs/8cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBdCrHhHkJs3smXt6RNpB6ICQwmSGhnZ9hFryjZLIi1VdK5bU
	YosF1sM2Uh9NwGymZk8WD0jqc9OBKef/aqvBRV9A/j408u+ZWha3pFniotH3Xna6
X-Gm-Gg: ASbGncu1aYYQOewyLLrOLEfgSjKFiZrJJSnIqukW4B5LMBp1pGQPKIDykGdbz6tXMgK
	a+K9d1B0pf1t65BNrivVLi4XXWS1NE3UgrnMBCrcRQgQOYSyvwVXSuvsLW73NQQ4030xe5BVphZ
	t/s2sGvn35f5ZjSf8EO9gZer8WxUt+c8OzDUnSaKfdqQe2rjDSQPsPKgaUmHHl6CEMNeNLI5885
	nMon0IIOSfjlP7HEnPU8fhOZ65Y2R5CuMPCCmJaUA0jZOGEg/inTJALnaoWG36hEfonhCq4JecL
	JtM0yomYzBHhjfkVLqCAI9pMCEWbkztIJyPC+adQ5B6lyWLj1wdsTAMbY1bFPbzephkR00/mQb3
	PIly7nGt812r337J0M/GvrSOTG2d/WaH4osLey8Qt2KKWDrbOxyHAYeLMW8cHgpGKHthxOKW7r6
	dAIFVHmz1yNARjAZyvz/kUwNS92/Rl8k7EMdvcllRFiw2PNUum
X-Google-Smtp-Source: AGHT+IGKK+ybY8885gsYbC7zJlNiY4NxmUhdKdPgSkY6oWxHCzeN6sBwnW5k1ESzcM+nwMHF6pzq8Q==
X-Received: by 2002:a05:6870:f14f:b0:3e8:8e56:674b with SMTP id 586e51a60fabf-3ecbe65ccc4mr1385631fac.53.1763743000059;
        Fri, 21 Nov 2025 08:36:40 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c2cf05asm2927471fac.3.2025.11.21.08.36.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:36:39 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75a5cb752so1291505a34.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:36:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7NigSWjosBT8KYE5uGe0WXTclscmfTFkyKzvFQpvh7R5VJvC8WCtfNWKlPO8rbYEGZTN1BNVBYAOtm6I=@vger.kernel.org
X-Received: by 2002:a05:6102:5983:b0:5e1:839b:4540 with SMTP id
 ada2fe7eead31-5e1de40c294mr825277137.44.1763742667723; Fri, 21 Nov 2025
 08:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-11-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 17:30:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURoSs2O5GW_0n9PbWsPwSM+eNueB10scJR=NP5_z+_aw@mail.gmail.com>
X-Gm-Features: AWmQ_blt3ZYDDqvSHDPvJqY1vebthbmFWNaVCZaKS4zbbEcf1TD9lOCuzfAaaBU
Message-ID: <CAMuHMdURoSs2O5GW_0n9PbWsPwSM+eNueB10scJR=NP5_z+_aw@mail.gmail.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
