Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262F3A5E9F
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368687; cv=none; b=kZifO1F7aHIhfqrOELTRLTNT2yAb4HvfCyaod54P4RiE3ElPI2AZHw4RrMmFe2xkoyanR3oOX7dfJgOoCo3IhOM0EUM/MVOMAXAjxV4R/+kuEUxfFQqmmE020VemdBRPLbFj3S6VSfIq8e2tHwbU8ZF49kyInpTybfsyf9eTnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368687; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pat/vNEj5yn2Cqsh80rJ0VrQaGwp8kF6b/AwFdqJWBGKGLFHDvuWO/fnnF87tbL0/Av4AQGINdlt9P61XXeQ0OIZisAe9wIa9hl03yvWeO5sAflEJH2ahfsvrBrUVJZjeMTvPJMWQ27reCbfCkq6T6eYeGK/L+BbKnif+n4fFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b886fc047d5so2002842766b.3
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 02:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368685; x=1777973485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=RxLuitapg+LndDOiIYMsFAwClxzQwKIr4BE5++pOCk5qxaKd5564NIqAKywi3DZQOv
         x6EkFHYmpdaHmA1xxNHPNcMf8Uus9y9z4plizVbokCeltL9kLHqZorz6k/adSK2DaqdA
         J9nk9DOmPpuzZA5uhNVNU6PAeL5v8MHYIIHhkOBukd08LMTEW5uzYEleX51FpM0yGu2u
         QmuYtFFUmPAO6D/gLFKgTd9/Mz2CN0nFQAsoSS1Fnnb3pt4JByLpFAdGrGHUOE2zW9pe
         eqgofPZmC0DFsTNQenOzfAH6HjJkwktj6v/ljcQrpV02MpC3v/nzYfUTvGrutFbJyBZw
         v+9A==
X-Forwarded-Encrypted: i=1; AFNElJ/VQ+amZAUxHEgwPfHoxU78VbGxcxs1LOHwiN6nEQ2RalPd180AUNjkH/ebDZ8qZ9KKiCRPt9Qg1JGDIek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH86u4czkUWzQec4K8BGr+M2Cmj050CRT7BMzAZny8kxq+FkiV
	OeqKqvRUaCizQHU6WFqkEXw/Y6xxCQcKiGHATgOTm8Gml9kfTn8UWhz+aSUgetfAbnY=
X-Gm-Gg: AeBDiesZZ8T0rR7nq+1KoqPIsoB5k8rjY3pPv/GwFV15uUhtEYrxn0ron5IGX9SGu2d
	TLEji7t7MHRFt0bKrBq0Nj2p0vKb6RMZACfExHW3wwhXNBpk1LaX3DtkBrTOuhjcvrxeY6Xm0Av
	jaLJ2pixLFJ5XtSr5lsbjC2nqN2gIlWXqWCzkUYMBueyFHwDuBOwAezTxQuVOQedvWw1C218H04
	3Tm/3WTs5c5qEQWKqVhLJem760QNSSLTerua4jv2K8waxH4C44vsBKg3uYBWYK7ZBMXIe/CCKwH
	xDzhf658KkpXaTlVXY9bVXw1Y/o1j/xlE6mHeOCn6+/Jq73pJci8xHRiAmIaTaEgMx45XlB3dfy
	rrfWDg0VNaeQOGGYN83YIpDllBRi8XXAPrSjF2DJZ5NjLUW7vLxtJJVFFqcyg2ECYgmZyRzJMIB
	tYf+ITYMkbb20njPFgThIW7/xmBNyHDCnQnjGNSkxgIG+f0pS1FleMTaXpyOTnNCzjJJeElOQ=
X-Received: by 2002:a17:907:3e9b:b0:b9d:e301:20db with SMTP id a640c23a62f3a-bb80472800emr149668866b.25.1777368684525;
        Tue, 28 Apr 2026 02:31:24 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c0828d0sm72321266b.56.2026.04.28.02.31.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:31:23 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c01854477so766314966b.0
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 02:31:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9SWIEFOHQ+WeOHTDG4EIcln4+V/QVZn+qF9jsTMXdUqsicXo47+OEor6HiTodnwwX7OQqf7prB1YsYw/c=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
