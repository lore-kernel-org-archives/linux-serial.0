Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155627AC3C;
	Thu,  2 Oct 2025 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382685; cv=none; b=TXEfqDeRSdL7RWsXFScj9ItFaCNeSMgs3b3psV8EUmoUh1CzAsbySVlXVPHFVuKoD77gVxCbbOVzYVy6f1AfWGVqtlErMOnQ+EMk+JAeqJdikV2HUK0VAndTjUpGcS3MGfbuxExcBg8QiIcszQffLHW1p6IZXYgzB/P9INK+tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382685; c=relaxed/simple;
	bh=Lg6AYA/WY5SpJYR4iQOQWQ0BpdppzRj8aHtUyceEC1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfAO1L9wZx/CCEt12zvdfGNu1R+eWDoiRRa6WFJ1HDugMrpxs+qYNCBraJnabZaYPduhAK6T/+H20tjCplY3QT7Ulh/ja3shTB/Uoe72JzuO2BXwIC61AHycKwh1P1IgKiIlS898Dck1yGaXL2zLnlnBAo1rKhXiWGZMsQBozWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfAbCO+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfAbCO+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022EEC4CEF9;
	Thu,  2 Oct 2025 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759382684;
	bh=Lg6AYA/WY5SpJYR4iQOQWQ0BpdppzRj8aHtUyceEC1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfAbCO+Gl8yfNAw1Md973H1LnIR6R9N9vdRuW5vlGn9B8LTwIvntjoYnWk4qPVevh
	 V2ZoTViN081ulrUeCqhk/SrphaZZWIYcXOMGgrcUGpKVwUDPqA1CfejVV26VgvwSX1
	 yTf9ZjXWUV8dr/2LKhf/+hehJbjWjUo7QUGB2lyQ=
Date: Thu, 2 Oct 2025 07:24:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, fvallee@eukrea.fr,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 12/15] serial: sc16is7xx: add missing space between macro
 args (checkpatch)
Message-ID: <2025100201-snowiness-goggles-4b43@gregkh>
References: <20250924153740.806444-1-hugo@hugovil.com>
 <20250924153740.806444-13-hugo@hugovil.com>
 <a6bb8046-1e71-4766-afa8-e9d303ba57b8@kernel.org>
 <20250930160828.546867810b4a17c36a5030c6@hugovil.com>
 <2025100132-usage-sandstone-8a9f@gregkh>
 <20251001092920.e6d5ffa046937fc850f1ab6a@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001092920.e6d5ffa046937fc850f1ab6a@hugovil.com>

On Wed, Oct 01, 2025 at 09:29:20AM -0400, Hugo Villeneuve wrote:
> Hi Greg,
> 
> On Wed, 1 Oct 2025 07:16:06 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Sep 30, 2025 at 04:08:28PM -0400, Hugo Villeneuve wrote:
> > > Hi Jiri,
> > > 
> > > On Mon, 29 Sep 2025 08:15:56 +0200
> > > Jiri Slaby <jirislaby@kernel.org> wrote:
> > > 
> > > > On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > 
> > > > > Fix the following checkpatch error:
> > > > > 
> > > > >      ERROR: space required after that ',' (ctx:VxV)
> > > > >      +#define to_sc16is7xx_one(p,e)...
> > > > > 
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > ---
> > > > >   drivers/tty/serial/sc16is7xx.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > > > index a05be92f7e776..9d04d665ec9ab 100644
> > > > > --- a/drivers/tty/serial/sc16is7xx.c
> > > > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > > > @@ -365,7 +365,7 @@ static struct uart_driver sc16is7xx_uart = {
> > > > >   	.nr		= SC16IS7XX_MAX_DEVS,
> > > > >   };
> > > > >   
> > > > > -#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
> > > > > +#define to_sc16is7xx_one(p, e)	((container_of((p), struct sc16is7xx_one, e)))
> > > > 
> > > > Or perhaps make it type-safe and more obvious by switching it to an inline?
> > > 
> > > Not easy to do, because this macro is also used with the second
> > > argument "e" not always being used with the same member name. At the
> > > same time, this is what makes this macro more complex than it should
> > > be. I will convert it to an inline and simplify it by removing the
> > > second argument (and of course adapt the code where the new, simpler,
> > > inline function no longer works).
> > 
> > Please don't use an inline fuction for container_of() as you will just
> > need to change it later in the future when you really want to use
> > container_of_const() instead :)
> 
> Noted. I will simplify the macro and leave it as a macro then.
> 
> Would you suggest to also convert container_of to
> container_of_const in this patch series?

For now, no, it's not needed as I do not think this structure is ever
marked as const, is it?

I have a long-term plan to move container_of() to be
container_of_const(), but that's a kernel-wide thing, and not relevant
here.  I was just trying to point out that when inlining container_of(),
it can actually cause problems.

thanks,

greg k-h
