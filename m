Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD80256A
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641264; cv=none; b=cmjMltVJjSpjqzoNG/y1SPwHK9RQDXissPtXpOn7RE0Za93aOiB+k+rEbvmueUqQ9TeusJ+7nEoa5ogF+NetSjiOPyKIzAkso4dsMO7RTbKWlFny8t5sCdY1IYfAxucsU2NM+NkJ+SRH8ZMaZ8WvNJzD9kGQM6O+tO4iF6u303M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641264; c=relaxed/simple;
	bh=bzS7+2svadIoLPZOgfYoAlisC09g0peAwRZFKFWFb+s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcGVcUcuG+gtVuCh5s80fMz8E7LLDtlGd3exJvmrJqQtWB23e2EVaQtW25j7fvSqTk4txyQpYkvNYoVKcELTGgH67lpQsk63yyFBCFTlWhHsuS4vSi4/dpqJgL+FAV82Gs4OUILvw6DN4os1zKcaEDlClbjqxkaYJAdDrUfZ6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 84e549d2-d1d2-11ee-a9de-005056bdf889;
	Fri, 23 Feb 2024 00:34:20 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Fri, 23 Feb 2024 00:34:19 +0200
To: andy.shevchenko@gmail.com
Cc: Federico Vaga <federico.vaga@cern.ch>, linux-serial@vger.kernel.org,
	jirislaby@kernel.org, gregkh@linuxfoundation.org
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <ZdfL68clwFIYI4tG@surfacebook.localdomain>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
 <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdfKxqwuJZodRDbz@surfacebook.localdomain>

Fri, Feb 23, 2024 at 12:29:26AM +0200, andy.shevchenko@gmail.com kirjoitti:
> Thu, Feb 22, 2024 at 10:21:38AM +0100, Federico Vaga kirjoitti:
> > On Mon, Jan 22, 2024 at 11:52:15AM +0100, Federico Vaga wrote:

...

> > > I'm having problems in trying to use the MOXA CP-132EL card with the 8250 driver
> > > on the stable kernel 5.10.192 (but I also tried the 6.1.70). It seems not to
> > > work. As a note, to do my tests, I have a loop cable connecting the two on-board
> > > serial ports.
> > > 
> > > I see this device should be supported by the 8250 code, in particular this
> > > appears in 8250_pci.c
> > > 
> > > ```
> > > $ git grep 132EL drivers/tty/
> > > drivers/tty/serial/8250/8250_pci.c:#define PCI_DEVICE_ID_MOXA_CP132EL   0x1322
> > > drivers/tty/serial/8250/8250_pci.c:     { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
> > > ```
> > > 
> > > At boot time the device is correctly discovered, and it matches the driver.
> > > Indeed two new tty interfaces appear under `/dev`
> > > 
> > > ```
> > > $ dmesg | grep 0d:00.0
> > > [    0.196175] pci 0000:0d:00.0: [1393:1322] type 00 class 0x070002
> > > [    0.196350] pci 0000:0d:00.0: reg 0x10: [io  0x4000-0x403f]
> > > [    0.196448] pci 0000:0d:00.0: reg 0x14: [mem 0xb0100000-0xb0100fff]
> > > [    0.196534] pci 0000:0d:00.0: reg 0x18: [io  0x4040-0x404f]
> > > [    0.197474] pci 0000:0d:00.0: supports D1 D2
> > > [    0.197475] pci 0000:0d:00.0: PME# supported from D3hot
> > > [    0.371301] 0000:0d:00.0: ttyS2 at MMIO 0xb0100000 (irq = 16, base_baud = 921600) is a ST16650
> > > [    0.371832] 0000:0d:00.0: ttyS3 at MMIO 0xb0100200 (irq = 16, base_baud = 921600) is a ST16650
> > > 
> > > ```
> > > 
> > > The communication seems not to work. However, the communication works when using
> > > the driver provided by MOXA (``mxupcie.ko``).
> 
> Shouldn't we use mxser in the kernel for MOXA?
> 
>         { PCI_DEVICE_DATA(MOXA, CP132,          2) }, 

Ah, letters matter, we have only these there

#define PCI_DEVICE_ID_MOXA_CP132        0x1320
#define PCI_DEVICE_ID_MOXA_CP132U       0x1321 

But maybe it should also support 0x1322? Dunno, I believe Jiri knows better.

> > > The interesting thing is the following. Binding back the device to the 8250
> > > serial driver after having loaded first the mxupcie makes it work.

-- 
With Best Regards,
Andy Shevchenko


