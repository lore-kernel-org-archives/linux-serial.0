From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Wed,  5 Nov 2008 13:51:12 +0900 (JST)
Message-ID: <20081105135042.966B.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com> <20081104174142.360a964a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:39598 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYKEEvQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 23:51:16 -0500
In-Reply-To: <20081104174142.360a964a@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> > fix following warnings.
> > 
> > drivers/serial/8250.c: In function ‘serial8250_shutdown’:
> > drivers/serial/8250.c:1612: warnings: ‘i’ may be used uninitialized in this function
> 
> NAK
> 
> This is an incorrect compiler warning. It's also one that current gcc
> does not emit warnings for.

I see.
Thanks!



