From: rich+ml@lclogic.com
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 12:45:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505091225590.750@deadrat.localdomain>
References: <200505051650.38471.andyparkins@gmail.com> <m3br7klpz4.fsf@zoo.weinigel.se>
 <m37ji8lpof.fsf@zoo.weinigel.se>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-64-164-130-2.dsl.snfc21.pacbell.net ([64.164.130.2]:57607
	"EHLO mail.lclogic.com") by vger.kernel.org with ESMTP
	id S261493AbVEITpQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 15:45:16 -0400
In-Reply-To: <m37ji8lpof.fsf@zoo.weinigel.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
Cc: Andy Parkins <andyparkins@gmail.com>, linux-serial@vger.kernel.org

> Christer Weinigel <christer@weinigel.se> writes:
>
> >     do {
> >         ioctl(fd, TIOCSERGETLSR, &lsr);
> >     } while (lsr & TIOCSER_TEMT);
>

Ah that'll usually work OK but try it after this:

 for (( x=0; x<100; x++ )); do tar -c / > /dev/null & done

Hopefully we're not talking about an RS-485 industrial pallet nailer :)
