From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Thu, 26 Jul 2007 09:31:01 -0700
Message-ID: <46A8CC45.9050307@howardsilvan.com>
References: <000b01c7cf9c$de574ea0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:50047 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710AbXGZQcR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2007 12:32:17 -0400
In-Reply-To: <000b01c7cf9c$de574ea0$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

Yes, CRTSCTS is set.  Here is what stty says...

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


Tosoni wrote:

>Trivial check:
>
>Did you set the CRTSCTS flag in the c_cflag parameter to tcsetattr() in your
>linux application code ? Or in the corresponding ioctl(..., TCSETA,...) call
>?
>
>
>  
>
>>-----Original Message-----
>>From: linux-serial-owner@vger.kernel.org
>>[mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Lee Howard
>>Sent: Thursday, July 26, 2007 3:53 AM
>>To: linux-serial@vger.kernel.org; tytso@mit.edu; rmk@arm.linux.org.uk;
>>linux-kernel@vger.kernel.org
>>Subject: serial flow control appears broken
>>
>>
>>Hello.
>>
>>I have fax modems that will, in their proper behavior with certain
>>features, send up to 64 kilobytes of data to the host DTE all
>>at once.
>>(So, the fax modem handles an incoming fax and periodically will send
>>between 256 bytes and 64 kilobytes of data in bursts.)
>>
>>When the DCE-DTE (modem-to-host) communication rate is established at
>>115200 bps data loss occurs systems using at least Linux
>>kernels 2.6.5
>>and 2.6.18 (and probably everything in-beween and then some
>>more).  This
>>is because the modem overflows the host's buffer.  This is
>>evidenced in
>>kernel logging:
>>
>>Jul 23 14:01:30 gollum kernel: ttyS1: 1 input overrun(s)
>>Jul 23 17:09:45 gollum kernel: ttyS1: 1 input overrun(s)
>>
>>Normally I would blame the modem itself for not honoring the
>>host's flow
>>control signals.  However, I have worked with the modem manufacturer
>>closely on this matter for over three months now.  In that
>>process they
>>have improved the responsiveness of the modem and have fixed other
>>problems, but the end result is that it truly does appear that the
>>serial tty driver is not using flow control.  Whether software flow
>>control (XON/XOFF) or hardware flow control (RTS/CTS) is used
>>the result
>>is the same.
>>
>>This is evidenced in hardware flow control by a little LED
>>labeled "RTS"
>>that is on the external modem.  This LED lights up when pin 7
>>of the DB9
>>serial connection is given +12Vdc current (signalling "RTS"
>>is on - that
>>the host can accept data).  The LED goes dark when the current is
>>removed (signalling that the host cannot accept data).  This
>>"RTS" LED
>>never flickers at all, as it should, when receiving these
>>bursts of data
>>- the LED stays lit as long as the serial cable is connected to the
>>host... and yet I will see those "input overrun" messages.  Thus, it
>>seems quite clear that the Linux serial tty driver is not deasserting
>>RTS as it should in hardware flow control.  (And probably the
>>analogous
>>problem exists in software flow control, too.)
>>
>>Please tell me what I can do to help you resove and/or remedy this
>>matter.  Also, please let me know if I have contacted the
>>wrong people.
>>(I have cross-posted to linux-kernel as a catch-all.  I am not
>>subscribed to either linux-serial or linux-kernel mailing lists.  So
>>please CC me in any list responses.)
>>
>>If it is of any value to know (perhaps they have common
>>code?), the same
>>error occurs on FreeBSD 6.2 as well.   The problem does not occur on
>>Windows.  The problem does not occur on RedHat 6.0 (kernel 2.2.5).
>>
>>Thanks,
>>
>>Lee.
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe
>>linux-serial" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>    
>>
>
>
>  
>

