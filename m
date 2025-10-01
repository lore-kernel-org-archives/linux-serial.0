Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041D299A81;
	Wed,  1 Oct 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325372; cv=none; b=eOMoYk3iEb1ZP2ROYZgkQ8nCsHIs8FYCFHnuOZgLMPjK2dAAiLV0WS0uDUX319HtOzp27z74Io4iaDpPjN15YpOwzGzQgv6r0hVxlFWAxWTO/ZiBrVCpXhFKT1jVycP8/y+tIQZhd8nJkyfOrDIsMtu4IRe3UT+s5adH9v0LmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325372; c=relaxed/simple;
	bh=OZC0tt3exZ8mrMSmgLzrE/u/RYsfs/kNrj2o8ax8fOA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=gL8hIax2Y9d2b8F3g0plKymig4Y0CdA660H2fSiadb54xHC7YLB7/fjGDx5Z/EcRHUP5LkQ3sgztMMxBgLH+k+4InX8yqrL+DfUd1AqPCmpBV5DN33pF4mbiZ+KxNqJuDnYqF6N1UyhIgC25l7D5bV/9VNSl/Z8TvrQyhBZKKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=pyhUXrGr; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="pyhUXrGr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=/2kuQRr7Hq1T+cMeHaxihzxf/gDDuGxrcXHk1gQvul0=; b=pyhUXrGrpmcPd/+/gO3+Q39F/C
	6poPPEuq5TcMFNqfAvhtWpE5+huArnZAXLNA+6A7XKpH3mOGo9kpobzuhp4ym/PhMv7SM25Sfg6BJ
	Ti1hJxGwbkmYFqUWxgxhHjaN7uDbbRG284KyWpdyDWGd/Gs9Ptf0P87kYvl7sQvkbZBQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41924 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3wtW-0003Gk-EN; Wed, 01 Oct 2025 09:29:23 -0400
Date: Wed, 1 Oct 2025 09:29:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20251001092920.e6d5ffa046937fc850f1ab6a@hugovil.com>
In-Reply-To: <2025100132-usage-sandstone-8a9f@gregkh>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-13-hugo@hugovil.com>
	<a6bb8046-1e71-4766-afa8-e9d303ba57b8@kernel.org>
	<20250930160828.546867810b4a17c36a5030c6@hugovil.com>
	<2025100132-usage-sandstone-8a9f@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -3.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 12/15] serial: sc16is7xx: add missing space between
 macro args (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Greg,

On Wed, 1 Oct 2025 07:16:06 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Sep 30, 2025 at 04:08:28PM -0400, Hugo Villeneuve wrote:
> > Hi Jiri,
> > 
> > On Mon, 29 Sep 2025 08:15:56 +0200
> > Jiri Slaby <jirislaby@kernel.org> wrote:
> > 
> > > On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > Fix the following checkpatch error:
> > > > 
> > > >      ERROR: space required after that ',' (ctx:VxV)
> > > >      +#define to_sc16is7xx_one(p,e)...
> > > > 
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > ---
> > > >   drivers/tty/serial/sc16is7xx.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > > index a05be92f7e776..9d04d665ec9ab 100644
> > > > --- a/drivers/tty/serial/sc16is7xx.c
> > > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > > @@ -365,7 +365,7 @@ static struct uart_driver sc16is7xx_uart = {
> > > >   	.nr		= SC16IS7XX_MAX_DEVS,
> > > >   };
> > > >   
> > > > -#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
> > > > +#define to_sc16is7xx_one(p, e)	((container_of((p), struct sc16is7xx_one, e)))
> > > 
> > > Or perhaps make it type-safe and more obvious by switching it to an inline?
> > 
> > Not easy to do, because this macro is also used with the second
> > argument "e" not always being used with the same member name. At the
> > same time, this is what makes this macro more complex than it should
> > be. I will convert it to an inline and simplify it by removing the
> > second argument (and of course adapt the code where the new, simpler,
> > inline function no longer works).
> 
> Please don't use an inline fuction for container_of() as you will just
> need to change it later in the future when you really want to use
> container_of_const() instead :)

Noted. I will simplify the macro and leave it as a macro then.

Would you suggest to also convert container_of to
container_of_const in this patch series?

Hugo.
