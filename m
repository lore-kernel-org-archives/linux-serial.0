Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55462581;
	Tue, 30 Sep 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759261372; cv=none; b=Sdokzu6Gj1en4ca47wpz7yPHI5MazUwzEnBluwBWO2hyo4KPwXzIwJtQLCSgFpe7zbzOMTurCO6xzKSppzK5dAERxJzgvH4j7emqvSi7QsuD+pSORqxlcA1OcOZs61dqRioIypnVz5VN0tQmrmgF0HLS5xd58iY4nUqnF/hRiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759261372; c=relaxed/simple;
	bh=X1uedMjifch/HBfEA9YdTLc3ZAIYvwShhf/7HuUHoZg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=rnKI0cl39PMYnpuBf0wWPHPxJ2CJ+p5TTf5eInnHBsoXGUcNg++w0StRxdGje+3wUvkoiXQTdhOEaD2/zwNa+QEHZHPmD35o/hNVOHwCyMyZDRBildFZM42nCMz+p4CkrLqwMKkwheFNB0tqW0+vDx7FC88tkNc4/Z6Xe5zvrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=DJeivoFv; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="DJeivoFv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=3gBJ4nP+qc/A8NDWXpsGP7ab4u1MNsYZezJ46nSXncc=; b=DJeivoFvEOCtWQH+cYJcVCaQmc
	+zIflskLHmHIiaMVjxRFh59gDZ108JjQxpZ1UWbAdYKBxZSIBrArR/21NcTZPeZTPvaU3qg1g/7+b
	3prmg5Lifp9nVch6B7tzT3Vi8SDGPFa8ijqlw+WMm0vzxvy4eA2wRrRvadOtteQF++so=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57168 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3gFK-00022k-IV; Tue, 30 Sep 2025 15:42:47 -0400
Date: Tue, 30 Sep 2025 15:42:45 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250930154245.93d0405ac3aaa6baa06dd1d8@hugovil.com>
In-Reply-To: <70fc7ca0-a98c-4d1b-9212-c7948607e840@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-15-hugo@hugovil.com>
	<70fc7ca0-a98c-4d1b-9212-c7948607e840@kernel.org>
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
Subject: Re: [PATCH 14/15] serial: sc16is7xx: reformat comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Mon, 29 Sep 2025 08:18:01 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add missing space at end of comments and reformat to have uniform style.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >   drivers/tty/serial/sc16is7xx.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 31d43fc857187..b3fbe9459303a 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -81,11 +81,14 @@
> >   /* IER register bits */
> >   #define SC16IS7XX_IER_RDI_BIT		BIT(0)   /* Enable RX data interrupt */
> >   #define SC16IS7XX_IER_THRI_BIT		BIT(1)   /* Enable TX holding register
> > -						  * interrupt */
> > +						  * interrupt
> > +						  */
> 
> I am not forcing this, but maybe put it on one line, if it fits into 100 
> columns? I believe people are using 100 columns nowadays (me included).

Yes good idea. And since the goal of this commit was to try to
uniformize all comments accross the driver, I will probably reformat
most of them to improve readability and follow same convention.

Hugo.

-- 
Hugo Villeneuve
