Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78883EDF;
	Fri, 24 May 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509780; cv=none; b=bQE7LtQ4QHt904vhWb3DS+jIgMwQURDbTidJxREScEWIQp3gHwdXLBm6o8GCBErUmJuruebCzliEJdcd1cPo436Ho64EKjKZZ8rsneyft41EOe73DYDCbjzMrkrFxV3sBt+qPv6Cqcz7B51WAh+ct79c1Ckhvo1Ey5IYSPJeGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509780; c=relaxed/simple;
	bh=An7QDABjUyeXMgQPlCNFAn0hOnKqKCWC8bpn8L7lUmc=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=X5dhUfCinmUJ5tPYh8ty0TjGVJ5tifXR3PIK6PbLmD/psIu1ulxs9yMPBLDMv8OeCoPiM7kqy0//81mUYYg9D9NPvMWliPUpeio9XQh3WdeeqdnL4PTa5Nl/W9adGbVOdNki56Skm/kwzcpUQpdDaP7cAFOdxvCcmgWjNOJQwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=UU7k9q7j; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="UU7k9q7j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=bsNx66CWNPzOVgmvYU9g1FX7pZwySMGx2SwEOaCqt18=; b=UU7k9q7jSmaQO8GSp3Mn4dAN7M
	ewoGgkcMukvFbu9FfUURLiQmeDOrlLsy/PjXUB71FI/+AcXQtwLMqxTawoLTs0ShmkSVj9CZblR9J
	H5iJaeQoztwlFxbMiCkVNKXBITVm0tviDm7Hn02FXtVdlHSvSO4WlQo7wzQFZ9VBR4GE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:40780 helo=debian-acer)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sAIIM-00054Q-1x; Thu, 23 May 2024 19:56:26 -0400
Date: Thu, 23 May 2024 19:56:25 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, peterz@infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240523195625.fa40049802a43a76dbc2a96d@hugovil.com>
In-Reply-To: <CAMuHMdX2rrncANhCVf5bo+Md5bpMOeacYAu+Sgiy7noo55PYew@mail.gmail.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
	<20240409154253.3043822-4-hugo@hugovil.com>
	<CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
	<CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
	<CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
	<CAMuHMdX2rrncANhCVf5bo+Md5bpMOeacYAu+Sgiy7noo55PYew@mail.gmail.com>
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
	* -1.2 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 23 May 2024 09:33:36 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, Apr 23, 2024 at 3:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Apr 23, 2024 at 12:37 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Apr 23, 2024 at 1:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Apr 9, 2024 at 5:48 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > > > > -config SERIAL_SC16IS7XX
> > > > > -       tristate "SC16IS7xx serial support"
> > > > > +       tristate "NXP SC16IS7xx UART support"
> > > >
> > > > Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> > > > so arch/mips/configs/cu1??0-neo_defconfig needs to updated.
> > >
> > >         select SERIAL_CORE
> > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> > > +       select SERIAL_SC16IS7XX_I2C if I2C
> > >
> > > > So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_*
> > > > subdriver can no longer be disabled?  According to
> > > > https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hugovil.com/
> > > > you did want to support that?
> > >
> > > I believe it has been taken from one of the IIO drivers as an example.
> >
> > Looks like a bad example to follow:
> >   1. The driver question now pops up if both I2C and SPI_MASTER
> >      are disabled,
> >   2. What if SERIAL_SC16IS7XX_CORE is builtin, but I2C and/or
> >      SPI_MASTER are modular?
> >
> > I believe the only way to fix that is by letting the sub-drivers select the
> > core driver, like before.
> 
> FTR, this issue is now upstream.

Hi Geert,
I replied to you and Andy a few weeks ago about this (multiple emails with suggestions/explanations), and I even asked if you were satisfied with what I proposed, but never got anything from you, so I am still waiting on feedback to send a patch to fix this:

https://lore.kernel.org/all/20240430090333.5c5f029553cabcdf699310cb@hugovil.com/

Hugo.
