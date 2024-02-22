Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245573F20
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640971; cv=none; b=FRM9ueXxEMikTopynKyqJA5DOyAp67ML5PwGLfJpe+JXIodSdqIGdUFcqjDDpoM+nau5qUwVBn4B+uncr92RleqEhjv0LSBVDmRbCPh1gaU1YwPGonyht4WGTElYGrDlgRL27Z6STJ1YslNycp8hVd5+z6DMEsFNqI7yg2B07GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640971; c=relaxed/simple;
	bh=olKlT2pUuFeA7Wz0mKP8es2JWouUJWnDYsDKC+7z0wo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANlL3oj4BFJa12bPnqmy6zdpSSJxESSVLfFwLtE+5Nn5uz5RiLeX5Iq5CUAGZXG/TJpHCepNtDMB4Vq7zFfYJmEzAGcWKZn87DsqWtVj8cPPOm/pFh1UOEmUf/zkXDbmxZZcUbwuJ/kdlzWvI8ICmxaVBEZLzb7ztUBf8SKkznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id d659b229-d1d1-11ee-b972-005056bdfda7;
	Fri, 23 Feb 2024 00:29:27 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Fri, 23 Feb 2024 00:29:26 +0200
To: Federico Vaga <federico.vaga@cern.ch>
Cc: linux-serial@vger.kernel.org, jirislaby@kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>

Thu, Feb 22, 2024 at 10:21:38AM +0100, Federico Vaga kirjoitti:
> Dear all,
> 
> My previous email might got lost in some inbox. Allow me to retry to ping you to
> get some help in configuring the MOXA CP-132EL using the 8250 driver.

You need to Cc maintainers and relevant developers.

> On Mon, Jan 22, 2024 at 11:52:15AM +0100, Federico Vaga wrote:
> > Dear all,
> > 
> > I'm having problems in trying to use the MOXA CP-132EL card with the 8250 driver
> > on the stable kernel 5.10.192 (but I also tried the 6.1.70). It seems not to
> > work. As a note, to do my tests, I have a loop cable connecting the two on-board
> > serial ports.
> > 
> > I see this device should be supported by the 8250 code, in particular this
> > appears in 8250_pci.c
> > 
> > ```
> > $ git grep 132EL drivers/tty/
> > drivers/tty/serial/8250/8250_pci.c:#define PCI_DEVICE_ID_MOXA_CP132EL   0x1322
> > drivers/tty/serial/8250/8250_pci.c:     { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
> > ```
> > 
> > At boot time the device is correctly discovered, and it matches the driver.
> > Indeed two new tty interfaces appear under `/dev`
> > 
> > ```
> > $ dmesg | grep 0d:00.0
> > [    0.196175] pci 0000:0d:00.0: [1393:1322] type 00 class 0x070002
> > [    0.196350] pci 0000:0d:00.0: reg 0x10: [io  0x4000-0x403f]
> > [    0.196448] pci 0000:0d:00.0: reg 0x14: [mem 0xb0100000-0xb0100fff]
> > [    0.196534] pci 0000:0d:00.0: reg 0x18: [io  0x4040-0x404f]
> > [    0.197474] pci 0000:0d:00.0: supports D1 D2
> > [    0.197475] pci 0000:0d:00.0: PME# supported from D3hot
> > [    0.371301] 0000:0d:00.0: ttyS2 at MMIO 0xb0100000 (irq = 16, base_baud = 921600) is a ST16650
> > [    0.371832] 0000:0d:00.0: ttyS3 at MMIO 0xb0100200 (irq = 16, base_baud = 921600) is a ST16650
> > 
> > ```
> > 
> > The communication seems not to work. However, the communication works when using
> > the driver provided by MOXA (``mxupcie.ko``).

Shouldn't we use mxser in the kernel for MOXA?

        { PCI_DEVICE_DATA(MOXA, CP132,          2) }, 

> > The interesting thing is the following. Binding back the device to the 8250
> > serial driver after having loaded first the mxupcie makes it work. Translated
> > into a procedure:
> > 
> > 1. load 8250 serial driver
> > 2. make a test (FAIL)
> > 3. unbind device from 8250
> > 4. load mxupcie driver
> > 5. unbind device from mxupcie
> > 6. bind device to 8250
> > 7. make a test (SUCCESS)
> > 
> > This made me think of two possible cases:
> > 
> > 1. mxupcie applies a default serial configuration that works out-of-the-box
> > 2. mxupcie perform a hardware configuration that the 8250 is not doing
> > 
> > 
> > About option (1) I used ``stty -g`` to compare configurations right after
> > binding. But it seems exactly the same when using 8250 or mxupcie from MOXA.
> > 
> > 
> > ``` Using 8250
> > # stty -F /dev/ttyS3 -g
> > 500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
> > # stty -F /dev/ttyS2 -g
> > 500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
> > ```
> > 
> > ``` Using mxupcie
> > # stty -F /dev/ttyMUE0 -g
> > 500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
> > # stty -F /dev/ttyMUE1 -g
> > 500:5:cbd:8a3b:3:1c:7f:15:4:0:1:0:11:13:1a:0:12:f:17:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
> > ```
> > 
> > This makes me think that probably option (2) represents the problem, but due to
> > my limited knowledge with these two drivers (8250, mxupcie) and the device
> > (CP-132EL) I can not spot the problem in the code.
> > 
> > Therefore, I'm asking you: are you aware of such a problem with this card or
> > others from MOXA? Is there someone in the community who is using the 8250 driver
> > with MOXA devices?

-- 
With Best Regards,
Andy Shevchenko


