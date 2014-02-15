From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RFC: MFD: driver for Atmel Microcontroller on iPaq h3xxx
Date: Sat, 15 Feb 2014 11:24:10 -0800
Message-ID: <20140215192410.GC2280@kroah.com>
References: <1391175275-27347-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdb1LFP45Oy0YJ6DSHriSorvHacH=RRWb4LmZ286LJJX0g@mail.gmail.com>
 <20140210115318.GD22773@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53059 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbaBOTWu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Feb 2014 14:22:50 -0500
Content-Disposition: inline
In-Reply-To: <20140210115318.GD22773@lee--X1>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alessandro Gardich <gremlin@gremlin.it>, Dmitry Artamonow <mad_soft@inbox.ru>

On Mon, Feb 10, 2014 at 11:53:18AM +0000, Lee Jones wrote:
> > > This adds a driver for the Atmel Microcontroller found on the
> > > iPAQ h3xxx series. This device handles some keys, the
> > > touchscreen, and the battery monitoring.
> > 
> > Any opinions on this driver or should we queue it in MFD as-is?
> 
> I have no problem taking this through the MFD tree with Greg's nod.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
