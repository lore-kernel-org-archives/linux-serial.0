From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC: exposing uartclk value to sysfs
Date: Fri, 10 Aug 2012 23:48:58 +0100
Message-ID: <20120810234858.4a5decd4@pyramind.ukuu.org.uk>
References: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41251 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab2HJWo2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 18:44:28 -0400
In-Reply-To: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>

> Although there is a way to set baud_base via setserial(8) I was
> wandering whether it would be possible to expose uartclk in sysfs for
> read/write. I have created a following proof-of-concept experimental
> patch:

That would probably be a *lot* more civilised. As a conceptual idea I
think its a good one.

Alan
