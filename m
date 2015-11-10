From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 4.3 serial driver crashes with console shortly after boot
Date: Tue, 10 Nov 2015 23:39:58 +0100
Message-ID: <20151110223957.GI3533@two.firstfloor.org>
References: <20151110002939.GG3533@two.firstfloor.org>
 <56414DE9.20707@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56414DE9.20707@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Andi Kleen <andi@firstfloor.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> I've just tried to reproduce this without success on my current
> tree which has some additional patches I just posted this am. They weren't
> intended to fix crashes but they directly impact the area of concern. Could
> you try these three?
>
> [PATCH v2 2/4] n_tty: Ignore all read data when closing
> [PATCH v2 3/4] tty: Abstract and encapsulate tty->closing behavior
> [PATCH v2 4/4] tty: Remove drivers' extra tty_ldisc_flush()
>
Applying the three patches fixes the crash. 
I haven't tried to figure out which one did the trick.

Thanks,

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
