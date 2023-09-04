Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13340C71153
	for <linux-serial@archiver.kernel.org>; Mon,  4 Sep 2023 06:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIDGkL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Sep 2023 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjIDGkK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Sep 2023 02:40:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57578BB
        for <linux-serial@vger.kernel.org>; Sun,  3 Sep 2023 23:40:07 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RfJqZ3Mr7zrRrZ;
        Mon,  4 Sep 2023 14:38:18 +0800 (CST)
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:40:03 +0800
Subject: Re: [PATCH] tty: vcc: Add check for kstrdup() in vcc_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <davem@davemloft.net>, <jirislaby@kernel.org>,
        <jag.raman@oracle.com>, <linux-serial@vger.kernel.org>
References: <20230903101322.205537-1-yiyang13@huawei.com>
 <2023090321-conch-stopper-51c7@gregkh>
 <b73d22ba-8f19-286e-9441-ac456bf37be5@huawei.com>
 <2023090400-sweat-algebra-1f34@gregkh>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <af31eba9-ad34-76f4-51fc-e20813a1607d@huawei.com>
Date:   Mon, 4 Sep 2023 14:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2023090400-sweat-algebra-1f34@gregkh>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023/9/4 14:17, Greg KH wrote:
> On Mon, Sep 04, 2023 at 11:45:11AM +0800, yiyang (D) wrote:
>> On 2023/9/3 18:49, Greg KH wrote:
>>> On Sun, Sep 03, 2023 at 06:13:22PM +0800, Yi Yang wrote:
>>>> Add check for the return value of kstrdup() and return the error, if it
>>>> fails in order to avoid NULL pointer dereference.
>>>>
>>>> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
>>>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>>>> ---
>>>>    drivers/tty/vcc.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
>>>> index a39ed981bfd3..420d334f6077 100644
>>>> --- a/drivers/tty/vcc.c
>>>> +++ b/drivers/tty/vcc.c
>>>> @@ -579,6 +579,10 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>>>    		return -ENOMEM;
>>>>    	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
>>>> +	if (!name) {
>>>> +		kfree(port);
>>>> +		return -ENOMEM;
>>>
>>> Please just add another goto target later in the function like the rest
>>> of the error paths follow.
>> Ok, i will send v2 patch for this issue.
>>>
>>> And how did you test this patch?
>>>
>> I use crosstool-ng build sparc arch for open CONFIG_VCC.
> 
> That is build-testing, how did you functionally test that this works
> properly?
> 
Sorry, I only passed the build test, and did not perform the works test 
because there was no corresponding hardware.

thanks,

Yi Yang
