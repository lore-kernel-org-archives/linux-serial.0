Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135623;
	b=VqVnuTJsYqMOWNm5Qsye4M708u8PAmybX3xIemGgA4c0ZEBDtTNClJq1G4MfyWp1fQ4G
	 UVzmn5XVM8f6OBK1joKcz9Mq2sq/9tsA5Mz+Imm9JFm6yyETJXRGILwnFlaSi8FFBPZ8d
	 KS8BPd3rsK8oW8/vtYm3E3bIXmvU6M+FxsFgXl7l+BtVLtivn9pL60TOiSxezs5cy8csd
	 SGXQa3SQUIb64h2kFsTW7IrzATboBq3wVXEE5YOhabpvHNOaGFgUf3iykDSkd/HcmyjAR
	 M/Zaj0EQuzuc2um4eJIr1JyXuYEv5hpMXGjCiqBClWsgDTLE73ae+XBIBcLdBobH50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135623;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=Fc3GYSRmt0+nbblkQ7aAwD4YrkOtstST5jptPmqJKHg=;
	b=RnZws8crTRJt/Ozolwe3dKLzUMBM0BIm+5vWBxUFeKed9oFbE6x2HCfRCASm3oWYMqVO
	 7/uPHAEHfhrJMfVM84a3JYjHPVsvSzR7jJgXtObmv9ezzqTt7LNTYxLBDV0s6nXBpbmmH
	 VaghAQUv1QwNLU4qm7L5E9P2PI19UzSNgrR/XnQNe/chQ/SQKmDY8SKcxpExKPjWXabFQ
	 n6XFYZQNjGBCARvUDC0RfUZoCdkd4Py7rRGFBp9ckg5LS++1U1s/VzBYrrkuyHDiqBWrB
	 3RbN2zfE+vkN0uUV4ihzVfJkeonQO9alNOpabViR68nVaAxyhjT9MAsgCVHycFkZw4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03727606A31A;
	Tue, 27 Oct 2026 21:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03727606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7D10E92009D; Tue, 27 Oct 2026 22:13:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 75BE492009B;
	Tue, 27 Oct 2026 21:13:39 +0000 (GMT)
Date: Tue, 27 Oct 2026 21:13:39 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Cameron Williams <cang1@live.co.uk>, Jiri Slaby <jirislaby@kernel.org>, 
    Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>, 
    Josef Bacik <josef@toxicpanda.com>, Tony Lindgren <tony@atomide.com>, 
    Rafael Gago Castano <rgc@hms.se>, Florian Fainelli <f.fainelli@gmail.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    Marnix Rijnart <marnix.rijnart@iwell.eu>, stable <stable@kernel.org>
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
In-Reply-To: <auDB3QMuEGeNpaIk@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2610271928360.42255@angie.orcam.me.uk>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org> <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk> <auDB3QMuEGeNpaIk@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Oct 2026, Andy Shevchenko wrote:

> >  Hmm, what is "a malicious device" supposed to be, a broken chip?
> 
> Carefully reconstructed malicious device in FPGA that gets connected via
> Thunderbolt. This is real vector of attacks (assuming the Thunderbolt side is
> misconfigured to automatically authorise anything connected to it).

 Hmm, yeah, or ExpressCard.  I've thought someone could program an FPGA 
this way, but what would be the purpose?  They'd still have to persuade 
someone to plug such a EC/TB device in to their system and if you have 
physical access, you can do all kinds of stuff of less finesse anyway.

> IRL I don't believe it would ever happen as the result of this attack most
> likely would be minor if any.

 Nod.

> > 	if (!pci_oxsemi_tornado_p(dev) || pci_resource_len(dev, 0) < 8)
> > 		return -ENXIO;
> > 
> > 	p = pci_iomap(dev, 0, 5);
> 
> Why not 8 instead of 5?

 This code only accesses offsets 4:0 while BAR sizes come in powers of 2.  
I think the checks can be considered equivalent.  No strong opinion either 
way.

> > 	if (p == NULL)
> > 		return -ENOMEM;
> 
> This is so interesting... For MMIO it gives a page, I don't see how it can go
> outside the boundaries.

 I've double-checked the minimum memory space bus allocation size for PCI 
and it is 16, so indeed the check for the size isn't needed (beyond 16 
you'd have to validate so as not access another adjacent bus allocation, 
possibly for another device).

> For port based IO I think it can't be less than 4 for
> sure (due to PCI bits to interpret) and most likely can't be less than 8. But
> I have a weak memory of PCI specifications.

 Port space allocation can't happen with legitimate OxSemi configurations 
as this code is only ever reached with the native UART chip configuration. 
With the legacy UART configuration BAR0 only maps 8 conventional 8250 UART 
registers, but this is handled elsewhere.  Perhaps we need to assert that 
BAR0 is MMIO here before proceeding.

 NB it can go down to 4 for sure, no need to look far:

07:00.0 Parallel controller: Oxford Semiconductor Ltd OXPCIe952 Parallel Port (prog-if 02 [ECP])
	Subsystem: Oxford Semiconductor Ltd OXPCIe952 Parallel Port
	Flags: fast devsel, IRQ 35
	I/O ports at 1000 [size=8]
	I/O ports at 1008 [size=4]

 Overall it seems to me a lot of noise for a highly unlikely corner case.  
Most drivers have been written with an assumption that the device is 
legitimate and don't make any sanity checks.  Do we want to review them 
all now?

  Maciej
