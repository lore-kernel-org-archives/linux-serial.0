From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: serial driver cleanups v2
Date: Thu, 14 Mar 2019 23:33:30 +0100
Message-ID: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Hello folks,


here's v2 of my serial cleanups queue - part I:

essentially using helpers to code more compact and switching to
devm_*() functions for mmio management.

Part II will be about moving the mmio range from mapbase and
mapsize (which are used quite inconsistently) to a struct resource
and using helpers for that. But this one isn't finished yet.
(if somebody likes to have a look at it, I can send it, too)


happy hacking


--mtx
