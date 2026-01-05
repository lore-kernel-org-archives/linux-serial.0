Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2B33A6E4
	for <linux-serial@vger.kernel.org>; Mon,  5 Jan 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622118; cv=none; b=annBeW1Gs4coGU72BgQsNuJBeHYAfe/YCGfZaXWq+UQyOE/LIZr3bfthNaODqzF5eBt+M3eBR7IP4/avvaS3DxbiA65FqdgCmPJuokitU/6axrTfKFFK1Bqog7ebBiylPdSxrk24LArb/iVMFFNMQI3bDPpxkJFrVJfrKXCMljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622118; c=relaxed/simple;
	bh=r3I6M7kWHIbwx8pg9jWTMfz8fscetYU9L971EGe7OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUtWocnHOEDzO6cFqIJCl6xQ3erGuDkUeon067vthBBS3laU6FSZ/urUjP+yojducMVIP8n9Q+oJluE/K1cGQuA61RqWXV9mPpgyX3Tjpf8uoFN1q3BZwrb8EqGR4Jl9dz/zwvXYbHi+ZO2z+F9SoAOqaOHam/hiuA7avAynUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=H9+hkPjh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="H9+hkPjh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so6752258f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=H9+hkPjhAyTEos4JbC3SAHaK4U1jFi/jCKRwkG3H3+42Ugy69WLCmKacOeNmxPOKw0
         Ix+pwpDSjEpf1yAwNXdsT20c7NqUd5oHunNPqzsePlSzps5WYOiSx5uiCtjGUY1TIUPv
         t3T9IoS8ShGcJgfzjL2u6Q1kdVMwGv1f8pIgH0DMcox24h5IEYh+Atzg4WxOTvniWzK+
         G51sNEh08yMuuRlk8CmnRljUjsg5kNffJGszJhny8HWJRogQSvnCbU6DTnjhLeuxTHmy
         I4XskcK1GoHISE8qrTfNJmMx/D+rH0FMktQJVeTsE0D2xA7ox80+XRiyZ3oSBGef62e1
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=SQvLUUtyfT0XAAcS1LMWHQTBqcRxDQTLl5xjlJCTmvd1dkgA5dzLCihCoW+mLjVEKM
         sg3ycYJXzb5/VXVFrpiB7HdFrlKKsKpuTAQkMbqO0ZFcTshPzoslm/zmGqzNM58mfyc8
         5usDys/VElAgDx2bjdd0du06vcO83Jg7ECWlIUSg6mBYaCpkKmMCNEqheZ4jPw8NrPWK
         gPg2rHeTxkmj39WmKVEZk+GXDF/5Uw/6DkJtOlBoEBlEsEwPp2puup+JLPeCDd4g0bRO
         y19lFX6FgdM6ujV4DZ5WlcaUM8ZYgNc2WrXVRl7/nDEePWeTmqApL23IYTF+1uQcoeH6
         6o1g==
X-Forwarded-Encrypted: i=1; AJvYcCXaPhVyKgRh8YgC3C5ANcI1LGltNkcZMMCp7XdkECr4z/JS4jEuq4XShnI6lntYZobTTH4zWwTFgtpwrHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqS5g0WYBVAaDZBgO9rmxOkOt4HF5NfnulbQerdehtnWz//mm
	+IZixX3gM03JNo2BqKCsALBhNbIIhBs+G5ODTe0NdSM78PxCH3xhfw7dISmUMgfwqxE=
X-Gm-Gg: AY/fxX5Z/CjvWlWXYNeV4I/lZ7EvGzoL0JLEE0LV3AboE2ZOnF0imvAwUimVtG8YObc
	6okwDKkw9N3QIrQTI1jhXct8thUpKPMOyCh8JooPILuGSQNC95rJDBlWpFG780MyXLk+71rl0mA
	ppFVyHksWQ23BeWMc2VjvDVt+Lp7sy7Rz2qJaiG4g188Lpo7MGYMllku2KbB2m+FlZOed4UFsfj
	Z5WPwCZnkz/jwwpPkHneOXapxGEo5ZtX3whhPJkBhR/TFUzuWYsO2F+HgqROijSrrQtDpnDdCQB
	V2ri7ALaYVjBrzzpj5BArskiB6Watq+QWGUaSwW53jyPnEbHU4KfrHAuFsVEJ1DeuD08uKUyHUR
	FVsyiHKPoA1NDWLKzUk5+R9ilJ0vr0PYqQjyRQT77r43//gd7glOsgdE2RDVr4APKZgj2adIE/y
	ebf+QavffhIjXhCTvl0RfZfy7zO4lH66tF0Nlj0SgdD7oNipo2YAnNtg5aluUphCN87hYKiQ3qI
	4Ytk1m+KsiITx8BKzhgEYVxZomX0ekh598kdYOsJcufjQpCDmI0C83389MrXq0sIZz8+sN0
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
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
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.
