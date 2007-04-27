From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] serial 8250: move push calls out of lock
Date: Fri, 27 Apr 2007 08:09:23 -0500
Message-ID: <4631F603.40901@acm.org>
References: <20070426205103.GA28569@localdomain> <20070426205847.GB11735@flint.arm.linux.org.uk> <46311E48.4070106@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta13.mail.adelphia.net ([68.168.78.44]:37405 "EHLO
	mta13.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbXD0NJ0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2007 09:09:26 -0400
In-Reply-To: <46311E48.4070106@acm.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Corey Minyard wrote:
> Russell King wrote:    
>>
>> Use of an uninitialised variable.  The reason we use check_modem_status
>> to return the current status here is because reading the MSR _clears_
>> interrupts.  So, repeatedly calling get_mctrl via an ioctl is a great
>> way to introduce a hardware race condition if you just read the MSR and
>> never act on it.
>>   
> "status" is used as a return variable; it is set by the call.  I modified
> check_modem_status() to return if it detected a change and set the
> status if it was passed in.
Ok, I see what I missed.  Never mind.

-corey

