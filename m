From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] max3100 driver
Date: Thu, 9 Oct 2008 10:18:22 +0100
Message-ID: <20081009101822.54acd701@lxorguk.ukuu.org.uk>
References: <1221895208650-git-send-email-chripell@gmail.com>
	<20080920151149.21dbad1d@lxorguk.ukuu.org.uk>
	<cabda6420810082330i6d013e18o72eac3cb869b1e4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34231 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753468AbYJIJSY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2008 05:18:24 -0400
In-Reply-To: <cabda6420810082330i6d013e18o72eac3cb869b1e4e@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chri <chripell@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> > If there has been a hangup the port.tty will be NULL...
> >
> 
> I check against NULL. But let me ask again: the other drivers (for
> example SA1100) don't do it. How they avoid the nasty NULL pointer
> dereference?

Some drives keep the tty pointer and deliver data to closed ttys wrongly,
others do careful locking, others are just broken.


> Sorry again for not having replied before resending the patch.

No problem
