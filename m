From: "Gary Frerking" <gary@frerking.org>
Subject: Re: Serial Howto suggestions (was Re: Trouble reading from my serial device...)
Date: Thu, 20 Nov 2003 22:29:18 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <008301c3aff0$6a5d0a00$11103742@LAPTOP>
References: <11E89240C407D311958800A0C9ACF7D1A34049@EXCHANGE> <3FBD7CD7.1060902@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from larry.frerking.org ([65.166.141.103]:47775 "EHLO
	larry.frerking.org") by vger.kernel.org with ESMTP id S264291AbTKUFa6
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2003 00:30:58 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Chuck Messenger <chuckm@rochester.rr.com>

I've saved this whole thread for future consideration, thanks.

-- Gary

----- Original Message ----- 
From: "Chuck Messenger" <chuckm@rochester.rr.com>
To: <linux-serial@vger.kernel.org>
Sent: Thursday, November 20, 2003 7:47 PM
Subject: Serial Howto suggestions (was Re: Trouble reading from my serial
device...)


> OK, thanks for the thorough explanation, Ed -- it all makes sense now...
>
> As far as the documentation goes -- I'm sending this to the
> maintainers/writers of the Linux Serial Howto, and the Linux Serial
> Programming Howto.  I had trouble sending to both before, so I'm
> cross-posting here in the hopes they might see it...
>
> 1) In my experience, open() does not hang if DTD is not asserted, even
> without O_NONBLOCK.  Instead, open() returns, but read() hangs instead.
>   If DTD is not asserted, and you open with O_NONBLOCK, then open()
> returns (as per the documentation), but all read()'s fail right away
> (not in the documentation).
>
> 2) It would be very helpful to point out in the documentation that you
> _must_ assert DCD -- in hardware -- or it will be impossible for you to
> operate the serial port, no matter what software flags you use.  It
> would be nice to point out the trick of attaching DTR to DCD, too.
>
> For reference, I'm running Mandrake 9.1, with kernel 2.4.21-0.13mdk.
>
>      - Chuck
>
> Ed Vance wrote:
> > Hi Chuck,
> >
> > Yep, I'm surprised too about open. Also, in theory, the read should not
have
> > hanged, because you had previously set CLOCAL. Just a bug or two, here.
Oh
> > well. For hysterical .. oops .. historical reasons, the default
termio(s)
> > settings have CLOCAL off. The idea was that if you were using a modem,
the
> > port would hang in the open until the phone line and modem connection
was
> > made, as evidenced by detection of carrier tone from the remote modem.
(DCD
> > = carrier detect). This standard behavior has frustrated people who were
> > just trying to connect local devices for many years. Some systems have a
> > "soft carrier" option outside of termios that causes a port to act as if
DCD
> > is always asserted.
> >
> > You can accomplish the same thing by looping back DTR (pin 4) to DCD
(pin
> > 1). Open will assert DTR, and that will drive DCD high for you. That's
what
> > most folks do.
> >
> > Cheers,
> > Ed
> ...
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

