Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6625C4332D
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469C964DF5
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhAaUFr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:05:47 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:58566 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhAaTry (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Jan 2021 14:47:54 -0500
X-Greylist: delayed 14344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jan 2021 14:47:53 EST
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:8d8e::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id E5A2E15360;
        Sun, 31 Jan 2021 19:47:11 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id DAD56219FCF; Sun, 31 Jan 2021 19:47:11 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
References: <20210128172244.22859-1-mans@mansr.com>
        <CAHp75VenDC0R3uX4_=Yzii-q5Z-YWcfT2_OO0yJkYehYAHDCew@mail.gmail.com>
Date:   Sun, 31 Jan 2021 19:47:11 +0000
In-Reply-To: <CAHp75VenDC0R3uX4_=Yzii-q5Z-YWcfT2_OO0yJkYehYAHDCew@mail.gmail.com>
        (Andy Shevchenko's message of "Sun, 31 Jan 2021 21:25:33 +0200")
Message-ID: <yw1xo8h4dh34.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Thursday, January 28, 2021, Mans Rullgard <mans@mansr.com> wrote:
>
>> On systems that do not have the traditional PC ISA serial ports, the
>> 8250 driver still creates non-functional device nodes.  This change
>> makes only ports that actually exist (PCI, DT, ...) get device nodes.
>>
>>
>
> This is kinda ABI breakage. At least this will break x86 platforms with
> HSUARTs (all modern ones) that are used in embedded systems.
>
> I think you would rather need an option to disable this and select it by
> the platforms where it is known not to break anything.

What exactly breaks?  The new option is enabled by default, just like
the one right beside it (SERIAL_8250_PNP), so nothing at all changes
unless this is actively disabled.  On a system that doesn't have those
ports, any attempt to access the device nodes produces some kind of
error.  How is it breaking anything to not create device nodes for
hardware that doesn't exist?

-- 
Måns Rullgård
