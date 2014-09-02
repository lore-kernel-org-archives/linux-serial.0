From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH 01/26] Revert "serial: uart: add hw flow control support
 configuration"
Date: Tue, 2 Sep 2014 18:17:26 -0400
Message-ID: <540641F6.1050504@ti.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com> <1409693975-1028-2-git-send-email-peter@hurleysoftware.com> <54063BA1.2030206@ti.com> <54063D96.30703@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbaIBWRV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 18:17:21 -0400
In-Reply-To: <54063D96.30703@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

On 09/02/2014 05:58 PM, Peter Hurley wrote:
> On 09/02/2014 05:50 PM, Murali Karicheri wrote:
>> Peter,
>>
>> On 09/02/2014 05:39 PM, Peter Hurley wrote:
>>>   Finally, this patch
>>> supposes to fix existing bugs in the serial core for auto CTS-enabled
>>> hardware, but does not include the class of hardware for which these
>>> bugs exist.
>>
>> What is this? What class of hardware are you referring to?
>
> UART_CAP_AFE and UART_CAP_EFR hardware.
>
>> As discussed, I will send an updated patch for this as discussed..
>
> Great.
>
> And since that patch will touch every single line this reverts (and more)
> with a different solution, I see no reason not to back this out.
>

No Issues and I am fine with the revert.

> Plus, as you can see, you're holding up progress.

I need to make progress on the hardware that I deal with for which this 
patch was submitted :) Unfortunately this patch didn't get proper review 
before merge causing the issue. Just want to give right context.

Regards,
Murali
>
> Regards,
> Peter Hurley
>

