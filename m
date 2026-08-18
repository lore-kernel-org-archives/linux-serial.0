Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA43B5319
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068412; cv=none; b=uJuBlL12Dsui8NeaLWo2UtWmg5Lqzjjt9/zXSrzW4heAhq76UNCG9NZoMBtJNpCnCQHGbVV344FS71103YMn6bbOZY/NwF+0ciDP5ss2gvlV7gvJPma1fDYPE4QerSdSWtc87TIDOl5X7Z6jlajlZQklPPKbkB2IcpExc7Y6wl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068412; c=relaxed/simple;
	bh=tS0sEv+m5DRCz3lExErTZgJcWpr+2cKH0uieATYUxIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r072cuBe62z0Lni70XmcRR3MQtgDBIEMJB2rvu2Aclp9sXQfiXWMZGXDmGmAZ+bXaeveJ0bnQ+5xUCnQ3zGDMl0TKxgfZ8CbgsfpBHrJ45pYXfIdvzi+PexZPKutGJCEd1Dg76qM9IUZUEc3BRY/mgFruuDVMUCl2vA8QJCBFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JSfxNfNB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JSfxNfNB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so33705365e9.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787068409; x=1787673209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Alr9XBhyLRgMVmzv9/uueizUdhpYjxx8XekBqdVYwg=;
        b=JSfxNfNBRQ4XGWi5IN6pmYNllIVTyPEH4vJ3HwlvGAmAlo3d9syE8BWM/L7XydgzMi
         UnWItE3ctyO0vaaVisMJH3ZeyWHjRb106vskqYapWehQ7QxCQsi9X0EG6sfxGuWlxCIh
         GoCETG1jjTM8zc9ASTsyUerY8QDUjUzvGstAZPuviBk6Xb2NJmM5cMln5EgKm/+K0qDk
         JWaZaeRIXMAq0W8t8ByEkFkY1VpwPiT3AK+3S7MkbdKvHhmO1o6JjEh6j5tiur1YDAj7
         o42ZVuh9UcbKXmBqPGqXJmA8BQ+jRcRitfr1d5+oD+itPGCUXf8U2vs7CtolioMIkJkf
         CpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068409; x=1787673209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Alr9XBhyLRgMVmzv9/uueizUdhpYjxx8XekBqdVYwg=;
        b=Ljpnadb2OkxgXTZwFS4zixiVJXLJq49CCXQuUAgQ62k4w1HRP/S0Ve0qGLg3f1SiFc
         QMW/CU7O/Fy5W+2QkMSh6+pQoB3o+X+OiY2HDMcfH5yAIOEUX4ui/sXnymGFPwv0fch+
         Di693l3ISiALyqc5b6UQ22xDWiV1sSaNMfwFGXZfM1be2l/n8d92UebrITbo0mAjEtjJ
         T3rpDrIy0RIMq0//XUKXYVEvjT5ZeLuYQoHb3XLUHCRCykrXwfGieuVjgh4J8sV5nVz8
         GmSw3XA/mzzmd7AZUl+E0d+M91qr3wxo4HiRbmtFCEF5mG9J4RyGJl7NRQvBiafOFEHl
         lf4A==
X-Forwarded-Encrypted: i=1; AHgh+RqPze7/H0kVgwmETfc7hicGgrpsW58ZCRJpCtSeQQA6icUHuZhrlSvqjAl+vCqerTV6s2CoqTotjoUMuZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWkCvlpCtAZ6ifIWZJiEyWmBO4vq0PKuyIC2cvAl6FICIHQzp
	TkiQnmgKzbq/B6Ru+gw+I3lYsS+VdOftJP7M5FI7d+mmbcqLvoJqBlLssbj8mlJDwDU=
