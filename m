Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C83259CB2
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876494; cv=none; b=a5j1suenvrUi7/z82USmyuuc1UNRyDi10qn+wqZXdoeOcXJn2wdJNG5MJ64sWMUilKk131QVo3lps/2EcnYTORzwrZe/pWUnD/Ckcb0T+X3XK04vk8WGn0yiXq3tAbTpKLxvsPSkIRsMZzQX8ejwS5UphfvdCpK9dAjdKZnTEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876494; c=relaxed/simple;
	bh=gYLqcuQR8Q+WXhLk5WsSY60ZFCxF9gWLSAXbl+g0qyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOkDeISwp+MxG5CRda8J0Oz6xQGI4USoDgRw1oBd7r1X2vphvKOXbxU2lF3pkkh1X+1ZGnYA9ktilu8IkoTbk82kQpsOGMl0W+9F38mvv7zPkKNKXJW6KAv5hSeDs7gMucSrkLPVjzp0v8mdvQJz2R1flrk0L7crKua4Wq7l1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-56352466d86so627382e0c.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876491; x=1768481291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B4tidj+iK0D3xATA4P9Q9+i8tTKE7sCV5IU5EjdDtk=;
        b=vf+dTs9znByVj2uNmYC+Kd7dH2NMEO96Qu5Ym3w6Qpf1/SnpBfSSm7rnxLwTgBP/ob
         Saoyc73o8ZJUAli4xAegMrZxEV/oSGs/ooPtsNtVG89Q/QUaRzWwWD+9chHKvkwTePDF
         Dxo1/5lGDOmxDrN8A9P+fLE6QU69HD02J94QUpp5kYqfzZlLdRTztXY4oAN+GIh8hmhc
         OGtO5wFoIzjbm7hpNEnFttHkWBO+r/esl2sadKqDFN9ml86/0BxshwfejqVHUV1Qu7Ba
         MnEAd0Lo7qUIEneehEYlVJxoO/Ur7tB0FcILAYPndPF/tAzgP4a+tAVRWQmLkVrhIuR4
         XI6g==
X-Forwarded-Encrypted: i=1; AJvYcCUf/FxKA5BKGthwMUuGcIacKTsj7hqbIRK2Ur/RPQzBgM1HMW6g+TbGbgaxB72s69J6khDCTkem4ReQfkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcilxn7ZsFgYeNcZC19Ke4kIayYH4YamH8IlLiKL1gP0eBTOrV
	ysSJ61Sc7+zIU5kelcR/aHiu+7tEjlEBR8hUq+KSMK50rODmB6zwHnzRAR9tpsB/mmo=
X-Gm-Gg: AY/fxX4j9zJTOIt69VTEVfGVP4NlqC/C5C/xTFbygaE/YdvzQJTg40zIqrnR8mCrit4
	fzvspi00x5LuB2D6Da+L9+4SQuenbOansbG6RACeIxL0vhv6XB+EGf6WA01KuW8sWEqt9AGVLxz
	rXz3iCkcwiTBZGyWhsN5W5PxRPLNStwBBXdAnl7VQuoU27ePMCjhqRkjBUjFcYnKawiesIbmTie
	Moe72BAY3OglbYH2L+S6zf2I3jnjpSoNAlqw3XKQQm5k8Fg4YTVdeeZp61xBWZRv1r6Rqzyqbby
	YpRgxwlgoyK2vyB39cU2OGYiIFrqpIxQ8INdtsV82PmK/CMwzVzlMMIyC1MHWL7te0ijTIcvbu5
	9bMAGVf39HFUUhTz2kPOXPvu3lvP0rsL5fUluJg9F/RJUv9GxcWpUyftWcl//9NwUSYT3KG0eK0
	RwoAmsLry6T8+3xx5aWjNdChsLNzVLZWTXQA1mjkLpSdu5OTV4LwWfgOyTD0U=
X-Google-Smtp-Source: AGHT+IEAyWnI0J1WgobRD/vZnbH+DW7XFz5pUdB5zYeTd/Hd5ivw6KvYiWxigZNgNkKNOAcCJKiwoA==
X-Received: by 2002:a05:6122:31a5:b0:544:93b6:a096 with SMTP id 71dfb90a1353d-56347d709ccmr1634142e0c.8.1767876490749;
        Thu, 08 Jan 2026 04:48:10 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636106e953sm291951e0c.8.2026.01.08.04.48.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 04:48:10 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94240659ceaso997016241.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:48:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUq9Op/1CwmNbK9Z5x7LNLIVD4Mpz1sL4e5J6YQVB1HObpuSnfFzgCkWGw2CDzkUogE42GXbpgTs4vL54w=@vger.kernel.org
X-Received: by 2002:a05:6102:508c:b0:5db:cc25:dd7e with SMTP id
 ada2fe7eead31-5ecb69083d6mr2121654137.34.1767876488653; Thu, 08 Jan 2026
 04:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222162909.155279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251222162909.155279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 13:47:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJe68Vz1nk_30KT54t040mYv6MBD=Kttruw4nfz1qLWw@mail.gmail.com>
X-Gm-Features: AQt7F2qW201xE1CipQTEgelw42wE49kIh7jGt0uhdogu1_rDaCTLbGtcolX4WD4
Message-ID: <CAMuHMdVJe68Vz1nk_30KT54t040mYv6MBD=Kttruw4nfz1qLWw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,rsci: Document RZ/V2H(P) and
 RZ/V2N SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 17:29, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the serial communication interface (RSCI) used on the Renesas
> RZ/V2H(P) (R9A09G057) and RZ/V2N (R9A09G056) SoCs. These SoCs integrate
> the same RSCI IP block as the RZ/G3E (R9A09G047), so the RZ/G3E
> compatible is used as a fallback for both.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
