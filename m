From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0
 chip Oopses
Date: Thu, 03 May 2012 11:14:46 +0200
Message-ID: <4FA24C86.5090003@fold.natur.cuni.cz>
References: <4FA10506.7020203@fold.natur.cuni.cz> <201205021222.30133.oneukum@suse.de> <4FA11113.6060901@fold.natur.cuni.cz> <201205021444.07823.oneukum@suse.de> <20120502234639.GH22341@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:55710 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755361Ab2ECJOu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 May 2012 05:14:50 -0400
In-Reply-To: <20120502234639.GH22341@xanatos>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Oliver Neukum <oneukum@suse.de>, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

Sarah Sharp wrote:
> On Wed, May 02, 2012 at 02:44:07PM +0200, Oliver Neukum wrote:
>> Am Mittwoch, 2. Mai 2012, 12:48:51 schrieb Martin Mokrejs:
>>>> Does it work if you boot with nomsi?
>>>
>>> Yes, dmesg attached.
>>
>> Sorry, I was referring to pci=nomsi
>>
>> So it works if you simply add "nomsi" to the kernel command line?
>> Can you check whether this is repeatable?
> 
> If it's repeatable, we can just add the XHCI_BROKEN_MSI quirk to that TI
> host.

I have to figure out what I did to my .config that it is not repeatable anymore,
at all. :(( I will come back to you later when I repeat that. Thanks.
Martin
