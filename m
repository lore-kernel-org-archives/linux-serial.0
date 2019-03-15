From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Fri, 15 Mar 2019 10:06:16 +0100
Message-ID: <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314225204.GB1795@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On 14.03.19 23:52, Greg KH wrote:
> On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
>> Use the safer devm versions of memory mapping functions.
> 
> What is "safer" about them?

Garbage collection :)

Several drivers didn't seem to clean up properly (maybe these're just
used compiled-in, so nobody noticed yet).

In general, I think devm_* should be the standard case, unless there's
a really good reason to do otherwise.

<snip>

> Isn't the whole goal of the devm* functions such that you are not
> required to call "release" on them?

Looks that one slipped through, when I was doing that big bulk change
in the middle of the night and not enough coffe ;-)

One problem here is that many drivers do this stuff in request/release
port, instead of probe/remove. I'm not sure yet, whether we should
rewrite that. There're also cases which do request/release, but no
ioremap (doing hardcoded register accesses), others do ioremap w/o
request/release.

IMHO, we should have a closer look at those and check whether that's
really okay (just adding request/release blindly could cause trouble)

> And also, why make the change, you aren't changing any functionality for
> these old drivers at all from what I can tell (for the devm calls).
> What am I missing here?

Okay, there's a bigger story behind, you can't know yet. Finally, I'd
like to move everything to using struct resource and corresponding
helpers consistently, so most of the drivers would be pretty simple
at that point. (there're of course special cases, like devices w/
multiple register spaces, etc)

Here's my wip branch:

https://github.com/metux/linux/commits/wip/serial-res

In this consolidation process, I'm trying to move everything to
devm_*, to have it more generic (for now, I still need two versions
of the request/release/ioremap/iounmap helpers - one w/ and one
w/o devm).

My idea was moving to devm first, so it can be reviewed/tested
independently, before moving forward. Smaller, easily digestable
pieces should minimize the risk of breaking anything. But if you
prefer having this things squashed together, just let me know.

In the queue are also other minor cleanups like using dev_err()
instead of printk(), etc. Should I send these separately ?

By the way: do you have some public branch where you're collecting
accepted patches, which I could base mine on ? (tty.git/tty-next ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
