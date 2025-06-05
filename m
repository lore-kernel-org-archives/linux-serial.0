Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8921E89C;
	Thu,  5 Jun 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109366; cv=none; b=tAuUkiYu2Bp64jsIG5hZ0TIyNxhq7y0AOXdc/FW2PLyh7V3O0rixxgiICRq9Httlji8+Gz4lkt1wPZpbn0fdBK9L/ITljzsvPoMZBRlc1WlmSFsmM3IOFIzNsBxzGVqcQY+7hxww3nrcaJUn9OGP9CQd5bhx1SG+baVEfH2sj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109366; c=relaxed/simple;
	bh=peuxk0dkEC2wxlfivCJMs9Q2+LO/nasgZkbrMNUpV4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nptVDvA8WfS2XX8yFJBkgz+pUWk3YCIunXMqklD8S7JvecqvS9C2SuYvBiN1vK6sfIitG4SInjBKcex/FIbjh4bbAT1zCuvTeXh6vBchJrhQXpcMbd5eYdnavUSMUDBi+6tG/G1Kdt/c8/6Kx84VeGxCGserDmJeK5PUvMjl3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dEzXuzzm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xaIgdKHQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dEzXuzzm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xaIgdKHQ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749109363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk7jUtyFriANUDP97nlPEEGavPhnHMbnB5cr3BLrlT4=;
	b=dEzXuzzm7qOiZMhDCY/Uud8J20wiBvShDbrLBHWRDku30PSJqFP9GmEhs/RJC9zsYW0i8i
	9rYw4AXFkvvQLl7qgc6YXVpqqOzax1c9YNeZKxww5TQ9Ekz8BRNXvuIIm7r7+QijfB8ApF
	wRzBCmdbCdc6EYW3F/zUMAy/mdDKNu8bI/KCDMWE2OZYOzNAOXXTJTmjhl975w0ML3QWs4
	lMqG4i6cqEVCQ3q8No7Xwqt+/9EbvxPRts8XVGYSlSbHgijpztY/cnU9BKzKbqVZF4rRkv
	mkwegLuyKU6mzdPM71WzW0VOUayNd6RWLkIarIs70Dd4klJ7YPc1V9wd9VH/CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749109363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk7jUtyFriANUDP97nlPEEGavPhnHMbnB5cr3BLrlT4=;
	b=xaIgdKHQsDFX9XqICsj59NIkOI0erRFCXhx9udCz/da7bXgApBUFttnk84VGCi7r9Uk1wC
	cfdfJoV3IOB1QEAQ==
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
In-Reply-To: <TY4PR01MB1377757DD5E7F27A41F0B4723D76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <SN6PR02MB41575419E1223B8A8B0A1F1FD46FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <TY4PR01MB1377757DD5E7F27A41F0B4723D76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Date: Thu, 05 Jun 2025 09:48:42 +0206
Message-ID: <84frgevdl9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-05, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
>> I've tested the fix in my primary environment (ARM64 VM in the Azure cloud), and I've seen no failures to stop a CPU. I kept my
>> custom logging in place, so I could confirm that the problem path is still happening, and the fix recovers from the problem path.
>> So the good results are not due to just a timing change. The "pr/ttyAMA0" task is still looping forever trying to get ownership
>> of the console, but it is doing so at a higher level in nbcon_kthread_func() and in calling nbcon_emit_one(), and interrupts are
>> enabled for part of the loop.
>> 
>> Full disclosure: I have a secondary environment, also an ARM64 VM in the Azure cloud, but running on an older version of
>> Hyper-V. In this environment I see the same custom logging results, and the "pr/ttyAMA0" task is indeed looping with
>> interrupts enabled. But for some reason, the CPU doesn't stop in response to IPI_CPU_STOP. I don't see any evidence that this
>> failure to stop is due to the Linux pl011 driver or nbcon. This older version of Hyper-V has a known problem in pl011 UART
>> emulation, and I have a theory on how that problem may be causing the failure to stop. It will take me some time to investigate
>> further, but based on what I know now, that investigation should not hold up this fix.
>> 
>> Michael
>
> Thank you for testing the patch.
> I'm concerned about the thread looping...

The thread would only loop if there is a backlog. But that backlog
should have been flushed atomically by the panic CPU.

Are you able to dump the kernel buffer and see if there are trailing
messages in the kernel buffer that did not get printed? I wonder if the
atomic printing is hanging or something.

John
