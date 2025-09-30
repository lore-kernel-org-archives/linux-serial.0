Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3733C133;
	Tue, 30 Sep 2025 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193618; cv=none; b=iP7tHCXgr/iDH009ixQkb3YyyV+tDzE1Aj5S8DAugrrzaiRiKYg1PA5AlW0jgArgP0Zxs/IXYo6t5BhDrD+KZg+1P7wOw4C5G48ttouIX10/h1nhNcH+rNHCYAevnIaQV89ksWE1kNQcWCN2IYNJcJQrB6qN7obluE3K/rVI9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193618; c=relaxed/simple;
	bh=hoca13KcHwxHNi7PYf1m+6JtiDzJUsspKSSlJUp0o9g=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=JtB8zHOIVSJhaRwd/IGDMni9ZENty0tBlj3G7f1MMdG/KWuRGhb4DbO9//VXEaMyLKOzMkPDsHLSyqAJIZLtbiNFff5BhU5n6U4QopOCOGcF4BHF0iG88SwtUCvDAoCjk37iAwjaltiQ2MZ7Peg1ttIjIvamwlOfa1Wt80VqU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Op1Mn8DJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Op1Mn8DJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=meEmlsHD2YwqxAbxt1NL+/Q1AzPmFXGThSNSuRKLTb0=; b=Op1Mn8DJ0B3PxQgv9cmwfCedUe
	NHAVbK1wdQBxzUOB7C8BgZn58zOho8LJJmpLJy9CgHOFZtE3UNwPff7KBw8fWi9Jmd8r6k3sIrhs3
	V6xMzoGPAN3apu8g/masvWveaJ92LmW35icyx6mvNgvSE67lggg+AOwl1CEE4WGXT07w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47494 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v3OcY-0005dw-FC; Mon, 29 Sep 2025 20:53:34 -0400
Date: Mon, 29 Sep 2025 20:53:34 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, fvallee@eukrea.fr,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20250929205334.670aeaa3a747801d9071e1d9@hugovil.com>
In-Reply-To: <14a1f14f-f5c7-4d09-9b4b-9248c4f5162c@kernel.org>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-12-hugo@hugovil.com>
	<14a1f14f-f5c7-4d09-9b4b-9248c4f5162c@kernel.org>
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
Subject: Re: [PATCH 11/15] serial: sc16is7xx: remove empty line
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Jiri,

On Mon, 29 Sep 2025 08:14:33 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Remove empty line inavertently added in commit d5078509c8b0
> > ("serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()").
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >   drivers/tty/serial/sc16is7xx.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index d1a9fa26e9bdb..a05be92f7e776 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -834,7 +834,6 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >   static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
> >   {
> >   	bool keep_polling;
> > -
> >   	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
> 
> And remove the cast and switch the two definitions, so we have a 
> reversed xmas tree ;).

Good idea, I will do it in V2.

Hugo.
