Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5698F54;
	Tue, 30 Sep 2025 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192333; cv=none; b=rd/xMmy2MAMt4t6aOiMS5SKLcayts7AUIvKqU/8xmrVXSqh6UUxvV5yd85LrmcCyMGRyk4iDJ9BiPSwwPSolSkAws7gbGNcw84c+OrVm9i1hmKXT30gI9a+ssf30u1/+KBwtZBW6GvvS2EdSRTIwwfbMEwLwai7FhT+d/zT83hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192333; c=relaxed/simple;
	bh=+tLNx+ty8nM9Mq69rXCXs1LMIASD60kRA1Yv1OyNcjw=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=phadzV6P3SDd2ZVvGCUhSU8ZLaYyrX76PE9DldEoKZ2rGp16YN0tItbWX2dXcG8oP+lmQ3yzBUimD/7TeLC4HR+6qgoJF4IfXuQMGbn8xG9CY0eCyVT1GyRWFEUmyZB/rqBK/eyV1PVajml64gisXPK633a5lHCGmrXbvhUe9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ecE4NoUU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ecE4NoUU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=hQOQ4L7I2CcAyJkBWqUO9MjfM4Y5ef3z7CcrWZV4qR0=; b=ecE4NoUUt4hfIN6D3D+NGrSHXU
	kyLuDVf4dePDF+RsQOb+41YaKTZvOfJRZ5dR/HCYzXRW3/TJUNe9Ges6YqnvDmymCdgqTo7BL3cr7
	g0Af1eIrfv87gVWt9IO9uZ4qEYo7kvoiQRxLQ8AN89odjA7vHHgQ6Yhs8BCEW0Pkx9t0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43862 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3OHo-0000nE-V4; Mon, 29 Sep 2025 20:32:09 -0400
Date: Mon, 29 Sep 2025 20:32:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250929203208.507952a1d6454a94427dee50@hugovil.com>
In-Reply-To: <a7fe7f1e-df3f-4823-a19c-b581e8bb0eea@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-7-hugo@hugovil.com>
	<a7fe7f1e-df3f-4823-a19c-b581e8bb0eea@kernel.org>
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
	* -2.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 06/15] serial: sc16is7xx: use dev_err_probe() instead of
 dev_err()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Mon, 29 Sep 2025 08:10:17 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > This simplifies code and standardizes the error output.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >   drivers/tty/serial/sc16is7xx.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 7af09535a1563..4384804a4e228 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1528,10 +1528,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
> >   
> >   	/* Alloc port structure */
> >   	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
> > -	if (!s) {
> > -		dev_err(dev, "Error allocating port structure\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!s)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "Error allocating port structure\n");
> 
> This does not work as you'd expect:
>          case -ENOMEM:
>                  /* Don't print anything on -ENOMEM, there's already 
> enough output */
>                  break;

Ok, I will simply remove the original dev_err() call.

Hugo.
