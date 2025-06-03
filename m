Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B61DE3D9;
	Tue,  3 Jun 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945617; cv=none; b=jY5x7U3abhvVhtz4WGueo+skOVK61T9e5QVE4a4AAAIIGGtBmb72xxvaHBOLvU4oTl3GAEmvQW+G4eYUpH7LH3Ou+l4pSZyznYejFmKeUtohzw7GgpJKFt0nb+deUdpZEz/QuNRkRx3GFBOZPYYSUI4CaQXR4b+9mngPF3FqHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945617; c=relaxed/simple;
	bh=WpA8vk81DM7YpkDfuHTbQ/Sfa1Xajazk+5EhEjjP3ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M2KHLe+197qe4dHAcltduVjQRn4BE18BgfhTiqAOGOKA6olCnDdLwz45u2nq/klXi7xZxwfTbSFlebIusu7BYiAbCO9Th1AH5+t7gFnznO8yOzGTT+uvvfy+PMgpvsMWlYadSs/wS5/k2ldOjXklAqj/o+1BNDWCH3Sy1+sEeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9wcuCoc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WvtCDCkh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9wcuCoc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WvtCDCkh"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748945613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fmXLNY28v1hpCt9gnOZ3e1NvaAcrprXNPAeAIatdwY=;
	b=L9wcuCocVvAROJB+Vm0OMYtp7fufY8dT/XSrg66W/wPnRPYVwXbuzvxw6y/I0bxWGZLl7k
	hhsYZ/WXTKhJcBS9P8EKndIyRzxkuIQ5eFMfUEWTNKAYq6xom2+K4mQx/Wo77fZEx6sr8+
	XOtD/Br06ez9QfpXwaQVqrvV0XLpFymmBMDTjPqFb0QNvuCbEUBr0cKhcMuwBcHjaBJTNM
	tOfbZCzQ5GIKH0JUeRQ25WViQOjsHG8rJ0HlJubM6ctKGLqwmAIqif7h8LoYDAs16AyeDN
	ai7LFH63uRhQXBclK7LDIn6QNMiEYLWsgRaqkKEp2jarZ+cAbJDinATxEB/Fdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748945613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fmXLNY28v1hpCt9gnOZ3e1NvaAcrprXNPAeAIatdwY=;
	b=WvtCDCkhUyXu1qXvp7/fcYjduzLtlT//gr4N95lbI4JHE7mq1qxMduaAOFDCksOFsOXHo9
	a39axwuqZMvMlJBg==
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>, 'Michael Kelley'
 <mhklinux@outlook.com>
Cc: "pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura'
 <ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
 <fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
Date: Tue, 03 Jun 2025 12:19:32 +0206
Message-ID: <84y0u95e0j.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Toshiyuki,

On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
>> 4. pr_emerg() has a high logging level, and it effectively steals the console
>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon design.
>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
>> enters a busy "while" loop waiting to reclaim the console. It's doing this
>> busy "while" loop with interrupts disabled, and because of the panic,
>> it never succeeds. Whatever CPU is running "pr/ttyAMA0" is effectively
>> stuck at this point.
>> 
>> 5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). On
>> ARM64, other CPUs are stopped by sending them an IPI. Each CPU receives
>> the IPI and calls the PSCI function to stop itself. But the CPU running
>> "pr/ttyAMA0" is looping forever with interrupts disabled, so it never
>> processes the IPI and it never stops. ARM64 doesn't have a true NMI that
>> can override the looping with interrupts disabled, so there's no way to
>> stop that CPU.
>> 
>> 6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
>> problems, such as when loading and running a kdump kernel.

[...]

> After reproducing the issue, 
> I plan to try a workaround that forcibly terminates the nbcon_reacquire_nobuf
> loop in pl011_console_write_thread if other_cpu_in_panic is true.
> Please comment if you have any other ideas.

For panic, if it is OK to leave uap->clk enabled and not restore REG_CR,
then it should be fine to just return. But only for panic.

So something like:

	while (!nbcon_enter_unsafe(wctxt)) {
		if (other_cpu_in_panic())
			return;
		nbcon_reacquire_nobuf(wctxt);
	}

(And other_cpu_in_panic() will need to be made generally available.)

John Ogness
