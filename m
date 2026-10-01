Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5263F6C3D;
	Thu,  1 Oct 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878675; cv=none; b=K9VpWC8/iQXNPiGmFakm10S7+c+WkaxRTXawZzbNo0H5P54NtTa3HZLTd3/wkb57WVzbK6hbGIvLbVrTpUT6fwaTjFH54WMGyo7wZ0yVgxCplBRWwHGINi5Ry5x67Xu/poGizkjPDjwGfDHAPmLOFVC/bBU4rQ0kNraa1so2S6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878675; c=relaxed/simple;
	bh=3ZmflNzaiLcNCfQKsT5ZY7rchtehQoayT5kF/TVeg84=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hmTxzbWtgqF61LbF9lOgctXNfYSkgCXxej4JqTqBRRvlLZ/RyoojJjG69yH8QsutDAvxCW+His1PCS73FBa4VMnujH+fIyuSdoLn1YhYM/tcTdSFfsW0sktExP/I0QI59Yx24sU5dOLfX0ogolurSCZ8ICT1Bxf29zUzbvZWIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhHs9Xog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhHs9Xog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9521F000FF;
	Thu,  1 Oct 2026 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878667;
	bh=MesaoZSQ3esm3EyAqNPB4AFZZ/rifbsqgmE4LQLEul4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YhHs9XogTz0xpgvpPBI1VHJ+i29O2mb9pO9p9CGt3dFqvKp/R8adrbXwMt8/6JiDx
	 tCSYCzx+2JNmw/ilxKuv0OEGlwDdikdIEI6Wl+JsO879Hd7luP+ux6/EO3Q6hesjB9
	 5ZctKDPBJveH8BshAoWZ2Objb58/refg2aXlJ0OW/F37D5LV8AIUBe2z2PbGC8vERb
	 sbSiQ9RQjT+byWGCf7uYc/SNnxC7qGlDzdJxP8L35/wUAXRd4mziSXEjY/Ci9W6PW9
	 ycLcOi54atxcnNyFEsQSkZCbKzPwsYBfZmJmoqXzl8JF29eYnNg8hoxaJfHpJrBVqw
	 F5IvYmwHTWuwA==
Date: Thu, 1 Oct 2026 20:16:43 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
    Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] MIPS: SGI-IP27: print the NMI dump on an nbcon console
In-Reply-To: <87bj9d8fm7.fsf@jogness.linutronix.de>
Message-ID: <61511441-7d39-9606-9d9a-38c72baffd5e@kernel.org>
References: <20261001155013.1694-1-kaloz@kernel.org> <87ece98je8.fsf@jogness.linutronix.de> <55083820-478c-e6a6-b129-467140f161db@kernel.org> <87bj9d8fm7.fsf@jogness.linutronix.de>
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
>> nmi_dump() has no caller in Linux. install_cpu_nmi_handler() stores
>> its address in the per-CPU NMI vector the PROM keeps in low memory,
>> and the PROM jumps to it when the system controller asserts NMI on
>> the CPUs: the "nmi" command at the L1 (or the MMSC on an Origin
>> 2000), typically used to get a dump out of a hung machine.
>>
>> Every CPU that takes the NMI enters nmi_dump(). The first one to get
>> nmi_lock waits until all online CPUs have arrived, prints the saved
>> state of every CPU and ends with the NI_PORT_RESET write. The others
>> spin on nmi_lock, which is never released. No CPU goes back to the
>> interrupted context
>
> Thanks for the explanation. I guess it should have been obvious, also
> because @nmi_lock is locked and never unlocked.
>
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
>
> Note that putting the CPU into emergency state does not cause any
> printing. A later printk call is required.
>
> Also note that only _this_ CPU is put into the emergency state. So any
> printk's on other CPUs will not be visible until _this_ CPU performs a
> printk.
>
> In order to make sure that any backlog is flushed, I suggest also
> adding:
>
> 	printk_trigger_flush();
>
> after the loop waiting for the other CPUs, just before triggering the
> reset.
>

Makes sense, thanks. v2 will flush after the dump, right before the 
NI_PORT_RESET write.


Best,
Imre
