From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 15 Mar 2007 00:59:45 +0100
Message-ID: <m3fy87s7f2.fsf@maximus.localdomain>
References: <002001c7663f$0bc45ee0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:33359 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422751AbXCNX7q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Mar 2007 19:59:46 -0400
In-Reply-To: <002001c7663f$0bc45ee0$2e01a8c0@acksys.local> (Tosoni's message of "Wed, 14 Mar 2007 14:45:35 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

"Tosoni" <jp.tosoni@acksys.fr> writes:

> The reality is: the need exists, it does not break the driver, other OSs
> support it, Linux does not, I personally wrote support for it in the
> existing 8250 driver, other people wrote similar code in similar Linux
> drivers.
>
> But for some reason maintainers did not want to hear about this work. So I
> must reinsert it over and over again with each new version of the kernel.
> </sigh>

Some link to archives maybe? I don't think I've seen your code.
Perhaps you should post the code again? Cc to the maintainer and
lkml wouldn't hurt.

> What I talk about, is a way to toggle RTS
> around transmit data with acceptable delays. This can only reside in the
> serial driver, not in a line discipline.

Of course.

> I do not want to remove the existing behaviour for RTS, I want to add a
> optional "new" one to handle the original standard, and I do believe that I
> am not alone to need this.

That is quite possible, though the normal way of getting things
included into the kernel is posting a patch, getting comments,
perhaps fixing problems, posting again, until it's accepted.
-- 
Krzysztof Halasa
