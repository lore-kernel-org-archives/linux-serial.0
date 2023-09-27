Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C84CE810A8
	for <linux-serial@archiver.kernel.org>; Wed, 27 Sep 2023 07:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjI0Hsp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Sep 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjI0Hsi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Sep 2023 03:48:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A71126
        for <linux-serial@vger.kernel.org>; Wed, 27 Sep 2023 00:48:36 -0700 (PDT)
Received: from kwepemm000014.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RwTFR0P2yz15NVG;
        Wed, 27 Sep 2023 15:46:19 +0800 (CST)
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm000014.china.huawei.com (7.193.23.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 15:48:33 +0800
Subject: Re: BUG: sleeping function called from invalid context in
 console_lock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, <hedonistsmith@gmail.com>,
        <daniel.starke@siemens.com>,
        linux-serial <linux-serial@vger.kernel.org>
References: <42c2c0c4-9ee2-6426-8c3c-2585e0345fcb@huawei.com>
 <c1dbec59-9564-5705-1ae6-200860a7371b@huawei.com>
 <2023091838-shrubs-paragraph-e579@gregkh>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <9613ee6f-08f7-ab6e-64f0-38505f67b891@huawei.com>
Date:   Wed, 27 Sep 2023 15:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2023091838-shrubs-paragraph-e579@gregkh>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000014.china.huawei.com (7.193.23.6)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023/9/18 23:19, Greg Kroah-Hartman wrote:
> On Mon, Sep 18, 2023 at 09:35:23PM +0800, yiyang (D) wrote:
>> In recent years, this problem has been reported in syzkaller all the time.
>>
>> Link: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
>>
>> Historically, the developers have tried to fix this problem by use mutex
>> instead spinlock, but it didn't solve the problem..
>>
>> Link: https://lore.kernel.org/all/20220826193545.20363-1-pchelkin@ispras.ru/
>>
>> Other developers have recently reported this problem, but no one has
>> continued to try to fix it.
>>
>> Link:
>> https://lore.kernel.org/all/20230420082153.6711-1-daniel.starke@siemens.com/
>>
>> Anyway, do we have any ideas for solving this problem?
> 
> Nope!  Why do you think this is something that even needs to be
> addressed?
> .
> 
Kernel only perform cannot sleep operations in atomic context, as 
otherwise a system hang or crash may occur.

So there's a risk to this problem.

