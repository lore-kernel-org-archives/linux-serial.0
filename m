From: Grant Edwards <grante@visi.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 14:22:30 +0000 (UTC)
Message-ID: <g773b6$edj$1@ger.gmane.org>
References: <200807241347.33261.laurentp@cse-semaphore.com>
 <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52593 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbYHDOW4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 10:22:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KQ0xS-0001Tn-Oy
	for linux-serial@vger.kernel.org; Mon, 04 Aug 2008 14:22:49 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 14:22:41 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 14:22:41 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-08-04, Tosoni <jp.tosoni@acksys.fr> wrote:
> About the flags names -- CARTS, UART_FCTR_RS485
>
> May I suggest CRTSTOGGLE since it is known by that kind of name in other
> OS's :-)

RTS toggle is what the feature is called in the products I work
on.  I assume that's a microsoftism, but it seems to be in
commmon usage.

> And further, it says was RTS will do, instead of why. Maybe
> someone could use it for something other than RS485?

Sure.  It's also used for half-duplex modems (e.g. Bell-202,
various RF comm modules) and other sorts of line drivers (e.g.
optical stuff).

-- 
Grant Edwards                   grante             Yow! I want to kill
                                  at               everyone here with a cute
                               visi.com            colorful Hydrogen Bomb!!

