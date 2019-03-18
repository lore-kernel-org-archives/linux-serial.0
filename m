From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_*
 functions
Date: Mon, 18 Mar 2019 08:03:54 +0000 (GMT)
Message-ID: <alpine.LFD.2.21.1903162132540.31531@eddie.linux-mips.org>
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-11-git-send-email-info@metux.net> <20190314225204.GB1795@kroah.com> <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net> <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net> <20190316032630.GB2499@kroah.com> <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Sat, 16 Mar 2019, Enrico Weigelt, metux IT consult wrote:

> > No, it's just that those systems do not allow those devices to be
> > removed because they are probably not on a removable bus.
> 
> Ok, devices (hw) might not be removable - that also the case for uarts
> builtin some SoCs, or the good old PC w/ 8250. But does that also mean
> that the driver should not be removable ?
> 
> IMHO, even if that's the case, it's still inconsistent. The driver then
> shouldn't support a remove at all (or even builtin only), not just
> incomplete remove.

 This device (as well as `dz') is typically used for the serial console as 
well, so being built-in is the usual configuration.  Nevertheless modular 
operation is supposed to be supported, however it may not have been 
verified for ages.

 A further complication is in the virtual console configuration one of the 
serial lines is dedicated for the keyboard, so again you want the driver 
built-in (although hooking up the virtual console keyboard this way has 
been broken with the conversion to the serial core in the 2.6 timeframe 
and I have never figured it out how it is supposed to be done correctly 
with the new serial infrastructure and SERIO_SERPORT; I believe some 
platforms do it with the use of horrible hacks rather than SERIO_SERPORT).

  Maciej
