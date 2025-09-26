Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154C1F4168;
	Fri, 26 Sep 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903084; cv=none; b=NCap3KmHkiTHH7gOwJvtkLJwtKx+tcUF6jcdCLCuDsRszlEMk7It1QgcoK9uOmtsns20DvIG21vJLh4fEp2XuU45ADrzYgDqynxFZTLZerJ0oFqSgkkVxsX9xWeCgAzhqxq53BKas5D63yd0axuacU995Lb7ch/hfc/Se9DbbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903084; c=relaxed/simple;
	bh=9NYZD3x9GFtKPgbclMfdlp6RMOI9t52rGodws8FLemA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=DEaQGNyWVBSa8juHsl/SxeiqoMAORhtPaLi9IVZA7DYm4ARovdm39a/eFzLQRa89gtzuJprqyVzHP/BEM5uwqgokSRgGIvfdLb6z86WoE9WfnXE5Bx56cx6vaVchEpVYWnBHvdvRx15EK1TNEjRhJJpWn8BVBYsVNMC75vzr1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=PgoiqZPO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="PgoiqZPO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=81JsLoFxnWm1L8S1ud896ycOO1gyTeFPVlGazgA2IV0=; b=PgoiqZPOOtTXStLKs38J3b0akQ
	/kw0wZv6f3EOR1shUnQSwB1AzD5OEX6Kmiz204lpQy58PF00MTz55RMfnly7VC94cNtVo/merPjMd
	nfuREo43I8p63w71rQTVRPo8GNpQb+rzbPc//aSsjk3wwXSLYZTR/qzb2gCm/jJXlkwg=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:45198 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v2B2K-000685-Rq; Fri, 26 Sep 2025 12:11:11 -0400
Date: Fri, 26 Sep 2025 12:11:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>, "fvallee@eukrea.fr"
 <fvallee@eukrea.fr>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20250926121108.2e1c26b9acd140f5ede5b2a1@hugovil.com>
In-Reply-To: <DB6PR05MB4551CE3468BE5BC059981F49831EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
	<20250924153740.806444-14-hugo@hugovil.com>
	<DB6PR05MB4551CE3468BE5BC059981F49831EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.5 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 13/15] serial: sc16is7xx: change incorrect indentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Maarten,

On Fri, 26 Sep 2025 09:18:38 +0000
Maarten Brock <Maarten.Brock@sttls.nl> wrote:

> Hi Hugo,
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Change incorrect indentation level introduced in commit 9eb90d57b55a
> > ("sc16is7xx: Add flag to activate IrDA mode").
> 
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1181,7 +1181,7 @@ static int sc16is7xx_startup(struct uart_port *port)
> >  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
> >  			      SC16IS7XX_MCR_IRDA_BIT,
> >  			      one->irda_mode ?
> > -				SC16IS7XX_MCR_IRDA_BIT : 0);
> > +			      SC16IS7XX_MCR_IRDA_BIT : 0);
> 
> Are you sure you want to unindent this?
> To me it now looks as if both "one->irda_mode" and "SC16IS7XX_MCR_IRDA_BIT : 0" are parameters.
> And why not fix this by placing both on one line? Is 76 characters already over the line length limit?

Excellent suggestion, will look much better. Will do it in V2.

-- 
Hugo Villeneuve
