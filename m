Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E592629D;
	Tue,  3 Jun 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948984; cv=none; b=GAbzbZKATGoeV7RiYKE2GIRfF8MGT8Aze5MP1maBldFdSmd0b2X7RpOLoCPtXRj4ZBkS9XgCBVzmCvpToZx612ZqVFxTVLCIEhXzgRctGsR583TCnqR4lt/mgGGW8JPqcWlal2v/PtEJXEbp4dB+AM9pwDBizmiuAKS1MQWYuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948984; c=relaxed/simple;
	bh=hsvHtz8hbEbZdfgWCg7X2R/JN8FQgC+kg2ZRkW0wU8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjTd4pJ8fpVgqV86BPuUH8YbU6d0HaNF7gyamJF863JjI1qp2B9C6GDZTDnq//BTqtCydeprV83zpCAobUwC+C7dSaj5pBk9cCK+nSOiIFlDE7wcWzJsXD+f4URTS0v/yJCbCC02C06ZhBaoAAm4st5xNemkdL3lD9mDBh0pQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yfTIZSBp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4qg9UZ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yfTIZSBp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4qg9UZ1"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748948979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSILnF8ALIga7ol7KA0XLGa9sgrZiwLmZV6n0yOi3XI=;
	b=yfTIZSBpy5wwH7vutk1qg0rFMVXceMLdecwvwpXNQJRcBoM+Yyy9ykNR98BVsj1TxMzMk2
	g8+UvQHVCBiteNweMsZ8rEEHskOGiWxknuKEPxkctPjaiwan81mPCSLlb34Yu0fmmipY1P
	taWiBXXsmXiC9pLqfPSeNCzR3iHsEVn8ee4zrdwGDt+8q6c+P5h8gkvaECqIoLO83DSNx9
	tF5y5NszsmM8J+cwM3p+ip4rid589mD3wMlaJjm92AcQvEtLBvL8BSxG5kHeY2Fkto8sto
	uvYDnZz+sD4TNf450kyWmzdZytVGD7gGYGIbt33o6NldOHWL3tWmzhdzyhcgmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748948979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSILnF8ALIga7ol7KA0XLGa9sgrZiwLmZV6n0yOi3XI=;
	b=J4qg9UZ1ZUwWnm70gdWiEtdVO+Muyz5BT1zrP5oqHRzpEnmyYcZaFYNMwssNNEzDsz6X7/
	0Bt2qYwxc8y5HwBA==
To: pmladek@suse.com
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>,
	'Michael Kelley' <mhklinux@outlook.com>,
	'Ryo Takakura' <ryotkkr98@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <84y0u95e0j.fsf@jogness.linutronix.de>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
Date: Tue, 03 Jun 2025 13:15:38 +0206
Message-ID: <84plfl5bf1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
>>> 4. pr_emerg() has a high logging level, and it effectively steals the console
>>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon design.
>>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
>>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
>>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
>>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
>>> enters a busy "while" loop waiting to reclaim the console. It's doing this
>>> busy "while" loop with interrupts disabled, and because of the panic,
>>> it never succeeds. Whatever CPU is running "pr/ttyAMA0" is effectively
>>> stuck at this point.
>>> 
>>> 5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). On
>>> ARM64, other CPUs are stopped by sending them an IPI. Each CPU receives
>>> the IPI and calls the PSCI function to stop itself. But the CPU running
>>> "pr/ttyAMA0" is looping forever with interrupts disabled, so it never
>>> processes the IPI and it never stops. ARM64 doesn't have a true NMI that
>>> can override the looping with interrupts disabled, so there's no way to
>>> stop that CPU.
>>> 
>>> 6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
>>> problems, such as when loading and running a kdump kernel.
>
> [...]
>
>> After reproducing the issue, 
>> I plan to try a workaround that forcibly terminates the nbcon_reacquire_nobuf
>> loop in pl011_console_write_thread if other_cpu_in_panic is true.
>> Please comment if you have any other ideas.
>
> For panic, if it is OK to leave uap->clk enabled and not restore REG_CR,
> then it should be fine to just return. But only for panic.
>
> So something like:
>
> 	while (!nbcon_enter_unsafe(wctxt)) {
> 		if (other_cpu_in_panic())
> 			return;
> 		nbcon_reacquire_nobuf(wctxt);
> 	}

Actually this is not enough because there is also a loop inside
nbcon_reacquire_nobuf().

nbcon_reacquire_nobuf() needs to return an error for the panic case
because it will never succeed. This is the only case where it will never
succeed. Should we use a bool? Or return some code like -EPERM?

So the above code becomes:

 	while (!nbcon_enter_unsafe(wctxt)) {
 		if (!nbcon_reacquire_nobuf(wctxt))
 			return;
 	}

We should also add __must_check to the prototype.

Thoughts?

John
