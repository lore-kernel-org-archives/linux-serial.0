Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BBC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 10:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35B123D98
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 10:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgLJKm5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:42:57 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:37512 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728865AbgLJKm5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 05:42:57 -0500
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.0 patch 1) with ESMTPA;
        Thu, 10 Dec 2020 11:41:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Dec 2020 11:41:24 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
In-Reply-To: <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
Message-ID: <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Mychaela,

On 2020-12-09 23:49, Mychaela Falconia wrote:
> Greg K-H wrote:
> 
>> I think we need more review for the rest of the series.  This does
>> change the way serial ports work in a non-traditional way (i.e. using
>> sysfs instead of terminal settings).
> 
> But the problem is that the current status quo is fundamentally broken
> for those hardware devices in which DTR and/or RTS have been repurposed
> for something other than modem and flow control.  Right now whenever a
> "cold" (never previously opened) serial port is opened for the first
> time, that open action immediately and unstoppably asserts both DTR
> and RTS hardware outputs, without giving userspace any opportunity to
> say "no, please don't do it".  Yes, this behaviour is codified in a
> bunch of standards that ultimately trace back to 1970s Original UNIX,
> but just because it is a standard does not make it right - this
> Unix/POSIX/Linux "standard" serial port behaviour is a bug, not a
> feature.

I agree. And an application not configuring the required handshakes, but
still relying on them is an equal bug.

> But if there exist some custom hw devices out there that are in the
> same predicament as my DUART28 adapter, but are different in that they
> are classic old-fashioned RS-232 rather than integrated USB-serial,
> with no place to assign a custom USB ID, *then* we need a non-USB-ID-
> dependent solution such as Johan's sysfs attribute or O_DIRECT.

Any device with a classic old-fashioned RS-232 has probably already
solved this in another way or is accepted as not working on Linux.

And then there is also the device tree (overlay?) through which a quirk
like this can be communicated to the kernel driver. Not sure if this
could help for a plug-and-play device like on USB.

>> So I want to get a bunch of people
>> to agree that this is ok to do things this way now before taking this
>> new user-visible api.

Personally, I would prefer the VID:PID to enforce the quirk and an
O_DIRECT (or other) flag used on open() as general backup plan. To
me a sysfs solution seems illogical.

> If the concern is with the new sysfs interface or the proposed O_DIRECT
> alternative, how about deferring those while allowing specific USB ID
> support to go in first?  Right now there already exists at least one
> piece of hardware actively supported by its manufacturer (my gadget)
> that has a custom USB ID and requires the quirk - what is wrong with
> adding support for this existing specific hw?  How about merging
> Johan's patch that defines the NORDY flag in tty_port, merging the
> ftdi_sio driver patch setting this flag for my custom USB ID, allowing
> other hardware engineers in the same boat to submit similar quirk
> patches for their affected custom hw with custom USB IDs, while
> deferring the sysfs patches until there is a more pressing need for
> quirky devices that have no custom USB IDs?
> 
> Sincerely,
> Mychaela

Again, I agree.

Maarten

