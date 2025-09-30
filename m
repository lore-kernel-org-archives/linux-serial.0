Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D538F9C;
	Tue, 30 Sep 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262913; cv=none; b=Hu4/UNeITKZF2eSjwUHt6rYTlsTmDghS1yfuwjKTs8SlvG9F2ruZxpMOoJft1ZomzZR00iLnPeh5PEs8dkUdiLmVap6bXmKlQFGiUslOETH6zrfUZTCC9dj53rraPUVpbsB46bF19S4th42RG5oeFR68/9URL0dC3tbnTUiKGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262913; c=relaxed/simple;
	bh=SH461plYDbqzUaxAI7yt5yEkeCWlmWIsg+yQu8VHmsg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=tojst+LlTgWHwiysulXu+0nsLPBjnVVYjKURV+iM1JM0S7X37FOTlH4sKMMyGRRMxGMhqPr+828AlOdUu5U2c04XcXvlyEZETSCPzrWbrsgVYJQ/obdPfM+3v3pBGAg9QIbivnkXFNdduAlV1S9DaeyWyUMEg5Ld+64Qf5Ww0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=WsV0mR10; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="WsV0mR10"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=x+Y/tV8Eydgc4UKrGHMMgX2Hjs45tKx36dhlL+aIn3k=; b=WsV0mR10qaEQbKMdTleKzMXdO9
	216W4MchBgZ1Adlu/Q0W4kMsK2iaFBsPxhAX1Qif5Yn+H4jt23PTvXHtmAiMCP7QDLGJSu8q2dK4T
	e3ny8puiEb2EcUvs0OivNWHQtbQW92EMnx5XM9tCQBupDXh+jwEZQyINxVR7MsKX/DfA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34072 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3geD-00089c-25; Tue, 30 Sep 2025 16:08:29 -0400
Date: Tue, 30 Sep 2025 16:08:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250930160828.546867810b4a17c36a5030c6@hugovil.com>
In-Reply-To: <a6bb8046-1e71-4766-afa8-e9d303ba57b8@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-13-hugo@hugovil.com>
	<a6bb8046-1e71-4766-afa8-e9d303ba57b8@kernel.org>
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
	* -2.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 12/15] serial: sc16is7xx: add missing space between
 macro args (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Mon, 29 Sep 2025 08:15:56 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Fix the following checkpatch error:
> > 
> >      ERROR: space required after that ',' (ctx:VxV)
> >      +#define to_sc16is7xx_one(p,e)...
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >   drivers/tty/serial/sc16is7xx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index a05be92f7e776..9d04d665ec9ab 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -365,7 +365,7 @@ static struct uart_driver sc16is7xx_uart = {
> >   	.nr		= SC16IS7XX_MAX_DEVS,
> >   };
> >   
> > -#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
> > +#define to_sc16is7xx_one(p, e)	((container_of((p), struct sc16is7xx_one, e)))
> 
> Or perhaps make it type-safe and more obvious by switching it to an inline?

Not easy to do, because this macro is also used with the second
argument "e" not always being used with the same member name. At the
same time, this is what makes this macro more complex than it should
be. I will convert it to an inline and simplify it by removing the
second argument (and of course adapt the code where the new, simpler,
inline function no longer works).

The end result improves readability a lot.

Thank you,
Hugo.

-- 
Hugo Villeneuve
