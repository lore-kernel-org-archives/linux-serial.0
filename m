From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [2.6 patch] drivers/serial/8250_pci.c: don't probe non-serial softmodems
Date: Sat, 28 May 2005 02:00:50 +0300
Message-ID: <20050527230050.GF13829@tecr>
References: <20050419235608.GB8276@tecr> <20050430095416.A31027@flint.arm.linux.org.uk> <20050430212356.GB11770@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sa9.bezeqint.net ([192.115.104.23]:52673 "EHLO sa9.bezeqint.net")
	by vger.kernel.org with ESMTP id S262625AbVE0Wmo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 May 2005 18:42:44 -0400
Content-Disposition: inline
In-Reply-To: <20050430212356.GB11770@tecr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

On 00:23 Sun 01 May     , Sasha Khapyorsky wrote:
> On 09:54 Sat 30 Apr     , Russell King wrote:
> > On Wed, Apr 20, 2005 at 02:56:08AM +0300, Sasha Khapyorsky wrote:
> > > Some soft modem pci devices (known list in the patch) claim to have 
> > > 'communication' class, and as result they are grabbed by serial driver.
> > > Actually those devices are useless for serial drivers (it is not "real"
> > > modem and doesn't have serial interface), but this prevents probing from
> > > soft modem drivers (there are few in ALSA).
> > 
> > What class id are these devices?
> 
> It is '0x0703' - PCI_CLASS_COMMUNICATION_MODEM

Any updates, comments? What is the patch status?

Sasha.

