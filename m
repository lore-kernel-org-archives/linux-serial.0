Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F42248A0;
	Wed,  4 Jun 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023543; cv=none; b=GQRE1Y9csLKZ4a2raSjYUFQwrBYBawUFQqRSHkRKSHB0C8t7kh27+ilfo2ARlfy198fFkWw3bWlyLpHHj8vJbCAjLDqQ0oUtONHj0gRg3UHxzXyQBkI4K2zOfzJpCtnX2QSqhGsuTdcNxsVfu2C2zAsGDq/5ltiIB5San7H6P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023543; c=relaxed/simple;
	bh=zyxXGaBMfIPnjIZy5o+hkiN3erFrYjY2CZBtiUW5JxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGhVUWO1jOnYPo13c7fgrWYaY07BqzM3L+GeSCnUDmD1rGSZDJf8Jo8HW5dkyc8ZzpBaTaog+N7aLM4j8p43dL1TSH94Uk4x3uV6UuR3JgYAqjdiSLSgQT+kuIbiHNVgXQiN0m67YRfZZNNbScP1F8s7ddae2mecW1Q4tXJy0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBG70Qvg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=psY2YnPH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBG70Qvg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="psY2YnPH"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749023540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaUBwKIEL6gYu/LhMMd/q2hSFrXFhJp+PTp1JhKEikg=;
	b=BBG70Qvg7fI5r/SBmAdFEu06d3IMuZuMq4Vi4Lo91jbiWSPT7QqEEJh+PcnjWMELb3Szjd
	L9oSzQStJ7sR+vBQx+M43+ranfV/BjiI3awSQP82ZKk4QSDrp5WFux8msZCeTqaMftxl0/
	6cxj49JeWUEZ4ROxvGj2ICjVObu4OTzq0j3CLK4BBtpOOHtzYqtcT0DP4VQV/zr69m6Q3D
	6RzjW/qdVIxatvS5ptEDE2r8axsDlRqcQ17JGFSRQcoND5lznMW1HqvdUREBSI6T/aZSUZ
	W1WH6SbYnCQAXv+iKOO1e4IkPBoEODztXQfXDnCPlFL5p7RZE86kcUppeJTxYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749023540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaUBwKIEL6gYu/LhMMd/q2hSFrXFhJp+PTp1JhKEikg=;
	b=psY2YnPHoLBZUoEQmkEOMxqILHQXXXfL7mmtNEiRqoU8yoAAegO6WTHBsHdrhrRw0Wlcp3
	ZOLksnkr5Bqu+jDg==
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
In-Reply-To: <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Date: Wed, 04 Jun 2025 09:58:19 +0206
Message-ID: <84tt4wndu4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-04, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> This is a proposed fix to force termination by returning false from
> nbcon_reacquire_nobuf when a panic occurs within pl011_console_write_thread.
>  (I believe this is similar to what John suggested in his previous reply.)
>
> While I couldn't reproduce the issue using sysrq-trigger in my environment
>  (It seemed that the panic was being executed before the thread processing),
> I did observe nbcon_reacquire_nobuf failing to complete when injecting an
> NMI (SError) during pl011_console_write_thread. 
> Applying this fix seems to have resolved the "SMP: failed to stop secondary
> CPUs" issue.
>
> This patch is for test.
> Modifications to imx and other drivers, as well as adding __must_check, 
> will likely be required.
>
> Michael, could you please test this fix in your environment?
>
> Regards,
> Toshiyuki Sato
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 11d650975..c3a2b22e6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2577,8 +2577,10 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
>  		}
>  	}
>  
> -	while (!nbcon_enter_unsafe(wctxt))
> -		nbcon_reacquire_nobuf(wctxt);
> +	while (!nbcon_enter_unsafe(wctxt)) {

I realize this is just a test patch. But for the real patch, there needs
to be some comment here about bailing out. On panic, the driver is
leaving the clock enabled and not restoring REG_CR. At a quick glance
this appears to be a bug. So the comment is needed to make it clear that
the driver is exiting on purpose without proper completion. And perhaps
also mentioning why this is safe during panic. Thanks.

> +		if (!nbcon_reacquire_nobuf(wctxt))
> +			return;
> +	}
>  
>  	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
>  		cpu_relax();

John Ogness
