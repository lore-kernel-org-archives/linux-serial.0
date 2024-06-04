Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEE145B1C;
	Tue,  4 Jun 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504345; cv=none; b=LiaBvNMzc+KWV/7I7i75DXYHrU7UHl0GQf6gGDrSh8HAz8AawD6KPqoMP9iZItZxkRVlJaVbJvFSzcQNKkMJNM/JodWZQj1msOVio25SeHSQjLivE6YOPw/IAOrGV4Ajpthb5xx2L5eVw+a3oZzIowr+IXY80i8GNPs9o+rnDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504345; c=relaxed/simple;
	bh=iA3g8bwEgMixe5xQYp76A3mHSq/qJillg/hgf4HjgeE=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=VSFYT91XwYgrQLKNc9EH2lfPf0fdTg3v3YTbIiuJt4T70HHsO6mJPgZYlq0f6VMsVrNrdky4wmetMkjuZrL9K4FkBjYMVx200MVEBCnTxt7m0JNIG3/IpwHifeYi3ZpJtEDYSu4S2PIoDliJeYKscgaaor5wfmzgpkVvpQtpmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NvJA4rZa; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NvJA4rZa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=RaxHgWk6jYpH+0zhyTKnZK+FxoUWw7STphYHCwBMzIw=; b=NvJA4rZa1Dtn9N2BZHc4m5KPe0
	DcMS1KrBmAbBTMPwgNAiuLnwfglS7hKAOFXT2p9AbYZLuXXIVdCk5Ow1mfZrRJyXrgD372Md8TdWr
	PYztiyEY/pi+lPXVEvzjJE1+HmQEa4FnBljOkxmn4U2+T9bMohnuSdBek68icYRjpbDQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:57106 helo=debian-lenovo)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sETKo-0003cs-Dp; Tue, 04 Jun 2024 08:32:15 -0400
Date: Tue, 4 Jun 2024 08:31:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Message-Id: <20240604083159.d984dd08741396ea4ca46418@hugovil.com>
In-Reply-To: <CAMuHMdUo7yPdkPKHXYiWqsqM9Zs4rr2G1tQbH9mZ=bjNLgKamw@mail.gmail.com>
References: <20240603152601.3689319-1-hugo@hugovil.com>
	<20240603152601.3689319-3-hugo@hugovil.com>
	<CAMuHMdUo7yPdkPKHXYiWqsqM9Zs4rr2G1tQbH9mZ=bjNLgKamw@mail.gmail.com>
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
	* -2.5 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 2/2] serial: sc16is7xx: re-add Kconfig SPI or I2C
 dependency
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 4 Jun 2024 09:09:12 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> On Mon, Jun 3, 2024 at 5:26 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Commit d49216438139
> > ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> > removed Kconfig SPI_MASTER or I2C dependency for SERIAL_SC16IS7XX (core).
> > This removal was done because I inadvertently misinterpreted some review
> > comments.
> >
> > Because of that, the driver question now pops up if both I2C and
> > SPI_MASTER are disabled.
> >
> > Re-add Kconfig SPI_MASTER or I2C dependency to fix the problem.
> >
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: d49216438139 ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1025,6 +1025,7 @@ config SERIAL_SCCNXP_CONSOLE
> >
> >  config SERIAL_SC16IS7XX
> >         tristate "NXP SC16IS7xx UART support"
> > +       depends on SPI_MASTER || I2C
> 
> You may want to add "|| COMPILE_TEST".

Hi Geert,
I will add this to my TODO list, since this patch series is already in Greg's tty tree.

Hugo

> 
> >         select SERIAL_CORE
> >         select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> >         select SERIAL_SC16IS7XX_I2C if I2C
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
