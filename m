From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Newbie question: setting baudrate / managing FIFO.
Date: Wed, 16 Feb 2011 13:07:12 -0600
Message-ID: <AANLkTin7n0Uy3ypnibvExANmZmMBZmDi-UHXP_RfJZ7W@mail.gmail.com>
References: <AANLkTimdduXQaXJTuWPUKTFdQo9XOEYCkdNB_6RTVLFu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:49573 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab1BPTHQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Feb 2011 14:07:16 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1GJ7P2m021923
	for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 14:07:25 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1GIeemf006724
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 14:07:25 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 11so966429vws.15
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 11:07:12 -0800 (PST)
In-Reply-To: <AANLkTimdduXQaXJTuWPUKTFdQo9XOEYCkdNB_6RTVLFu@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Wed, Feb 16, 2011 at 4:51 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Hi,
>
> I looked about the archives, but maybe I skipped something... When I
> am handling set_termios, what assumptions can I make regarding the
> TX/RX state? I didn't take a look at all the serial drivers, but the
> ones I did look did not bother flushing FIFOs and ensuring nothing can
> be present in the TX FIFO while updating LCR and divisors. Should I do
> the equivalent of stop_tx inside set_termios? Is that already ensured?
> The hardware I am looking at needs to have FIFO cleared after setting
> baud rate, and I was getting concerned over potential data loss
> scenarios...
>
> Thanks,
> A
>

I realize there are different versions of the TCSET - TCSETS,
TCSETF... i.e. if you wanted to flush the buffer you'd ask for it. So
it should be ok to just clear the FIFO and destroy anything in them,
right? Or should I still flush the FIFOs after disabling flow control
if it was on? After all you could have gotten data after you called
set_termios.

Thanks,
A
