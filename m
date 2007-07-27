From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 10:36:03 -0700
Message-ID: <46AA2D03.70800@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	<46A84B4A.6070902@shaw.ca>	<46A8C6F1.4080309@howardsilvan.com>	<20070726173121.70088a92@the-village.bc.nu>	<46A98845.8010806@howardsilvan.com> <20070727124715.20130b14@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:38103 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbXG0RhR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 13:37:17 -0400
In-Reply-To: <20070727124715.20130b14@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org

Alan Cox wrote:

>>So, does this explain why I wouldn't have a problem at 115200 bps with 
>>kernel 2.2.5 but why I do with 2.6.5 and 2.6.18?  Both hardware and 
>>    
>>
>
>Without a scope on the board running both 2.2 and 2.6 that would be hard
>to tell.
>  
>

I see.  Unfortunately I don't have a scope here in my office.  The modem 
manufacturer does have a scope, but they only have a system running 
2.6.  I suppose I could have them return the test system that I sent to 
them and I could reinstall it with 2.2... if you feel like that will help.

>You are
>making assumptions that seem unwise - eg that the code didn't happen to
>work in 2.2.5 even though it was not correctly setting hardware flow
>control, or that the defaults set by the user space apps run with the
>distribution haven't changed and thus shown up such a problem.
>  
>

Understood.  Please let me know the systematic approach that you would 
like me to follow in debugging this.

>Also was the 2.2 and 2.6 on the same exact mainboard ?
>  
>

Yes.  I have several hard drives with various installations on them.  I 
just plug whichever drive in that I want to use for the OS version 
installed.  So I've got a drive with RedHat 6.0 (kernel 2.2.5) and a 
separate drive with Fedora Core 2 (2.6.5).  The installation that I did 
for the manufacturer on a separate machine is Fedora Core 6 (2.6.18).

>You've verified that flow control does not seem to be getting asserted
>for h/w control on the wires
>  
>

The manufacturer has verified this with their scope.  I can ony do this 
by watching the RTS LED on the modem... which may or may not be a 
reliable way to monitor things.

>Next question on the software side therefore is does the serial port have
>CRTSCTS set when the problem is showing up. (stty -a </dev/ttyWhatever)
>

Yes.  Here's what it looks like:

# stty -F /dev/ttyS1 -a
speed 115200 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; 
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = 
^W; lnext = ^V; flush = ^O;
min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl 
-ixon -ixoff -iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 
bs0 vt0 ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop 
-echoprt -echoctl -echoke
#

Thanks,

Lee.
