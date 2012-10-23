From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Tue, 23 Oct 2012 11:31:41 -0500
Message-ID: <CAJp1Oe67Jd+FaaDPosexrVrrUFS=c-0FUZx_JHTbpTN5RCCcUw@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org> <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37699 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab2JWQcD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2012 12:32:03 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4469799vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 23 Oct 2012 09:32:02 -0700 (PDT)
In-Reply-To: <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Tue, Oct 23, 2012 at 11:27 AM, Matt Schulte
<matts@commtech-fastcom.com> wrote:
> On Fri, Oct 19, 2012 at 4:21 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> Alan's advice to get your card working as a basic serial card is very
>> good one.  Get basic functionality working, and then you can add the
>> support for the extra bits later....
>
> I can see the logic in getting it working as a basic serial card
> first.  I think at minimum I would still need to implement the extra
> divisor calculations to get accurate bit rates.
>
> So when it works as a basic serial card, I assume you would want me to
> use the default PCI IDs to keep it more generic.  Then would I add my
> own PCI IDs and refer them back to the generic port?
>

As more of a procedural question, when I go to make the patch(es) to
submit which, kernel repo do I start with?  Do I start with Greg KH's
tty repo and then generate the patches and submit them here?

Matt
