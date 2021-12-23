Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC27C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 23 Dec 2021 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348813AbhLWO0T (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:26:19 -0500
Received: from foss.arm.com ([217.140.110.172]:43094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLWO0S (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Dec 2021 09:26:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7544AD6E;
        Thu, 23 Dec 2021 06:26:18 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB203F5A1;
        Thu, 23 Dec 2021 06:26:16 -0800 (PST)
Message-ID: <5303e161-1e2b-4879-ccb7-f21ec2b503e0@arm.com>
Date:   Thu, 23 Dec 2021 14:26:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] serial: mps2-uart: Check for error irq
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211223132733.1400381-1-jiasheng@iscas.ac.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211223132733.1400381-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-12-23 13:27, Jiasheng Jiang wrote:
> On 2021-12-23 12:54, Robin Murphy wrote:
>>> Because of the possible failure of the platform_get_irq(), it should be
>>> better to check it to avoid the use of error irq.
>>
>> As far as I can see, the only "use" of error values is that they will be
>> passed to request_irq(), which will then return -EINVAL because they are
>> not valid IRQ numbers, and that error will be handled appropriately. I
>> think that's a relatively common pattern, so your commit message should
>> really describe why you think it's a problem and why this addition is a
>> meaningful improvement.
> 
> Thanks for your reminder, and I correct my commit message as follow.
> If that's ok, I will correct my other patches like this.
> 
> For the possible failure of the platform_get_irq(), the returned irq
> could be error number and will finally cause the failure of the request_irq().
> So it might be better to check just now in order to avoid the waste of
> later processes.

Even better, consider that platform_get_irq() can now in certain cases 
return -EPROBE_DEFER, and the consequences of letting request_irq() 
effectively convert that into -EINVAL, even at probe time rather than 
later on ;)

Cheers,
Robin.

> 
> Sincerely thanks,
> Jiasheng
> 
