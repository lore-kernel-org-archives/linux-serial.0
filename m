From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 39/45] drivers: tty: serial: efm32-uart: use devm_*
 functions
Date: Fri, 15 Mar 2019 08:46:12 +0100
Message-ID: <20190315074612.i6hxyrxs4lhbn6d5@pengutronix.de>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-40-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552602855-26086-40-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Hello Enrico,

On Thu, Mar 14, 2019 at 11:34:09PM +0100, Enrico Weigelt, metux IT consult wrote:
> Use the safer devm versions of memory mapping functions.

In which aspect is devm_ioremap safer than ioremap?

The only upside I'm aware of is that the memory is automatically
unmapped on device unbind. But we don't benefit from this because an
UART port is "released" before the device is unbound and we call
devm_iounmap() then anyhow. So this patch just adds a memory allocation
(side note: on a platform that is quite tight on RAM) with no added
benefit.

I didn't look at the other patches in this series, but assuming that
they are similar in spirit, the same question applies for them.

Do I miss anything?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
