From: Ed Vance <EdV@macrolink.com>
Subject: RE: DTD required (was Re: Trouble reading from my serial device (
	a microcontroller))
Date: Thu, 20 Nov 2003 13:38:39 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34049@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:56459
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S262458AbTKTViI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2003 16:38:08 -0500
List-Id: linux-serial@vger.kernel.org
To: 'Chuck Messenger' <chuckm@rochester.rr.com>
Cc: linux-serial@vger.kernel.org

Hi Chuck,

Yep, I'm surprised too about open. Also, in theory, the read should not have
hanged, because you had previously set CLOCAL. Just a bug or two, here. Oh
well. For hysterical .. oops .. historical reasons, the default termio(s)
settings have CLOCAL off. The idea was that if you were using a modem, the
port would hang in the open until the phone line and modem connection was
made, as evidenced by detection of carrier tone from the remote modem. (DCD
= carrier detect). This standard behavior has frustrated people who were
just trying to connect local devices for many years. Some systems have a
"soft carrier" option outside of termios that causes a port to act as if DCD
is always asserted. 

You can accomplish the same thing by looping back DTR (pin 4) to DCD (pin
1). Open will assert DTR, and that will drive DCD high for you. That's what
most folks do.

Cheers,
Ed

> -----Original Message-----
> From: Chuck Messenger [mailto:chuckm@rochester.rr.com]
On Thu, Nov 20, 2003 1:13 PM, Chuck Messenger wrote:
> 
> Thanks, Ed.
> 
> I just got done trying out connecting DCD to +12 before reading your 
> message - it did the trick.
> 
> I did not call open() with O_NONBLOCK, but open() did not hang.  The 
> documentation I've read suggests that open() would hang in this case, 
> without DCD, but since I found that open() didn't hang, I figured DTD 
> wasn't necessary.
> 
> I guess the documentation is wrong.
> 
> Thanks for the fast response!
> 
> On another note: why should the Linux device driver require DTD to be 
> on?  This seems like a bad design -- surely it should be controllable 
> via tcsetattr() or an ioctl or something...?  And, it would 
> be useful if 
> the requirement was documented.
> 
>      - Chuck
> 
> Ed Vance wrote:
> > On Thu, Nov 20, 2003 at 11:23 AM, Chuck Messenger wrote:
> > 
> >>I'm unable to read from a serial device under Linux (Mandrake 9.1, 
> >>2.4.21-0.13mdk kernel), but the device works find in Windows.  I'm 
> >>hoping someone can offer me suggestions.
> >>
> >>My device is a Basic Stamp microcontroller, which I've 
> programmed to 
> >>spit out a certain byte continuously -- 0x40 -- at 38400 
> >>baud,n,8,1. The 
> >>device loops RTS back to DSR (i.e. it connects pins 6 and 7 
> >>of the 9-pin 
> >>serial connector -- DSR and RTS).  Other than that, only Rx 
> >>and Tx are 
> >>connected (and ground, of course).
> >>
> >>I know the hardware works (both controller and PC), because I 
> >>can boot 
> >>Win2k on the same machine and run a short program I wrote which 
> >>continuously dumps to the console whatever comes in.
> >>
> >>Also, I know that things are _basically_ configured right, in 
> >>my Linux 
> >>boot, since I can run "statserial /dev/tts/0", which shows, in real 
> >>time, the status of the DSR line.  When I unplug from my 
> device, DSR 
> >>goes low; when I plug it back in, DSR goes high.
> >>
> > 
> > [snip]
> > 
> >>However, the program fails to read any bytes -- it hangs at 
> >>the read().
> >>
> >>I've tried running serlook, but that, too, failed to see any bytes.
> >>
> >>Any suggestions?
> >>
> >>I've tried 9600 baud instead of 38400 -- still no luck (although it 
> >>works under Win2k).
> >>
> >>Poking around, I've seen mention of the DCD control line -- 
> >>could that 
> >>be the problem (i.e. does the Linux serial driver require it, 
> >>somehow? 
> >>I don't have it hooked up.)
> >>
> > 
> > Hi Chuck,
> > 
> > Your program works fine on my Red Hat 7.3 setup. A 
> difference is that all of
> > my modem status lines are driven. (could not find my 
> breakout box) Try
> > connecting your serial port's DTR output to its DCD input. 
> Perhaps the
> > program is hanging on the open instead of the read, because 
> DCD is detected
> > low and you are not opening with O_NONBLOCK (or O_NDELAY).
> > 
> > cheers,
> > Ed
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
