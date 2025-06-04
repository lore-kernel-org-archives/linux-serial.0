Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD51804A;
	Wed,  4 Jun 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023049; cv=none; b=m2KAmSbFx/da4VaTIwZRayLRtn2/mpXnMHhawHhVYf3ttPxVC2QwJps9/BdTMWBAMh3tuQLwmKjeYvUK0NQJkP/4euiUOvYCCpAj3NocNKRGt2iFIzRxpQYRTK5wmOqIeQuvnu4cg0Gjgrn4S+T3qZATK9U9McUF0wtnRHb/8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023049; c=relaxed/simple;
	bh=Y8IlbtWYCUHsgHWTbxdx5RxNUgfxB5HeIUE7rJx4f4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6VfIQBrXkPwJ5x6latfTitSM20HlnT7M1GVcjoN3bX/RZAy4o6N1cZuNsXJXvlhK+m+EnW95HSlNfllCn4eYDoGVqFimV3/w1rGjdrb3uV9Vr/IgkEbhUvg4aTjHrNgq50oLgtasKDloNF1TDpIa5zik4/x+LjFj4nod6nHRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyiT0v0J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzXxhYCz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyiT0v0J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzXxhYCz"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749023044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lryDCpxFt+jlR1Yqmf+dLIaEjF0R9KXXz2DDNZQ5zYM=;
	b=fyiT0v0JK6oTqwCg0TWPk1rhXkFYY+LsS3HY0+sLcHnZ414OpM6yIttBfLbxrqpc0HSW8Z
	SxzcsT6yNU+hWBrh0kGshX4bkmQvnJBOxZUkQAcJl8TReAn5x+iB0DkAM9vektU16ZnQsm
	X+/uBKWzZ3m8X6SgQxoVpoOUgtNvKpTFXG6Y8mjxamO6xvcw1nW4wOa9dRTn75huVulZGI
	16Uqp4dJCEDPg+z5wGSAXtdU/DxmMKQnUVQWe+Ued+STb+KfmMbT7lTKmkJ6svbWlNtZlJ
	iSThdMN+WtdxIwaWQLSdFuufT9oY+BVFoWg9TELSloc73ZNy1qz7ArJ9LmQR/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749023044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lryDCpxFt+jlR1Yqmf+dLIaEjF0R9KXXz2DDNZQ5zYM=;
	b=rzXxhYCzZcixFqbWBYMcUcQG0diMkiwQ+vuvpy5eB82H35PoovQCM0r/9KTlH6sCVQVWXn
	FdDihW0QdOLv1BDQ==
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Cc: 'Michael Kelley' <mhklinux@outlook.com>, "pmladek@suse.com"
 <pmladek@suse.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
 <fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <TY4PR01MB13777DAC71E234B9E58CC6C0DD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84sekh5cki.fsf@jogness.linutronix.de>
 <TY4PR01MB13777DAC71E234B9E58CC6C0DD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Date: Wed, 04 Jun 2025 09:50:03 +0206
Message-ID: <84wm9sne7w.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-04, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
>> Unrelated to this particular report, I am looking at commit 2eb2608618ce
>> ("serial: amba-pl011: Implement nbcon console") and I do not think it
>> implements atomic printing correctly.
>> 
>> pl011_console_write_atomic() assumes uap->clk is disabled when it is
>> called. However, if it took over ownership from the printing kthread,
>> the uap->clk is already enabled. And then after printing its line it
>> disables uap->clk, even though the interrupted printing kthread expects
>> uap->clk to still be enabled once it regains ownership.
>
> I believe the Common Clock Framework manages the enable count for clocks.
> Specifically, uap->clk->core->enable_count is incremented by clk_enable
> and decremented by clk_disable.
> Wouldn't the clock remain enabled until enable_count reaches 0?

You are correct. I wasn't aware that the clock framework had a usage
counter to allow recursive calls. Sorry for the noise.

John
