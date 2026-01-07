Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5052BEC41
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775496; cv=none; b=o4oOAaERllWsaJDZUge3u9Ewq6OrXzCm2wTIsWxafKrY5PiPAOXukGodoCG6OAcZa2eh1BvxXdTENIyOSGJHtxSvHeN3m4kQ9bcjAixBW9aPAltPYz5ouANo95zZxZyOmCCPt6cBLbSTK3LTr5j6OqOv2CpI6RIlwaWGbh1DG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775496; c=relaxed/simple;
	bh=Z/Cp4F0ZBq+W2m+DW/28XQxAMadBOYzvQ9QpYNbTJ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5aY2swFQPspMFX+D0cX+LSkO7BLoswEU578jL4Psc/uRmDjrqg6TEakRnjegVOIwzmuiND07/C+D1sABlLPXOIfWSTvQfw2+kXmkt3fsC65ZWjzJFt+n0p7ARvqaO/wbKZZZ/B4kyo8+Ze/8UU5fa3SNVwXo6zpKO9MKDYzDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so1380095137.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 00:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775493; x=1768380293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1vgOPEez9FRp6KWJKirWJAqRTlbTZlVkOJqMPd6HmQ=;
        b=bAqvF4s6LcM5U810uNfkRzOToMOMCd/8hrHog7vNpN06eBvb6CYOpIT0KvAm3WugET
         a53/hbk9wh+I4JYCpdA53Auzckeb7ZIAUt0i5RBrPTevJbPwmYDQOIl8JQjiik4ZzOti
         QkoVT02K8WggHjJDrrxbbGBExjTPZsb5XrSMKjv2ymQjV+bEAxl74un9yj+pVX6p/QGn
         VBXbItEl30fTmjy/ih2j9SAn1jG3PEu2tbNGSgofSV+wdg2FxHCxuFS+vNMCN7adCE0v
         wCQI3aZ+CxARUPpNC7ZynaroCWWp2xS3/s0leto4LnOoBp01wPJfBPXoGk3EPAkv2TFI
         QgQA==
X-Forwarded-Encrypted: i=1; AJvYcCWww67v9yqvF9pnjD5xSyjVF449PDVYL4T6AJsC9VIxGGabDwIzY07jX6fEkZwFjYYoHme1ZzJwpG9L8Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuoGZHCl+QRPzPSkW3J9GjjSv4WJOMRkPm/6QRbEYmk0hhss5
	ffHsr17cQaYCQioho1RNGpZatrWptxyaydxsc3ahHlQM9XMoC90h+7QFhjooHjfW
X-Gm-Gg: AY/fxX5GDm1f2lrzzmcYdWvSrXY8/6Osh/CbA5uY1s+l+OAUAtrk/+TkiPJi2Bayiot
	9RQ0Dtf2lXeqOoPAc/kWs98QhnqywhiBSjzZ5UmWGi4CeP79zvUr9DA/DhRRPEgI2Xxram5BCDt
	kiRpS1cLP6lMPzHMjfc3iiP/SGEzlTeeApB+Mi5XfqFj/abTn5zLhW3PMSUEeqFjrmudBrp/6Io
	80oiMlsbOnoIZrIXKGrmEIc/0b/p+XIoT/mPyoMDqy9UYDjMHMPy8bsTkKTkIdcj61B0FfGk8wC
	I809DPzsGQXcBASY48VJA2KGgpahCmGdCHXrz6BhpRz8kBxFaymRBJVe+IaEb+khA16PYIxwAOC
	yDTbl6Lj2wN3L7RGd87dScTJ1s1rdvjpfAO2fhFsOHhwxoG/Ckyzd1/s9GyZnq18CPMA20Z+eoU
	CH93SDAgcUoc3mIkc8lx8v0X2BDG8eCQuFFRZd0sgFoDnan8FX
X-Google-Smtp-Source: AGHT+IFG3SA39PvCHWEJZly1CJL58ZGlBXM0IN5J6cmksR3m5C3LMpHEvDrEX5lKWecTmuny7K1y3Q==
X-Received: by 2002:a05:6102:162a:b0:5e1:82e5:2020 with SMTP id ada2fe7eead31-5ecb685aab2mr583882137.15.1767775493253;
        Wed, 07 Jan 2026 00:44:53 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a34acsm2132124241.10.2026.01.07.00.44.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 00:44:52 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f5729f159so1001256241.0
        for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 00:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWu5/bwEPM/vRI+KFRSxAKHmSe++mYuj1AxIFpzMatab/6ACTBFSMYrrbpXeNmx9sYorO7DohfbUD3f5aI=@vger.kernel.org
X-Received: by 2002:a05:6102:4b11:b0:530:f657:c40 with SMTP id
 ada2fe7eead31-5ecb6932feemr583997137.22.1767775491732; Wed, 07 Jan 2026
 00:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 09:44:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=kCg62C06jMSdse0QZacKn4R2EqmW2BZuZ+cBwr5tmQ@mail.gmail.com>
X-Gm-Features: AQt7F2qmnFtghLvjGfXih1A7aLAlQHCFX_w3g17kIVrnEuB-I-dOz0canJODDr4
Message-ID: <CAMuHMdV=kCg62C06jMSdse0QZacKn4R2EqmW2BZuZ+cBwr5tmQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Check that the DMA cookie is valid
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, wsa+renesas@sang-engineering.com, 
	namcao@linutronix.de, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 08:40, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The driver updates struct sci_port::tx_cookie to zero right before the TX
> work is scheduled, or to -EINVAL when DMA is disabled.
> dma_async_is_complete(), called through dma_cookie_status() (and possibly
> through dmaengine_tx_status()), considers cookies valid only if they have
> values greater than or equal to 1.
>
> Passing zero or -EINVAL to dmaengine_tx_status() before any TX DMA
> transfer has started leads to an incorrect TX status being reported, as the
> cookie is invalid for the DMA subsystem. This may cause long wait times
> when the serial device is opened for configuration before any TX activity
> has occurred.
>
> Check that the TX cookie is valid before passing it to
> dmaengine_tx_status().
>
> Fixes: 7cc0e0a43a91 ("serial: sh-sci: Check if TX data was written to device in .tx_empty()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
