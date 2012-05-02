From: Oliver Neukum <oneukum@suse.de>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0 chip Oopses
Date: Wed, 2 May 2012 12:08:47 +0200
Message-ID: <201205021208.47420.oneukum@suse.de>
References: <4FA10506.7020203@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38818 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab2EBKMq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 06:12:46 -0400
In-Reply-To: <4FA10506.7020203@fold.natur.cuni.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

Am Mittwoch, 2. Mai 2012, 11:57:26 schrieb Martin Mokrejs:
> Hi,
>   I am trying to setup a remote serial console on my Dell Vostro 3550 laptop.
> I have some USB to serial dongle which has Prolific 2303 chipset, and works.
> I have statically in my kernel:
> 
> USB_SERIAL=y
> USB_SERIAL_CONSOLE=y
> CONFIG_USB_SERIAL_PL2303=y
> 
>   The problem is that when I attach the dongle to USB3.0 controller linux crashes.
> It does not happen if I attach it to EHCI controller (like shown in lsub output at
> the end of this email).

Hi,

interesting. There's no good reason scheduling a work should fail
depending on the hardware at this point. What does /proc/interrupts say?

	Regards
		Oliver
