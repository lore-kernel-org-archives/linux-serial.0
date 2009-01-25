From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [trivial patch] fix missing space in printk
 drivers/serial/8250.c
Date: Sun, 25 Jan 2009 14:16:57 +0000
Message-ID: <20090125141657.3f74f73a@lxorguk.ukuu.org.uk>
References: <497B7C7F.80104@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42529 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754839AbZAYORf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Jan 2009 09:17:35 -0500
In-Reply-To: <497B7C7F.80104@msgid.tls.msk.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-serial@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

On Sat, 24 Jan 2009 23:39:27 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> Again, I don't know where to push this trivia thing.
> 8250 marked as Orphan in MAINTAINERS, so I'm sending
> to linux-serial@ AND to linux-kernel@
> 
> Because.. when I see such mess in dmesg, it annoys me ;)
> 
>  Serial: 8250/16550 driver10 ports, IRQ sharing enabled
> 
> Signed-Off-By: Michael Tokarev <mjt@tls.msk.ru>

Doesn't apply and the upstream tree appears to have this fixed
