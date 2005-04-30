From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [2.6 patch] drivers/serial/8250_pci.c: don't probe non-serial softmodems
Date: Sun, 1 May 2005 00:23:56 +0300
Message-ID: <20050430212356.GB11770@tecr>
References: <20050419235608.GB8276@tecr> <20050430095416.A31027@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sa3.bezeqint.net ([192.115.104.17]:42926 "EHLO sa3.bezeqint.net")
	by vger.kernel.org with ESMTP id S261432AbVD3VFc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 30 Apr 2005 17:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20050430095416.A31027@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On 09:54 Sat 30 Apr     , Russell King wrote:
> On Wed, Apr 20, 2005 at 02:56:08AM +0300, Sasha Khapyorsky wrote:
> > Some soft modem pci devices (known list in the patch) claim to have 
> > 'communication' class, and as result they are grabbed by serial driver.
> > Actually those devices are useless for serial drivers (it is not "real"
> > modem and doesn't have serial interface), but this prevents probing from
> > soft modem drivers (there are few in ALSA).
> 
> What class id are these devices?

It is '0x0703' - PCI_CLASS_COMMUNICATION_MODEM

Sasha.
