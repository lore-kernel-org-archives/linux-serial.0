Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E653E0220;
	Mon,  4 May 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909205; cv=none; b=s9j+5kjYsnmrq7aKi84qNR3VJcMm7H3LPjw1u0CzeN4Nknjd4UKa0JFGVXsItgbFmQQ1PdFdG94qYZRQm8VHb+ZCvvicX38gJUYGy/1kWBPO+aV5Sc5+8ZVTrSn0FMda5wbZ4v2UthWUGX6U6vBonU+7dGwaD0/q26e8hxtPItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909205; c=relaxed/simple;
	bh=/PPUw0tsg+S8RNeyQk0ciFkxcKiJKNrnHVxk9hi+SpY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N0/92nI6YZnwlhvnJveyXst7cz/Fpnjj/4Awoep2HalMubpw0e5GMVTR4tITy91VfVKkxrrIx5umbqX6kR7sVHEaX33hE0+Fg7oBCUtvegQcRhl8IUqEDRrMofZBTq76NuOWJnBL8VVEIEyuHxTWp7IV6iQJIli21M9Wxoi1rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=zuc3ksra; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zuc3ksra"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=GC+U0FWgLRlnRz1C2NvSd3LbvGzDTtch8U0L3QyKOkU=; b=zuc3ksraM+3PJ2Y57xAexi830r
	osXIF9k1OXF6snjC4gv28sKvlLPTYFseqS+cdVG0t4SFycfwHMhEJ4DpEvl4tZpZHDLtHK8KCQ1Lg
	c3HsG9QUSa0hi8B/ckSIuCyf3xYKcjdH38OUebh3xlArD7Q2qquZSRNoLuv2HDav/BWQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wJvOr-000000001mH-48Tk;
	Mon, 04 May 2026 11:40:02 -0400
Date: Mon, 4 May 2026 11:40:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 08/15] serial: earlycon: use uart_iotype_*() to
 simplify code
Message-Id: <20260504114001.a20541e974060c6fe2f26ba1@hugovil.com>
In-Reply-To: <afNvR59jmKu3-CoF@black.igk.intel.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
	<20260428-tty-upio-v2-8-01c1857cf761@dimonoff.com>
	<afNvR59jmKu3-CoF@black.igk.intel.com>
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

On Thu, 30 Apr 2026 17:03:35 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 01:53:54PM -0400, Hugo Villeneuve wrote:
> 
> > Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
> > to simplify and improve code readability.
> 
> ...
> 
> > +	char address[64] = "";
> 
> TBH, I prefer two pr_info() calls as that approach
> - doesn't require temporary buffer
> - doesn't use heavy s*printf() on top of the existing printing
> - doesn't limit the flexibility of each of the strings (64 might
>   become not enough in some cases, however unlikely to happen)

Note that this approach is already used in uart_report_port().

Also this patch may be reworked if patch "serial: uniformize serial
port I/O infos display" is deemed ok...

-- 
Hugo Villeneuve
