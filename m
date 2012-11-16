From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] tty: of_serial: fix return value check in of_platform_serial_setup()
Date: Fri, 16 Nov 2012 10:21:20 +0800
Message-ID: <CAPgLHd9demYGjb6mCWK-=mcLfw=Jo73WMfsLfa-3AxHwqpOEuA@mail.gmail.com>
References: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
	<20121115120811.B9EB63E0B12@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63618 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab2KPCVV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 21:21:21 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so1585202qat.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 18:21:20 -0800 (PST)
In-Reply-To: <20121115120811.B9EB63E0B12@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, rob.herring@calxeda.com, seth.heasley@intel.com, stable@kernel.org, yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 11/15/2012 08:08 PM, Grant Likely wrote:
> On Thu, 1 Nov 2012 13:27:34 +0800, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function clk_get() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value
>> check should be replaced with IS_ERR().
>>
>> dpatch engine is used to auto generate this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> Looks correct to me.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> Alan, which tree should this go through?
>
> Wei, did you run into this causing a bug? Do you think it should go back
> into linux-stable? It looks like it should to me.

Hi,

this only happens in the -next tree, so I think no need for stable.
 

