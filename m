From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 12:03:32 +0200
Message-ID: <001701c5547e$5bd9cca0$2e01a8c0@acksys.fr>
References: <20050509095903.A5674@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.clb.oleane.net ([213.56.31.17]:922 "EHLO
	smtp1.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261185AbVEIKEF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 06:04:05 -0400
In-Reply-To: <20050509095903.A5674@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Russell King' <rmk@arm.linux.org.uk>, 'Tosoni' <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

Hello Russell,

First I apologize for not spelling your name correcty. Also, I wrote the
previous mail of memory of our discussion because my mail archives were
since destroyed in some part.

Still it is true that I pushed my suggestion, since it works so perfectly
well in Windows. (for your records I wrote serial drivers in Unix far before
Windows was born, so don't call me a Windows enthusiast please).

> 1. we get a third (and there are more than two) flow control styles.
> 2. the port is closed and something else opens it which wants standard
>    flow control. (or even an overlapping open/close.)

I did not understand well your motivations before. I'm not sure I get all
the implications you suggest. But did you consider theses points:

a) The change we are seeking is not a new flow control at all, in the
   sense that it has absolutely no concern with buffer-full events.
b) The change we are seeking is *exclusive* with other uses of RTS
   (that is how it is done in Windows)
c) With RS485 we are talking about, e.g., a computer installed in a
   factory and connected to an automaton. There is no purpose for someone
   to reopen the port for another kind of use (I know this argument is weak)
d) We could define (since the functionality is not yet defined) that in
   the last close the standard RTS behaviour is reinstated. But still,
   there are differences between some UNIXes and LINUX regarding what state
   is kept between close and open.

Finally, I agree that the best would be to add this feature in termios -
well, it is exactly what I am seeking: to define a application API which
would be recognized as a standard. I am tired of reimplementing my own way
in each release of Linux. I am tired of seeing the same need implemented by
different people with diverging ioctls over and over.

When I talked to Allan Cox as you suggested, there was no answer from him.
Maybe too busy?

Jean-Pierre Tosoni

