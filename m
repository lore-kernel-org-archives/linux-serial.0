From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: msm_serial_hs: Add MSM high speed UART driver
Date: Mon, 13 Dec 2010 10:06:07 -0800
Message-ID: <20101213180607.GA28841@kroah.com>
References: <4CEE028B.1040701@codeaurora.org>
 <20101125170113.GB17686@kroah.com>
 <4D05C664.3030605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60028 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758276Ab0LMSGR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Dec 2010 13:06:17 -0500
Content-Disposition: inline
In-Reply-To: <4D05C664.3030605@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mayank Rana <mrana@codeaurora.org>
Cc: linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, npelly@google.com

On Mon, Dec 13, 2010 at 12:38:20PM +0530, Mayank Rana wrote:
> >>+#include<linux/msm_serial_hs.h>
> >
> >Please put this file in include/platform_data/ instead.
> Greg,
> 
> Thanks for reviewing the patch.
> Is there any particular reason not allowing msm_serial_hs.h as part
> of include/linux and need of moving same into as part of
> include/platform_data? I am seeing multiple driver doing same.
> Can you please suggest on this ?

Yes, it's not good to clutter up include/linux/ with this kind of
platform specific stuff.  Create a new directory and we will then move
all of these types of files over to it, yours will be one of the first.

thanks,

greg k-h
