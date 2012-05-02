From: Oliver Neukum <oneukum@suse.de>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0 chip Oopses
Date: Wed, 2 May 2012 14:44:07 +0200
Message-ID: <201205021444.07823.oneukum@suse.de>
References: <4FA10506.7020203@fold.natur.cuni.cz> <201205021222.30133.oneukum@suse.de> <4FA11113.6060901@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48620 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab2EBMsH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 08:48:07 -0400
In-Reply-To: <4FA11113.6060901@fold.natur.cuni.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

Am Mittwoch, 2. Mai 2012, 12:48:51 schrieb Martin Mokrejs:
> > Does it work if you boot with nomsi?
> 
> Yes, dmesg attached.

Sorry, I was referring to pci=nomsi

So it works if you simply add "nomsi" to the kernel command line?
Can you check whether this is repeatable?

	Regards
		Oliver
