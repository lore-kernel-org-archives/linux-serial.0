From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Subject: Re: Serial port read working but not write.
Date: Fri, 23 Jul 2004 14:50:07 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4101097F.4020205@wincor-nixdorf.com>
References: <20040722164803.5219.qmail@web8206.mail.in.yahoo.com> <4100DAA3.7060205@wincor-nixdorf.com>  
   <20040723100226.GU18676@lug-owl.de> <410100C1.5030404@wincor-nixdorf.com> <20040723124149.GY18676@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mixi.wincor-nixdorf.com ([217.115.67.70]:37853 "HELO
	mail.wincor-nixdorf.com") by vger.kernel.org with SMTP
	id S267697AbUGWNFB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2004 09:05:01 -0400
Received: from label.wincor-nixdorf.com (label.wincor-nixdorf.com [172.18.160.24])
	by zipp.wincor-nixdorf.com (8.12.8/8.12.8) with ESMTP id i6ND4xAw000622
	for <linux-serial@vger.kernel.org>; Fri, 23 Jul 2004 15:05:00 +0200
In-Reply-To: <20040723124149.GY18676@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org



Jan-Benedict Glaw wrote:
> On Fri, 2004-07-23 14:12:49 +0200, Salomon, Frank <frank.salomon@wincor-nixdorf.com>
> wrote in message <410100C1.5030404@wincor-nixdorf.com>:
> 
>>Jan-Benedict Glaw wrote:
>>
>>>On Fri, 2004-07-23 11:30:11 +0200, Salomon, Frank 
>>><frank.salomon@wincor-nixdorf.com>
>>>wrote in message <4100DAA3.7060205@wincor-nixdorf.com>:
>>>
>>>>the problem is you need a procedure which find out what the problem is.
>>>>Hardware check:
>>>>Your hole hardware you can divided in:
>>>>- PC - com port
>>>>- cable
>>>>- external Hardware
> 
> [...]
> 
>>>This doesn't need to work, depending on handshake settings. Also, (at
>>>least in theory), you can have different sending and receiving speeds...
>>>
>>>man stty
> 
> 
>>it there any linux OS on which that test does not work after reboot ?
> 
> 
> The point is like this: something in your serial settings *is* already
> broken, so the last thing you want is to *rely* on the serial port's
> config state. With a good chance (especially in this case), exactly this
> is what is wrong.

Hi,
@Jan-Benedict,
sorry, is there any linux OS on which that test does not work after 
reboot ? If you don't know any linux system, we can go back to the 
origin problem from Suresh.

Frank
