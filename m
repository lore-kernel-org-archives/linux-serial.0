From: Chuck Messenger <chuckm@rochester.rr.com>
Subject: DTD required (was Re: Trouble reading from my serial device (a microcontroller))
Date: Thu, 20 Nov 2003 16:13:06 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <bpja5d$mua$1@sea.gmane.org>
References: <11E89240C407D311958800A0C9ACF7D1A34048@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:10430 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262425AbTKTVCk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2003 16:02:40 -0500
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AMvwl-00035G-00
	for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2003 22:02:39 +0100
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A34048@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Thanks, Ed.

I just got done trying out connecting DCD to +12 before reading your 
message - it did the trick.

I did not call open() with O_NONBLOCK, but open() did not hang.  The 
documentation I've read suggests that open() would hang in this case, 
without DCD, but since I found that open() didn't hang, I figured DTD 
wasn't necessary.

I guess the documentation is wrong.

Thanks for the fast response!

On another note: why should the Linux device driver require DTD to be 
on?  This seems like a bad design -- surely it should be controllable 
via tcsetattr() or an ioctl or something...?  And, it would be useful if 
the requirement was documented.

     - Chuck

Ed Vance wrote:
> On Thu, Nov 20, 2003 at 11:23 AM, Chuck Messenger wrote:
> 
>>I'm unable to read from a serial device under Linux (Mandrake 9.1, 
>>2.4.21-0.13mdk kernel), but the device works find in Windows.  I'm 
>>hoping someone can offer me suggestions.
>>
>>My device is a Basic Stamp microcontroller, which I've programmed to 
>>spit out a certain byte continuously -- 0x40 -- at 38400 
>>baud,n,8,1. The 
>>device loops RTS back to DSR (i.e. it connects pins 6 and 7 
>>of the 9-pin 
>>serial connector -- DSR and RTS).  Other than that, only Rx 
>>and Tx are 
>>connected (and ground, of course).
>>
>>I know the hardware works (both controller and PC), because I 
>>can boot 
>>Win2k on the same machine and run a short program I wrote which 
>>continuously dumps to the console whatever comes in.
>>
>>Also, I know that things are _basically_ configured right, in 
>>my Linux 
>>boot, since I can run "statserial /dev/tts/0", which shows, in real 
>>time, the status of the DSR line.  When I unplug from my device, DSR 
>>goes low; when I plug it back in, DSR goes high.
>>
> 
> [snip]
> 
>>However, the program fails to read any bytes -- it hangs at 
>>the read().
>>
>>I've tried running serlook, but that, too, failed to see any bytes.
>>
>>Any suggestions?
>>
>>I've tried 9600 baud instead of 38400 -- still no luck (although it 
>>works under Win2k).
>>
>>Poking around, I've seen mention of the DCD control line -- 
>>could that 
>>be the problem (i.e. does the Linux serial driver require it, 
>>somehow? 
>>I don't have it hooked up.)
>>
> 
> Hi Chuck,
> 
> Your program works fine on my Red Hat 7.3 setup. A difference is that all of
> my modem status lines are driven. (could not find my breakout box) Try
> connecting your serial port's DTR output to its DCD input. Perhaps the
> program is hanging on the open instead of the read, because DCD is detected
> low and you are not opening with O_NONBLOCK (or O_NDELAY).
> 
> cheers,
> Ed
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


