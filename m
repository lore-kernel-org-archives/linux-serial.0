Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67D37F0E5
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378833; cv=none; b=jT2ZdyB3PAQ0RRqYMmKuP+OgLcy26+kq4Iy13saKA/dL7clWQ8TkOEi1FSB8HeAJMDURjuFzc0Mh8Xqif+a6xgz2udXJ+Nm9PGrmXmfUKyfC+vdcQCz0fU6oDEcyxvSx5lvB6q97s06IR7L9JpsTMzlJd8A7EioNr4++TJQbFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378833; c=relaxed/simple;
	bh=cVeFdKo0k7nGdWRXnAwflkhPHd9OUkqReF3689rtABc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXkERyrZKkuFW/upzV5KdBfMVNFlEoPMjjNdJgsM2z/9GQUZHcs8WDRMM87RxupfFykOeCosfTIBuMGw/Y2KYqU50MLibkFj0D9cLI0nXBGN7mD0pWO7HCHgfo+bfQVAz5ghiSV3e54zM9Y3nRavi3h6QEVLz62nF4INKa1bsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HAqBZOWJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HAqBZOWJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so4898388f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 00:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768378824; x=1768983624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOjWICKElajAktcnLTxDO0a0hjOrXuTPJG+TIiIDMlE=;
        b=HAqBZOWJEIe4297o2nch9K7sfY2e3rwSW4KHYoclvUMAcEcNUg91l/u9/l2DhoiKDh
         5mQ4Tmk8jFbK+/ztvvC3fxPmXlgYD014LA9iSPLwBDMuy8spbBC9T3FxGQkvef8OP8yL
         5krZhcAQbya3VX03HlBzNsj5j1anLNi/SLLzwCVbgydydZrz9pEmavTs0dhxYagPzWPj
         vZBG6qWsx5kDlz0+Tvb7GqDpEQKTyncmmIMrZ5k0T2lHxekITQnL8QuQx/vLfEIhqPca
         Dpt5fKyRvxPTTBOTsr8GTUOiBe9YP3PjjL0zcPKr4ijCiy8fYXe+4Q1ggtB4RE1/+Bq5
         1o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378824; x=1768983624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOjWICKElajAktcnLTxDO0a0hjOrXuTPJG+TIiIDMlE=;
        b=Xqo80tnBTSFweY5cPvpkctcO/Tu7qM12j919rQG9Tq6qH8hz81D8aM4Pk7wpUz4z+l
         FgjsyGR2Xt+QSW50VRfP+oNWuW63to2TykXbiNPrw2PmDJjU1OMucY7QeLjNKaS01qWm
         SYQ0JJfXiEik6BlOiYEgj4A2zvPLWeoYnLln24CoiUqcGn+XUafw0AbdbqSZt/ZMKpFY
         iYA+F48LsdoIdZP3g4ZaFDaKCX8ZFUI8lBudv8GO7QforfQecohSNNCDa6QDFMvD93Vs
         oMz27anhx7tM/HrD7K4VqEDlDN5nxx3C6kKEOGVoeA/dg56XsNQCBilyWxrAyTLQ8ijb
         hVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE9+dSludkEYZ+6+xJQMy4EoIXeCM0MsiVCOqx6Rc5U40QG6GWpFkYt/PcEkbIlIUeUjhPfjXyksEaAZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/nouipGF5CocKg4tReO0RX4gExJ8VwlrpweUjv6lavwF5qC9
	PV7FFF2jtqM6x8/UfaTnQbtskQoSDmAWPVvQn8LxGtnV7EtPPpsHykHszyWa2EjWeLQ=
X-Gm-Gg: AY/fxX6R5eQcmFiLb+Hn0cQn8K4uxtkatEfxEMvS5zUzlj1Q3NIv8hlGmxUMf7W+STv
	qxtWBDmszAaiw/lMJGJB+26JpmJ10E0fCWXWZz3zEQNyfLlTJCbTnd+EocTIl68ttUAI+XAfi+2
	jbVgQZ5SAKTLeEA6Ubq9rL22rUUOACtJRlKGEIGCjgYWI/RluaAo8AaHje8fVGxLBnLlR4S6smY
	2OwdIPhrhEYrPZK92B3Djexi4bzXEQgH9HT9SGNkKursqJFpdxjYCEs+AsUTaYI3N3FZoz470ra
	C2oOUDPLwNQh/D5H0OsgS15u8+LHOdcDNRMYYkpAf98mN+XomxbrKdSex+48kMQ9aIqS5qBeXUM
	e4Cenv0tXv4XxY/3t2iquFWj7vRJZbnUfdjeU3JVUVjAuYCzp9BmHTlXwRPur/KuFh69/+cc1qU
	jzV8BliBVw8bx5xw==
X-Received: by 2002:a05:6000:40e1:b0:432:5b81:498 with SMTP id ffacd0b85a97d-4342c4f4a32mr1782744f8f.23.1768378823922;
        Wed, 14 Jan 2026 00:20:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm49346913f8f.8.2026.01.14.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:20:23 -0800 (PST)
