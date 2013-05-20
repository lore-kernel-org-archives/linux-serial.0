From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/13] serial: imx: Let device core handle pinctrl
Date: Mon, 20 May 2013 11:50:12 -0700
Message-ID: <20130520185012.GB24761@kroah.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
 <1367863561-11534-9-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45869 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab3ETSuN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 May 2013 14:50:13 -0400
Content-Disposition: inline
In-Reply-To: <1367863561-11534-9-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, festevam@gmail.com, linux-serial@vger.kernel.org

On Mon, May 06, 2013 at 03:05:57PM -0300, Fabio Estevam wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for handling pinctrl.
> 
> So remove devm_pinctrl_get_select_default() from the driver. 
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/tty/serial/imx.c |    9 ---------
>  1 file changed, 9 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
