From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: Re: [PATCH 29/29] Drivers: tty: serial: jsm: jsm_tty: fixed a brace
 coding style issue
Date: Fri, 06 Jan 2012 18:08:26 -0200
Message-ID: <4F0754BA.8070708@linux.vnet.ibm.com>
References: <1321596182-11031-1-git-send-email-zac.3.14159@gmail.com> <4EC66C07.9020009@br.ibm.com> <4F073CF3.70604@linux.vnet.ibm.com> <4F074F89.6060300@linux.vnet.ibm.com> <20120106195332.GA10814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:45318 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab2AFUIp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jan 2012 15:08:45 -0500
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Fri, 6 Jan 2012 18:08:39 -0200
In-Reply-To: <20120106195332.GA10814@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Breno Leitao <brenohl@br.ibm.com>, Zac Storer <zac.3.14159@gmail.com>, leitao@linux.vnet.ibm.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 01/06/2012 05:53 PM, Greg KH wrote:
> On Fri, Jan 06, 2012 at 05:46:17PM -0200, Lucas Kannebley Tavares wrote:
>> On 01/06/2012 04:26 PM, Lucas Kannebley Tavares wrote:
>>> On 11/18/2011 12:30 PM, Breno Leitao wrote:
>>>> On 11/18/2011 03:03 AM, Zac Storer wrote:
>>>>> Fixed a brace coding style issue.
>>>>>
>>>>> Signed-off-by: Zac Storer<zac.3.14159@gmail.com>
>>>> Acked-by: Breno Leitao<brenohl@br.ibm.com>
>>> Acked-by: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
>>>
>>
>> Adding Alan and Greg so they can catch this up on their trees.
>
> Catch what up with what?
>
> What patch is this?  Where is it?  Why wasn't it sent to me in the first
> place?
>
> Also note, the merge window for new patches to be sent to subsystem
> maintainers has been over for a week or so now, all of of the
> maintainers are now busy merging stuff with Linus, so trivial stuff like
> this is going to have to wait a few weeks at the earliest before it can
> start to be queued up.
>
> thanks,
>
> greg k-h
>

I said catch up because I didn't see it on any trees I looked and 
figured it had been passed over.
As for not sending it to you earlier, I and Breno had only replied to 
Zac's original CC list, and I only noticed you were missing now. But, as 
you've said it, it's a trivial patch, without great consequences 
(although good to have). No rush in it.

Thanks

Lucas

