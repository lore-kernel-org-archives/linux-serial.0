Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100820;
	b=NJH/+uV8kCRSkH3bcVSzhMszizicik0Zm1Fpn7q8wCik0Q7MGcMRsTjpMPVYJCA3F91I
	 d13UZ8XtzdhQU0IijGjWVhd8SQkrUKHBmbM++SeGzMKoOQ2Vag3fWvjd2iOUPm7uxVdfK
	 PgIlvtdW3x1iOPrDD6U4/dfYlwZvJ/X2DJ5iSn+9I8f9RzAeRHCIap4CBYaPZSU3+Gozj
	 R3HvyqYBAp0mCpBjBVsScUpie5hv3P/lDxM3ipDgGtAv3ZQEc77QBcp8mT5FF98S9u/7A
	 UBpSYzRhWyS23bB4kH0KIeHm2CNRlj229y4++j+UMF+zi9z+8J4iqetI0tL0YAJ3loQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=kJDjNU0dZaCl7vq80j34Y7JKA/POP5UfhMbpxoRWU9o=;
	b=m9k/XshS5hNSWxQosY5ENetDYBS/Vy5TZWO4EgLDY6B7yh4NQ2m6nyptNLhc+X+CZLJJ
	 UjziLlJ1yvvlVoQ8j/37hqhFFJKgmeLGSTVSX71u+wZ9kYRi4ZZt8amjqtjvMEZAPOfqX
	 Pwhvh+y45i/YoGICYjrBCjmVxbEYdawUX0P/S+kOrif3Q3LsVoqI5IB+6Sh7j7KT2FaLN
	 dznAHDCK4tbEx64nu2vuKPY2WeRNL0V7on4vaJ0y4XOoMK+RTCil5f4AePQQU24PR21nA
	 YLuCZD6Vu/ZD8OdUKRFeUuNTevFW567XvaWzHRtzN9kPgvPNR7my3MYces6kgIfo1HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=F9rgkgTi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86569606A32A;
	Tue, 27 Oct 2026 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=F9rgkgTi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3491F01825;
	Tue, 27 Oct 2026 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793100820;
	bh=kJDjNU0dZaCl7vq80j34Y7JKA/POP5UfhMbpxoRWU9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F9rgkgTiVx0zOkrHSZhpnP0pLRG8rtAsTZD4q+/00nQeoaqmBTyYipHT/g1WFie2L
	 bkFNPPJeey7427ZCdj0LBmQN3sXrNOO1amg2XH3cDZWtChk7P/5AdpTrAOXMSO1HQg
	 xz2UnZbQyxd2+8mk7aCs4ibnnfk1KEpcfOE2CB4g=
Date: Tue, 27 Oct 2026 12:33:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count
 against BAR size
Message-ID: <2026102755-chewing-snippet-af92@gregkh>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
 <10465f24-0d87-48f8-9684-302434b456fc@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10465f24-0d87-48f8-9684-302434b456fc@kernel.org>

On Tue, Oct 27, 2026 at 12:23:14PM +0100, Jiri Slaby wrote:
> On 27. 10. 26, 12:06, Greg Kroah-Hartman wrote:
> > From: Joshua Rogers <linux@joshua.hu>
> > 
> > pci_oxsemi_tornado_init() reads the UART count from device-controlled
> > BAR0 memory without validation, allowing a malicious device to report up
> > to 255 ports. Cap the device-reported count against what actually fits
> > in the BAR using the Tornado register layout.
> > 
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>
> > Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Joshua Rogers <linux@joshua.hu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> > index 1dda63be6b89..9919504334bb 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1083,6 +1083,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
> >   	u8 __iomem *p;
> >   	unsigned long deviceID;
> >   	unsigned int  number_uarts = 0;
> > +	resource_size_t bar_len;
> >   	if (!pci_oxsemi_tornado_p(dev))
> >   		return 0;
> > @@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
> >   	/* Tornado device */
> >   	if (deviceID == 0x07000200) {
> >   		number_uarts = ioread8(p + 4);
> > +
> > +		/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
> > +		bar_len = pci_resource_len(dev, 0);
> > +		if (bar_len >= 0x1000)
> > +			number_uarts = min_t(unsigned int, number_uarts,
> > +					     (bar_len - 0x1000) / 0x200);
> 
> Is the _t variant necessary? Both are unsigned (int and u64).

Ah, yes, the true tell of a LLM that was based on an "old" kernel
history.  I'll go fix this up for the next round of these patches, for
those that still need work, thanks!

greg k-h
