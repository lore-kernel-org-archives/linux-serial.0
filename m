From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 2/3] serial: 8250_dw: Use new dev variable in probe
Date: Wed, 24 Aug 2016 20:06:37 +0800
Message-ID: <df249941-7f3c-5d57-7058-0ae7ed923b57@huawei.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
 <1468580485-28567-3-git-send-email-wangkefeng.wang@huawei.com>
 <1471864381.4887.202.camel@linux.intel.com>
 <c9107ca9-bd35-e80e-135c-1492789e044a@huawei.com>
 <1472032817.4887.253.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472032817.4887.253.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org



On 2016/8/24 18:00, Andy Shevchenko wrote:
> On Wed, 2016-08-24 at 16:20 +0800, Kefeng Wang wrote:
>>
>> On 2016/8/22 19:13, Andy Shevchenko wrote:
>>>
>>> On Fri, 2016-07-15 at 19:01 +0800, Kefeng Wang wrote:
>>>>
>>>> Use new dev variable instead of pdev->dev and p->dev in probe
>>>> function.
>>>
>>> I'm not sure we need this one. What is wrong with &pdev->dev?
>>
>> Yes, no error in current code. there are &pdev->dev(A) and p->dev(B),
>> some codes use A, others use B, so I want to use an unified one.
>>
>> If someone don't like this, I will drop it, :)
> 
> I want to say that this change doesn't belong to the series in this
> case. You may submit it separately later on.
> 

Will do, thanks.

