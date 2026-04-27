Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388237D110
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327076; cv=none; b=plG8enQio+jj70moPItqFAF1vNWR2a0EmLXalWckbg3IlzYtlrfD5n+iNIeLeneVX3udzHsOZSo262LcaWqpxwz3zVFL6TGSLoWuGyOxBvy5kqfVeaQ3VSCUyhX3JbRRCAX5hbZjtPBCLxWgE7dOObPIZy2QK16056rdLo+fp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327076; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXm630ysXpASa1sUnfMqwW+77kYHNoj3rQn3SO931rNkru4liYJuGheZuoLHUtE05mGDOZwnDbGg0OERH9kK+A8te1VJDoDigLw8NK2Dz3r1RZ1o0BGbj1m3OScRkAiMGsPJ3X5Evl632ik5Vpq/28YUkFkuTbjDvd1y9BPiUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XNRGYP/s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XNRGYP/s"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so13205340a12.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327073; x=1777931873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=XNRGYP/s1iHcLDY/wF4YwhPCmrTjO8RaZ2qkEUslMQVqM0ag1xyvhLtAXPoEQIz7Gx
         AJQrtI44qSoUAs6OOuwCvKDNd91q9Zwkv9KpsndpZ3jpS+kPeJKy10x8EnUsd2CPFDrq
         fAOaUtDx5s621SrXq5CaHyz/xJxO+IFDaFdMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327073; x=1777931873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=rv6ELTM1vEU7IZg9VGy6yqWMzp+8JZAqJdpP/FHWQyNyQ69fGoKLLcZqVFlZiyPJ1L
         pxfHC521+PDh2MtBfUp1BX610575lRdqB0au3TcQT6lIgs4YXK+hNTa3qZd2WreXSXbd
         TIt0fctdrol4EQ8rx/lQxqLOTYHS4CNRw9WDNWyb/+vdAVp0jWQoing1SxxDsBA/7nAC
         xO0YdltF6YyYxyGChn8w3QZ0lpmL3W/e9dMj/Gt45DYJKaFOtF+0srCfoK280eLfcfXq
         IG/nDBRZ2RcbQzmkaVQ3iQyyCwAf2RvnAOqsDApoZQFOp6D/N76CJobiqanXvyQUYT5t
         ES4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZmnceVtNjuGJs5ZyU3fs+Ne53DLHqdqlQfADi1Ry87mYan6wRX40ODNOitX1202JkVhDWt81wwI1YdNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nP/PZ+Zg+RdxHMXzIvHDcZTmmDkgzjIlFQiuA0Lzpb8owGRo
	hGOCru+vuZouj2AlPRGZXbBP2EO9tXqh9MPOPsoHqYiMj2abhSbO915VDCGybPL1O5oxWj/7bNQ
	qYG6sKke/1A==
X-Gm-Gg: AeBDieu7V/vJNHjfrrUewH2VgUzv/bbwGTgNwt5+uYjuc7HoZzm/hsigXVwRF+5lpo6
	+oGWTHUwkiSDDIrCaQGhCO1AjCT5rZLWc6yTJjOBXk6OIwvMW5ihIS78X66q2UKinF2rTfkdGn4
	++hJxHKTOsNYdN5WxwmcsI9eWPcFRlqYKsdNA0ZT8KwNP9qLH3+zLODefWfEreErWVqPjjOnB4B
	Q4qDgSqqYlCH94ux5Slow3b7QCrxl/EAFnf0wkabULIYTQAovUuiuv9d3yIGaf69QBcuaD2IILs
	G1hzN50+4bNUaagW6Y6/tPhR3OILnwiqbfpPUbugIGqlBWUYvk3k2kaCQndUfHTVK+HNPHTpm+W
	I9bnLK5seKDQsgDe0xLUdTQTy01PuY2XqJCS2zX6pyv4FxB4U015MNJiHdxpr84jiyEOkqrZ7C5
	rUJJjwLYUjB4PDzv419EDr6uSC5vhLNI3c0OB2195D+AAsJkrWKo1o1mBg1W6qvwFH3625W8qJa
	zv8YjgQNnE=
X-Received: by 2002:a17:906:6206:b0:ba3:76b9:c3cd with SMTP id a640c23a62f3a-bb80443dc0emr32955466b.42.1777327073041;
        Mon, 27 Apr 2026 14:57:53 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb809021ffcsm10551766b.23.2026.04.27.14.57.52
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:57:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f9568e074so1773074366b.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 14:57:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MNKlELc9czdmzVwmekTx/DzctXymrV3vYfbqkKYNNl/qHhm8u10zdM1gDabHmSwR4/tMuq3EkXxVWYyk=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
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

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
