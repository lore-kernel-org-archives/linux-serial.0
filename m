Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F694184A;
	Wed, 20 Dec 2023 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="hc2ZOE4L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=ebua2wySSX5WI4UINedesYX+NQM/p2GeiFeCoKwMB/o=; b=hc2ZOE4Luf3maQom4qq8yo8c8q
	dFr6QA6ZCqecAYmLjNo0nqheLjqvCUSNxZWbJCZqXyHkLew/i5eCkRWCh7ThmQoO92svvv87QARmY
	7earedJb0utss6Emi0PKvx63LH6Mwf3cbsKkU4XRMHMxrjMwLiNg04K14SiyIfbAyTWY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33870 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFzJk-00071Q-S1; Wed, 20 Dec 2023 11:21:09 -0500
Date: Wed, 20 Dec 2023 11:21:08 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220112108.9ff049f369b6fa95f50b803a@hugovil.com>
In-Reply-To: <ZYMOTx-IniZOhO-Z@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-15-hugo@hugovil.com>
	<ZYMOTx-IniZOhO-Z@smile.fi.intel.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 14/18] serial: sc16is7xx: drop unneeded MODULE_ALIAS
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:54:55 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:58PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The MODULE_DEVICE_TABLE already creates the proper aliases for the
> 
> MODULE_DEVICE_TABLE()

Done for V2.

Hugo.


> 
> > SPI driver.
> 
> With the above fixed
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 


-- 
Hugo Villeneuve
