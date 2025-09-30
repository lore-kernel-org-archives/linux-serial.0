Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AC1514F7;
	Tue, 30 Sep 2025 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192039; cv=none; b=KAgMBvghUWwBrIv40p7/+r6OknlrQIWLhx+3wt3gE1WArzjrAKGVOa4I4MFikr8RHpsYZlInMgP66hFpST1QVtttD5mZePNF+wgF8razFJT0+7nZmBodd4jYRGWj7I3SQC3lHW6i0+F/uDVOQ9AnDGb95Ht3lEbo9xXvNeX3j60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192039; c=relaxed/simple;
	bh=KIMSr9El/g5mZ5tswBobA701Foqyxmxfhh8ckYrmHoQ=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=BHq681oNRy/xD5cA+SyNFoxRiASAw0oNcl7p9/Nohcf7p90Tq4Zpml37xxGe//HY2kMGfEucK7m1e6hZB3UEwjTzCqaO+0GXg3J+lTiyl0i2JXh+hiIhboN21q+N0w4T2Nm/eVO91PQG4ZHyhy7aHnMyZ4l2LCVlr5S3hNTmYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QUR38N3i; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QUR38N3i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=1/eQsiCVd5lqpEwihop8t2LKjbcv0Ywm6mDBdgGqJLY=; b=QUR38N3iYWRPuyAOk8vpHsWSuY
	aNtYiPUp0KAA7c4Ok1mBG3SC1rdr5BVW/zFpj0ibMgYeEVaUoJJLGmhL4GhcJJBl6Uer1G4PYsM8I
	b6JzS6WlnfNFoVXdHrDuuTJK1sIv7QBvpZ5TtHeKT/KgqjBrtWX1Vu/mLj7dpnKu8fBQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34830 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3OCz-0007ny-CJ; Mon, 29 Sep 2025 20:27:09 -0400
Date: Mon, 29 Sep 2025 20:27:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250929202708.c81f114be5286eab259aa4c1@hugovil.com>
In-Reply-To: <0a606585-a7fb-4457-99f5-fe9cc75e366a@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-6-hugo@hugovil.com>
	<0a606585-a7fb-4457-99f5-fe9cc75e366a@kernel.org>
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
Subject: Re: [PATCH 05/15] serial: sc16is7xx: use guards for simple mutex
 locks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Mon, 29 Sep 2025 08:09:12 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> ...
> > @@ -829,9 +827,6 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >   		break;
> >   	}
> >   
> > -out_port_irq:
> > -	mutex_unlock(&one->lock);
> > -
> >   	return rc;
> 
> No need for rc now AFAICT.

You are right, I will remove it in v2.

> 
> >   }
> >   
> > @@ -874,9 +869,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
> >   	    (port->rs485.delay_rts_before_send > 0))
> >   		msleep(port->rs485.delay_rts_before_send);
> >   
> > -	mutex_lock(&one->lock);
> > +	guard(mutex)(&one->lock);
> >   	sc16is7xx_handle_tx(port);
> > -	mutex_unlock(&one->lock);
> >   }
> >   
> >   static void sc16is7xx_reconf_rs485(struct uart_port *port)
> > @@ -943,9 +937,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
> >   	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
> >   
> >   	if (one->port.state) {
> > -		mutex_lock(&one->lock);
> > +		guard(mutex)(&one->lock);
> >   		sc16is7xx_update_mlines(one);
> > -		mutex_unlock(&one->lock);
> >   
> >   		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
> 
> Now the lock is held till here. R U sure it is OK?

Now that you mention it, I am sure its not OK :)

I will restore this one to the original lock/unlock code in V2.

Thank you,
Hugo.
