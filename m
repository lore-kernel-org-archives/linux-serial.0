From: David Miller <davem@davemloft.net>
Subject: Re: Heads Up: Next Batch Of Serial/TTY Changes
Date: Fri, 31 Aug 2007 14:41:15 -0700 (PDT)
Message-ID: <20070831.144115.48807246.davem@davemloft.net>
References: <20070831221105.2fce9023@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57409
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965747AbXHaVlP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Aug 2007 17:41:15 -0400
In-Reply-To: <20070831221105.2fce9023@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 31 Aug 2007 22:11:05 +0100

> Firstly some architecture maintainers still haven't updated their
> platform for arbitary tty speeds. The kernel is going to start whining
> and issuing warnings on your platform if you don't keep up with the
> programme (its been 6 months).

I took a look at this for sparc and I'm currently balking the same way
you did :-) The current bit usage on sparc just don't work properly
for what you're trying to do.
