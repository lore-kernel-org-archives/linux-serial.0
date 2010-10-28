From: Maciej Szmigiero <mhej@o2.pl>
Subject: Re: [SERIAL]blacklist si3052 chip
Date: Thu, 28 Oct 2010 12:44:22 +0200
Message-ID: <4CC95406.4070103@o2.pl>
References: <4CC73085.2070304@o2.pl> <20101026224940.22b4ac93@lxorguk.ukuu.org.uk> <4CC74E04.7080407@o2.pl> <20101028012010.GC29960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.go2.pl ([193.17.41.11]:37029 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab0J1Kod (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2010 06:44:33 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id AF9A15D514A
	for <linux-serial@vger.kernel.org>; Thu, 28 Oct 2010 12:44:24 +0200 (CEST)
Received: from unknown (unknown [10.0.0.142])
	by mailout1.go2.pl (Postfix) with SMTP
	for <linux-serial@vger.kernel.org>; Thu, 28 Oct 2010 12:44:24 +0200 (CEST)
In-Reply-To: <20101028012010.GC29960@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

W dniu 28.10.2010 03:20, Greg KH pisze:
> On Tue, Oct 26, 2010 at 11:54:12PM +0200, Maciej Szmigiero wrote:
>> W dniu 26.10.2010 23:49, Alan Cox pisze:
>>> On Tue, 26 Oct 2010 21:48:21 +0200
>>> Maciej Szmigiero <mhej@o2.pl> wrote:
>>>
>>>> [SERIAL]blacklist si3052 chip
>>>>
>>>> Si3052-based softmodems aren't serial ports so don't bind serial driver to them.
>>>> Allows proper driver to bind to them.
>>>
>>> Which is the proper driver ?
>>>
>>> Alan
>>>
>>
>> Awaiting final review on the DAHDI reviewboard.
> 
> What does this mean?
> 
> confused,
> 
> greg k-h
> 

DAHDI is the name for drivers for hardware ports of Asterisk open source PBX.
This allows, for example, to route calls from Asterisk to PSTN (classic, analog telephone line) or ISDN.
There is good explanation on http://www.voip-info.org/wiki/view/Zaptel (Zaptel is pre-2008 name for DAHDI).

Maciej Szmigiero

