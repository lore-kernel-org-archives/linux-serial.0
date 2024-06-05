Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CF19D882;
	Wed,  5 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601597; cv=none; b=EwAg7yjt/YSME0BTEucmgBaIf/+A2xvJJZ9g/niksDQSDSomkW8ry1AHOtuDspCkv2zGE+Mn15mVVixYg2ZhHrllTf39LaUXy+GiluVWREX0x3j8i78qHXhwj22UXMC1lQuh+VG0FIugY9FzRQtMVzl/xsi6PnM+Ei7zKq7iQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601597; c=relaxed/simple;
	bh=9WcFWQSXNFHjjjjzw5SaQHLZrkcwgxdvaFCK0KqAWS4=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Lyqa2fJ20+Gx0idCJWuCJEVOxBseQ5G2saCcSQOOzfKwgizbrTAahKy/cs5jjXTIdihaKcS627rinJDGcK3Zlb/7b6d8HZctrDKeIE11GvVs7XdoEMkj3CZ99ackhBkBkm+nDh6lzbYLb94pEgPJibsnGkrinXtYsyyDZvm4Y4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Mf9Wq7/e; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Mf9Wq7/e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=Gxk2m052eGUR2G/XiNVefqcIx6UYE0RDiDcBmIQTbE0=; b=Mf9Wq7/e3GlzU9uhgnXKScdQxc
	pmW1N7/mnG0LuEgIrtd3+OVx8hqAA9fhDPYnkYrSuvgdOS1+KATSEfnrDJ9y76VtM+8PvpnWmJsCs
	mlOf7W/gCAeGMTAqf3Yj/nKnRwzCwfUux09Wt2VAmMRyViWb4fYn1EI5kWePWpgRByK0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:47348 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sEsdL-0001Oo-HT; Wed, 05 Jun 2024 11:33:03 -0400
Date: Wed, 5 Jun 2024 11:32:46 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Maarten Brock
 <Maarten.Brock@sttls.nl>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "jirislaby@kernel.org"
 <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
 <hvilleneuve@dimonoff.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
 "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Message-Id: <20240605113246.5a0a6a8840636e835f2bbc4c@hugovil.com>
In-Reply-To: <1d5c49ea-c021-42cf-b878-83c625e17caa@canonical.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
	<20240604132726.1272475-2-hui.wang@canonical.com>
	<20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
	<AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
	<f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
	<CAHp75VfEONqGBx7xbOKtGcn5z3shzSyUt8WABJqq4yOnweAr3w@mail.gmail.com>
	<1d5c49ea-c021-42cf-b878-83c625e17caa@canonical.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -4.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 5 Jun 2024 20:55:21 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> 
> On 6/5/24 19:19, Andy Shevchenko wrote:
> > On Wed, Jun 5, 2024 at 1:55 PM Hui Wang<hui.wang@canonical.com>  wrote:
> >> On 6/5/24 18:30, Maarten Brock wrote:
> >>>> From: Hugo Villeneuve<hugo@hugovil.com>
> >>>> Sent: Tuesday, 4 June 2024 16:23
> > <...>
> >
> >>>> Add function description from original comment "Reset device,
> >>>> purging any pending irq / data", since the comment applies to both
> >>>> hardware and software reset,
> >>> No it does not (at this moment). See below.
> > ...
> >
> >>> The problem here is that this only deasserts the reset if it were asserted before.
> >>> Nothing happens if it already was deasserted. This makes the delay also pretty
> >>> useless.
> >>>
> >>> To make this a proper reset pulse for the device you must first assert the reset,
> >>> then wait >3us, and finally deassert the reset.
> >> My understanding is when calling devm_gpiod_get_optional(dev, "reset",
> >> GPIOD_OUT_LOW) and returning a valid (gpio_desc *), the flag
> >> GPIOD_OUT_LOW guarantees the GPIO is set to output and low (assert the
> >> reset pin).
> > No, this is logical, not physical state. Maarten is correct. How did
> > you test this?
> 
> Yes, Maarten, Krzysztof and you are correct. Thanks for pointing out 
> this error.
> 
> If I call "reset_gpio = devm_gpiod_get_optional(dev, "reset", 
> GPIOD_OUT_HIGH);" I will get the result as below:
> 
> # cat /sys/kernel/debug/gpio
> 
> gpiochip4: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio: 
> gpio-141 ( |reset ) out lo ACTIVE LOW
> 
> If I call "reset_gpio = devm_gpiod_get_optional(dev, "reset", 
> GPIOD_OUT_LOW);" I will get the result as below:
> 
> # cat /sys/kernel/debug/gpio
> 
> gpiochip4: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio: 
> gpio-141 ( |reset ) out hi ACTIVE LOW
> 
> I tested the reset pin by dumping chip registers, if the reset pin is 
> asserted (out lo), I will get the result like this:
> 
> # cat /sys/kernel/debug/regmap/spi0.0-port0/registers 1: 10 2: ff 3: 00 
> 4: ec 5: ff 6: ff 7: ff 8: ff 9: ff a: ff b: ff c: ff d: ff e: ff f: 06

Hi Hui,
the best way to test a reset pin is with a voltmeter, if you can. It is
way too easy to get confused with reset pins values/polarities, etc.

By the way, if the reset pin is asserted, you cannot communicate with
the device, therefore dumping registers cannot work for debug purpose.

Hugo.


> 
> If the reset pin is deasserted (out hi), I will get:
> 
> # cat /sys/kernel/debug/regmap/spi0.0-port0/registers 1: 10 2: 01 3: 00 
> 4: 00 5: 60 6: 00 7: 2e 8: 40 9: 00 a: 00 b: ff c: 00 d: 00 e: 00 f: 06
> 
> My original code set the reset GPIO to high (the reset pin is 
> deasserted) continuously, so I didn't notice this hidden error.
> 
> Thanks,
> 
> Hui.
> 
> >


-- 
Hugo Villeneuve
