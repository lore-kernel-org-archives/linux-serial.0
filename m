Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E91D516C;
	Mon, 29 Sep 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127604; cv=none; b=jJz6XdMBJcwIG5tNjqBF2alHC8khbhUGy/RiBTATubZwVxx2ksh9PMxTA3ySyBXWj7se8U+PbhBAczunFqVpfvUL4cBFQwzg6IW0hZUkJb0JG/gnKmGsRYHOEMfZk6P/4IMI7JG43kXmBbk8yrWpkSbB+bCeDq+ywqqzxYyU1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127604; c=relaxed/simple;
	bh=x9nAZFHwTavntXJzo6i8En8mMnzDx03pdX8PJk4aMhQ=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=UAsZpZaIp9x+X4LHCPouPU3HMrI51CXB1DiDkyIk89kWzLn3X98NLjoBnuNdnsak4Bazbh9yg9xrqOOP0p/BVjCbMKkzgzyTixtMF+BWcAXa+IBkHUUWjRXAt3Oyg5e9XYCZ0097EvMBDzGjT8F3BmaUMoQ+A3MqiNgSADy5KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=Of1Fp7Ru; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="Of1Fp7Ru"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8381f8b361=fe@dev.tdt.de>)
	id 1v37Rg-00BYII-K1; Mon, 29 Sep 2025 08:33:12 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v37Rf-0079UB-R9; Mon, 29 Sep 2025 08:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1759127591;
	bh=x9nAZFHwTavntXJzo6i8En8mMnzDx03pdX8PJk4aMhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Of1Fp7RuwiHF9jYc2xkapReL4dC2GBSnvgcg61SPT73R3xcZHYFX4ZvkjaK4kz2zE
	 Y4nuXHFYXJmMZFZElaOoHlp77+3qbM5Hddl6svs8TsILUOusDwfqPT+bce9QluLSaZ
	 PlvxUuFwCsll2mWIso+ZLfMNTlSw6A8B8CJki8F1LSle50f67pksfCAXcBIa5JBfmz
	 qrNrclQjRs8Sfct5m9/G+XSVz97cZdR8zeq1XSKpASjSqYNZu6ObMrOEeuNEhS96oC
	 KiqVQg3Xt/8rY/K3iEOk0oA+PKfd8IQA89JWcXRbdZP/qgAXvCknvqsRnswZ9Cl+m2
	 0zSq0TplmM+Gw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5AF24240042;
	Mon, 29 Sep 2025 08:33:11 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 3D1C6240036;
	Mon, 29 Sep 2025 08:33:11 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id D758126879;
	Mon, 29 Sep 2025 08:33:10 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 29 Sep 2025 08:33:10 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, kumaravel.thiagarajan@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <da2de297-2c9c-4855-9fb7-553022538cde@kernel.org>
References: <20250924133544.2666514-1-fe@dev.tdt.de>
 <5fed7e09-b59f-46b0-be49-881c0c1b61c1@kernel.org>
 <e4d2fa14701092977daa844cf25e7dd7@dev.tdt.de>
 <da2de297-2c9c-4855-9fb7-553022538cde@kernel.org>
Message-ID: <cd5e677afaefb5ffa48913f4b6aa1efb@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1759127592-5FF4A80C-D85077DE/0/0
X-purgate: clean

On 2025-09-29 08:00, Jiri Slaby wrote:
> On 26. 09. 25, 14:31, Florian Eckert wrote:
>>>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>>> ...
>>>> --- a/drivers/tty/serial/8250/8250_pci.c
>>>> +++ b/drivers/tty/serial/8250/8250_pci.c
>>>> @@ -165,7 +165,15 @@ static int
>>>> =C2=A0 setup_port(struct serial_private *priv, struct uart_8250_port=
=20
>>>> *port,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 bar, unsigned in=
t offset, int regshift)
>>>> =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 return serial8250_pci_setup_port(priv->dev, port=
, bar, offset,=20
>>>> regshift);
>>>> +=C2=A0=C2=A0=C2=A0 void __iomem *iomem =3D NULL;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (pci_resource_flags(priv->dev, bar) & IORESOU=
RCE_MEM) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iomem =3D pcim_iomap(pri=
v->dev, bar, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(iomem))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return -ENOMEM;
>>>=20
>>> Why not to propagate the error?
>>=20
>> Most other calls in the kernel of this function return
>> -ENOMEM on error. Therefore, I thought that this is the
>> correct return value. I can fix that in v2 if you like.
>> Let me know what you prefer.
>=20
> Ugh, pcim_iomap() returns NULL on error, so the IS_ERR() check is all
> wrong. What other places in the kernel use IS_ERR()? They need fixing.

You're right. The function returns a pointer here and my check IS_ERR()
is wrong. I mixed it up with the 'pcim_iomap_region()' function.
Because I wanted to use this function before. As far as I can see, the=20
return
value of 'pcim_iomap()' is checked correctly in the linux sources.

Sorry for the noise.

I will adjust this and send a V2 patch.

--
Florian
