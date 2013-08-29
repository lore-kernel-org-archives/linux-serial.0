From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] serial: fsl-imx-uart: Cleanup duplicate device tree
 binding
Date: Thu, 29 Aug 2013 20:55:19 +0800
Message-ID: <20130829125517.GJ18729@S2101-09.ap.freescale.net>
References: <1377716903-19699-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377716903-19699-1-git-send-email-galak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, fabio.estevam@freescale.com, s.hauer@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 28, 2013 at 02:08:22PM -0500, Kumar Gala wrote:
> We had two bindings for the same serial device, it looks like the one in
> tty/serial/fsl-imx-uart.txt is the more up to date one so go with it and
> merge a few things about the use/need for aliases in from
> serial/fsl-imx-uart.txt.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
