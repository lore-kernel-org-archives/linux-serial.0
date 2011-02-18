From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Newbie question: setting baudrate / managing FIFO.
Date: Fri, 18 Feb 2011 14:15:59 -0600
Message-ID: <AANLkTikR+Kcs9eNhDFxn1G6bo9yomEa7C-szyFdu2SoZ@mail.gmail.com>
References: <AANLkTimdduXQaXJTuWPUKTFdQo9XOEYCkdNB_6RTVLFu@mail.gmail.com>
	<AANLkTin7n0Uy3ypnibvExANmZmMBZmDi-UHXP_RfJZ7W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:55269 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab1BRUQB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 15:16:01 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1IKGCRS001024
	for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 15:16:12 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1IK97gc028118
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 15:16:11 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 38so2787299vxc.15
        for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 12:15:59 -0800 (PST)
In-Reply-To: <AANLkTin7n0Uy3ypnibvExANmZmMBZmDi-UHXP_RfJZ7W@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Wed, Feb 16, 2011 at 1:07 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Wed, Feb 16, 2011 at 4:51 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> Hi,
>>
>> I looked about the archives, but maybe I skipped something... When I
>> am handling set_termios, what assumptions can I make regarding the
>> TX/RX state? I didn't take a look at all the serial drivers, but the
>> ones I did look did not bother flushing FIFOs and ensuring nothing can
>> be present in the TX FIFO while updating LCR and divisors. Should I do
>> the equivalent of stop_tx inside set_termios? Is that already ensured?
>> The hardware I am looking at needs to have FIFO cleared after setting
>> baud rate, and I was getting concerned over potential data loss
>> scenarios...
>>
>> Thanks,
>> A
>>
>
> I realize there are different versions of the TCSET - TCSETS,
> TCSETF... i.e. if you wanted to flush the buffer you'd ask for it. So
> it should be ok to just clear the FIFO and destroy anything in them,
> right? Or should I still flush the FIFOs after disabling flow control
> if it was on? After all you could have gotten data after you called
> set_termios.
>
> Thanks,
> A
>

Anyone :)?
