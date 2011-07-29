From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Very strange data loss with jsm driver
Date: Fri, 29 Jul 2011 17:27:36 +0100
Message-ID: <20110729172736.4b199d31@lxorguk.ukuu.org.uk>
References: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44066 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012Ab1G2QYd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Jul 2011 12:24:33 -0400
In-Reply-To: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Breno Leitao <leitao@linux.vnet.ibm.com>

> The trigger point appears to be lines of up to 14 bytes, followed by
> a newline.  With 15 bytes or more per line it seems to be OK.
> 
> Anyone got a clue?

FIFO size perhaps - and some kind of missed wakeup or tx handling bug ?
