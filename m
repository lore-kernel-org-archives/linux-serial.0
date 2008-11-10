From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Mon, 10 Nov 2008 23:47:44 +0000
Message-ID: <20081110234744.0eb062b5@lxorguk.ukuu.org.uk>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20081104174142.360a964a@lxorguk.ukuu.org.uk>
	<20081110143039.6f21fdc3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50954 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752001AbYKJXrp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2008 18:47:45 -0500
In-Reply-To: <20081110143039.6f21fdc3.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> hlist_for_each() can execute that loop zero times, in which case
> serial_unlink_irq_chain will dereference an uninitialised variable.
> 
> Presumably the list shouldn't be empty at this stage, but this
> is not particularly robust behaviour if that should happen..

And the only cases that can trip are the more important BUG_ON() checks.
You could remove the BUG_ON() calls and make it less robust but that
seems slightly well silly to me ?

Alan
