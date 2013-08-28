From: Kumar Gala <galak@codeaurora.org>
Subject: merging device tree binding dirs for serial bindings
Date: Wed, 28 Aug 2013 13:02:14 -0500
Message-ID: <F93329E6-1426-4197-871D-211F34455DDE@codeaurora.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org Guo" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de Hauer" <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

We appear to have:

Documentation/devicetree/bindings/serial/

and

Documentation/devicetree/bindings/tty/serial/

Which one do we want to keep, I'd pick the first, but I don't care too much.

Also, there appears to be a duplicated (but different) binding for the fsl-imx-uart.txt in these two dirs.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
