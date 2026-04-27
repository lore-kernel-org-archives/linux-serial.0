Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C430AD0C
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326358; cv=none; b=QcK6ErR4afw1oCmfv6c/ysB+TrNVlCiQrTE/8ZH/JEp6AhUWCzl6BXcwh1XNy22F6s9pt/+8cBe6pEAobEeP6Lb/EB4/LJgu10Mf0k+v5CbuA09ZsQyFm+I1+8nwAwLwYGrGQeOZnzkqeJaGAFVP+l9dN4vTsPOB9OH9KI7qdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326358; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQjBw/Ff+fCqx8o+0ns2pvvYRMoIX/a4CWH5BBzZXOcebL3UPzeY0lOFcFofPZxtQ45nWdsiSP5C5J1Upd9DjLkVXOWgGQnztdeWcC1m75OvMEbsGY7dZoKGiJhZEnaucWl3efu8fWeh8yOFbttuQ5w2pvaveoJcjp9m+yi68f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C3AVbCax; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C3AVbCax"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b886fc047d5so1921001466b.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326356; x=1777931156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=C3AVbCaxAAsWvN1VgrkfScSc5gHKjoORXvKzGFHcpaaM0jnTd0TbEkjVlivTiPtJv1
         6nUjO8Z/zDROYKTog/jKapnDDM8iAqh/VhGnVtaQdllGs4y+qYhMOhWrWgmG4EU6qspQ
         s3SwJG9V3oYEfFztzlHZeoSwEAqXt3CbkZrsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326356; x=1777931156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=s61gtSPb1GkFNN+TvhUTeiXLmf1Td9mAEeZWBBB01Iz1W5cdIvS1Of1AaX+tfV/5dl
         da2RBmlH+GxBSDdog+sympvcS3ymUtmRKStM28PwVjMEXMV9KoirWh7vZIucLLYVF1Ci
         370DOOAhj2rFk+s+wchZZgpQdx6LqwGYbxuKgRTDQb9Z29+AXrHi5itPJ4mV/yyNhgsb
         P9KRS5wwE0D7owCW+YOuBDMhvYvrNa9/X/CrmEFWK9Kg6yTbXwSo8wtXZ8mnRuD7Sfp2
         pdojjSg8qo5SfgOdm53GDhqABl8UMduw1vuYrxHSUi5R1d31gBh5P5Bn7g88GhuIY+SK
         1t/g==
X-Forwarded-Encrypted: i=1; AFNElJ92fFHaIVsvAsb1IUCpfF2eJO7WEj5hsx6Ba6NPyTrEOajaJJwMIHfTqZyG/O5my79huDLossCI9Bt9y14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq539lpRirTyxllcVx8BRDlWlk4tE2LeuNQNNZbWu8kZfzeVEY
	dLb/c0odRDiPt5LRE0SCAcTgMdx0AsAW5nsHIC78wZec4ZWbGE67MHxwJWG6GyKai9poAs+FyXX
	XpHrGSGpyvw==
X-Gm-Gg: AeBDieuiE2Mpv2aXKZpmsq5dSkx7Mf1AsjiKTWys+2KkD3JPAHs1xjobYQnV0+7vHO3
	ffaQpfzckBoAGdm92bR0KcQjFwQGhq7rpUsiemRDmDSYFYLMoSucZ2okv4xWLaNFbkqrQ7juF2k
	EM7goD0JxjnEUs07YMFYcfkbnI3HamF12ZGHb1mfyNdYKcQgFX7W0QNwPaX+NAGaVxmt7sxGm1q
	cY6Sz3F4Vbyll5imvGVJIFFdt5/yFis/Ej9MHesxlWhj2uEs4K5C1P+diZ1A9CNs3MFmt/eJzk7
	9W8pKhVwnwzd3MlRgEos7yp0h6nf1IXUfmowm79g1HiJrATud9oYZ90sjc9RZ1I39MICCA060Cv
	lEoECGLOSQPL8IpnGFtG7h8BDOIG7eZuwsM0C8AGyd2XvCwU7xdE0zDaE1fIXlyUPUxbcz7JKR/
	LIP2uJMFGA4tCtOv6wZog5Cu6dEveRTYKNn+Rlf4ZM1a1WsV5KhDP0WN5dQ1v7hG5pCERlIUYBa
	VuNP+1iZFKh9WUqJsvuyA==
X-Received: by 2002:a17:907:1c0d:b0:bad:f032:fc78 with SMTP id a640c23a62f3a-bb8020c94dcmr27610866b.1.1777326355778;
        Mon, 27 Apr 2026 14:45:55 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c37ff67sm9042666b.60.2026.04.27.14.45.55
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:45:55 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so236867766b.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 14:45:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tpuObmhgzTSfELIApERR0V07qBYqdpLSMMJI6SjF0KllijZ+vOg5hl3wcvzA3p4kB6TE8AAZ0K4kWnZw=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
