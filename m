Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111371;
	b=FqgLNkPbatwNbAnBGJfIDEjgUSGLIowns7hpePlKwBEaarrBYu+yATKvBgCFyzm5Jar6
	 MD0yT9cj1ji+5TJlf14bngT5pdoP4hhshy+iv5oeAc3jZXvNNMlKZoqnSzXVMJcrU5a/l
	 zWpjSuaxxy8NUb4KaZx7xQgnY8C1iCS7xqPlLFAA2Xe3vcykUSYq8gXX5dZ2LnYvOa2AP
	 eVNCaTG2mxmHRY9Kd5e9lYNGTWClRINQdTcGYfANM2XCTABT4VQMBRdtMRf7zVVjt9MFL
	 3bfNolXCFa6OLNh8+a8mhJahPVu5dVyO7Kid/G2Fr4GsZ2eF2MOd8VbVLEaSRonE7Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111371;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=xqv3/WZDttv92aMuY50epWeQYW5OprQqcoNgsC7ZetA=;
	b=Ek+jjwFjmnVOLB2NwxPKrwyyXWyigbjB7wADpyRxbWyionwv0j6nfv2vMrBzZ0vTtwuc
	 ofG3VpmknabLp/TJfQaqITcApeAmx8zj5uJe7xoez8uPmIvdCG5h1GY88zSqaKPFllixC
	 itiHLfaH87tosxSWOKd8OuRyZlFc2ZfzvzGcECkksclogrbnhaValYSJ/sQqG/E/ZRcDZ
	 ju/HZtB0GQtqInTESTDHnOySlBu4Sewx70y56Ebz1yavmOC8GtYLDvAGNTn6HnPfKkmcj
	 7aN8kWiHyUkoSlRxkgGOPWZgETOyvmacBmiZNfHFXatedXHVfDNd5zyxFYTDnpEPCIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAC606A329;
	Tue, 27 Oct 2026 14:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACBAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 320E492009C; Tue, 27 Oct 2026 15:29:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2B09292009B;
	Tue, 27 Oct 2026 14:29:21 +0000 (GMT)
Date: Tue, 27 Oct 2026 14:29:21 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Cameron Williams <cang1@live.co.uk>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
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
In-Reply-To: <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
Message-ID: <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
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

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> pci_oxsemi_tornado_init() reads the UART count from device-controlled
> BAR0 memory without validation, allowing a malicious device to report up
> to 255 ports. Cap the device-reported count against what actually fits
> in the BAR using the Tornado register layout.

 Hmm, what is "a malicious device" supposed to be, a broken chip?

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 1dda63be6b89..9919504334bb 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
>  	/* Tornado device */
>  	if (deviceID == 0x07000200) {
>  		number_uarts = ioread8(p + 4);
> +
> +		/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
> +		bar_len = pci_resource_len(dev, 0);
> +		if (bar_len >= 0x1000)
> +			number_uarts = min_t(unsigned int, number_uarts,
> +					     (bar_len - 0x1000) / 0x200);
> +		else
> +			number_uarts = 0;
> +

 Technically an overkill and duplicating the FL_REGION_SZ_CAP feature 
rather than making use of it, and then falsifying the actual number of 
ports report in the kernel log (which I think ought to be accurate even if 
do clamp the number).

 Sashiko is however right that this function ought to return an error 
rather than 0, and also should BAR0 be smaller than 8, we already violate 
access with the ioread8() call quoted (and possibly ioread32() earlier 
on).

 So I think overall this ought to look like (unchecked):

static int pci_oxsemi_tornado_init(struct pci_dev *dev)
{
	u8 __iomem *p;
	unsigned long deviceID;
	int number_uarts = -ENXIO;

	if (!pci_oxsemi_tornado_p(dev) || pci_resource_len(dev, 0) < 8)
		return -ENXIO;

	p = pci_iomap(dev, 0, 5);
	if (p == NULL)
		return -ENOMEM;

	deviceID = ioread32(p);
	/* Tornado device */
	if (deviceID == 0x07000200) {
		number_uarts = ioread8(p + 4);
		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
			number_uarts,
			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
			"EndRun" : "Oxford");
		if (number_uarts < 1)
			number_uarts = -ENXIO;
	}
	pci_iounmap(dev, p);
	return number_uarts;
}

with the FL_REGION_SZ_CAP flag set for the relevant entries, and possibly 
setting ->num_ports to 0 too since we need to determine that at run time.

 Not sure how this interferes with Brainboxes devices, support for which 
seems not to have been fully merged given that pci_oxsemi_tornado_p() does 
not let PCI_VENDOR_ID_INTASHIELD devices through.  Cameron?

 NB BAR0 size is 16k by the spec and the maximum # of UARTs is 16, for a 
dual-OXPCIe958 master/slave setup, still leaving 4k of the available space 
unoccupied.

  Maciej
