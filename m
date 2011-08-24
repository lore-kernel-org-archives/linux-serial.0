From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] tty: 8250_dw: fix build error for CONFIG_SERIAL_8250=m
Date: Wed, 24 Aug 2011 16:24:34 +0100
Message-ID: <20110824152434.GQ23757@pulham.picochip.com>
References: <1314169906-12958-1-git-send-email-jamie@jamieiles.com>
 <201108241645.16377.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59490 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HXPYs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 11:24:48 -0400
Received: by wyg24 with SMTP id 24so920260wyg.19
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2011 08:24:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108241645.16377.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

Hi Arnd,

On Wed, Aug 24, 2011 at 04:45:16PM +0200, Arnd Bergmann wrote:
> When go go to such length, I think the approach I initially advocated
> (making 8250_dw a standalone platform_driver like of_serial) will be
> nicer.

For a separate driver, is it okay to make it depend on CONFIG_OF, and 
only have device tree bindings, or should this still support being 
registered as a static platform device with platform data?  I'm not sure 
what the consensus is on creating device tree only platform drivers.

Thanks,

Jamie
