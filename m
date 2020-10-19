Return-Path: <SRS0=RzGw=D2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A00C433E7
	for <linux-serial@archiver.kernel.org>; Mon, 19 Oct 2020 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DB72224D
	for <linux-serial@archiver.kernel.org>; Mon, 19 Oct 2020 08:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgJSIAr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Oct 2020 04:00:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgJSIAr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Oct 2020 04:00:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBCC3B04F;
        Mon, 19 Oct 2020 08:00:45 +0000 (UTC)
Subject: Re: [PATCH 3/3] vt: keyboard, extend func_buf_lock to readers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minh Yuan <yuanmingbuaa@gmail.com>
References: <20201016122412.31767-1-jslaby@suse.cz>
 <20201016122412.31767-3-jslaby@suse.cz> <20201016132044.GA1798163@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <502f12ae-ac08-bb3c-ee6a-cd0baf34059c@suse.cz>
Date:   Mon, 19 Oct 2020 10:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016132044.GA1798163@kroah.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16. 10. 20, 15:20, Greg KH wrote:
> On Fri, Oct 16, 2020 at 02:24:12PM +0200, Jiri Slaby wrote:
>> Both read-side users of func_table/func_buf need locking. Without that,
>> one can easily confuse the code by repeatedly setting altering strings
>> like:
>> while (1)
>> 	for (a = 0; a < 2; a++) {
>> 		struct kbsentry kbs = {};
>> 		strcpy((char *)kbs.kb_string, a ? ".\n" : "88888\n");
>> 		ioctl(fd, KDSKBSENT, &kbs);
>> 	}
>>
>> When that program runs, one can get unexpected output by holding F1
>> (note the unxpected period on the last line):
>> .
>> 88888
>> .8888
>>
>> So protect all accesses to 'func_table' (and func_buf) by preexisting
>> 'func_buf_lock'.
>>
>> It is easy in 'k_fn' handler as 'puts_queue' is expected not to sleep.
>> On the other hand, KDGKBSENT needs a local (atomic) copy of the string
>> because copy_to_user can sleep.
>>
>> Likely fixes CVE-2020-25656.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Reported-by: Minh Yuan <yuanmingbuaa@gmail.com>
>> ---
>>   drivers/tty/vt/keyboard.c | 26 +++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> So all 3 of these should go to 5.10-final?

Let me try to eliminate also patch 1/3 which I now think is possible.

-- 
js
suse labs
