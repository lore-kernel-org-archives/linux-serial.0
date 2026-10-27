Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100205;
	b=XPMk3PvYoKLQHs8FQoqRiiM5V/2zIFWSpdKe066ZRmnS31iUuMxAJEon9muQyXyi7xRz
	 Hb289cU6oTNFHuqlJzmNzO1wre4aa0pN1Ucs3p9j4HSseEs5RmlrNklDvA4VDbglg9VMr
	 yujWOV+xF9PnlDNZlG9gSwXN33c8u6L91CxLmeK9Tz7/F0iyeaT+ZC5YFoEi8/qMHZbgJ
	 cju8lhXLqjq8WiQ6+JjUVVPgsxdjGIZEaEzcmbByB4Xvw8D24nmV8lT9t5Vu5YbL/mdHK
	 /YnMkWrMJmkGS+D/DRlSak3lE3wTGfjmC5t86UOmQDpCuH0YhXY+82NmVjL8gYrPRUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100205;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZL//RQzqhSPDr1a37l52tGV4TWlxdO+0hTSVKLkxguQ=;
	b=Ck7S8u+8qfs3jfRJTtjmLBqGTlqYhl1fH6bpU4YCtKCSYGy7l0vsnrANn6nsGX5Abf9z
	 FSN2zW3S+HlJBIEc5TOKhFk8+HPFKSv0bi8dgxs/hoO/msIWR4HbZjR+iA7cms3/OEKTC
	 /cMDNF9taR89zOlhJPeWYmd3G4S19Ppf+g6Lq6xIGoRx6qoXFS9ppNNtcyKNtSzpgRB82
	 jQM3ZQyOK96KYWIA5LCDPuMP0eOG3IFZB9blpSFIeJXyNTiPRSAVC0D3ayr4vrijRukOv
	 f91cVBt/2NnnYg+bEi5W/u2jLx2VQ3E+U0icD3K7cnaCm1cA8q+3U6nlY0gqFKImq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPsqgnxg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F69606A31F;
	Tue, 27 Oct 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPsqgnxg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3CA1F01825;
	Tue, 27 Oct 2026 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100204;
	bh=ZL//RQzqhSPDr1a37l52tGV4TWlxdO+0hTSVKLkxguQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HPsqgnxg7k0E5/PQf/2frljxN8LMVdhJcWD7/aT8dpueEmC9wJ8cfpWJ04epQlo8x
	 q6g9tUOl5XG1ZWHF1gq24YTcU/ZwD3GHhqpdZAfZRikWKqBUbacDKDlfXc9Lkb05To
	 mLDUZZzIp297CZiE0ZchLPFH1lH356iEu2pvRyoTgUa2DG44QJuvKqsiZjr0TxYwTO
	 iRTm2cpcJDXiNPu+Mdx212zU5VmVWKj0I2Dzwr/zVHXvp8qQ6Jq6VfvjpdSFO/9WY0
	 xeuaR0c2v5A1QBrUMbZaQ0eA5bpmHqIOEy7mcY27hRCfzx81k833y934TXTwiRoU/K
	 fQPzLevN3roqQ==
Message-ID: <10465f24-0d87-48f8-9684-302434b456fc@kernel.org>
Date: Tue, 27 Oct 2026 12:23:14 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
 Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Marnix Rijnart <marnix.rijnart@iwell.eu>,
 stable <stable@kernel.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27. 10. 26, 12:06, Greg Kroah-Hartman wrote:
> From: Joshua Rogers <linux@joshua.hu>
> 
> pci_oxsemi_tornado_init() reads the UART count from device-controlled
> BAR0 memory without validation, allowing a malicious device to report up
> to 255 ports. Cap the device-reported count against what actually fits
> in the BAR using the Tornado register layout.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Marnix Rijnart <marnix.rijnart@iwell.eu>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 1dda63be6b89..9919504334bb 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1083,6 +1083,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
>   	u8 __iomem *p;
>   	unsigned long deviceID;
>   	unsigned int  number_uarts = 0;
> +	resource_size_t bar_len;
>   
>   	if (!pci_oxsemi_tornado_p(dev))
>   		return 0;
> @@ -1095,6 +1096,15 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
>   	/* Tornado device */
>   	if (deviceID == 0x07000200) {
>   		number_uarts = ioread8(p + 4);
> +
> +		/* Cap against BAR0 size (Tornado layout: 0x1000 + n * 0x200) */
> +		bar_len = pci_resource_len(dev, 0);
> +		if (bar_len >= 0x1000)
> +			number_uarts = min_t(unsigned int, number_uarts,
> +					     (bar_len - 0x1000) / 0x200);

Is the _t variant necessary? Both are unsigned (int and u64).

> +		else
> +			number_uarts = 0;
> +
>   		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
>   			number_uarts,
>   			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
> 


-- 
js
suse labs
