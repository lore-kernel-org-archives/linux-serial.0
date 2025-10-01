Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792F2522BA;
	Wed,  1 Oct 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295770; cv=none; b=fX6c+6USNUJO07i6oy3iSJlFOT0jjZ2jLnspU8kdPK/qfQTE3oQGWXI4LT9zNXzMWIHKYsdNmrG499tBRGMyYNxit+1BUD7VPQkEDTN2rhfB7wP7BEpj0ICE6MwJC88RerQajTGFj5FCA4jJsFXA9SLRAZPxz0HTHMMKsfC+Xg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295770; c=relaxed/simple;
	bh=YnE0dy5W4cZnBVjbHXTJaql1n2ab4p6ekpKHo2MGa8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S25MHUpKDw4WuTao1bVMIamC7F4Bjjw1GvdGFuHbq62nXXGpyGvqIMamhxmW/jFe2Yle3l0KP9IWtNTPMKemRMGDTqN4Y7zCEs0T8iU/EH7rMFed+/KRET0dDSUsZ4hmLKnDvxlpTq/5ibLaRvY7Ssg25hw4SJA6IWrQkJ64ENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pop+VGZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pop+VGZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5C2C4CEF4;
	Wed,  1 Oct 2025 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759295769;
	bh=YnE0dy5W4cZnBVjbHXTJaql1n2ab4p6ekpKHo2MGa8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pop+VGZdjhx4JrQhKoooC1eA8uOhDH3HurBbdm6mDeoQGFJrko88CrwLj1o4aOkxX
	 0X4+C9QBNrJp3J29eOewMBGUWzb6h3ROK46xR/bkaZ8T+sRBioF7fTUVxVAuRCmiPd
	 XIKZWJzPeUGOkwRWV0IERr/5h3tSKzGcgo5ZuDNU=
Date: Wed, 1 Oct 2025 07:16:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, fvallee@eukrea.fr,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 12/15] serial: sc16is7xx: add missing space between macro
 args (checkpatch)
Message-ID: <2025100132-usage-sandstone-8a9f@gregkh>
References: <20250924153740.806444-1-hugo@hugovil.com>
 <20250924153740.806444-13-hugo@hugovil.com>
 <a6bb8046-1e71-4766-afa8-e9d303ba57b8@kernel.org>
 <20250930160828.546867810b4a17c36a5030c6@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930160828.546867810b4a17c36a5030c6@hugovil.com>

On Tue, Sep 30, 2025 at 04:08:28PM -0400, Hugo Villeneuve wrote:
> Hi Jiri,
> 
> On Mon, 29 Sep 2025 08:15:56 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
> 
> > On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Fix the following checkpatch error:
> > > 
> > >      ERROR: space required after that ',' (ctx:VxV)
> > >      +#define to_sc16is7xx_one(p,e)...
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >   drivers/tty/serial/sc16is7xx.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > index a05be92f7e776..9d04d665ec9ab 100644
> > > --- a/drivers/tty/serial/sc16is7xx.c
> > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > @@ -365,7 +365,7 @@ static struct uart_driver sc16is7xx_uart = {
> > >   	.nr		= SC16IS7XX_MAX_DEVS,
> > >   };
> > >   
> > > -#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
> > > +#define to_sc16is7xx_one(p, e)	((container_of((p), struct sc16is7xx_one, e)))
> > 
> > Or perhaps make it type-safe and more obvious by switching it to an inline?
> 
> Not easy to do, because this macro is also used with the second
> argument "e" not always being used with the same member name. At the
> same time, this is what makes this macro more complex than it should
> be. I will convert it to an inline and simplify it by removing the
> second argument (and of course adapt the code where the new, simpler,
> inline function no longer works).

Please don't use an inline fuction for container_of() as you will just
need to change it later in the future when you really want to use
container_of_const() instead :)

thanks,

greg k-h
