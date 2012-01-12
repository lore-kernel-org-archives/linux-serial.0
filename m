From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty/serial: Need clarification on Support for 4+M Baudrate
Date: Thu, 12 Jan 2012 11:49:13 +0000
Message-ID: <20120112114913.21809bed@pyramind.ukuu.org.uk>
References: <20120111121901.GA4034@bnru05>
	<20120111123025.244a9cf5@pyramind.ukuu.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50582 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2ALLsc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 06:48:32 -0500
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@sude.de" <gregkh@sude.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 12 Jan 2012 10:49:38 +0100
Rajanikanth H V <rajanikanth.hv@stericsson.com> wrote:

> Alan,
> 
> Thanks for your response, suggested modification helped to get 4.8M baud
> but not 4.05M as this is being approximated to 4.0M baud which happens in
> tty_termios_encode_baud_rate(...).

Only if you don't have the BOTHER flag set and only for returned data to
user space.

When you do a TCSETS2 ioctl and have BOTHER set as the rate as well as a
c_ispeed/c_ospeed the exactly value is given to the driver.

Alan
