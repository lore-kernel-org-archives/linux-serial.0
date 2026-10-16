Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F255C1D9;
	Fri, 16 Oct 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170992; cv=none; b=ZlJsHtaG70WsbnB+TzTaQLjMAE3/RCn1fAUCRmriK5vO97btbIcktyuNcCgyW5yIT/WEenH0xkRILctctP53W4SsmOKZ5eCXnXmq4DB9xWAD+CMHtmBM1IvijxzfcVDXQnf9fRB0+IRbrAfSy9IqdkcGrFsDQWQdKBokcKSx1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170992; c=relaxed/simple;
	bh=HeA/TRrIMzSLPZEJEe2gUXhaeg76MD88XR5/4eL4VzU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WU85ejvM34KTnT2UL4Qie+gvbQbWIr67h3ML78tUIJRmU61Pc+5nqu6sGWNYwCysiL79SFORBRgWmpGky2Vy3QkmbnE+iOvD+FQrOFv4oO/I0lI7lV0h/2aIt+r4jLaK2GqND8WSIJw9tpgc5PBX4yV7irXI9kfgy5sDj9J9XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=lr+bokTD; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="lr+bokTD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=dKQ62B/68glF3VJQl3TwnzQ09ixoOo9aoTa47BHK5rg=; b=lr+bokTDzJ+s+ioETGpBVlCIxj
	KWS1zr5+gCEXjzc4fwVwvQQ12wlJvQg9pX34AuWejVkS7CfuQWTNWVCyHa9Yjst5M08WNJEK3T02H
	wqcGY7WUHkSIv1E6UGzHLtS8yj7rvUSbE9fsBRkVa64lkd//g7TEppVJ/KQJCPBpIBOk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xHlXf-000000006af-2Iq4;
	Fri, 16 Oct 2026 13:16:25 -0400
Date: Fri, 16 Oct 2026 13:16:24 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-Id: <20261016131624.0fda5a185bf5c5ae67f09112@hugovil.com>
In-Reply-To: <aace8c7a-61ab-4b54-8563-3e1ab0f99e56@app.fastmail.com>
References: <20261016130328.1037616-1-arnd@kernel.org>
	<20261016124839.0d5564f7d7e036ee782a0486@hugovil.com>
	<aace8c7a-61ab-4b54-8563-3e1ab0f99e56@app.fastmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Fri, 16 Oct 2026 19:12:19 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, Oct 16, 2026, at 18:48, Hugo Villeneuve wrote:
> > On Fri, 16 Oct 2026 14:59:47 +0200
> 
> >> -			scnprintf(buf, size, " I/O:0x%lx, offset 0x%x", port->iobase, port->hub6);
> >> +		scnprintf(buf, size, " I/O:0x%lx", port->iobase);
> >>  	}
> >
> > With this simplification, you can now remove the {} braces...
> 
> Done
> 
> >> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> >> index 4ff3e5c41dab..f43b802add12 100644
> >> --- a/drivers/tty/serial/sunsu.c
> >> +++ b/drivers/tty/serial/sunsu.c
> >> @@ -106,10 +106,6 @@ static unsigned int serial_in(struct uart_sunsu_port *up, int offset)
> >>  	offset <<= up->port.regshift;
> >>  
> >>  	switch (up->port.iotype) {
> >> -	case UPIO_HUB6:
> >> -		outb(up->port.hub6 - 1 + offset, up->port.iobase);
> >> -		return inb(up->port.iobase + 1);
> >> -
> >>  	case UPIO_MEM:
> >>  		return readb(up->port.membase + offset);
> >
> > Maybe change to a simple if/else?
> >
> > 	if (up->port.iotype == UPIO_MEM)
> > 		return readb(up->port.membase + offset);
> > 	else
> > 		return inb(up->port.iobase + offset);
> >
> 
> I think I'd rather not change sunsu.c any more than necessary.

Ok


-- 
Hugo Villeneuve
