From: Glynn Clements <glynn@gclements.plus.com>
Subject: Re: Accessing USB thermometer sensor
Date: Fri, 20 Jun 2008 17:44:29 +0100
Message-ID: <18523.56941.116797.23150@cerise.gclements.plus.com>
References: <8b08c39f01286180748bbc0eeddc56cb.squirrel@webmail.vp44.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-c-programming-owner@vger.kernel.org>
In-Reply-To: <8b08c39f01286180748bbc0eeddc56cb.squirrel@webmail.vp44.net>
Sender: linux-c-programming-owner@vger.kernel.org
To: jhammond@external.fwmail.org
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-c-programming@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Josh Hammond wrote:

> Hello to everybody.
> I have recently purchased a USB thermometer from a chinese ebay store.
> The sensor has no brand whatsoever and just carries the "TEMPer" label.
> 
> I plugged it to my debian unstable box (with a vanilla 2.6.24.4 kernel)
> and it was detected as
> 
> 4348:5523 WinChipHead USB->RS 232 adapter with Prolifec PL 2303 chipset
> 
> I believe this means that it is, at least partly, accessible by a linux
> system (although it seems to do some weird USB-serial emulation).
> I am now trying to access the thermometer, and more specifically be able
> to read the data it provides.
> 
> I realize this is a very broad question, but could somebody point me in
> the right direction to be able to read the temperature from command
> line?
> The only serial experience I have is connecting to a switch's console and
> configuring it with putty/minicom.
> 
> I pasted the outputs from syslog and lsusb but I dont' really see how
> the latter relates to my problem.
> Thanks to everyone that will respond, since now I feel quite lost.

> usb 1-2.2: pl2303 converter now attached to ttyUSB0

Does "cat /dev/ttyUSB0" work?

-- 
Glynn Clements <glynn@gclements.plus.com>
