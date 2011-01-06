From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] RS485 on Cris: use global value of TIOCSRS485
Date: Thu, 6 Jan 2011 13:34:55 +0000
Message-ID: <20110106133455.2f6175c6@lxorguk.ukuu.org.uk>
References: <4D257C87.4040400@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37255 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751522Ab1AFNgK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 08:36:10 -0500
In-Reply-To: <4D257C87.4040400@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: starvik@axis.com, Jesper Nilsson <Jesper.Nilsson@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

> With this patch, TIOCSRS485 gets the same value across all
> architectures, making maintenance and portability of user-level code
> easier.

I don't see why this is worth doing - no application code should ever
hardcode the value.

> +	case TIOCSRS485DEPR:
> +	{
> +		printk(KERN_DEBUG "The use of this ioctl is deprecated. Use TIOCSRS485 instead\n");
> +		/* Fall through */
> +	}

and letting everyone spew printks is not a good thing.

NAK
