From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: 8250_dw: fix build error for CONFIG_SERIAL_8250=m
Date: Wed, 24 Aug 2011 18:14:04 +0200
Message-ID: <201108241814.04695.arnd@arndb.de>
References: <1314169906-12958-1-git-send-email-jamie@jamieiles.com> <201108241645.16377.arnd@arndb.de> <20110824152434.GQ23757@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56211 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab1HXQOI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 12:14:08 -0400
In-Reply-To: <20110824152434.GQ23757@pulham.picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

On Wednesday 24 August 2011, Jamie Iles wrote:
> On Wed, Aug 24, 2011 at 04:45:16PM +0200, Arnd Bergmann wrote:
> > When go go to such length, I think the approach I initially advocated
> > (making 8250_dw a standalone platform_driver like of_serial) will be
> > nicer.
> 
> For a separate driver, is it okay to make it depend on CONFIG_OF, and 
> only have device tree bindings, or should this still support being 
> registered as a static platform device with platform data?  I'm not sure 
> what the consensus is on creating device tree only platform drivers.

Do only what is necessary. If the devices are all probed using device
tree, then support only that. If someone else really needs static
platform_data instead, they can add support for that later.

	Arnd
