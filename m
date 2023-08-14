Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655DC001DB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 08:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjHNIZJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjHNIZC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 04:25:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294FA6
        for <linux-serial@vger.kernel.org>; Mon, 14 Aug 2023 01:24:42 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPS5Q2YGVz2BdFZ;
        Mon, 14 Aug 2023 16:20:42 +0800 (CST)
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 16:23:37 +0800
Subject: Re: [PATCH] tty: vt: selection: fix soft lockup in paste_selection()
To:     Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>,
        <alan@llwyncelyn.cymru>
CC:     <linux-serial@vger.kernel.org>
References: <20230814040131.79439-1-yiyang13@huawei.com>
 <16025ce7-e0f9-fbcc-a961-9f729cf357c8@kernel.org>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <4371567f-6876-daee-c6ac-a687eabca845@huawei.com>
Date:   Mon, 14 Aug 2023 16:23:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <16025ce7-e0f9-fbcc-a961-9f729cf357c8@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023/8/14 14:32, Jiri Slaby wrote:
> On 14. 08. 23, 6:01, Yi Yang wrote:
>> Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
>> is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
>> 0 in paste_selection(), this cause deadloop and cause soft lockup.
>>
>> This can be reproduced as follows:
>>    int ldisc = 0x1b; // 0x1b is n_null
>>    struct{
>>        char subcode;
>>        struct tiocl_selection sel;
>>    } data;
>>    date.subcode = TIOCL_SETSEL;
>>    data.sel.xs = 0;
>>    data.sel.xe = 1;
>>    data.sel.ys = 0;
>>    data.sel.ye = 1;
>>    data.sel.sel_mode = TIOCL_SELCHAR;
>>    char bytes[2] = {TIOCL_PASTESEL, 0};
>>    open("ttyxx", O_RDWR) // open a vt device
>>    ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
>>    ioctl(fd, TIOCLINUX, &data.subcode);
>>    ioctl(fd, TIOCLINUX, bytes); // cause deadloop
>>
>> Fix soft lockup by check if ldisc in paste_selection() is n_null.
> 
> Ugh, no. What if another ldisc returns with 0 too?
> 
> So instead, what about checking for progress instead of checking a 
> particular ldisc?
> 

Sorry, my previous analysis have problem. The real reason why
tty_ldisc_receive_buf() returns 0 is that n_null ldisc does not
assign a value to receive_room. Therefore, min_t(int, count,
ld->tty->receive_room) is always 0 in the tty_ldisc_receive_buf().
Maybe i should check the receive_room size instead of checking the
specific ldisc, check if receive_room size is 0 can fix this issue
passed my test.

>> Link: 
>> https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/
>> Fixes: 8a8dabf2dd68 ("tty: handle the case where we cannot restore a 
>> line discipline")
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>>   drivers/tty/vt/selection.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>> index 6ef22f01cc51..9ba7f66fcf05 100644
>> --- a/drivers/tty/vt/selection.c
>> +++ b/drivers/tty/vt/selection.c
>> @@ -388,6 +388,12 @@ int paste_selection(struct tty_struct *tty)
>>       ld = tty_ldisc_ref_wait(tty);
>>       if (!ld)
>>           return -EIO;    /* ldisc was hung up */
>> +
>> +    /* tty_ldisc_receive_buf() will not do anything when ldisc is 
>> n_null*/
>> +    if (ld->ops->num == N_NULL) {
>> +        tty_ldisc_deref(ld);
>> +        return -EIO;
>> +    }
>>       tty_buffer_lock_exclusive(&vc->port);
>>       add_wait_queue(&vc->paste_wait, &wait);
> 

-- 
Yi Yang
