From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 11:11:42 -0700
Message-ID: <46AA355E.20901@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com> <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl> <46AA2748.80703@howardsilvan.com> <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:52192 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbXG0SM6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 14:12:58 -0400
In-Reply-To: <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

> The TTY line discipline driver could do that based on the amount of 
>received data present in its buffer.  And it should if asked to (a brief 
>look at drivers/char/n_tty.c reveals it does; obviously there may be a bug 
>somewhere though).  So could e.g. the SLIP and PPP line discipline 
>drivers, though the criteria might be different (apparently they do not, 
>which is a shame).
>
> The serial drivers have nothing to do about it -- all they can do is 
>pushing data upstream, to the discipline driver.  They can provide an 
>interface to hardware flow control features though, if implemented by a 
>given UART.
>

Thank you for this clarification.  So I should have more correctly been 
saying that "tty flow control appears broken".  Right?

I've asked the manufacturer to take a look at drivers/char/n_tty.c to 
see if they can't see anything obvious.

Thanks,

Lee.
