From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Fri, 12 Oct 2012 19:51:02 +0100
Message-ID: <20121012195102.5781c7d4@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37392 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab2JLSqB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Oct 2012 14:46:01 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> Of course swapping is a waste of cpu cycles.
> Workaround can be 3 further bytes offset.
> Thanks
> 
> Back to my problem.
> How can 8250_early be enhanced to support big endian registers.

They are 8bit registers - I don't understand why you are asking the
question ?
