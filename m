From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Q: how to control the TTY output queue in real time?
Date: Fri, 10 Aug 2012 21:15:09 +0100
Message-ID: <20120810211509.34cc723e@pyramind.ukuu.org.uk>
References: <50255E31.8060904@list.ru>
	<20120810203355.224622cc@pyramind.ukuu.org.uk>
	<502566EB.3070304@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41086 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2HJUKg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 16:10:36 -0400
In-Reply-To: <502566EB.3070304@list.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stas Sergeev <stsp@list.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org


> If they do quite fine with the fifo, then maybe the new
> function will do too? Its basically a tcdrain(), just with
> the controllable watermark I guess.

I guess providing you account the fifo, and any hardware flow control it
would work.

