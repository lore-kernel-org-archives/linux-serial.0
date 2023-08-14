Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6AAEB64DD
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjHNJQr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjHNJQa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 05:16:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1012D
        for <linux-serial@vger.kernel.org>; Mon, 14 Aug 2023 02:16:29 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPSqV5WrLzNnCh;
        Mon, 14 Aug 2023 16:53:42 +0800 (CST)
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 16:57:13 +0800
From:   "yiyang (D)" <yiyang13@huawei.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <alan@llwyncelyn.cymru>
CC:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: vt: selection: fix soft lockup in paste_selection()
Message-ID: <4b92bab4-dbc9-0d75-72a5-c2765516a6b6@huawei.com>
Date:   Mon, 14 Aug 2023 16:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023/8/14 16:52, Yi Yang wrote:
> On 2023/8/14 14:32, Jiri Slaby wrote:
>> On 14. 08. 23, 6:01, Yi Yang wrote:
>>> Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
>>> is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
>>> 0 in paste_selection(), this cause deadloop and cause soft lockup.
>>>
>>> This can be reproduced as follows:
>>>    int ldisc = 0x1b; // 0x1b is n_null
>>>    struct{
>>>        char subcode;
>>>        struct tiocl_selection sel;
>>>    } data;
>>>    date.subcode = TIOCL_SETSEL;
>>>    data.sel.xs = 0;
>>>    data.sel.xe = 1;
>>>    data.sel.ys = 0;
>>>    data.sel.ye = 1;
>>>    data.sel.sel_mode = TIOCL_SELCHAR;
>>>    char bytes[2] = {TIOCL_PASTESEL, 0};
>>>    open("ttyxx", O_RDWR) // open a vt device
>>>    ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
>>>    ioctl(fd, TIOCLINUX, &data.subcode);
>>>    ioctl(fd, TIOCLINUX, bytes); // cause deadloop
>>>
>>> Fix soft lockup by check if ldisc in paste_selection() is n_null.
>> 
>> Ugh, no. What if another ldisc returns with 0 too?
>> 
>> So instead, what about checking for progress instead of checking a 
>> particular ldisc?
>> 
> 
> Sorry, my previous analysis have problem. The real reason why
> tty_ldisc_receive_buf() returns 0 is that n_null ldisc does not
> assign a value to receive_room. Therefore, min_t(int, count,
> ld->tty->receive_room) is always 0 in the tty_ldisc_receive_buf().
> Maybe i should check the receive_room size instead of checking the
> specific ldisc, check if receive_room size is 0 can fix this issue
> passed my test.
> 

Check receive_room size no a good idear, receive_room may also be 0 when
ldisc is n_tty. Do you have any idear if do not check the particular ldisc?

>>> Link: 
>>> https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/
>>> Fixes: 8a8dabf2dd68 ("tty: handle the case where we cannot restore a 
>>> line discipline")
>>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>>> ---
>>>   drivers/tty/vt/selection.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>>> index 6ef22f01cc51..9ba7f66fcf05 100644
>>> --- a/drivers/tty/vt/selection.c
>>> +++ b/drivers/tty/vt/selection.c
>>> @@ -388,6 +388,12 @@ int paste_selection(struct tty_struct *tty)
>>>       ld = tty_ldisc_ref_wait(tty);
>>>       if (!ld)
>>>           return -EIO;    /* ldisc was hung up */
>>> +
>>> +    /* tty_ldisc_receive_buf() will not do anything when ldisc is 
>>> n_null*/
>>> +    if (ld->ops->num == N_NULL) {
>>> +        tty_ldisc_deref(ld);
>>> +        return -EIO;
>>> +    }
>>>       tty_buffer_lock_exclusive(&vc->port);
>>>       add_wait_queue(&vc->paste_wait, &wait);
>> 
-- 
Yi Yang
