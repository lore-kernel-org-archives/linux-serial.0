From: Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Fri, 25 Aug 2006 20:56:13 -0700 (PDT)
Message-ID: <20060826035613.18365.qmail@web31505.mail.mud.yahoo.com>
References: <200608260038.13662.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web31505.mail.mud.yahoo.com ([68.142.198.134]:367 "HELO
	web31505.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422705AbWHZD4O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Aug 2006 23:56:14 -0400
In-Reply-To: <200608260038.13662.thomas.koeller@baslerweb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

As it's not a driver I think I use, my opinions on the
matter should not carry any significant weight. On the
other hand, if there are no other opinions on the
matter, then no non-zero weight is insignificant.
(I'll leave it as an exercise to resolve the triple
negative.)

Anyway, it is my opinion that code believed to be
dubious should be fixed and that it is an error to add
more code that carries the same potential flaw until
either the flaw is resolved or proven insignificant.
That includes flaws in style or code cleanliness.

If the flaw is easily fixed, then it would seem vastly
better to fix it once now rather than twice (or more)
later - particularly if there is any risk that copied
flaws could be forgotten. Forgotten temporary code is
an excellent breeding-ground for bugs.

There's also a potential for friction as there is a
very understandable unease when it comes to knowingly
adding brokenness to the mainstream kernel if it's not
necessary, again even if that isn't brokenness in
terms of logic but merely in some aspect of how it's
represented.

On the flip-side, if we waited for code to be perfect,
we'd still be waiting for Alan Turing to finish the
world's first stored program.

--- Thomas Koeller <thomas.koeller@baslerweb.com>
wrote:

> On Tuesday 22 August 2006 02:59, Yoichi Yuasa wrote:
> Hi Yoichi,
> 
> so far nobody commented on my recent mail, in which
> I explained why I
> think that the AU1X00 code in 8250.c is not entirely
> correct, so I assume
> nobody cares. I therefore modified my code to take
> the same approach,
> although I still have my doubts about it. Here's the
> updated patch:


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
