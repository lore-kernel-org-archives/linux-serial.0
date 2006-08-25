From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:52:34 -0400
Message-ID: <Pine.LNX.4.61.0608251148490.18661@chaos.analogic.com>
References: <043401c6c859$9c611350$294b82ce@stuartm>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from odyssey.analogic.com ([204.178.40.5]:57873 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964923AbWHYPwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Aug 2006 11:52:36 -0400
Content-class: urn:content-classes:message
In-Reply-To: <043401c6c859$9c611350$294b82ce@stuartm>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


On Fri, 25 Aug 2006, Stuart MacDonald wrote:

> From: On Behalf Of linux-os (Dick Johnson)
>> But the baud-rates have always been some approximation that starts
>> at 75 and increases by powers-of-two. This is because the hardware
>> always had fixed clocks with dividers that divided by powers-of-two.
>> What is the claim for the requirement of strange baud-rates set
>> as an integer of dimension "baud?" Where does this requirement
>> come from and what devices use these?
>
> Perhaps you'd like to check out our products
> http://www.connecttech.com/
>
> We build a lot of custom boards that have odd clocks to generate very
> odd baud rates for random serial devices. The Bxxx style has been a
> thorn in my side since 1999.
>
> Also, Oxford's 16PCI95x family has three different points of altering
> the clock; the clock prescaler, the actual sample rate (which is the
> classic /16 that most are used to), and the actual divisor. That can
> produce pretty much any baud rate, albeit with some error.
>
> ..Stu
>

Well when you change things, remember that you need not only something
that translates B9600 to your new 9600 (trivial it's a #define, but
ALSO (very important!) B0 needs to hang up the modem! This means
that some value (perhaps 0), as a divisor, needs to perform this
same function.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
