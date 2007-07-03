From: Morten Helgesen <morten@sourcepoet.org>
Subject: Re: [PATCH] genericserial: Remove bogus optimisation check and dead
 code paths
Date: Tue, 03 Jul 2007 23:33:38 +0200
Message-ID: <468AC0B2.9000404@sourcepoet.org>
References: <20070703152021.6eb8013d@the-village.bc.nu>	<468A5F89.70900@sourcepoet.org> <20070703162655.6a001fdc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 195134058148.customer.alfanett.no ([195.134.58.148]:37755 "EHLO
	barebone.sourcepoet.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758379AbXGCVrB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 17:47:01 -0400
In-Reply-To: <20070703162655.6a001fdc@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Alan Cox wrote:
> On Tue, 03 Jul 2007 16:39:05 +0200
> Morten Helgesen <morten@sourcepoet.org> wrote:
>
>   
>> Alan Cox wrote:
>>
>> [...snip...]
>>     
>>> @@ -75,11 +64,11 @@
>>>  	if (! (port->flags & ASYNC_INITIALIZED)) return;
>>>  
>>>  	/* Take a lock on the serial tranmit buffer! */
>>> -	LOCKIT;
>>> +	mutex_lock(& port->port_write_mutex);
>>>   
>>>       
>> ^ Contains additional whitespace.
>>     
>
>
> Its an old driver, it doesn't follow the coding style too well at all -
> viz stuff like if (! ( the line above. Given its age and limited userbase
> I don't plan to go and make it conform either, but I will take patches
> for the formatting (and the spelling errors it is full of) from someone
> who wants to do the work.
>
> Alan
Ok, so how is this for a start?

- Proper indenting.
- Fixes for the most obvious typos and spelling errors.

Signed-off-by: Morten Helgesen <morten@sourcepoet.org>

== Morten
