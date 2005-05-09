From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 11:13:38 +0100
Message-ID: <20050509111338.C5674@flint.arm.linux.org.uk>
References: <20050509095903.A5674@flint.arm.linux.org.uk> <001701c5547e$5bd9cca0$2e01a8c0@acksys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25358 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261185AbVEIKNq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 06:13:46 -0400
Content-Disposition: inline
In-Reply-To: <001701c5547e$5bd9cca0$2e01a8c0@acksys.fr>; from jp.tosoni@acksys.fr on Mon, May 09, 2005 at 12:03:32PM +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

On Mon, May 09, 2005 at 12:03:32PM +0200, Tosoni wrote:
> I did not understand well your motivations before. I'm not sure I get all
> the implications you suggest. But did you consider theses points:
> 
> b) The change we are seeking is *exclusive* with other uses of RTS
>    (that is how it is done in Windows)

There are many different styles of use of RTS.  The conventional one
and your one are only two.  There are more than two, and all of them
are exclusive.  I don't see why you made the above comment, since we
obviously agree.

> c) With RS485 we are talking about, e.g., a computer installed in a
>    factory and connected to an automaton. There is no purpose for someone
>    to reopen the port for another kind of use (I know this argument is weak)

Consider a brail device which requires non-standard RTS behaviour,
which may be replaced by a modem.

> d) We could define (since the functionality is not yet defined) that in
>    the last close the standard RTS behaviour is reinstated. But still,
>    there are differences between some UNIXes and LINUX regarding what state
>    is kept between close and open.

As I tried to point out (and you missed) there is no clear point at which
the port is closed.  Consider the following scenario:

	1. program A has the port open.
	2. program B tries to open the port, but blocks in the open,
	   waiting for program A to free up the port.
	3. program A closes the port.
	4. program B finally returns from the open call.

Compare this with:

	1. program A (eg, terminal program) has the port open.
	2. program B (eg, file upload utility) opens the port and
	   sends its data.
	3. program B closes the port.

With the second scenario, it's clear that step 3 shouldn't reset the
behaviour.  However, what about the first scenario?

> When I talked to Allan Cox as you suggested, there was no answer from him.
> Maybe too busy?

I can't talk for Alan.  However, Alan has taken on the task of looking
after the tty layer, and so Alan needs to comment.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
