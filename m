Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F52227EB3;
	Thu, 13 Feb 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454186; cv=none; b=o4iRU60bap7Q0nk/4FSohpWPsYCjWDOhrXQDB+2GZVtL6GmgARjPGTwVnT6dIbvVwu/pSrbgG0hgl6lxn/1FDf74xfcLkBdRZiKk9FLHupTnFtKq4iv69Q7TtMMpFIOhHM9yrNOOiQquBT19XBJWgRDvxSWxGD4vr01NgTUsTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454186; c=relaxed/simple;
	bh=k4RbEIyAR+ANn73bOtihxB6irmXjDRqcb9idZPMB5Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpiO/PGF4FOhJhw/Pw+0U5wBbluxL+tZEN76FusT9PtS0v80w1zbVlOp7RBVrYMsFZoleVafr6MHz3mpG4x+aEGWOSLuSx09AgoioISSzO44ieAZQu1LMdEtYxkEzO2xXXLuatOFfnd24xv+jyKOOBbhMom/jDmZRLrBw8PolDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UsNJuD4X; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UsNJuD4X"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0135D440EA;
	Thu, 13 Feb 2025 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739454176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm7XKVhBb29N/0ZGLeQV/Hvrssux+61wOZwuTX8KNK4=;
	b=UsNJuD4XUBmjbgOSrbOsnmXWQjngrRl3HCRZ4AFsbr040l7wQWhGBAYM7ugvSPztEr404y
	sG3AFOT35aee2kcyCcGkHVWHvDWLTMCVNE1ns8zVCQGnoWl+B0uAw9DpcqVXoo8ozUa6si
	Jc1gBNVMH0/VFFCz0Rc0+nv4h3ejj3J77wPfgd91fgRYEn0cW0GJg3vXPzj0WO6lJY+UZm
	MKNeonZzYcSWALUPCOm72eXlzDqM5xYBRM5AYeUyc7A4m5+2STYJhBFkV2mbfyCWgkViuB
	ldlZfjaFDZunxqzdFCss+IKKZ0vP6wZ8nca4IX8LtwynwYIhz4hzGXWu5iWmbg==
Message-ID: <64ec49f2-8c3b-4642-a910-32a656095c68@bootlin.com>
Date: Thu, 13 Feb 2025 14:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: mctrl_gpio: add parameter to skip sync
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250213-atomic_sleep_mctrl_serial_gpio-v1-1-201ee6a148ad@bootlin.com>
 <2025021347-cling-smoked-9f28@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <2025021347-cling-smoked-9f28@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetteektdehudelheehkeeggfejgfelveevgeevtdejudfgveetgefhtdduuedtnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrghgvnhhouhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghro
 hgthhhiphdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrdhhrghuvghrsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Greg,

On 2/13/25 10:58, Greg Kroah-Hartman wrote:
> On Thu, Feb 13, 2025 at 09:25:04AM +0100, Alexis Lothoré wrote:

[...]

>> -	mctrl_gpio_disable_ms(up->gpios);
>> +	mctrl_gpio_disable_ms(up->gpios, false);
> 
> This a bad api.
> 
> When you read this line in the driver, do you know what "false" means
> here?
> 
> Please make two functions, mctrl_gpio_disable_ms_sync() and
> mctrl_gpio_disable_ms_no_sync() which can internally just call
> mctrl_gpio_disable_ms() with the boolean, but no driver should have to
> call that at all.
> 
> That way, when you read driver code, you KNOW what is happening and you
> don't have to hunt around in a totally different C file to try to figure
> it out and loose your concentration.

Makes sense, I'll spin a v2 with a more explicit API.

Thanks,

Alexis
> 
> thanks,
> 
> greg k-h


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
