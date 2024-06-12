Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B5180A9D;
	Wed, 12 Jun 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211013; cv=none; b=tUkXlVs8kgNT8YxVkPwc7wwfx7thmpl7KW53uQdk9K2H/3bjs8vXKpbjGNPVGXBLskTF48G21Sz79Nj2StQIIetNWPjgMkPrumgjddN98k+9MJ3DtzJnajstP8uV1SUoYllRH2ZCoJoBEhbCfTUlXumRwBg1uOS1bLO4Utllz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211013; c=relaxed/simple;
	bh=1+I5V9NYee1bHQnUE0DpjcmsjTOMx2yLHVVcxFh2xUc=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=JXheR4bNbo9T4w9ktP66Ddrg6jTeGjHjkBC27e91KireeDyZk3Kr7t1KFKyLqOKc7CP8dLX3lAi3Qu4eIT5nqhpW78o9KPhqxnzs+UTXZf0dTkuYdZm8x+YDqb+C9aJ1NIXfo3uC3I/duQ8eorHnE5OWusFDdM+fPiNfmzGXNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=cLZPPb87; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="cLZPPb87"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=qLxkdcofhQumVijzICDBQTPcWLQYVU9tUB2EIf7Q9XI=; b=cLZPPb87XkYkaqmDJQCAOfq5ii
	4oLHbHGeAPJq8UGVM8nb7VSUzxVu2t5duSceJXP8AGVZjG9iZrHNirlDtnE5b9jlidn4BRf80W8qz
	TF5NDLYcUj0sVw67vtC8mMq8OVaI+a+1AqTJRcNxpzrOW+q6bwgt/Gvi+xYogBI9Xb0s=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34928 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sHRAi-00005w-Ep; Wed, 12 Jun 2024 12:50:04 -0400
Date: Wed, 12 Jun 2024 12:49:43 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Conor Dooley <conor@kernel.org>
Cc: Hui Wang <hui.wang@canonical.com>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Message-Id: <20240612124943.5ce6996abdf670651d0231a5@hugovil.com>
In-Reply-To: <20240612-skeleton-bullseye-71067b2244b4@spud>
References: <20240612131454.49671-1-hui.wang@canonical.com>
	<20240612-skeleton-bullseye-71067b2244b4@spud>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 12 Jun 2024 17:37:30 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jun 12, 2024 at 09:14:53PM +0800, Hui Wang wrote:
> > In some designs, the chip reset pin is connected to a GPIO, and this
> > GPIO needs to be set correctly before probing the driver, so add a
> > reset-gpios in the device tree.
> > 
> > Signed-off-by: Hui Wang <hui.wang@canonical.com>
> > ---
> > In the v3:
> >  - drop the Reviewed-by
> >  - change gpio to GPIO
> >  - change "this GPIO" to "and this GPIO"
> >  - change "so adding" to "so add"
> 
> There's no need to drop an R-b for grammar changes in a commit message.

Hi Conor,
The R-b tags were never given in the first place, that is why they are
removed:

https://lore.kernel.org/all/6b1b0635-304c-48d7-a941-fae30962083a@canonical.com/

-- 
Hugo Villeneuve
