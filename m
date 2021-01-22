Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C9C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Jan 2021 07:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647AA238D7
	for <linux-serial@archiver.kernel.org>; Fri, 22 Jan 2021 07:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAVHHt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Jan 2021 02:07:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbhAVHHr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Jan 2021 02:07:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEC12ABD6;
        Fri, 22 Jan 2021 07:07:02 +0000 (UTC)
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
 <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com>
 <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
 <YAnZaYj1ohUNinaf@kroah.com>
 <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <31c96cba-dda5-59eb-dd7c-1bd023a2ff57@suse.cz>
Date:   Fri, 22 Jan 2021 08:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgfEiuxr6QbVXV3PXCBq35V_xVt8xMMBV3kTR4SarToSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 01. 21, 22:09, Linus Torvalds wrote:
> On Thu, Jan 21, 2021 at 11:43 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This works, thanks for these.  I'll wait for Jiri to review them before
>> applying them to my branches...
> 
> Let's hope Jiri sees them, since he had some email issue earlier..
> 
> I'll add his suse address here too.

Thanks, I am fixed and nothing was lost :).

-- 
js
suse labs
