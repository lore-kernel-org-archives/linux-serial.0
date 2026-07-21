Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D73B4EBF
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784603699; cv=none; b=kImIA4mfXJ8cJ/jjX2vCQ0yY7k/+XM+rY8NOh0+je3yTIdiKdSn6viJcrZNrPCNwUlEFXi/lBwFyHCNnRicVG9URusNv2z2MGgfObMMQUaO6Lmh0K6OHvsqNWaVKfqMbmPFI8QhFCP59UdqNqYNGtzRM6aDMO+bYkTidb3XbH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784603699; c=relaxed/simple;
	bh=48BiHH+hqLFPwV1Ajz9gxx2EkNddPe9mnUB9E7/Q5sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/sTy7pUfs41CeE4a+jCE10tRDFmSuIVHw/8fS7Q0xQlysPXAg/BsAb8UY4XX7ZQqhlErUbHMKWDZdfrrxD4r8Aa/IF/gdkILqTnN2ONMg4OcXl7IYrGv1pPU/hmNRp2QZwdtJMJplStEL9YrwBZYR6KnesE2l7iJzfd44wX728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5Jq8GZd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5Jq8GZd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784603685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws6R9xlrB7HNBXGvEpjJ8lMU2yDFgA7S9WmBKoyu3SY=;
	b=Z5Jq8GZdaU0lp4+7nNlRIbjM1ov6T6A8+vX0dZa/fJ26ilDRLEZ4/oizLpnwbIJP7bWF+e
	gVy11x7WObXjfnva+NjWYY5oakOYyb0OfcuC2ZlyU+r3q1/CuUhpAYBqeDebGGcp3e4OAJ
	unlz+0o0lKG24ovFgTCBlAHrLSho+yQ=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: andy.shevchenko@gmail.com
Cc: alan@linux.intel.com,
	asrinivasan@oss.tenstorrent.com,
	fushuai.wang@linux.dev,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	sean@mess.org,
	wangfushuai@baidu.com
Subject: [PATCH v3] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Tue, 21 Jul 2026 11:14:27 +0800
Message-Id: <20260721031427.53396-1-fushuai.wang@linux.dev>
In-Reply-To: <CAHp75VcTs2Vro3vg8dqmYfRebk6bBfmJCZFBgD2KMHpTKY6jvQ@mail.gmail.com>
References: <CAHp75VcTs2Vro3vg8dqmYfRebk6bBfmJCZFBgD2KMHpTKY6jvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> > On Fri, May 22, 2026 at 06:10:42PM +0800, Fushuai Wang wrote:
>
> > Seems like this patch was added in next-20261717.
>
> 0717
>
> > I'm noticing that this patch is causing no serial output to be visible
> > on riscv boards till the uart device is registered. Normally while
> > booting, we expect for all the prints made before this to be
> > buffered and appear post serial device initialization.
> >
> > => booti 0x11000000 0x21000000:${initrd_size} 0x31000000
> > Moving Image from 0x11000000 to 0x200000, end=1ca6000
> > [ 161.301] ## Flattened Device Tree blob at 31000000
> > [ 161.302]    Booting using the fdt blob at 0x31000000
> > [ 161.307]    Loading Ramdisk to 7653e000, end 7dd81853 ... OK
> > [ 161.366]    Loading Device Tree to 0000000076532000, end 000000007653d25d ... OK
> >
> > Starting kernel ...
> >
> > [    0.235159] printk: legacy console [ttyS0] enabled
> > [    0.238787] /soc/i2c@d401d800/pmic@41: Fixed dependency cycle(s) with /soc/i2c@d401d800/pmic@41/regulators/buck5
> >
> > Most devs who are debugging might be booting with the earlycon boot
> > parameter. If earlycon is present, serial output is present, but
> > with earlycon missing (which is what most distros use), I don't get
> > any serial output till this point.
>
> Perhaps it's inconvenient. Logically I support using earlycon (I have
> noticed a few times in the past double printing of the kernel buffer
> to the serial console). So I tend more towards that this patch
> actually gives a better experience. However, I haven't given any tag
> to it, nor do I object to any improvements or reverting to the old
> behaviour — your inconvenience will become mine :-)
>
> Just my 2c.
>
> -- 
> With Best Regards,
> Andy Shevchenko

Hi, Andy and Anirudh

Thanks for the report. I only tested this on x86 and don't have a
RISC-V environment.

I think this patch should be reverted in -next. Since I haven't done
this before, could you let me know the proper way to handle this?
I'll also explore a better approach later.

-- 
Regards,
Fushuai
