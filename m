Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352292E7BBE;
	Thu,  3 Jul 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554937; cv=none; b=fQF/VUe92hr/sQpR2An1YnhRLRv5g1TV1xHlf5Fo3ZSGHHh/O97QyGQoXDx7yVrj2KCF4MoG+wYM2d85WlAMwq7VlIox2NhWKEXlmlNVz17/D4TLd80Z3NWhNVQ/hUYFEiNtd06JGqgRU/xVE7NqbJo1JCkW7k+Gi0hoLtPRR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554937; c=relaxed/simple;
	bh=Zl8BffPR8rnREgtYfU4AlvafGOWoybBGrZam8tP38lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB1KrNKxHffnywSnH3dNYLANrFlK0/xM8Bbwa4XLS93wHuYpElCTpfrw4XLhxHFGnYrOFl3Ux6KSE+b3vlAO2jdW1LnlOJS8HjIY2HJpGHJpMwHezRT0K6jxmow5f9ZVBZwhZoFxhXf4xYNxP8hIrosB02eS2TWIPEktKJSlXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b5165cf5so35973e87.0;
        Thu, 03 Jul 2025 08:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554933; x=1752159733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9fsm/GMzU4nqbcKsxS9glFMOJCYfvJ+oEJCI8KRLbc=;
        b=PJU4cT0uOY/0ECVl0v4KXglriusYfc51ZAOcNn04ZQPMg43cP+RmuaYRnHp6J18My3
         cWOQHAey+OpbW+H+FyeUj1XpIqbtbInRAYUhHQox01XI5/ORZaNRLlSiUxx4qYx4D1Al
         LXQj6cKqwmwbNwUCZfoQTVxrfhSdhImjmljNf6yDVOTik3IvVYquFRyR0bT2WcN/50Lk
         9hcVTcwS0dYfz5VhqzpIcCAViqwwbgD87wKA0BQ0dMshbd0X+SbPDKCFV+eoIglZlzw9
         70xK0M05oRsLDX2TscsS6wsnJqhe0xS//SMKQXY+895UG8Jxmm6WMi+kJRL8mXOQF//i
         OTyw==
X-Forwarded-Encrypted: i=1; AJvYcCUUlc/LKK2+2dunCgBDwRxCAwEfDriKVV6p1aOPLgt5FvdT9l4pH4wDS5QBx+jgxcsEMU//KUosO3kN0kM=@vger.kernel.org, AJvYcCWNlyy2oRdGR6u9JErKzrVfy2/7b79ilrfsPEi8ipw4KRWWOtyuNh7snWJLXrj+Erushl7QtBwvdRo3hkOF@vger.kernel.org
X-Gm-Message-State: AOJu0YztydbDhioPqv+26o21PsNDovquQPPy3n05+h9mfjivgiEaYRc6
	C5wreNJC/vjTUnIYI9pawRIQLjlRMhYpvojj4HlM+RLo73x1r9n/zZzNgBqN6032
X-Gm-Gg: ASbGncvqUcMw+UN/OZorD07WqzfzarCAg8cHffXPtqf/WKOqn92THn3pph2gATapwX7
	qO0088E7oEFZwtFLqUAp1rrflwE8pEAA2LnRxW0CipQ4fUpcnwuVBJHWWi1lVLg1D+HMfIbgdnR
	qssOWJpQpkiFFdIxNS39/yXDA+5eu84zv89ISjWg0pH9CwEcb6YQ46kY6lsGhSFnNcpCJnh7/eN
	C019XLhb85FGRnnGyA4XgqY6kIB4ghikshO/+dsNThc2V0X/hzasTexlH4QncvzFPPBFxlvYeDC
	iK0PI23UpwAY6DdoWizydLai+inxweNs+6XUDP8XNXYeXOqL6KchCmb+Yg1tzuLp7vo/ivG5Qu0
	=
