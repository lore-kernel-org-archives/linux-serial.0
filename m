From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and preparation for DMA engine conversion
Date: Wed, 10 Oct 2012 11:29:03 -0700
Message-ID: <87mwzuxjtc.fsf@deeprootsystems.com>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
	<507427DA.6020409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64212 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2JJS3B (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Oct 2012 14:29:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so999599pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 10 Oct 2012 11:29:01 -0700 (PDT)
In-Reply-To: <507427DA.6020409@ti.com> (Sourav's message of "Tue, 9 Oct 2012
	19:04:18 +0530")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

Hi Sourav,

Sourav <sourav.poddar@ti.com> writes:

[...]

> Boot Tested this patch series against v3.6 tag(applied cleanly) on
> panda board and
> PM tested(hitting off in Idle and suspend) on omap3630 based beagle board.
>
> Note, I also tested the patches against the current master but only
> after rebasing, since the current master includes serial patches from
> Felipe Balbi[1].
> [1] https://lkml.org/lkml/2012/8/24/139
>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>

Did you test flow control after off-mode transitons?

Russell indicated that the context save/restore is not saving important
bits related to HW flow control, so I suspect some more testing,
specifically of flow control after off-mode is needed.

Kevin
