From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: Very strange data loss with jsm driver
Date: Tue, 02 Aug 2011 11:17:52 -0300
Message-ID: <4E380710.1010204@linux.vnet.ibm.com>
References: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca> <20110729172736.4b199d31@lxorguk.ukuu.org.uk> <20110729165342.GB8566@caffeine.csclub.uwaterloo.ca> <20110729180650.GL8562@caffeine.csclub.uwaterloo.ca> <20110729191442.35d09111@lxorguk.ukuu.org.uk> <20110729181337.GM8562@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:45940 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab1HBOSx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Aug 2011 10:18:53 -0400
Received: from /spool/local
	by br.ibm.com with XMail ESMTP
	for <linux-serial@vger.kernel.org> from <leitao@linux.vnet.ibm.com>;
	Tue, 2 Aug 2011 11:18:48 -0300
In-Reply-To: <20110729181337.GM8562@caffeine.csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/29/2011 03:13 PM, Lennart Sorensen wrote:
>
>  It seems it can't be the tty layer, since other serial drivers seem to
>  work fine. It has to be the jsm.
Well, I finally tested it over here, and what I found is:

If the line has a \r among the first 16 bytes, then the information
is TXed immediately. If there is no \r in the first 16 bytes, then the
information seems to be buffered.

So, it seems that that the patch should ask the driver to TX the
information when we receive a \r or when the buffer is full. Does it
make sense to you ?

Thanks