X-Google-Smtp-Source: AGHT+IEri2yurMSh6ssyzS0tOyLJvejqQ9bKtd90V7OhU858+wxFHpFvVOr1IMzHvMpLeoNexrxbtw==
X-Received: by 2002:a05:6402:2549:b0:608:a7a0:48 with SMTP id 4fb4d7f45d1cf-60e71e50e18mr3056093a12.28.1751554918954;
        Thu, 03 Jul 2025 08:01:58 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::4:6e61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c826f6788sm10500440a12.0.2025.07.03.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:01:58 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:01:54 +0100
From: Breno Leitao <leitao@debian.org>
To: Leo Yan <leo.yan@arm.com>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGabYkQixrVeYlLD@gmail.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <20250702172036.GC1039028@e132581.arm.com>
 <aGZVP8A2a3VVQwzt@gmail.com>
 <20250703114557.GD1039028@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703114557.GD1039028@e132581.arm.com>

Hello Leo,

On Thu, Jul 03, 2025 at 12:45:57PM +0100, Leo Yan wrote:
> On Thu, Jul 03, 2025 at 03:02:39AM -0700, Breno Leitao wrote:
> > > In some cases, if normal world and secure world share the same UART
> > > port, it can cause the UART state machine malfunction and long wait.
> > 
> > I don't know how to check it for sure, but, looking at the serial
> > console output, I don't see anything else using the UART. The only
> > output I see on the console at that time is coming from linux kernel.
> > 
> > Would you recommend any additional check?
> 
> I have no experience in the driver, I should avoid any noise. But two
> things in my head for quick trying.
> 
> - First, you could try earlycon mode, e.g., add option in kernel
>   command line:
>   
>     earlycon=pl011,mmio32,0xc280000
>     earlycon=pl011,0xc280000
> 
>   This would be possible to give more printing logs. If earlycon works
>   well, then the issue might be caused by later init code (clock, or
>   UART driver itself).

That is an interesting experiment, thanks for the heads-up.

I got `earlycon=pl011,mmio32,0xc280000` working, the machine boots fine,
and I see different behaviours.

Booting up the system the following lines (as examples):

	[    0.000000] earlycon: pl11 at MMIO32 0x000000000c280000 (options '115200')
	[    0.000000] printk: legacy bootconsole [pl11] enabled
	[    0.493205] smp: Brought up 1 node, 72 CPUs
	[    4.232864] SMP: Total of 72 processors activated.
	[    4.242788] CPU: All CPU(s) started at EL2
	[    6.318137] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
	[    6.978245] netpoll: netconsole: local port 6666
	[    7.234429] Run /init as init process

Also, I have a trace_printk() in pl011_console_write_atomic, and it only
start later in the code. More precisely at:

       swapper/0-1       [000] dN.1.     6.334581: pl011_console_write_atomic: Printing 49 [    6.334573] printk: console [ttyAMA0] enabled

I understand that the early boot messages got sent by some other
function? (Or maybe the tracing framework was not initialized?)

Anyway, pl011_console_write_atomic() continues to call ~20K times cpu_relax()
waiting for the BUSY bit to disappear, as before.

For comparison, these are the same line as above, when earlycon is not
set:

	[    0.154009] smp: Brought up 1 node, 72 CPUs
	[    0.154012] SMP: Total of 72 processors activated.
	[    0.154013] CPU: All CPU(s) started at EL2
	[    0.466949] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
	[    0.466967] printk: console [ttyAMA0] enabled
	[    0.466949] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
	[    5.513307] smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5001000000 ns for CPU#05 do_nothing+0x0/0x10(0x0).
	[   10.719305] netpoll: netconsole: local port 6666
	[   10.961798] Run /init as init process


From what I see, using earlycon boots the kernel faster. Here are some
ideas I got:

	1) Earlycon enables the message to be printed earlier, thus, it smooth
	out the serial console

	2) without earlycon, the messages are printed at once, with interrupt
	disabled
	 2.a) This causes CSD locks
	 2.b) CSD locks caused an additional 3 seconds delay

	3) pl011_console_write_atomic is slow on both cases

Thanks for the good suggestion,
--breno
