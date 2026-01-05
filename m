Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DC335095
	for <linux-serial@vger.kernel.org>; Mon,  5 Jan 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617542; cv=none; b=hEVoti59xfS8ot2CzUwXcXGzNJv1AiZeT0KXhX6oaJrRsRGP1o2EduDK+KluwIgOEpwejNIzdXB/C+fQ326UDW9WrKiZ9fiWuvqDY+MZtLJf/deH56nKczGbqXYbrpaV/h7KC5Fzztra+zc1kR/P82sm4b1kaawTQBOJ0ZObLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617542; c=relaxed/simple;
	bh=N0gZejhpVIK3qi+zXOjdBby6xn4BUij6Dyqnfq1/VnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns6Yl6VxJbwn7ucnnO1AkRmPGi+u7vG7UK6t+OGyrNg0FrYvbGHp9knEU1r4sIE4ihPFEZVuMCp/SFVIPuZYfD+AuKViGgi+MphBVlbAgCNkCLHyDf5bioe18xxOgUAn9+23xUSQ6pjF1PgGD1N1Z8H/fNKz4U4KWeKU6KHrSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3Z0uC/UH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3Z0uC/UH"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so5733917f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767617538; x=1768222338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=3Z0uC/UHBVnzel8Jnhuk8T+cAwex0RTJSiYOheeNpc3vdOwwLJMBAffc5eAvD4KGOL
         LGK2+inyZLpmTytw/dcj5wps4yJKiNGEqtTVmqt9haYtMuPWkkHivDr4xtyJ+ttb12Ha
         rfZIWsPp4QYm17CPeymLbjcbS/AZMWvvB9y7ETcw6Pu0WL/DsaXiFxKww8/ccyrmPsvG
         86rI/h3UvSFHPf/e2t8new9Nx/gn7C/thk5LZPTN1SdjtNmTmXmoCRCPK4zABE3WLbII
         W7/0IjShWCirFI6WjQkTMAfwwZfi/GWyYgc7Buz1QSuu2YWxJSaD/AzfupN0+wO6jMeA
         jaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617538; x=1768222338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=XNqXapMPoFjwUBQr+D7IxT4T88Ky09BKWS7fR2fpnJSSRzo6+ax5IJHHZh1bx0/Nas
         H9FRrLtKokTEK/smVa+sXdSUqc1yoiRkuP0r4KOO5+CKqm3wVvcgVZBkfVAwzvEML/Wn
         jyOKIx3rojlwQM/BB+AaWZQJcdS+2yQcGuCoYHiGw55VCMGmZI+oFPWSlBlnGvzQ1qX1
         CArMnBUn0yjYtvMS7l7S1b2oKeHlsHBSfSqphrcW7mOpWkx5HwCZsM3nEMLo0jW4Nwal
         27Ogufon/YovYQkVEXbXZWA0uYynXMqBUHOb5R8A7esLt/+wBNdmtMsOHI1LWnHSC9xL
         USHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbVAdXU+bX2U52LpAUJVUZQshEHShy7L1hdC5xwP2urW3OZry1wStIfMzl2ShBtzIXzFtDxYNQUZ1OF3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRE0zfQvrVmGZ/evKAuIl1wZ0OHs4Z50Ui2uzLE2IPxcXsr2nF
	NVT6bbTFGWRh54I5i1XeVQ889yV5PBr46qMEFL84yrMyaUr754qNY9juBn7hqLCJLAo=
X-Gm-Gg: AY/fxX7ZVYMk9Hg6puJuuBPQNv9XP50rk9MhbgDV2o+W3fST/ek3xkITsdfk91cH1cN
	HKCHAwicS0FQsMiCT8MPixQnjwNnm7pItdWuhrKiZAdzGqcYtmW2HPNbspnu22L5xoJXTgiVRGL
	xxz5M7OTl40vrLVRX/7jqM7Eo9ByZAx14O1aFrPV+JHwJusoR8PZlw4GQ8MnIep41MOikIYRlYM
	PtLdt7Q8ukFxeyiWiROK3t74XuNyv2jsDkECIH9YJp2S8SQeW1csIdQlLHyHKlvY71qtGPeagxC
	2PVZWmTcLfOdEc9S5iCBwiRO83trwQ/i0aMDPPh1KMAsQcbXPT1h0mKKI7siTq3Faqv0lS5a+BH
	NM+z7AvUUpitf5WxYh6b8FA809syDFdI/cCWcCQFuF7u7+glqDG5OtJn3mv5yjIAG6fM7QB61eV
	fBzISN1dGFO7TvBEgmGWnLTV/GBSQ8SQaXEoCFby+mcbStQWUmQZtThBfhCtBaKods0FALeHAOZ
	ztjZW2dGXbn+lzxSSkIJ5VZayl30ksawftENIvMQNsZLj5KuCcPiDAKHbYFveRIoWG64DPj4kH8
	8VozP30=
X-Google-Smtp-Source: AGHT+IE4Mz004OZ0As7rWOFq5sPjHYJ4N8Pzam8+bOUXJdXGQOskOlJaecSDta7VRdPfx5XGGjwohQ==
X-Received: by 2002:a05:6000:1844:b0:432:8504:b8a9 with SMTP id ffacd0b85a97d-4328504b8e1mr37753933f8f.62.1767617537725;
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm100029761f8f.5.2026.01.05.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Date: Mon, 5 Jan 2026 12:52:14 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVuz_hpbrk8oSCVC@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>

Hi Marcos

On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> The parts 1 and 2 can be found here [1] and here[2].
>
> The changes proposed in this part 3 are mostly to clarify the usage of
> the interfaces for NBCON, and use the printk helpers more broadly.
> Besides it, it also introduces a new way to register consoles
> and drop thes the CON_ENABLED flag. It seems too much, but in reality
> the changes are not complex, and as the title says, it's basically a
> cleanup without changing the functional changes.

I ran this patchset through the kgdb test suite and I'm afraid it is
reporting functional changes.

Specifically the earlycon support for kdb has regressed (FWIW the
problem bisects down to the final patch in the series where CON_ENABLED
is removed).

Reproduction on x86-64 KVM outside of the test suite should be easy:

    make defconfig
    scripts/config \
        --enable DEBUG_INFO \
	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
	--enable DEBUG_FS \
	--enable KALLSYMS_ALL \
	--enable MAGIC_SYSRQ \
	--enable KGDB \
	--enable KGDB_TESTS \
	--enable KGDB_KDB \
	--enable KDB_KEYBOARD \
	--enable LKDTM \
	--enable SECURITY_LOCKDOWN_LSM
    make olddefconfig
    make -j$(nproc)
    qemu-system-x86_64 \
        -m 1G -smp 2 -nographic \
	-kernel arch/x86/boot/bzImage \
	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

In a successful test the kdb prompt will appear after only a few lines
of output:
~~~
[    0.000000] Linux version 6.19.0-rc4-00020-g4b7f3b144021 (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #2 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] printk: legacy bootconsole [uart8250] enabled
[    0.000000] kgdboc: Going to register kgdb with earlycon 'uart'
[    0.000000] KGDB: Registered I/O driver kgdboc_earlycon
[    0.000000] KGDB: Waiting for connection from remote gdb...

Entering kdb (current=0x0000000000000000, pid 0) on processor 0 due to NonMaskable Interrupt @ 0xffffffff9101491f
[0]kdb>
~~~

After this patchset is applied the earlycon triggers do not work
correctly and we get:
~~~
[    0.000000] Linux version 6.19.0-rc4-00019-g882df99205ba (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #3 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] kgdboc: No suitable earlycon yet, will try later
...
~~~


Daniel.
