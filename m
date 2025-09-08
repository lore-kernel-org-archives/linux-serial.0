Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291781DDC2A;
	Mon,  8 Sep 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324882; cv=none; b=I5hO/HEJ0e2XA7On1/zZPny0VB3g44O5aEmGxtVOV7+lx5dt1MzNLhv1ICc0RMkej71zHW0zVeLl9MfkE6h7IY+PUfPaXH97yaxwvL2njZDYGpE2iZdnPDRiaf/HLLoPzYu+vxuMQveAYwSsZZjRUTQeEZubgB1x80q92zGRLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324882; c=relaxed/simple;
	bh=GqqU9gQ6ksLgdH/oUPUWq87ARBy0UbhPT2s8vt4oWCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSH/0nvaYMlVfGVZTEyjIc6iaoRkxacfNvrhg+rL+P3OYkE5og/nY5LtZvOmj1ADkK2JYCXUegqFz5ZME3z75XhBzfFJhdLVWCLctcMKGMJNzb6f7p8UHyD6FAM5DOaPA5DDgsEXO6wIa9atnYxzXd8+0Bz53qKzbEsHec2UHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-545e265e2d0so3420946e0c.1;
        Mon, 08 Sep 2025 02:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324880; x=1757929680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzgk0xUzUlh6j52cGVIzM3waTCC9uxV/H9zzF7aMhCQ=;
        b=dA47YkQiz7jxS1RNMY67oqCWE5R/CVRVzDifRaWTUQ0CFYKKZ4ujUsiUHEQwiJ08iz
         ajwxQZ7CeNtsWEbhVKMH0FSK+W0pcpcfYW504flB3igbX14kHm+TRwy5OzOLdgapZR6V
         XlJaERmUJ+m+NzYG/p26wcqB+t+5jpVDzLaMpEBEPD78lGyj5JCxODAC3kK/r4Yxone2
         TixZCG9Ud3BfxtDrWEv+Ha0wGh5vWxjZTrKsTI6SrNH7UXXjInbVlb2loou+ne5cGeIo
         mRF12BC+PprT3ddmVsAvTq66nIpelcrRSYOu3RB4VI/3b9nDOypSjoG/f91QVQXoJeLQ
         z40A==
X-Forwarded-Encrypted: i=1; AJvYcCXqNdsDCwkOe27ULKCNdvbsFRglXeYiYW4zzMk38rKPFo6USPjpJhjieRPelokoNhgWDY5aOgBUXY8McXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWCAUl/kHkPAS7JSNOgreTwbwuQXnbdK3yxhNjH5sIpElkVFM
	V2cpg+DKJfDXSX2ZYKXuV35a+3HmewWBDmA+iQiJLlEHASreqydHSJHXf1X/AM+m
X-Gm-Gg: ASbGncucya1Awi17VyCVtYysWnRHw2YpA6zle+rSXYtczzNhtvpS/cp6Jdz58tVTDeb
	ZtzZgpueOn0wj9hGC/dFDCEqV5SuSRdkT6y7mhPIo7gYI0sg9aw3cpfI6dPOhduS/2dOq3B5gfJ
	sfJYRMPR2jlmXizEAPkd144M9Cy0IpBDE6E0WwkuP6S9eK2M33zUgK5y2IgwX0AnxGZrm3OJ2p+
	qe/UwSZLUCz1CZEFHOQslBvu5wp47nHVMqSDZL/mLEcNbLP0tX6xK8xQoZs+g7uMzPg4E7qFzmA
	psSn96VC8CCuZAoTRFhmO0MN6T39W1RihvexutJItHv6JwDilFl6dviC2g+LhuG17YMbFa/XTqH
	MLgP/CQPpR24apFPSGpYHmYACsJK5MEKFj5IXkAbdUFE8Nts0ZXbSMILUAMoS
X-Google-Smtp-Source: AGHT+IE15eppcnMsPaYykP4nYivMIrhZ5KYq1+nFCB9ag6yFg08PC5aD6w6ZmVm3szvld2saamxPNA==
X-Received: by 2002:a05:6122:d02:b0:545:d9d2:a832 with SMTP id 71dfb90a1353d-5472aeed8f7mr1980325e0c.7.1757324879871;
        Mon, 08 Sep 2025 02:47:59 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491464bd1sm11953028e0c.19.2025.09.08.02.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:47:59 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5290c67854eso2967137137.3;
        Mon, 08 Sep 2025 02:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8wZKNllkrpRBk80ZOsSdH90w6y6tPzrYEFiAv1pMRHZc54paO82P98uwyPMSzkgZ+iS6LkDkCuFv2zLk=@vger.kernel.org
X-Received: by 2002:a05:6102:f83:b0:524:b9b7:af01 with SMTP id
 ada2fe7eead31-53d1c3d6e5cmr2054887137.10.1757324879469; Mon, 08 Sep 2025
 02:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822104208.751191-1-jirislaby@kernel.org>
In-Reply-To: <20250822104208.751191-1-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 11:47:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXcm=6HmHYfkDF--jTKu-o7jWO=T6EuzeedhEvU3An_A@mail.gmail.com>
X-Gm-Features: AS18NWDoUuvjHVKj_6IGPnEkgWHda8d2Shyst11eUuVhsnm2ecFd1wqBdiVzjiE
Message-ID: <CAMuHMdVXcm=6HmHYfkDF--jTKu-o7jWO=T6EuzeedhEvU3An_A@mail.gmail.com>
Subject: Re: [PATCH] m68k: make HPDCA and HPAPCI bools
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

On Fri, 22 Aug 2025 at 12:42, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> The only user -- 8250_hp300 -- tests for CONFIG_HPDCA and CONFIG_HPAPCI.
> It does not test for *_MODULE variants. That means that if someone sets
> the configs to =m, the code is not compiled at all.
>
> There is actually no point having these as tristate. Switch them to
> bool.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.devices
> +++ b/arch/m68k/Kconfig.devices
> @@ -105,14 +105,14 @@ config AMIGA_BUILTIN_SERIAL
>           To compile this driver as a module, choose M here.
>
>  config HPDCA
> -       tristate "HP DCA serial support"
> +       bool "HP DCA serial support"
>         depends on DIO && SERIAL_8250
>         help
>           If you want to use the internal "DCA" serial ports on an HP300
>           machine, say Y here.
>
>  config HPAPCI
> -       tristate "HP APCI serial support"
> +       bool "HP APCI serial support"
>         depends on HP300 && SERIAL_8250
>         help
>           If you want to use the internal "APCI" serial ports on an HP400

This still causes a warning if SERIAL_8250 and HP300 are enabled,
but none of HPDCA and HPAPCI are enabled:

    drivers/tty/serial/8250/8250_hp300.c:24:2: warning: #warning
CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI
defined, are you sure? [-Wcpp]
       24 | #warning CONFIG_SERIAL_8250 defined but neither
CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
          |  ^~~~~~~

I have sent and alternativ\e fix.

[1] "[PATCH 0/2] tty: serial: 8250: Rework HP300 serial Kconfig logic"
    https://lore.kernel.org/cover.1757323858.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
