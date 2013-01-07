From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/5] serial: imx: Some fixes and cleanups
Date: Mon, 7 Jan 2013 09:30:56 +0100
Message-ID: <20130107083056.GF1906@pengutronix.de>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57344 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab3AGIa7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 03:30:59 -0500
Content-Disposition: inline
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, patches@linaro.org

On Mon, Jan 07, 2013 at 10:25:01AM +0530, Sachin Kamat wrote:
> This series build tested using imx_v4_v5_defconfig against
> linux-next tree (20130107).
> 
> Sachin Kamat (5):
>   serial: imx: Fix checkpatch errors related to spacing
>   serial: imx: Use <linux/io.h> instead of <asm/io.h>
>   serial: imx: Fix coding style issue
>   serial: imx: Use pr_info instead of printk
>   serial: imx: Use devm_* APIs
> 
>  drivers/tty/serial/imx.c |  263 ++++++++++++++++++++++------------------------
>  1 files changed, 125 insertions(+), 138 deletions(-)

Looks good.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
