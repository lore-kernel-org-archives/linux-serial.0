Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD7AC43219
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 02:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiKWClN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiKWClM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 21:41:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA0786EC
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 18:41:11 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH4yy4VCfzqSYJ;
        Wed, 23 Nov 2022 10:37:14 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:41:09 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 10:41:08 +0800
Subject: Re: [PATCH] serial: pch: Fix PCI device refcount leak in
 pch_request_dma()
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20221122114559.27692-1-wangxiongfeng2@huawei.com>
 <Y30c66gA+bOXGebH@smile.fi.intel.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <6b2013af-45cf-5a2d-a84e-5c6fa23911da@huawei.com>
Date:   Wed, 23 Nov 2022 10:41:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <Y30c66gA+bOXGebH@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

Thanks for your reply !

On 2022/11/23 3:03, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 07:45:59PM +0800, Xiongfeng Wang wrote:
>> As comment of pci_get_slot() says, it returns a pci_device with its
>> refcount increased. The caller must decrement the reference count by
>> calling pci_dev_put().
> 
>> Since 'dma_dev' is only used to filter the channel in filter(), we can
>> call pci_dev_put() before exiting from pch_request_dma(). Add the
>> missing pci_dev_put() for the normal and error path.
> 
> No, we can't do that. How is it supposed to work if DMA device disappears in
> the middle?

When the DMA device is registered into the system, its refcount is increased.
dma_request_channel() will increase the refcount for 'dma_chan'. So I think this
can gurantee the DMA device not removed in the middle.

Thanks,
Xiongfeng

> 
> Look at how it's done in the
> 
> 5318f70da7e8 serial: 8250_lpss: Balance reference count for PCI DMA device
> 67ec6dd0b257 serial: 8250_mid: Balance reference count for PCI DMA device
> 
