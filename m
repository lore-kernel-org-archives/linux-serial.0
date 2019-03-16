From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Sat, 16 Mar 2019 10:17:11 +0100
Message-ID: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
 <20190316032630.GB2499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316032630.GB2499@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On 16.03.19 04:26, Greg KH wrote:

> No, it's just that those systems do not allow those devices to be
> removed because they are probably not on a removable bus.

Ok, devices (hw) might not be removable - that also the case for uarts
builtin some SoCs, or the good old PC w/ 8250. But does that also mean
that the driver should not be removable ?

IMHO, even if that's the case, it's still inconsistent. The driver then
shouldn't support a remove at all (or even builtin only), not just
incomplete remove.

>> Okay, I was on a wrong track here - I had the silly idea that it would
>> make things easier if we'd do it the same way everywhere.
> 
> "Consistent" is good, and valid, but touching old drivers that have few
> users is always risky, and you need a solid reason to do so.

Understood.

By the way: do we have some people who have those old hw and could test?
Should we (try to) create some ? Perhaps some "tester" entry in
MAINTAINERS file ? (I could ask around several people who might have
lots of old / rare hardware.)

>> Understood. Assuming I've found some of these cases, shall I use devm
>> oder just add the missing release ?
> 
> If it actually makes the code "simpler" or "more obvious", sure, that's
> fine.  But churn for churns sake is not ok.

Ok.

> I put the review of new patch submissions on hold, yes.  Almost all
> maintainers do that as we can not add new patches to our trees at that
> point in time.

hmm, looks like a pipeline stall ;-)
why not collecting in a separate branch, which later gets rebased to
mainline when rc is out ?

> And I do have other things I do during that period so it's not like I'm
> just sitting around doing nothing :)

So it's also a fixed schedule for your other work. Understood.

It seems that this workflow can confuse people. Few days ago, somebody
became nervous about missing reactions on patches. Your autoresponder
worked for me, but maybe not for everybody.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
