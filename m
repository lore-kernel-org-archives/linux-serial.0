Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4F302163
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663162; cv=none; b=VCV4PcVBLD3kI/7f+BtvfS+sb4w47dl/Xdm+mAq8i7dCbuJZm5CkorCogUwzWv8z24UQnFJRyaDRnLs6nH0tF0YtGLBOrDCGA9Juo42fE8jBzOO561b7kfM/+gOBoCiCUoqpw4/UL/R/44696gzJGTHuq/bLqDzabIrDfJ9kzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663162; c=relaxed/simple;
	bh=16j4upoT9sJfPzdH6X/+Xv5a+TcPUTpYanV6Lb/dLPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU5bhPQLza4vfrW8xAbgnQHF8m8aoSSdmqdBMeqLpqNIcuqmu8j+6oJedIa4gXuE9jwHL8oplsMqw+2KRCGsCkOikIO9oK1V4G4XhwPhvKixHrjJe79tBvWDiApNVn1nu3s7BtuMDPyZR7z406J5tY0JZrYalp9B3Y+6AzgIdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-604fb44270aso8208137.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663160; x=1776267960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHFk0A5PiqyMvdhTllvamqBie3Dm7/U8ZhTI9V50sFc=;
        b=CtPtWyuzWs5R28WHY2QF2FlqeOGy3f5d3wPc6wpGBo80NR6Ju2ES8CobS3MPY/oV1n
         XF3x2wrWkAL0vyt1D/eYcfKEIZPhy4CilplpfQC6BzI+bI7bo0YeY6wwEHDuQkTWdkPb
         oFB28bXyVc2P5lx4TyYzXufsLnrVh6tKVYKTCLnQpYLNxizu7xdWX36MVTHMl43+f4cx
         qbtwQEQ4GGT4izHuolNQLZL8Vo+jMCTXRFVbsCwEA5NJqnfd9EPO0KM1NbMRkTMohHUI
         cGuatYgEkHvOhsIem2aoQFpxCrdBOu6pctDkzQcmzyfSUNuGRbx6Z1E5tIb25D+8M21Z
         Zx2g==
X-Forwarded-Encrypted: i=1; AJvYcCU950ABG/nHHRmwm0obLL93x1vzziBOYXKXdVEKiSe8Vj4v4Z+cOv1T6B0Z8vIovo3qgFXYQi/av5Yqzng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzegWWYN7kfeS/sooYbkhT2Fk62w2+FlzMcyQ1OCASNW+DE7t3
	1QUTpPK3GDyV2o+EiauZMRi9xLo0mn6TSVcr8JRzlb2tsNKNu/nnvLnwVxk9EJlR
X-Gm-Gg: AeBDiesejvPKrle9Zl2z7YCi4OmEoHgP+u7SVPGlTDzCx0vdPuk0TGyauYMCDC1ghSj
	RIYwYA7wvKOsPcePc8LMSDZogOoLWjt7OxfOMDR888bE1Z36s39eI6o1mYufbLDQyACAYrvQ1Hi
	Ajpw3uGoBrbLPp7DPRE3Vsp01c+otZ1d2zvgpCHvPYGGqBJixC03OppVV6dbyU8YqGLsgQ0UA2u
	7j3LGVzBmiJlrTZotw1HfMSYBuKFfSdzd3NE+RkbQmZFPCHmFa752pNCH3T1MFE0Rvw9FczkXxi
	Y5PsyO+Hh/y4wyYPKgeBIKLoR/VsBL2dG4g4Q0yoK8ri/k5kx27OYWU8gR45npo2d7wpaMBQImY
	k+ge1QrxrLIScR/UkRom4T2/Y/MXgc2RKx6w33PQ55vzngEp603aJ1dP4hhsl0Iox2AYLoDrjmC
	M1+WBIWt6dZ2tFtic8SEGBpNoDKkPHrdL6kfBub5owbbeAUqtPVNeNO+xWwjn0hCyp
X-Received: by 2002:a67:e70c:0:b0:608:2acf:cd19 with SMTP id ada2fe7eead31-6085df96fe1mr263822137.22.1775663160157;
        Wed, 08 Apr 2026 08:46:00 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm21476170137.9.2026.04.08.08.45.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:45:58 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56db63456d4so1685038e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:45:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2FjVp1jj88VlX4LQQE0n7yxPJ7mI3M+KYkZiFhzl3uK4x6G3DvxEiEepvtt/x0EJQWjip2UK/tmgnQvo=@vger.kernel.org
X-Received: by 2002:a05:6122:3221:b0:56b:814e:d35a with SMTP id
 71dfb90a1353d-56f274c9dcdmr288556e0c.8.1775663158274; Wed, 08 Apr 2026
 08:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com> <20260408142105.310210-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260408142105.310210-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 17:45:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVbWg=nz-E0VTet2YgCP-GvmVY_3MJeZbE0Thp-mMpHQ@mail.gmail.com>
X-Gm-Features: AQROBzBGldNv6VigTu3n3nywjLnQaTCy4GOqCagh4X2AkIWNe3fnNYY09g9NnsA
Message-ID: <CAMuHMdXVbWg=nz-E0VTet2YgCP-GvmVY_3MJeZbE0Thp-mMpHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: rsci: Remove goto and refactor baud rate
 clock selection
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Pavel Machek <pavel@nabladev.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 16:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Replace the goto done pattern in rsci_set_termios() with a positive
> conditional block. When baud rate is zero, the clock selection logic
> is now simply skipped rather than jumping to a 'done' label, eliminating
> the goto entirely.
>
> Since RSCI only uses a single clock source (SCI_FCK), the multi-clock
> tracking variables (best_clk, min_err, brr1, srr1, cks1) are redundant
> and removed. ccr0_val and ccr4_val are likewise dropped, replaced with
> hardcoded 0 at their write sites, as they were never modified from their
> initial zero values.
>
> No functional change intended.
>
> Reported-by: Pavel Machek <pavel@nabladev.com>
> Closes: https://lore.kernel.org/all/abPpZULsXhRmXTX9@duo.ucw.cz/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped the check (abs(err) < abs(min_err) as it is always true.
>  * Dropped the check (abs(err) < abs(min_err) as it is always true.
>  * Dropped variables best_clk and min_err as they are no longer needed.
>  * Dropped intermediate variables brr1, cks1 and srr1; results are now
>    written directly into brr, cks and srr.
>  * Moved dev_dbg() inside the if (baud) block.
>  * Dropped ccr0_val and ccr4_val, replaced with hardcoded 0 at their
>    write sites, as they were never modified from their initial values.
>  * Scoped variables err and srr locally within the if (baud) block.
>  * Updated commit description.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
