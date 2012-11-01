From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Thu, 1 Nov 2012 17:03:12 -0500
Message-ID: <CAJp1Oe4cnWot=wgou91dea81hHNxo8RWOPwXJj3o+JL4zOwQpg@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org> <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <CAJp1Oe67Jd+FaaDPosexrVrrUFS=c-0FUZx_JHTbpTN5RCCcUw@mail.gmail.com>
 <20121023183859.GA3317@kroah.com> <CAJp1Oe7MMuk8TNBom2EDXx6UBdMV6qAE5fDdKTZ0o-329QSdaA@mail.gmail.com>
 <CAJp1Oe7Lk2q6v+5jrj2wD4cW=M9LX6kkia=AQnJKOiUEod5uRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39112 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936002Ab2KAWDd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 18:03:33 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3177657vcb.19
        for <linux-serial@vger.kernel.org>; Thu, 01 Nov 2012 15:03:33 -0700 (PDT)
In-Reply-To: <CAJp1Oe7Lk2q6v+5jrj2wD4cW=M9LX6kkia=AQnJKOiUEod5uRQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Wed, Oct 31, 2012 at 4:55 PM, Matt Schulte
<matts@commtech-fastcom.com> wrote:
> On Mon, Oct 29, 2012 at 3:04 PM, Matt Schulte
> <matts@commtech-fastcom.com> wrote:
>> On Tue, Oct 23, 2012 at 1:38 PM, Greg KH <greg@kroah.com> wrote:
>>> On Tue, Oct 23, 2012 at 11:31:41AM -0500, Matt Schulte wrote:
>>>> On Tue, Oct 23, 2012 at 11:27 AM, Matt Schulte
>>>> <matts@commtech-fastcom.com> wrote:
>>>> > On Fri, Oct 19, 2012 at 4:21 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>>>> >> Alan's advice to get your card working as a basic serial card is very
>>>> >> good one.  Get basic functionality working, and then you can add the
>>>> >> support for the extra bits later....
>>>> >
>>>> > I can see the logic in getting it working as a basic serial card
>>>> > first.  I think at minimum I would still need to implement the extra
>>>> > divisor calculations to get accurate bit rates.
>>>> >
>>>> > So when it works as a basic serial card, I assume you would want me to
>>>> > use the default PCI IDs to keep it more generic.  Then would I add my
>>>> > own PCI IDs and refer them back to the generic port?

Hello, the next question that I have is how to handle the interrupts
on this UART.  It has a more complex interrupt scheme than a
traditional 8250 UART.  There is a global ISR register that tells you
which port had the interrupt and then there is another set of
registers that hold the actual interrupts.

In this situation where this UART needs extra code for the handling of
its interrupt, where is the best place to add this special interrupt
handler?  Directly to the 8250.c default handler or somewhere else?

Thank you,
Matt Schulte
