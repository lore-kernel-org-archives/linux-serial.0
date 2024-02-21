Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAB84FA5
	for <linux-serial@vger.kernel.org>; Wed, 21 Feb 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556395; cv=none; b=DlhDH8HUqrR9K/y2N7dpFgQudHRaKu/NOPu4qOQFveT0tstzNk6yENMLdGymgHRSWUNEiA+R9LKBadvx7kODLv1CdCHUTtdr37B+OY61Z0osoNmTJVOuh+N3zZvelfk/2gPHMvm8XU94qYoZz/h3wRn8y8jbg2/RrOhIyxxYuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556395; c=relaxed/simple;
	bh=AMSjpmxjA36u8C5j8FcCJuenzKkgGzOB5yLYbFdEbK4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gya8h7gw2qyLraG1VFhJVSDfThq5BY8YLh+ARdh2ykwClKRp8ximSXG82W2Xujji3+U2FW4WqIJbD3hjo5lM9C8TznCioB4awRaaxzV+ZFiUgP0E0aO1uxPSassZP2pVkKnu46iwU8997AXt4TLJoFqthkt0cY9m79u1qhSPIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id c2e1bbbe-d10c-11ee-b972-005056bdfda7;
	Thu, 22 Feb 2024 00:58:43 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 22 Feb 2024 00:58:43 +0200
To: "5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com" <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Darren Beeson <darren.beeson@sealevel.com>,
	Jeff Baldwin <jeff.baldwin@sealevel.com>,
	Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Message-ID: <ZdaAI4uZ1Byx2cWs@surfacebook.localdomain>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>

Wed, Feb 21, 2024 at 09:16:46PM +0000, Matthew Howell kirjoitti:
> Allows the use of the EN485 hardware pin by preserving the value of
> FCTR[5] in pci_xr17v35x_setup().
> 
> Per the XR17V35X datasheet, the EN485 hardware pin works by setting
> FCTR[5] when the pin is active. pci_xr17v35x_setup() prevented the use
> of EN485 because it overwrote the FCTR register.

First of all, please avoid In-Reply-to: for the new versions of the change,
i.o.w. new version — new email thread.

Second, the above commit message sounds like a fix. Does it deserve Fixes tag?

...

>  	unsigned int baud = 7812500;
>  	u8 __iomem *p;
>  	int ret;
> +	u8 en485mask;

Please, preserve reversed xmas tree order.

	unsigned int baud = 7812500;
	u8 __iomem *p;
	u8 en485mask;
	int ret;

-- 
With Best Regards,
Andy Shevchenko


