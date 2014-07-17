From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tcflow(TCOON/TCOOFF) vs. received XON/XOFF characters
Date: Thu, 17 Jul 2014 14:03:17 +0000 (UTC)
Message-ID: <lq8l35$cfa$1@ger.gmane.org>
References: <lq6c9q$isi$1@ger.gmane.org> <53C7CB1B.3010804@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48127 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbaGQODh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jul 2014 10:03:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1X7mHW-0003Bl-1E
	for linux-serial@vger.kernel.org; Thu, 17 Jul 2014 16:03:34 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2014 16:03:34 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2014 16:03:34 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-07-17, Peter Hurley <peter@hurleysoftware.com> wrote:

> tcflow(TCOxxx) flow control is independent of IXON flow control.
> The union of both flow states determines if the tty can output;
>
>                       IXON = true        IXON = false
>                    START       STOP
> tcflow(TCOON)      on         off          on
> tcflow(TCOOFF)     off        off          off

Thanks, that's pretty much what I had decided based on tests and
browsing the source code.

Just to confirm:

  tcflow(TCION/TCIOFF): overrides the "input" side of xon/xoff flow
                        control and forces the sending of XON/XOFF.

  tcflow(TCOON/TCOOFF): does not have anything to do with the "output"
                        side of xon/xoff flow control, but controls
                        something completely orthogonal.

That rather counter-intuitive (not that counter-intuitive is exactly a
novel thing when it comes to Unix serial ports).
                        
That rasies this question: what does an application use to control the
"output" side of xon/xoff flow control?  There is a Windows API for
doing that, and I get asked how to do it in Linux.  I always tell them
they can't.

-- 
Grant Edwards               grant.b.edwards        Yow! Oh, I get it!!
                                  at               "The BEACH goes on", huh,
                              gmail.com            SONNY??

