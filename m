From: Ed Vance <EdV@macrolink.com>
Subject: RE: Trouble reading from my serial device (a microcontroller)
Date: Thu, 20 Nov 2003 12:42:31 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34048@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:29038
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S261898AbTKTUlw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2003 15:41:52 -0500
List-Id: linux-serial@vger.kernel.org
To: 'Chuck Messenger' <chuckm@rochester.rr.com>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 20, 2003 at 11:23 AM, Chuck Messenger wrote:
> I'm unable to read from a serial device under Linux (Mandrake 9.1, 
> 2.4.21-0.13mdk kernel), but the device works find in Windows.  I'm 
> hoping someone can offer me suggestions.
> 
> My device is a Basic Stamp microcontroller, which I've programmed to 
> spit out a certain byte continuously -- 0x40 -- at 38400 
> baud,n,8,1. The 
> device loops RTS back to DSR (i.e. it connects pins 6 and 7 
> of the 9-pin 
> serial connector -- DSR and RTS).  Other than that, only Rx 
> and Tx are 
> connected (and ground, of course).
> 
> I know the hardware works (both controller and PC), because I 
> can boot 
> Win2k on the same machine and run a short program I wrote which 
> continuously dumps to the console whatever comes in.
> 
> Also, I know that things are _basically_ configured right, in 
> my Linux 
> boot, since I can run "statserial /dev/tts/0", which shows, in real 
> time, the status of the DSR line.  When I unplug from my device, DSR 
> goes low; when I plug it back in, DSR goes high.
> 
[snip]
> 
> However, the program fails to read any bytes -- it hangs at 
> the read().
> 
> I've tried running serlook, but that, too, failed to see any bytes.
> 
> Any suggestions?
> 
> I've tried 9600 baud instead of 38400 -- still no luck (although it 
> works under Win2k).
> 
> Poking around, I've seen mention of the DCD control line -- 
> could that 
> be the problem (i.e. does the Linux serial driver require it, 
> somehow? 
> I don't have it hooked up.)
> 
Hi Chuck,

Your program works fine on my Red Hat 7.3 setup. A difference is that all of
my modem status lines are driven. (could not find my breakout box) Try
connecting your serial port's DTR output to its DCD input. Perhaps the
program is hanging on the open instead of the read, because DCD is detected
low and you are not opening with O_NONBLOCK (or O_NDELAY).

cheers,
Ed
