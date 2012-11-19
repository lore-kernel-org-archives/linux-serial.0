From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH v3 resubmit] Add support for new devices: Exar's XR17V35x
 family of multi-port PCIe UARTs
Date: Mon, 19 Nov 2012 10:27:19 -0600
Message-ID: <CAJp1Oe4z5z8xfgUEBPkEsbc8PMZqwGPC-CY33kMvixnt8EMV0g@mail.gmail.com>
References: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
 <CAJp1Oe4vSwBgVe_bOV00ojvYy2fd7YWNfrEfJ+de_JSiyb7AHA@mail.gmail.com>
 <20121119152619.3752b591@pyramind.ukuu.org.uk> <CAJp1Oe4SKUh6w6q==pOZy-S3Xqd2LoE3jOi-3-MupxQwjOhuFg@mail.gmail.com>
 <20121119161305.GA1446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37739 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab2KSQ1k (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 11:27:40 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so1331936vcm.19
        for <linux-serial@vger.kernel.org>; Mon, 19 Nov 2012 08:27:39 -0800 (PST)
In-Reply-To: <20121119161305.GA1446@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Mon, Nov 19, 2012 at 10:13 AM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> On Mon, Nov 19, 2012 at 09:34:36AM -0600, Matt Schulte wrote:
>> On Mon, Nov 19, 2012 at 9:26 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > On Mon, 19 Nov 2012 09:12:04 -0600
>> > Matt Schulte <matts@commtech-fastcom.com> wrote:
>> >
>> >> Add support for new devices: Exar's XR17V35x family of multi-port PCIe UARTs.
>> >>
>> >> Built against tty-next 54d5f88f25c38e5500a17b16240cb3775af00876
>> >>
>> >> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
>> >
>> > Acked-by: Alan Cox <alan@linux.intel.com>
>> >
>> > Alan
>>
>> Now so that I am completely sure, because this has been Acked by Alan,
>> this means that I can submit a patch that relies on this one?
>
> Yes, I'll queue this patch up in my tree in a bit, and you will get an
> email saying where it is and what is going on with it.
>

Does that mean that if all goes well the patch could find itself into
the rc for 3.8?  Or does it take longer than that?

Matt Schulte
