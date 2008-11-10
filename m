From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Mon, 10 Nov 2008 15:58:08 -0800
Message-ID: <20081110155808.a4d94ee7.akpm@linux-foundation.org>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20081104174142.360a964a@lxorguk.ukuu.org.uk>
	<20081110143039.6f21fdc3.akpm@linux-foundation.org>
	<20081110234843.0fba9f16@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57531 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbYKJX6x (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2008 18:58:53 -0500
In-Reply-To: <20081110234843.0fba9f16@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 10 Nov 2008 23:48:43 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > That's a regression in current gcc, surely?
> 
> Oh and as a PS: Gcc is I believe right because if the loop is run zero
> times then pos = NULL (ie n == NULL so the first BUG_ON fires)

Whoa.  That would be clever of it.


On about half the architectures, BUG is not considered to be no-return.
Dunno if that's a gcc shortcoming or if the architectures just haven't
implemented it properly yet.  This causes those architectures to
generate quite a few warnings in generic code which don't appear on
x86 (this would be one such case if your above theory is correct).

This is fairly irritating of those architectures, as I keep on going
in asking "what's up" and deciding "oh, that again".
