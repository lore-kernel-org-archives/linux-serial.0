From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [GIT PATCH] TTY/serial driver patches for 3.1
Date: Tue, 26 Jul 2011 15:05:17 +0000
Message-ID: <CAOZdJXWuRLSZVof1q51yTmk1FXFR28mb9qSYcbChC8KC2awn=g@mail.gmail.com>
References: <20110726050225.GA2529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:24917
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab1GZPFV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jul 2011 11:05:21 -0400
In-Reply-To: <20110726050225.GA2529@kroah.com>
Content-Language: en-US
Content-ID: <375F0D82D6FC7B4CA22FC1855F182442@freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Jul 26, 2011 at 12:02 AM, Greg KH <gregkh@suse.de> wrote:
> Here is the big tty/serial patchset for your 3.1 tree.
>
> Nothing major at all, lots of line discipline tweaks for the newer ones
> that were added last release, and some small tty core fixes as well.

Greg,

I hate to be a pest, but you didn't include my patch, "[v3]
tty/powerpc: introduce the ePAPR embedded hypervisor byte channel
driver".  The other six patches of that patchset are already in Linus'
tree, so I'd really like to get this one into 3.1 as well.  You even
tried to apply v2 to tty-next about three weeks ago, but it didn't
apply so I immediately posted v3.

-- 
Timur Tabi
Linux kernel developer at Freescale
