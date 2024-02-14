Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16D5D8EF
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925478; cv=none; b=oaJN9sS2iD62rE6IK6oPapKwr27hB7yYZGkzaZLYETxnzp2Iw2vZGcTszG3WDoGUXAgnEXrG9gGP7A+eSwEdMCYqgljThmy1LPJFAGBrvGUkDQskbzsSKaQ43aHA/+XZZvDl/1gHf2XD0ChwCsF46OggsDiC9gV6HHm7Osa7Efc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925478; c=relaxed/simple;
	bh=fKoiCadkZo1au3t1rE9BOBoK9f42Dey8D80vTpAGoKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RSJM+IcmOgdVgKSKtbULAbvhmgbqwsLPCZB3zPOAJus6FFclRkvPHXfqcz7At48YjlHQTDkq3OHuS3JKGpYPbF8SPK4tmdSpahNWsVZ4D2V3JJKWu56sncmvCEQTipVR0QISTd6kv5XnepAnZAXQKkkRdARsPGIBlQjaUk3KVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=M3p3yJ55; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M3p3yJ55"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bfe5aa702fso214051039f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707925475; x=1708530275; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+tRUVl6VTTJ+I26hI6HADTZ0Un+fCkMERAMbKsgaY=;
        b=M3p3yJ55stQA8f9zc1eTSHcJ4QjhoZNUbYdIseibVUIYaSBmTS91+4e5+iwQdH+1vb
         XlQCeJJkbMG23+ipWdqY8yAP06aNZarDw83HvvYT7kH9eVH0yWmTdKaK+w1lJuZg40RL
         zXWwduGsE9rU7QwvqV24qc2N1OiZaobd32DPbwpocKv5zPc/imnUeNqIgio98sHXazs0
         6WnSflEQBW1rcorWadlj1ipHpxYx8K0rokvXeZdCZR7pzQ3CUyj7sYXCYm9yYRPge9rS
         z0IOMooHA3aRPP3K3A2wkKfrfltBE0ZmjF+HIxAs9Wxg9XarL3QMwyidDyIit2VF3Fdv
         SPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925475; x=1708530275;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+tRUVl6VTTJ+I26hI6HADTZ0Un+fCkMERAMbKsgaY=;
        b=SK/CaToOyjqKP/ro/RzGZ6MWVLA7iEFzlA+UgOVHNlloX/1GbSQu0dZAm37fjgCFUK
         HkXqfRYO8dS6EguQJPSEFjRoyHsBJKJXC/qg7fwiiD5qlYkuo33NygWUUJ+h01HcZ0br
         zQYABaEs8pR9Fdr6ZUD8HuYJ8ktAgwUooG8kB4BfL31AgbVLIdlwppjOgIjlqUZPO0t0
         s/M7Viy7j2XqkIZO4MGxOYD2p5f8PAWM3OR2doIxKUjhnXkV8uHw+r2LV6oC3kg45Ven
         PFQQ1n/mjv62bLLXCC2FCXtjWl1xjowAEJbxsjce7AjY07lEMMgagiSjfXRzf7N1xijJ
         jtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUtqrtg/9KWRgbAyj7ZtOAik1sFzrsNOCpi6KxejclLRkJVJusLLH/aXMBoAi8hwZqJlCTi5UyuWBGYDJFE3Al5Ql20eehxgkl8ozw
X-Gm-Message-State: AOJu0YxJp0NUiAdY3xOa2RfwZeUoGEQx1ss69JdQ3HpGj9GNvqR+jN6J
	KN7dRpciPMXk59ss+n9WSnvHYQeDZ7GavHq/VMQHqS7nC9zA+Fvvfr4r2haGokk=
X-Google-Smtp-Source: AGHT+IFSYvJVra1vjtWRcKFPj8EVyDWmX9NPiOhHx5QSIIUGMlUmsQm/kaGm5mHv2EhcHDI6PNBp7Q==
X-Received: by 2002:a05:6602:5c2:b0:7c4:6b0f:ee7 with SMTP id w2-20020a05660205c200b007c46b0f0ee7mr3689037iox.7.1707925475720;
        Wed, 14 Feb 2024 07:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVppKyfQx+1K0Z9etHaCtXFjcZ0ltuX51rMZRw8r7Hn3rqRCqUQHSe34BMQK/vibc3EGnEXzCUDXX4aJ4y12fqw+eikFKbJZP5ND+IEH7dP2qbcptphPDaBqWt6hz5g9bUIJV9GCWSVWJQfbnnJCnu+LWiS+SRarXPQRnWJTg09a0MPqcpWI1tHAeJJhPB9tsBX2LLa5o0Ei26c6kfq9Z/xqc6LTR/9BVl/cNEVsrCWD6pzUEwyt1h8UvE1LbIBZ3ZLy4AoX8qKzUhS5qD94rXCEkllJmhGAkmWyzjq/AkRUe6mlU60S889xjiUSdlaavBP8ScOM07xOKaOA9kzG7a5an3KUfuaOFIjoK/zPTvrWtL54g==
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id a26-20020a02ac1a000000b0047133a05f33sm2484253jao.49.2024.02.14.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:44:35 -0800 (PST)
Date: Wed, 14 Feb 2024 07:44:33 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
    jirislaby@kernel.org, Atish Patra <atishp@rivosinc.com>, 
    ajones@ventanamicro.com, apatel@ventanamicro.com, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by
 default
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>
Message-ID: <0e41108b-2a64-2144-34f1-e7c0f1ec952f@sifive.com>
References: <20240214153429.16484-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Palmer Dabbelt wrote:

> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
> 
> So just mark the new driver as nonportable.
> 
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