X-Gm-Gg: AR+sD13itj4ev4jzNd2Tx5jbyL+bY4tjUkF5oY/SCqJh/Yx1gTyT/oAZ7rwJcAxvBII
	sZZGNbBJWtgxpDZrulIvTkYtuGalrqhC/iVu+ryxRwucWLqlY1Yhxizvb1ptsp0A9/O2V77p0be
	fUgEHkuZXvCaQGvERh6TQQWmvJ3ZPXEnY/EzOpYKHOv35szZ1Xi5wbjGpocO9CPEboERCdYs9/5
	dKwuxLnhp6leZP6GrudjbzjPuuDXwe2BxRdvB3O3b8JxYPGBB4RhT2K8kuog+dAK4gQRRkC8M0r
	z0MPayBgmj8AM8GHivS6Ipx/fO26WHI9VhSGAKfbe8Z1I5UTu31XBiJ/PEcbxKT/vpUxU8+E9zG
	thNsHZLoY270ene09iZzsewfxxYXtj9EyYSzg4K7ye6D0j/ohKatPRcBuKM8St/av5pEjRaApBy
	Tiyuz9GalMg1uVfj2UkJkZ3bbVUwGpT0MechbUS/Mzf6jEvXNwiZUwLEMdoND3i4H4C8U=
X-Received: by 2002:a05:600c:c3cd:20b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-499a277e9bbmr101545005e9.3.1787068408984;
        Tue, 18 Aug 2026 08:53:28 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b43dsm12524486f8f.12.2026.08.18.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:53:28 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:53:26 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>

On Tue 2026-08-18 13:19:12, Jon Hunter wrote:
> Hi Petr,
> 
> On 18/08/2026 08:51, Petr Mladek wrote:
> 
> ...
> 
> > > This change is causing a boot regression for our Tegra20 and Tegra30
> > > platforms. Reverting this on top of -next fixes the issue. Previously with
> > > V5 I did not see a boot issue only an issue in suspend. So far I have not
> > > had chance to dig any further.
> > 
> > Interesting.
> > 
> > Another clue, mentioned in the v9 thread [1], is that the boot
> > regression does not happen with v11 when "keep_bootcon" option
> > is used.
> > 
> > The "keep_bootcon" option causes that the boot console driver stays
> > registered even when the full featured driver gets registered
> > later.
> > 
> > The most important effect is that the printk kthreads can't
> > be used as long as any boot console driver is registered.
> > All drivers need to be called in the legacy loop in this case.
> > There are two reasons for this:
> > 
> >    1. Boot console drivers are synchronized only by
> >       the legacy console_lock (console_sem). port->lock
> >       is available only for the full featured driver.
> > 
> >    2. There is no easy way to match boot console and
> >       full featured console drivers working on the same
> >       HW.
> > 
> > So, the regression seems to happen when the printk kthreads
> > start being used.
> > 
> > Jon, could you please share the full log when "keep_bootcon"
> > is used?
> 
> 
> Yes absolutely. You can find the boot log here [0]. So far nothing really
> stands out to me but let me know if you see anything.
> 
> [0] https://pastebin.com/FhQVSqfy

Thanks for the log.

One or two things look strange/important to me.
But let me show all important parts:

[    0.000000] Kernel command line: console=ttyS0,115200n8 console=tty1 earlycon ignore_loglevel root=/dev/nfs rw ip=192.168.99.2:192.168.99.1:192.168.99.1:255.255.255.0::eth0:off nfsroot=192.168.99.1:/home/ausvrl81292/nfsroot,tcp rootwait keep_bootcon

The last "console=" parameter is "console=tty1". It is a so called
preferred console. It has several effects:

   + it should get associated with /dev/console

   + it does not replay the log from the beginning when
     registered. Only newer messages are shown.

   + Boot consoles should get unregistered when this console
     gets registered (unless keep_bootcon is defined).

Note that "ttyS0" is _not_ the _preferred_console. As a result:

   + it will replay all messages when registered

   + boot console won't get unregistered when this one
     is registered


Now, the ordering is:

[    0.000000] earlycon: uart0 MMIO:0x70006300 (options '115200n8')
[    0.000000] printk: legacy bootconsole [uart0] enabled

   First, earlycon is registered thanks because of the "earlycon"
   parameter.

