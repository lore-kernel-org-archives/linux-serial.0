Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5A3081B7;
	Tue, 30 Sep 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240655; cv=none; b=lBWCthoB26CES9ZyoAXWIwoWOF2clFwWQA5DHOrNTT6QBYViZ/IapmWx9Y6jyl9++poNK2kCd3Q8XNKfufv/xChjh8GlGyphsduaRcbWywQWNiyb35oC4QkjsasMdCzTC3/rgPfb/o9Q6QabRZGkUukv3pJjigUm1ut5fNHDDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240655; c=relaxed/simple;
	bh=39QyzGMfiikXZkrlPxzShxpLUluSLeGLpS1p/PphIow=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=ry7EYKm4F80vCORx3Ch0/8H/VBW7JMCSl0AJcg6YcBXRWvvgyreNeR1DL9GhaFvjGVzarvYu7DsHxvxEkwR2/kxkpbBWkW3K88V6plDYeQsp8bWuq+GS4LPUTigoLkRFynKF7VpkdEnf+SFtRMJ06yDIzrgc9v0phkVMdpyg5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=p+YJ6/TB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="p+YJ6/TB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=F3sKom5bC4Wh31m4fE7+XVG4B2sDYrJrMQMCKp6TgeE=; b=p+YJ6/TB76jLL9Mi2SHBkJ7lnm
	QC2syv2td9lR0opNSKOTyFgrL62pvGFt82cocaQfeZbTKnofkJWJP/Up4KvCP2iSEAaHXu6tyz6N5
	QsPsRV/qxrC+dvsvW7DuN4v3S4QLgBcr5qJWqJzRAlyi9hO730lmoHNO+TAJ8aMhKhfs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56722 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3arD-0004Ol-6u; Tue, 30 Sep 2025 09:57:31 -0400
Date: Tue, 30 Sep 2025 09:57:28 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250930095728.2a35a4af334cf860cc476823@hugovil.com>
In-Reply-To: <3805400b-bf91-468a-8dac-4699b41cd5f6@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-6-hugo@hugovil.com>
	<0a606585-a7fb-4457-99f5-fe9cc75e366a@kernel.org>
	<20250929202708.c81f114be5286eab259aa4c1@hugovil.com>
	<3805400b-bf91-468a-8dac-4699b41cd5f6@kernel.org>
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
Subject: Re: [PATCH 05/15] serial: sc16is7xx: use guards for simple mutex
 locks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Tue, 30 Sep 2025 06:01:35 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 30. 09. 25, 2:27, Hugo Villeneuve wrote:
> >>> @@ -943,9 +937,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
> >>>    	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
> >>>    
> >>>    	if (one->port.state) {
> >>> -		mutex_lock(&one->lock);
> >>> +		guard(mutex)(&one->lock);
> >>>    		sc16is7xx_update_mlines(one);
> >>> -		mutex_unlock(&one->lock);
> >>>    
> >>>    		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
> >>
> >> Now the lock is held till here. R U sure it is OK?
> > 
> > Now that you mention it, I am sure its not OK :)
> > 
> > I will restore this one to the original lock/unlock code in V2.
> 
> Or use a scoped lock ;).

Cool, will use that.

Thank you,
Hugo.
