From: Philip Oberstaller <Philip.Oberstaller@septentrio.com>
Subject: Re: Printf hangs when internal buffer of driver is temporarily full
Date: Tue, 15 Jan 2013 15:23:58 +0100
Message-ID: <50F5667E.8010303@septentrio.com>
References: <50F40403.9040000@septentrio.com> <20130114193645.63a2d12c@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server2.septentrio.com ([194.78.112.130]:22735 "HELO
	barracuda.septentrio.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1756271Ab3AOOYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jan 2013 09:24:03 -0500
In-Reply-To: <20130114193645.63a2d12c@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On 01/14/2013 08:36 PM, Alan Cox wrote:
>> which happens when the driver's internal buffer is temporarily full.
>> I would have expected that the TTY layer or the libc implementation of
>> printf would requery write_room automatically and thus would notice
>
> How is it going to magically notice ?
>
>> after a while that there is space again, but this doesn't seem to happen.
>> Eventually the printf function returns after a very long timeout but without
>> that the remaining characters have been printed.
>
> You need to wake it up and tell it there is room in your completion
> interrupts. It will then think about retrying.

Yeah, behind the magic there is most of the time some manual work. Thanks
for the hint of the wakeup! That definitely makes it working. Don't ask
me why I didn't see it before...

> I would suggest recycling that book 8)

Agreed, but as it's pretty cold these days, it might well be used for
some other purpose...

(Sorry for the disclaimer, but it cannot be circumvented when sending
from this domain - at least I would not know how)

________________________________

This e-mail communication contains information that is confidential and may also be privileged. It is intended for the exclusive use of the addressees. If you are not the person or organization to whom it is addressed, you must not copy, distribute or take any action in reliance upon it. If you received this communication in error, please notify Septentrio nv immediately [ telephone +32 [0] 16 300800 ]. Septentrio nv will not accept liability for contractual commitments made by individuals employed by this company outside the scope of our business.
