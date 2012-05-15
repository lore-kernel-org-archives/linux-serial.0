From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 17:27:10 +0100
Message-ID: <20120515172710.0d0ce47b@pyramind.ukuu.org.uk>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
	<20120515165339.6b142cd2@pyramind.ukuu.org.uk>
	<20120515155833.GA24878@kroah.com>
	<CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45460 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965642Ab2EOQYV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 12:24:21 -0400
In-Reply-To: <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corbin <corbinat@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

On Tue, 15 May 2012 11:20:19 -0500
Corbin <corbinat@gmail.com> wrote:

> I agree that losing bytes in the software layer wouldn't happen under
> normal circumstances, but it is still important to know when it
> happens. My understanding was that the overrun field in the port's
> icount was for logging hardware overruns, while the buf_overrun field
> should be used for software overruns. If this is not the case then is
> there another method for determining when the software layer is losing
> bytes?

It'll occur when the machine cannot even allocate a free page of memory.
So you'll get GFP spews in the kernel log to go with it.

Alan
