Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F319E7FF;
	Thu,  5 Sep 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545128; cv=none; b=md8AuOBBM1aD1zwsvjQML2wQve5doTXeoQB3g2uWHprkCF8HaKAKlXvCkzjpRMTzwf+zA8awrAvZWh6OaGAV7tLr0unW0XQrpaAP1dFVmv4dAcQ29A1M4FYJZiOVmF+6N5bHxcpoxkw95JH9m/3AQR7oUuG/+eOKlmHu3pLnXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545128; c=relaxed/simple;
	bh=6v9VPGM4pvu1/xFiMRSmrBwbBvLzdjDH3ub2Kxsdhpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqUaK3RbTT6Sv0i+PgkD9oV5lHFpNfLxNyGn4Pm8ax/ErqAJuGoOZ77c0J8QlGyDXbnZhUsp/ZgdbzPpp9h3ABAX+zFisQpUnEwQn091qNJjN1gK8HRBs4U1ovwNJXL8CiaSUCCfRTykphKc9kSKNsIebDMne9PPFbx6qUrg/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TX31WWjk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0LNvuTr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TX31WWjk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0LNvuTr"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725545125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXitXmzzlbgIR1I6ztC2uUDK+7jU4F+SSdzUU4lXjSA=;
	b=TX31WWjkflE6QfBvD13ZEdlwxFhPkkQVDgbsnSNey8W9SucLDGvJyOAQ6r2dBny92B0zHU
	cAoguX5gbHD12NJEsz09loDAaiRvqR9DyhNuoht+vjctNB7stiD+x3yErE9+fF1MnVF5kL
	mXok/rTMNCXT1faKT9za2LmvhovUgTVjkG1D5QaYL/9Cotgi86MOqzpQl61nSXPW4SV2qF
	OUR2hhBMzFB74kZwFPaVLe7X4JAJIVEDztSqIvBeNLwE/m8aT9aQta2zKhQT1fbdxVOwdk
	pupjGie4Cz2tMFLlNMRGAm2CRLzbVchNEBd3JfK2+PPsI95AQxtF2ELcYEhLSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725545125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EXitXmzzlbgIR1I6ztC2uUDK+7jU4F+SSdzUU4lXjSA=;
	b=v0LNvuTru5cmQbqoCJlTiDDTjjKvYbJRPgFee87LCKcCxutUwVyLrfhG285Y6fyXRSpchG
	IWz7EUEzc3FcNRAQ==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Lino
 Sanfilippo <l.sanfilippo@kunbus.com>, Derek Barbosa <debarbos@redhat.com>
Subject: Re: [PATCH tty-next v1 0/2] convert 8250 to nbcon
In-Reply-To: <Ztm36qPI7fVteSX_@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <Ztm36qPI7fVteSX_@smile.fi.intel.com>
Date: Thu, 05 Sep 2024 16:11:24 +0206
Message-ID: <87frqe2o2j.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-05, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> $  cat /proc/consoles
>> ttyS0                -W- (EC N  a)    4:64
>> 
>> The 'N' shows that it is an NBCON console.
>> 
>> There will also be a dedicated printing kthread. For example:
>> 
>> $ ps ax | grep pr/
>>    16 root       0:00 [pr/ttyS0]
>
> Wondering if this can use the DEVNAME instead of opaque (to some extent) ttySx?
> Or is it using the same what has been passed to the console= kernel command line
> parameter?

fs/proc/consoles.c:show_console_dev() is just using:

"%s%d", con->name, con->index

The same goes for drivers/tty/tty_io.c:show_cons_active(), which is
responsible for the contents of:

/sys/devices/virtual/tty/console/active

John Ogness
