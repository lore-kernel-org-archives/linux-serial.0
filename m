Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD5CC4338F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 09:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6D66023D
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 09:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhHIJ32 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 05:29:28 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:33441 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234288AbhHIJ32 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 05:29:28 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2021 05:29:27 EDT
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.1) with ESMTPA;
        Mon, 9 Aug 2021 10:58:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Aug 2021 10:58:26 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 5/5] tty: serial: uartlite: Prevent changing fixed
 parameters
In-Reply-To: <YQONMMetaYI4aLMJ@kroah.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-6-sean.anderson@seco.com>
 <YQLC4L2Z3T4SuryE@kroah.com> <d46e0a4a-d9d4-190f-b41b-9c2b9e4748ae@seco.com>
 <YQLKB5jqx0/eFLR9@kroah.com> <79157167-335c-b2b3-8104-e3272226b369@seco.com>
 <YQONMMetaYI4aLMJ@kroah.com>
Message-ID: <29eb6890d4ff05dc550e18e57eaf0fb6@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-07-30 07:25, Greg Kroah-Hartman wrote:
> On Thu, Jul 29, 2021 at 11:43:08AM -0400, Sean Anderson wrote:
>> 
>> 
>> On 7/29/21 11:32 AM, Greg Kroah-Hartman wrote:
>> > On Thu, Jul 29, 2021 at 11:26:59AM -0400, Sean Anderson wrote:
>> >>
>> >>
>> >> On 7/29/21 11:01 AM, Greg Kroah-Hartman wrote:
>> >> > On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
>> >> > Through all of this, you are warning that nothing is supported, yet you
>> >> > are continuing on as if all of this worked just fine.
>> >>
>> >> We don't. The idea is that we see if (e.g.) CSIZE is something the
>> >> hardware can't produce, warn about it (once), and then set it to what we
>> >> can support.
>> >
>> > So you are ignoring what the user wanted, and doing whatever you wanted.
>> >
>> > As you can only support one setting, why even care?  Just set it to what
>> > you want and ignore userspace's requests.
>> 
>> That is exactly what we are doing. We set it to what we can support 
>> and
>> ignore what userspace requested.
> 
> If you can only support one set of options, just set it and always fail
> the tcsetattr call which will allow userspace to know it shouldn't have
> tried to do that.

I have to disagree strongly here against *always*. If the user calls 
tcsetattr
to set it to exactly what is supported it *should not fail*. Every 
decent
(terminal) program will start by setting or getting the initial 
settings.

Maarten

