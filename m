Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84D19F115;
	Mon, 20 Oct 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978178; cv=none; b=pu7FcVlUDU3ebZSxFNvlMMypv4kfTFScCUkxG6l2YXqrxmElQEvTtTRJsZ3T1zyLViQxudPlvWRi9VHfI/NO2iMd9fxwN1nevoIe9CcohV9rw5RJOkD3Yk4Dr8PVkN0ReWOhUfqrAYBuXl8lcQtDlQT+UdKraKJIJ+ilvRh18jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978178; c=relaxed/simple;
	bh=5Yz4poMQ4hJfWftp7RReVT/QPwWQOElygIWtcrn3u+Y=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ik878JN0rJijx3ySYX0OBYMxi1D1+aRDb53gNPqNfLEARtfLF1U2LxsMZHuIBqf5XNeiwIR5u+daerRuxiKPgQMVwYVirjHa/AfhIjV+15Jc1Yms2tOUypZpvb3rcM1EghzFORoouffTQo4uxklcuDbZIVdqqeCttM+CS1BWo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=Ulc9ql3W; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="Ulc9ql3W"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9402dab0bf=fe@dev.tdt.de>)
	id 1vAsaq-004xxe-KQ; Mon, 20 Oct 2025 18:18:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1vAsap-00BKck-S0; Mon, 20 Oct 2025 18:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1760977123;
	bh=Yu2p380KLTbVGoNddtvW9SeuUUz8wZq6pTgRY3DcFbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ulc9ql3Wqs46QKQyGgef+/RO0jDSjkiKvTO5d/KFJQ0fcSnI5R/0cK+2oI+kUhnMl
	 V3hr2jfNCPuXVBMSEtUf1VXRJbVElz9kXf+BdmCJ6damlp+SDs7d0fR3D8JdN0Zbjd
	 kLPsaMYoltUz+ffBVcErXxp68EzqfeRod8/hONYL9UB2ISBFTruYGUdh1Ysv/IvQpW
	 AM/UD3yWudCmxuNKzYC0ez3Pvo2AGc1TAySzrZMkK7w6tdcvAYmhRcI9OdrR2tYd1M
	 0ow1YHrpioUI11h9lM5ypOwUAY/hwNfrWK1QsH4J4HcOAnBDy3bEVl4X8+NLMubc8G
	 HRZDrjIKWcJkA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 55B06240045;
	Mon, 20 Oct 2025 18:18:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 390DF240040;
	Mon, 20 Oct 2025 18:18:43 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id DC84326D9A;
	Mon, 20 Oct 2025 18:18:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2025 18:18:42 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kumaravel.thiagarajan@microchip.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <aPX15a2Zv9b_wM3u@smile.fi.intel.com>
References: <aPPreT00iiTDzJwG@ashevche-desk.local>
 <84ad1b3070a8374ec20f06588fab9f86@dev.tdt.de>
 <aPX15a2Zv9b_wM3u@smile.fi.intel.com>
Message-ID: <e018879d65948462984da19e53cb610a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1760977124-99414F3F-B3016A52/0/0
X-purgate: clean



On 2025-10-20 10:42, Andy Shevchenko wrote:
> On Mon, Oct 20, 2025 at 08:47:16AM +0200, Florian Eckert wrote:
>> On 2025-10-18 21:33, Andy Shevchenko wrote:
>> > On Tue, Sep 30, 2025 at 09:27:43AM +0200, Florian Eckert wrote:
> 
> ...
> 
>> > > +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
>> >
>> > Dunno if this is included already in Linux Next, but here is room for
>> > improvement.
>> 
>> I followed the code in the 'serial8250_pci_setup_port()' [1] function.
>> The same pattern is used there [2].
> 
> I see. So if we want to amend that, it should be done separately.

If that's the case, then I'm done with this patchset, right?
I do not have to send a v3?

> 
>> > The problem with the above code is it (wrongly?) checks for bit and not
>> > for the resource type. OTOH I don't remember if 64-bit version requires
>> > the IORESOURCE_MEM to be set along with that.
>> 
>> Do you mean the function 'platform_get_resource()' [3]? This is a 
>> platform
>> device function?
> 
> I mean that the IORESOURCE_MEM and IORESOURCE_MEM_64 are separate bit 
> flags in
> struct resource::flags. Checking on one might not imply the other be 
> set,
> however brief look at the sources shows that _MEM_64 is supposed to be 
> set on
> top of _MEM.

Okay, I understand.

---
Best regards

Florian
