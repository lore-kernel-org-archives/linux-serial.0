Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646504921B3;
	Thu,  1 Oct 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873623; cv=none; b=jskIMdlTCpkTHVT9wsJXC0HokhGZgWSCjNcOcUsUPZ66Bx7zYKDoGO91X6/x2cfjtK1IGtNiA9Bqqu1QLr9Nc8MiYhW6sAkc56ZTS5o84BANKfNP1xIoZOXAMAZCMyuntazmfcbfteCsoN/F7Ic1Vv7l+DaRbba44df5GU2F6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873623; c=relaxed/simple;
	bh=oe3Xy6jZWdxWuutdSaQfH2C+11mQ4msdZfgO5uK4TCU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q1C/gD5eyNfTdMkc7quHAqvnZuTp+dBSn94Nxy5XUR7gZ321vlZOgS/zddMQYtV6lKasRUFYNOsHLf/eWNFGCQ/Oi9Wg91UwKLSKtUuBjYoTJRx6zgnwYK4CWPu/4in0EXlAkQhZI8dwf4oOh1YNgxD5Cm2lhBB/q4o/X9aJVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDtGzUTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDtGzUTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C811F000FF;
	Thu,  1 Oct 2026 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873621;
	bh=Q1BrRVRpxb+o78Gze7clFuiW7Y5XKDb66T5or0o279w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PDtGzUTZQTeHKJd7oxqARknbqqKKXhWq662e0txGET5Fyj9RJNo9FG7ZPGClZM9Mq
	 74zk/YWGgB/hMHYIf03E3Gc7E3N3lz2YNCTBQEGfQhu0fELla832WI9xg4HtzDUJp9
	 6O8DooODbFYTOEDcOpdw+W27wLVccv/bWRWbG3w3BgP7qtLekbNfYDbXMOoemoaFT1
	 K7xPOFOTDpQx++eNIrAz/4oeO/AwcGTNvw6oNPxkBrltNil5eMtbvhdvBJSQjBvzp5
	 ORMfp5JronFGOifzZBTxUZBBgGvtmIQ5QgYrKa1e/oRFnKR8A8y5fiSDT+5QSeMxD0
	 f+18X382Cp5/w==
Date: Thu, 1 Oct 2026 18:52:38 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
    Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <87ece98je8.fsf@jogness.linutronix.de>
Message-ID: <55083820-478c-e6a6-b129-467140f161db@kernel.org>
References: <20261001155013.1694-1-kaloz@kernel.org> <87ece98je8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hi John,

On Thu, 1 Oct 2026, John Ogness wrote:

> On 2026-10-01, Imre Kaloz <kaloz@kernel.org> wrote:
>> Since the 8250 console became nbcon, printk() in nmi_dump() only queues
>> records for the printer thread, which never runs because no CPU leaves
>> the NMI handler before the hub reset. Print the dump from an emergency
>> section.
>
> Please excuse my ignorance, but could you inform me about the context?
> When is nmi_dump() called? Does the hardware always reset/reboot/hang
> from this call?

nmi_dump() has no caller in Linux. install_cpu_nmi_handler() stores
its address in the per-CPU NMI vector the PROM keeps in low memory,
and the PROM jumps to it when the system controller asserts NMI on
the CPUs: the "nmi" command at the L1 (or the MMSC on an Origin
2000), typically used to get a dump out of a hung machine.

Every CPU that takes the NMI enters nmi_dump(). The first one to get
nmi_lock waits until all online CPUs have arrived, prints the saved
state of every CPU and ends with the NI_PORT_RESET write. The others
spin on nmi_lock, which is never released. No CPU goes back to the
interrupted context, so the printer kthread never runs, which is why
the dump never reaches the 8250 console today.

On the IP35 machines I tested the reset write takes effect and the PROM 
restarts right after the dump.

<snip>

>> @@ -183,6 +184,12 @@ static void nmi_dump(void)
>>  	 */
>>  	arch_spin_lock(&nmi_lock);
>>
>> +	/*
>> +	 * No CPU leaves the NMI handler before the hub reset below, so an
>> +	 * nbcon console's printer thread would never print the dump.
>> +	 */
>> +	nbcon_cpu_emergency_enter();
>> +
>>  #ifdef REAL_NMI_SIGNAL
>>  	/*
>>  	 * Wait up to 15 seconds for the other cpus to respond to the NMI.
>
> The CPU enters an emergency state, but shouldn't it exit the emergency
> state at some point? Or does the machine always unstoppably
> reset/reboot/hang after this point?

If the reset write did not take effect, nmi_dump() would return to
the PROM.


Best,
Imre

