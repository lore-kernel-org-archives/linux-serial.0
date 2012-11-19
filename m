From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH v3] Add support for new devices: Exar's XR17V35x family of
 multi-port PCIe UARTs
Date: Sun, 18 Nov 2012 23:15:06 -0600
Message-ID: <CAJp1Oe5Hcb-n-gWUZs1ypZztzXa4h5QMOadPiuP7FEY8162Y9w@mail.gmail.com>
References: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
 <CAJp1Oe6GG34JKaDus9pc8Geo14Wros6S1mmYbAv_oWQQKt7GSQ@mail.gmail.com> <20121119044233.GA30007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41769 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab2KSFP2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 00:15:28 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4688367vbb.19
        for <linux-serial@vger.kernel.org>; Sun, 18 Nov 2012 21:15:27 -0800 (PST)
In-Reply-To: <20121119044233.GA30007@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>

On Sun, Nov 18, 2012 at 10:42 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> On Sun, Nov 18, 2012 at 10:33:33PM -0600, Matt Schulte wrote:
>> On Thu, Nov 15, 2012 at 5:01 PM, Matt Schulte
>> <matts@commtech-fastcom.com> wrote:
>> > Add support for new devices: Exar's XR17V35x family of multi-port PCIe UARTs.
>> >
>> > Built against tty-next 54d5f88f25c38e5500a17b16240cb3775af00876
>> >
>> > Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
>> > ---
>> > v3: Moved overriding of handle_irq to serial8250_config_port
>> >
>> > v2: Moved extra interrupt handling to its own custom handle_irq
>> >
>> > v1: Hopefully if this gets accepted I will be able to submit an additional
>> > patch to add support for my company's PCIe cards that use these
>> > UARTs.
>>
>> What should I do if I would like to submit an additional patch that
>> depends on this one that has not yet been accepted?  Should I combine
>> them and resubmit both or do I just need to wait?
>
> I was waiting for Alan's ack on your first patch here.  I suggest
> resending it, and a second one with your additional changes as well.
>

Should I change anything in the original or just resend in its entirety?