Date: Wed, 14 Jan 2026 09:20:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Daniel Thompson <daniel@riscstar.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
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
Message-ID: <aWdRxBbJOEIZ-KjE@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
 <aVvF2hivCm0vIlfE@aspen.lan>
 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
 <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>

On Tue 2026-01-13 21:32:33, Marcos Paulo de Souza wrote:
> On Tue, 2026-01-13 at 09:41 -0300, Marcos Paulo de Souza wrote:
> > On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> > > On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > > > Hi Marcos
> > > > 
> > > > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > > > wrote:
> > > > > The parts 1 and 2 can be found here [1] and here[2].
> > > > > 
> > > > > The changes proposed in this part 3 are mostly to clarify the
> > > > > usage of
> > > > > the interfaces for NBCON, and use the printk helpers more
> > > > > broadly.
> > > > > Besides it, it also introduces a new way to register consoles
> > > > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > > > reality
> > > > > the changes are not complex, and as the title says, it's
> > > > > basically a
> > > > > cleanup without changing the functional changes.
> > > > 
> > > > I ran this patchset through the kgdb test suite and I'm afraid it
> > > > is
> > > > reporting functional changes.
> > > > 
> > > > Specifically the earlycon support for kdb has regressed (FWIW the
> > > > problem bisects down to the final patch in the series where
> > > > CON_ENABLED
> > > > is removed).
> > > > 
> > > > Reproduction on x86-64 KVM outside of the test suite should be
> > > > easy:
> > > > 
> > > >     make defconfig
> > > >     scripts/config \
> > > >         --enable DEBUG_INFO \
> > > > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > > > 	--enable DEBUG_FS \
> > > > 	--enable KALLSYMS_ALL \
> > > > 	--enable MAGIC_SYSRQ \
> > > > 	--enable KGDB \
> > > > 	--enable KGDB_TESTS \
> > > > 	--enable KGDB_KDB \
> > > > 	--enable KDB_KEYBOARD \
> > > > 	--enable LKDTM \
> > > > 	--enable SECURITY_LOCKDOWN_LSM
> > > >     make olddefconfig
> > > >     make -j$(nproc)
> > > >     qemu-system-x86_64 \
> > > >         -m 1G -smp 2 -nographic \
> > > > 	-kernel arch/x86/boot/bzImage \
> > > > 	-append "console=ttyS0,115200 kgdboc=ttyS0
> > > > earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
> > > 
> > > Actually I realized there was a simpler reproduction (hinted at by
> > > the
> > > missing "printk: legacy bootconsole [uart8250] enabled" in the
> > > regressed
> > > case). It looks like the earlycon simply doesn't work and that
> > > means
> > > the
> > > reproduction doesn't require anything related to kgdb at all.
> > > Simply:
> > > 
> > >     make defconfig
> > >     make -j$(nproc)
> > >     qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> > > arch/x86/boot/bzImage \
> > >         -append "earlycon=uart8250,io,0x3f8"
> > > 
> > > With the part 3 patchset applied I get no output from the earlycon
> > > (without the patch set I get the early boot messages which, as
> > > expected,
> > > stop when tty0 comes up).
> > 
> > Hi Daniel, sorry for the late reply! Lots of things to check lately
> > :)
> > 
> > Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
> > way to check that the new register_console_force is not working. Let
> > me
> > take a look to find what's wrong. Thanks a lot for finding this
> > issue!
> 
> Ok, I did a bisect and found out that the issue lies in the last
> commit, where CON_ENABLED was removed. After it, I then checked what
> was wrong, since everything was being plumbed correctly (tm), and then
> I found that it was not:
> 
> On _register_console, the function try_enable_default_console is called
> when there are not registered consoles, and then it sets CON_ENABLED
> for the console. Later on, try_enable_preferred_console it checks if
> the console was specified by the user, and at the same time it had
> CON_ENABLED set.
> 
> It worked by chance, but now, we don't have this flag anymore, and then
> we are not _marking_ the console on try_enable_default_console so
> try_enable_preferred_console returns ENOENT.

Great catch! Yeah, it worked just by chance.

> So, without any console kgdb is activated much later in the boot
> process, as you found it.
> 
> I talked with Petr Mladek and it would need to rework the way that we
> register a console, and he's already working on it.

Yes, I have some patches in early stages of developnent of another
feature which would help here.

> For now I believe
> that we could take a look in all the patches besides the last one that
> currently breaks the earlycon with kgdb and maybe other usecases.

I agree. I am going to review this patchset first. Then I'll try to
clean up the patches which remove the ugly side effect from
try_enable_preferred_console(). Then we could discuss how
to move forward. It might make sense to push this patchset
first without the last patch...

> Sorry for not catching this issue before. I'll use kgdb next time to
> make sure that it keeps working :)

Do not worry at all. It was a well hidden catch. It is great that
Daniel found the regression in time...

Best Regards,
Petr
