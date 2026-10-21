Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597071;
	b=pg0fWq8VFm/+Nr3Ud68kVvAyJ3IdQOeBjB2FVkXQLd3yl0ySxG0fIzHBRAlW/cz9kTee
	 Z+BUzflJ4NLrSF/mBsuuiEv/YGXGL6zNlYuz4YLHlgrxjYRikm0PViJMariQvr/JtlL8w
	 JUnQ8t+oM9P/RQru6GxEQ1kZj8mAEmpjB7ja2BDad3aReSWtgxo1iohTKMdQR2/gErgKi
	 g2SwdzCFnuSHMjjQO6i0J07wI78M9X/GmI2IGJgsEcEStKdKFL2OYnY8y70bSVcS5fOEq
	 S81TbIJjVEmSK3Rzy1GyxgMoYq53hY6xohNsyqoC6dm6tN4nLjjHFGu0GnTwM8a+4kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
	b=gMHs5f23zl99LTS9AiJwFatvBkJI9me9R0othQnzRhqfYvbLYpJ/+wqNnQts61F2dRUB
	 kY/c85lUghbBgRqs5mP7qTdDBe/BpZv6KaWcdYgMJcSUEvgzXJoFASSKhVr3Om9q+ajT5
	 CIMWToIfB8yx38cLaTx1DDIVIkyrKBitddblH+1hL3XG30+DoAYe6bX4+sfDFdZikjQ2g
	 pJrLHTcKRr/LYLfCb92wuTSF1GkJp/sDcwKaAYtuGc2ydq4o2HwXShV1PiH/43rC1csGZ
	 TN2fvdu0ypAU5U331yQBGcp6wsgmnaxWD+8CCg8qxgBo59lkANnBna3mrtvhPsIFHTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8WOfcfn;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C9606A31D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66C9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8WOfcfn
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eae12762c9so388613e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792597070; x=1793201870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
        b=U8WOfcfnMnpm6svYe5iJa9/W46YR4FzI8Nlj+7unkM7m0rftH2FoogDPMK26ILs3tw
         ms9az8/IEBxBnq5+p+y8QpOkfxpbjyjMZpObKISMc1AlVpCtroY8L7HpWqaN9LJp7Av/
         ikv7zKxySdsv74p2R/3OFIolqJNaymhzG9OFqPY65WDonlV5Pgagk71+wfZENoBDReGO
         0Wi0rN+Y+MtHE2ZtMEgL2lJ1kLk0G8GP+JFXuGcKj/x824ojcSSn035B408ME33gWqMJ
         ZSHXqIvQVikv3S5cRgsmonWb7b9tVLhoIH2cIzqoy0U/9rhbqQ6VhgYDS/9NOK7jFZHM
         qLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597070; x=1793201870;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
        b=lEw4cpInioXllnBhL7V+cdgqwI+6h7tyLE81wk9mcS39R3x/YGaeiXQWawr9D1+Eaa
         a2vzHXBC2iRAaYko0d7unGRD0dNzBSTyeTD3Q6G8eAUscfW5RWajxp+cyuT56epR2IdF
         pjZHk29r4Sy3EWiK47oprtKt1bymb73ySz6PfsrPGoVotDkGUfwlRseRZGPWfo9l3bb7
         IZJgoLfRWqqWwLNRGL6inWlOuzwyfX/ndzqnWctHtBe0HavSXhf6eOKjrXciEsDQwt1F
         AJJgPVzgo6M0NHP4ufsalAjYwJ3yVVuBcCNUjcCn0O1VgwR13ZjZSktT9bnEcm0tQp4j
         G1kA==
X-Gm-Message-State: AFq9FYJt4fKinS3FLtQEDV1nPm8plEhBnoKyGa5i7+2PKp6Qdf+kW9qU
	WMCvyGG9X71TFk7UZ1n1jfiRhykhFMk5x1hhFBpQ42LcgmN78hrhW96d
X-Gm-Gg: AYBFou0NLO64pYV9IWvlrWQkmecxXxEHXiCsZ8k8GrJ+79MTxYsnBaFoCAynpMhppSl
	2/1C3eJwUfXUJ3dGezGg5IvJXmFSSIZAogxLVwjxXk8ep0IEyDGsRhRi21V8eNfewkhrfCY/yBo
	cfu3G/Bx3ZaHe5JtpiyYZDJ0UaNDLrKiGNXxUxeU95Y/iGsZXq63lPutV3YYTLaoP6jTZbGz7om
	QorPlqkKCBZ+CRXpMej5B/4O/bon7bDVP6xbqqXUwreS9zX1BQ1EqLWWeK0EMMYplNAv+FPBm3m
	zv28KKOSqZwPpz/TOAzT3EfOeJSEkjsybL3hVMucENJfWiU3NkG1p06OFMZi+2BxBamNoOvpinR
	c0JdvRBqxRooIFkcLGZ9xdTViH4DTAjwU8Ea3A9J4Ga8CaMP3a+CuipQ3NdlHwZ+rc0k5/OwdMa
	1VrA2qH3hLkpTr1V6HIduUDbISHSRjo16rZMii5UvmNpAUnOTtNZOLn2Lvijym2M2KhcPdkxLYf
	MBgegwOZF3esi3Pqc2jzwbAsKRa1rqRdO0TKm7CC491YOW4ogKR1jcChraczBnONWB5eUYoqSix
	2zRHIfZ0QKlv5fKYu3DwUhuGH8nfSb+WkelsXmMW0iRtpa3uNwS0P920LnEFNvQ=
X-Received: by 2002:a05:6122:3122:b0:5ea:db3c:4a3f with SMTP id 71dfb90a1353d-5eaebc14cdemr1063889e0c.2.1792597069786;
        Wed, 21 Oct 2026 08:37:49 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97f0a94sm3505688e0c.11.2026.10.21.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:37:49 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 12:37:32 -0300
Message-ID: <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atjB-BnXclL3FcUm@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> Ah, dw8250_idle_*() are already BUSY-functionality aware. So, what we need
> is to provide dw8250_idlej_*() callbacks via struct dw8250_port_data and
> make current 8250_dw::dw8250_set_divisor() to be part of dwlib.
>
> Patch 1 (dwlib): Add callback definitions for dw8250_idle_*() to struct dw8250_port_data
> Patch 2 (dw): Assign new callbacks and use them in dw8250_set_divisor()
> Patch 3 (lpss): Introduce stubs and assign new callbacks to them
> Patch 4 (dwlib): Use dw8250_idle_*() in dw8250_set_divisor()
> Patch 5 (dw): Kill now duplicate code pieces
>
> Would it work?

Yes, I think the approach works. Two details from checking the call
paths.

dw8250_setup_port() is skipped for Octeon (skip_autocfg), so 8250_dw
would still have to install the setter from probe.

For LPSS, I wonder if the idle callbacks could simply be optional.
8250_dw would provide them and LPSS could leave them NULL, avoiding
stubs and a separate LPSS patch. The common setter in dwlib would use
them when present.

I'd still prefer to keep patch 1 as the small fix with the stable tag
and do the refactoring as a separate follow-up series. Would that work
for you?

I don't have LPSS hardware, but I can build-test the LPSS side.

Thanks,
Vinicius
