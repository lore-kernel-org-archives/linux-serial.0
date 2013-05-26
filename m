From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/13] serial: imx: Let device core handle pinctrl
Date: Mon, 27 May 2013 04:01:55 +0900
Message-ID: <20130526190155.GA17666@kroah.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
 <1367863561-11534-9-git-send-email-fabio.estevam@freescale.com>
 <20130520185012.GB24761@kroah.com>
 <CAOMZO5B+Le92n-0m2wwspW6iA_qP6d7M_YSAzmtFOhaBtbQyrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40766 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab3EZTBm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 May 2013 15:01:42 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5B+Le92n-0m2wwspW6iA_qP6d7M_YSAzmtFOhaBtbQyrQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@linaro.org, kernel@pengutronix.de, linux-serial@vger.kernel.org

On Sun, May 26, 2013 at 02:46:30PM -0300, Fabio Estevam wrote:
> Hi Greg,
> 
> On Mon, May 20, 2013 at 3:50 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, May 06, 2013 at 03:05:57PM -0300, Fabio Estevam wrote:
> >> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> >> we can rely on device core for handling pinctrl.
> >>
> >> So remove devm_pinctrl_get_select_default() from the driver.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: <linux-serial@vger.kernel.org>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >>  drivers/tty/serial/imx.c |    9 ---------
> >>  1 file changed, 9 deletions(-)
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Could you please apply this one and 10/13 in your tree?

Care to resend them so that I can?  I thought they depended on the
previous patches.

thanks,

greg k-h