[    0.036461] Console: colour dummy device 80x30
[    0.041020] printk: legacy console [tty1] enabled

   Second, the graphical "tty1" gets registered because
   of the "console=tty1" parameter.

   Normally, the boot console should get unregistered at
   this point. But it stays because of the "keep_bootcon"
   parameter.

[    0.645646] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.655230] printk: console [ttyS0] disabled

   IMPORTANT: This is the weird thing! I do not understand why "ttySO"
	gets disabled when it has not been registered yet.

[    0.659964] 70006300.serial: ttyS0 MMIO32:0x70006300 (irq = 51, base_baud = 13500000) is a Tegra
[    0.000000] Booting Linux on physical CPU 0x0
[    0.669026] printk: console [ttyS0] enabled

   The real "ttyS0" driver has been registered (added to
   console_list) and the legacy loop started flushing
   the messages in console_unlock().

   The real "ttyS0" console driver started emitting messages
   from the beginning.

   The boot console driver emits only the newly added messages
   "printk: console [ttyS0] enabled".

[    0.000000] Linux version 7.2.0-next-20260817 (jonathanh@build-jonathanh-noble-20260527) (arm-buildroot-linux-gnueabihf-gcc.br_real (Buildroot 2021.11-11272-ge2962af) 13.2.0, GNU ld (GNU Binutils) 2.42) #15 SMP PREEMPT Tue Aug 18 04:56:56 UTC 2026
[    0.000000] CPU: ARMv7 Processor [411fc090] revision 0 (ARMv7), cr=10c5387d

   The real "ttyS0" console driver replays the entire log.

[    0.659964] 70006300.serial: ttyS0 MMIO32:0x70006300 (irq = 51, base_baud = 13500000) is a Tegra
[    0.669026] printk: console [ttyS0] enabled


   And then all messages are emitted twice (by the boot console
   driver and by the real console driver:

[    1.574761] loop: module loaded
[    1.574761] loop: module loaded
[    1.584820] CAN device driver interface
[    1.584820] CAN device driver interface

   The real console driver would normally emit these messages
   from the printk kthread. But it does it in the legacy loop
   because the boot console driver is still registered.

[    2.904178] ------------[ cut here ]------------
[    2.904178] ------------[ cut here ]------------
[    2.913507] WARNING: drivers/soc/tegra/pmc.c:4999 at tegra_pmc_enter_suspend_mode+0x168/0x178, CPU#0: swapper/0/0
[    2.913507] WARNING: drivers/soc/tegra/pmc.c:4999 at tegra_pmc_enter_suspend_mode+0x168/0x178, CPU#0: swapper/0/0

  IMPORTANT: This is a warning. It is printed with
	NBCON_PRIO_EMERGENCY. These messages would normally
	get flushed by nbcon_atomic_flush_pending() directly
	from printk() using con->write_atomic(). It would
	take over the console ownership from the kthread
	when needed.

	In this particular log, it is emitted from the legacy
	loop in console_unlock() because the boot console
	is still registered.


Summary:

Almost everything works as expected except for:

  1. I am not sure why "printk: console [ttyS0] disabled" is printed.
     It does not make any sense to me.

  2. The WARNING would be handled with NBCON_PRIO_EMERGENCY.
     I wonder if this warning happened also with "v5" of this
     patchset.

Why is the WARNING important?

   If the WARNING happened also with v5 of this patchset
   then it tested emergency mode as well. But the system
   booted with v5. So that a difference between v5 and v11
   patchset might be important.

   If The WARNING did _not_ happen with v5 then we probably did
   not test the emergency mode in this version. So that
   the problem might be in the emergency mode handling.



Ideas for testing:

1. I wonder if adding a WARN() with v5 of this patchset
   would make v5 fail as well.

2. If wonder if boot_delay=10 makes any difference. It might
   prevent some races.

Best Regards,
Petr
