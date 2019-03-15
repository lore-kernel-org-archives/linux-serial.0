From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Fri, 15 Mar 2019 20:12:47 +0100
Message-ID: <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315142628.GA30650@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On 15.03.19 15:26, Greg KH wrote:
> On Fri, Mar 15, 2019 at 10:06:16AM +0100, Enrico Weigelt, metux IT consult wrote:
>> On 14.03.19 23:52, Greg KH wrote:
>>> On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
>>>> Use the safer devm versions of memory mapping functions.
>>>
>>> What is "safer" about them?
>>
>> Garbage collection :)
> 
> At times, but not when you do not use the api correctly :)

Okay, my fault that I didn't read the code careful enough :o

But still, I think the name is a bit misleading as it *sounds* as just
a wrapper around devm_ioremap() that just picks the params from a
struct resource. I guess we can't change the name easily ?

> Yes, there are lots of drivers for devices that are never unloaded or
> removed from the system.  The fact that no one has reported any problems
> with them means that they are never used in situations like this.

So, never touch a running system ?

> No, you need to have a good reason why it needs to be changed, when you
> can not verify that this actually resolves a problem.  As this patch
> shows, you just replaced one api call with another, so nothing changed
> at all, except you actually took up more memory and logic to do the same
> thing :(

Okay, I was on a wrong track here - I had the silly idea that it would
make things easier if we'd do it the same way everywhere.

>> IMHO, we should have a closer look at those and check whether that's
>> really okay (just adding request/release blindly could cause trouble)
> 
> I agree, please feel free to audit these to verify they are all correct.
> But that's not what you did here, so that's not a valid justification
> for these patches to be accepted.

Understood. Assuming I've found some of these cases, shall I use devm
oder just add the missing release ?

>> In this consolidation process, I'm trying to move everything to
>> devm_*, to have it more generic (for now, I still need two versions
>> of the request/release/ioremap/iounmap helpers - one w/ and one
>> w/o devm).
> 
> Move everything in what part of the kernel?  The whole kernel or just
> one subsystem?

Just talking about the serial drivers.

>> My idea was moving to devm first, so it can be reviewed/tested
>> independently, before moving forward. Smaller, easily digestable
>> pieces should minimize the risk of breaking anything. But if you
>> prefer having this things squashed together, just let me know.
> 
> Small pieces are required, that's fine, but those pieces need to have a
> justification for why they should be accepted at all points along the
> way.

Hmm, okay, in these cases, I agree there's no real justification if
we're not seeing it as an intermediate step to the upcoming stuff.
Having thought a bit more about this, my underlying dumbness was
setting everything on the devm horse when converting introducing the
helpers, and then splitted out the change to devm in even more patches
... Silly me, I better should have catched some sleep instead :o

>> In the queue are also other minor cleanups like using dev_err()
>> instead of printk(), etc. Should I send these separately ?
> 
> Of course.

Ok. I'll collect those things in a separate branch and send out the
queue from time to time:

https://github.com/metux/linux/tree/wip/serial/charlady

>> By the way: do you have some public branch where you're collecting
>> accepted patches, which I could base mine on ? (tty.git/tty-next ?)
> 
> Yes, that is the tree and branch, but remember that none of my trees can
> open up until after -rc1 is out.

So, within a merge window, you put everything else on hold ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
