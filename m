From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Questions regarding adding a patch in linux/drivers/char/8250.c
Date: Mon, 21 May 2012 10:30:09 +0100
Message-ID: <20120521103009.7f4be5e0@pyramind.ukuu.org.uk>
References: <00a301cd3719$b3faa370$1befea50$@com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52975 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141Ab2EUJ1Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 May 2012 05:27:16 -0400
In-Reply-To: <00a301cd3719$b3faa370$1befea50$@com.tw>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Donald <donald@asix.com.tw>
Cc: linux-serial@vger.kernel.org

On Mon, 21 May 2012 14:19:34 +0800
"Donald" <donald@asix.com.tw> wrote:

> Hi,
> 
> This is Donald from ASIX Electronics Corp. My company has three PCI to Serial controllers, including MCS9845, MCS9835, and MCS9820.
> Currently those serial devices using these three chips can directly use the Linux kernel's serial driver in
> linux/drivers/char/8250.c. Recently we find these three chips have a hardware bug relating to parity error count function. We have a
> software workaround for this issue. Below for reference is a pseudo code for this workaround.

Actually I have a second question.

Would it not be better to set the device to 8N1 and do the parity in
software rather than lose the FIFO, especially at higher speeds ? Can you
clarify what the erratum is triggered by ?

Alan


