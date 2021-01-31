Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CAC433DB
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A1A64E0E
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 15:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhAaPuA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhAaPt4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Jan 2021 10:49:56 -0500
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3BC061574
        for <linux-serial@vger.kernel.org>; Sun, 31 Jan 2021 07:48:55 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 82F1C15360;
        Sun, 31 Jan 2021 15:47:42 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 63E5E219FCF; Sun, 31 Jan 2021 15:47:42 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
References: <20210128172244.22859-1-mans@mansr.com>
        <YBam2m2VMowH5Yth@kroah.com> <yw1xwnvtcki0.fsf@mansr.com>
        <YBa0J82FrD6mdP/v@kroah.com>
Date:   Sun, 31 Jan 2021 15:47:42 +0000
In-Reply-To: <YBa0J82FrD6mdP/v@kroah.com> (Greg Kroah-Hartman's message of
        "Sun, 31 Jan 2021 14:44:07 +0100")
Message-ID: <yw1xsg6hcdlt.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sun, Jan 31, 2021 at 01:18:47PM +0000, Måns Rullgård wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Thu, Jan 28, 2021 at 05:22:44PM +0000, Mans Rullgard wrote:
>> >> On systems that do not have the traditional PC ISA serial ports, the
>> >> 8250 driver still creates non-functional device nodes.  This change
>> >> makes only ports that actually exist (PCI, DT, ...) get device nodes.
>> >> 
>> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >> ---
>> >>  drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
>> >>  drivers/tty/serial/8250/Kconfig     |  5 +++++
>> >>  2 files changed, 25 insertions(+), 6 deletions(-)
>> >> 
>> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> >> index cae61d1ebec5..49695dd3677c 100644
>> >> --- a/drivers/tty/serial/8250/8250_core.c
>> >> +++ b/drivers/tty/serial/8250/8250_core.c
>> >> @@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
>> >>  	}
>> >>  }
>> >>  
>> >> +#ifdef CONFIG_SERIAL_8250_ISA
>> >
>> > This is just making a mess of the code. 
>> 
>> It was already a mess.
>
> True, but don't make it a worse one please.
>
>> 
>> > To do this right, pull the isa code out into a separate file and put
>> > the #ifdef in a .h file, so we can properly maintain and support this
>> > code over time.  This change as-is is not going to make that any
>> > easier :(
>> 
>> I might put in that effort if there's a reasonable chance this change
>> will be accepted.  If it's going to be rejected regardless, I'd rather
>> not waste my time.
>> 
>> >> +config SERIAL_8250_ISA
>> >> +	bool "8250/16550 ISA device support" if EXPERT
>> >
>> > So, no one will set this?
>> 
>> I followed the pattern of the existing SERIAL_8250_PNP option.  Was that
>> a mistake?  How would you prefer it?
>
> I don't know, I'm just asking.
>
>> > What userspace visable change will be caused by this? 
>> 
>> There won't be /dev/ttyS devices for ports that don't exist.
>> 
>> > Will ports get renumbered?
>> 
>> Not if they had predictable numbers to begin with.
>
> So that would be "yes"?  If so, obviously we couldn't take this, right?

On a Beaglebone Black based system with some of the UARTs enabled, those
keep their numbers such that e.g. ttyS0, ttyS1, and ttyS4 show up in
/dev while ttyS2 and ttyS3 do not since they don't correspond to any
(enabled) ports.

If any of the very many variants of this driver do not assign fixed
numbers, those would possibly be renumbered.  Should that be the case,
the numbering was never guaranteed to begin with, so I fail to see any
problem.

-- 
Måns Rullgård
