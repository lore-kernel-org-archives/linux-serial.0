From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: serial driver cleanups v2
Date: Fri, 15 Mar 2019 11:36:04 +0100
Message-ID: <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com
List-Id: linux-serial@vger.kernel.org

On 15.03.19 10:12, Andy Shevchenko wrote:

>> Part II will be about moving the mmio range from mapbase and
>> mapsize (which are used quite inconsistently) to a struct resource
>> and using helpers for that. But this one isn't finished yet.
>> (if somebody likes to have a look at it, I can send it, too)
> 
> Let's do that way you are preparing a branch somewhere and anounce
> here as an RFC, since this was neither tested nor correct.

Okay, here it is:

I. https://github.com/metux/linux/tree/submit/serial-clean-v3
   --> general cleanups, as basis for II

II. https://github.com/metux/linux/tree/wip/serial-res
   --> moving towards using struct resource consistently

III. https://github.com/metux/linux/tree/hack/serial
    --> the final steps, which are yet completely broken
    (more a notepad for things still to do :o)

The actual goal is generalizing the whole iomem handling, so individual
usually just need to call some helpers that do most of the things.
Finally, I also wanted to have all io region information consolidated
in struct resource.

Meanwhile I've learned that I probably was a bit too eager w/ that.
Guess I'll have to rethink my strategy.

> And selling point for many of them is not true: it doesn't make any
> difference in the size in code, but increases a time to run
> (devm_ioremap_resource() does more than plain devm_iomap() call).

Okay, just seen it. Does the the runtime overhead cause any problems ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
