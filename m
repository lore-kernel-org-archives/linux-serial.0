Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAD3909BC;
	Mon, 20 Jul 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574704; cv=none; b=QWs8lxU461rCZaaVidUtOiqcS48KCMZFGFzU9YReaJpZO0cFCKpk1lysnZ1l2qZbYYynCLJNLuMRHTwnDAr3H0YR4MqIHzKDikkZxXt57CSHBf0hU8tMt9N4otGkDAwKrpMuZSWXRDv63MQVnshFU7kOZ1zy22viZuI0SYCRJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574704; c=relaxed/simple;
	bh=4ReCbrKmK5vByjwTOJ1jCUWqZdiGD2QLjMNFFGzkT70=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stIi2aBJoxXzVXSOXpScKpVvZvcz+1gM//fWlL3U4t4nHAjQXpicpoxfh00zPNANlTXNb0SbP6VKQKI+1jrFcVSEedsc0u5kjlBX9RZyvIkxHStWER6W2oggtRVzzD3bhS1oDFpCBxx+f8zrIS8lo3/gGRWcwN7KTCTlnx+yiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=I0PY/bkm; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="I0PY/bkm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=YTeJNm5CNwQNCvowfRUyXvIQ3dlefu/aKxMfyh8zRI0=; b=I0PY/bkmL/LNQS0bfwExtpda1X
	Kgwps9OzB3T2/TQRoXTISRleKQ5RkZfPmeDjMPNYh80IJeaHXCQ8X4sQDf0WgI4FLFefBaKXgVo9q
	pigGuSsEeZlYnoektwX0VWxnjLWSEnnJ6Qw549f0KQnEU/oFR3yhxqilLAvQPMSshrAs=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wltOu-000000005Ou-3yrM;
	Mon, 20 Jul 2026 15:11:41 -0400
Date: Mon, 20 Jul 2026 15:11:40 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, kernel
 test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix compile error with hub6_match_port()
 when compiled as a module
Message-Id: <20260720151140.70939799547c922b09670014@hugovil.com>
In-Reply-To: <al5yTxizfIGibYZa@black.igk.intel.com>
References: <20260715153707.4181828-1-hugo@hugovil.com>
	<al5yTxizfIGibYZa@black.igk.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Andy,

On Mon, 20 Jul 2026 21:09:03 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 15, 2026 at 11:37:05AM -0400, Hugo Villeneuve wrote:
> 
> > With CONFIG_SERIAL_8250_HUB6=m, we have the following compile error:
> > 
> >   ../drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of
> >        'hub6_match_port'
> > 
> > Fix hub6_match_port() prototype definition by using IS_REACHABLE() to
> > support both built-in and module values, and substitute empty prototype
> > otherwise.
> 
> ...
> 
> > +#include <linux/kconfig.h>
> 
> It's special header. It is always-included one, and hence here is a dup, please
> drop this line.

Will do. I will also remove the one in max310x.c which was added by...
me :)

-- 
Hugo Villeneuve
