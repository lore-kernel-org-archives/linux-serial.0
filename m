Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23833F5BF;
	Mon,  4 May 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908442; cv=none; b=t7w0O9iCGjmoceCfV2Jm9wJ5sa1aipPpRO4Zmr9TSxzctKWZRwTaGgR80k7sIUNWe7L8AFP/8c3MptFQAUrO/SEYLrqmGK1T3dWNFSi5ai32M0GD6xYlUYwYvp/7+MG6e+5dh44m7YxZ0HU+pRI338XAV86N44NSTo92GoyPAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908442; c=relaxed/simple;
	bh=dXetnoeU7fvZAHXxjnz1bBX9G/bfXmIXw3qI1tk+xc4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YBc84xeeObNHHETIYo17/9+T83Zc9DQj6fRYB8POxildfuJcazG8K7nd1B0RwsfMRV7jUHkUdgq308kK4VF9Grl9ppxETG9PzqNSQ9PPoto5ka/OeDjZIWTYOljtiO1872tN7Dv2fg5iAdttUMS1u5jZkl/gUXw5xvJIkPRWX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=cpKYd/JA; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="cpKYd/JA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=tqo31qpMjZ4GieSdjzzqmkCrnDX8nSy9/vx4FmUSp78=; b=cpKYd/JAJfWDtN8Di06jZ08My1
	BFGmnp/lwCAQm/yehUW1zbfCPqkyK85xrcsO4KrGvizMrX7jW6moaInmc7wlU40QegaKhBplrpAjS
	vXc0JQbkJMCeL3P31YUaoxSoNQZwMUFM/aQL7TsEzL2qlfpFytKViEhn/tcsZlDcY4dg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wJvCT-000000001Xx-0jSg;
	Mon, 04 May 2026 11:27:13 -0400
Date: Mon, 4 May 2026 11:27:12 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 05/15] serial: core: replace snprintf with more
 robust scnprintf
Message-Id: <20260504112712.7f3d74b47d76d0956b1911fc@hugovil.com>
In-Reply-To: <afNwH01y_6Dk2hVb@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
	<20260428-tty-upio-v2-5-01c1857cf761@dimonoff.com>
	<afNwH01y_6Dk2hVb@black.igk.intel.com>
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

On Thu, 30 Apr 2026 17:07:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 01:53:51PM -0400, Hugo Villeneuve wrote:
> > 
> > Use scnprintf() so we could perhaps one day get rid of snprintf() entirely.
> 
> Ah, now I understand the approach in earlycon. Hmm... Still not sure which one
> I prefer (it's not related to the contents of this patch anyway).
> 
> ...
> 
> >  	default:
> >  		strscpy(address, "*unknown*", sizeof(address));
> 
> Side note: This may use 2-argument strscpy().

This section is now removed in patch:
  serial: core: use uart_iotype_*() to simplify uart_report_port()

But interesting to know this 2-argument variant :)


-- 
Hugo Villeneuve
