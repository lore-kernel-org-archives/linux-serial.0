From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 0/9] tty: Fix buffer work access-after-free
Date: Thu, 06 Dec 2012 19:57:35 -0500
Message-ID: <1354841855.3026.7.camel@thor>
References: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:49507 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423263Ab2LGA5p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 19:57:45 -0500
In-Reply-To: <1354604865-10278-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <levinsasha928@gmail.com>

On Tue, 2012-12-04 at 02:07 -0500, Peter Hurley wrote:
> This patch series addresses the causes of flush_to_ldisc accessing
> the tty after freeing.

Well, there's going to be a v2 of this series.

Sasha found that PATCH 3/9 is an insufficient fix. I've already worked
out the correct solution but I've been plagued by the kswapd/flush
problem so that's making this more challenging then it ought to be.

Plus I tripped across a GP fault in the SLUB allocator which turns out
to be a free list corruption (probably because of the low memory
condition brought on by the kswapd problem. Good times...)

There is also going to be a v3 because I just came up with an idea to
clean up the whole ldisc ref situation, but I'm going to take some time
testing it out first.

Anyway, just wanted to hold this off for another respin.

Regards,
Peter Hurley

