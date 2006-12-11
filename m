From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Mon, 11 Dec 2006 11:22:06 -0600
Message-ID: <457D93BE.6050307@mvista.com>
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com>	<20061211102016.43e76da2@localhost.localdomain>	<457D70A4.1000000@mvista.com>	<20061211151943.2bbc720e@localhost.localdomain>	<457D876B.9000508@mvista.com> <20061211171521.777eeff8@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:1579 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762972AbWLKRWJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Dec 2006 12:22:09 -0500
In-Reply-To: <20061211171521.777eeff8@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>

Alan wrote:
>> This is going to require some more thought.  But I believe it can be
>> done with adding a poll routine to the tty_operations structure 
>>     
>
> What status do you need to poll ?
>   
I need to poll for receive and transmit characters so I can do I/O
during panics (interrupts disabled).

