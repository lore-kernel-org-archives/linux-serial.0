Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DCC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 14:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGLOAD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiGLN7p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 09:59:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC5B8EB1
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 06:59:05 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220712135901euoutp016860d83547183735c624fb4e39d4d167~BGaadO2wT0708707087euoutp018
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 13:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220712135901euoutp016860d83547183735c624fb4e39d4d167~BGaadO2wT0708707087euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657634341;
        bh=UrPawTkkxco5tNzWRxD6vVP9tjBtCtweHbBECxb5T8o=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UVL7V+VNtOvGJuZt6vcXLlVmz6T/gmDgabvME5JLAk6PloVixy0MTyg3LYeEXRd5X
         XcmQLMHPBAoWcApYLBPghubaSpHafPmJob48VbSefucnyRmxO4FvelNOUarRflXg4h
         VZ0GFugLdmrS90bXWI0iV51S7zeUteLaNx8Cmemc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220712135900eucas1p14a52f558e0ee24a00db457b1b938ee39~BGaaGFSV_1626016260eucas1p1Y;
        Tue, 12 Jul 2022 13:59:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 25.57.09664.42E7DC26; Tue, 12
        Jul 2022 14:59:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712135900eucas1p284595bf0268f06396e7dba21fa6eb244~BGaZpwtAB0409004090eucas1p2X;
        Tue, 12 Jul 2022 13:59:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712135900eusmtrp1f49bd185141eab176bb4115d9164945a~BGaZo-mJo1223712237eusmtrp1S;
        Tue, 12 Jul 2022 13:59:00 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-ad-62cd7e24525c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.01.09038.42E7DC26; Tue, 12
        Jul 2022 14:59:00 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220712135859eusmtip1e1fea7b861abd6226036e7300863b6f3~BGaYtxzAy0659806598eusmtip10;
        Tue, 12 Jul 2022 13:58:59 +0000 (GMT)
Message-ID: <caa266c1-aecc-31c4-75f5-b5061444b446@samsung.com>
Date:   Tue, 12 Jul 2022 15:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3] tty: serial: samsung_tty: loopback mode support
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Jiri Slaby' <jirislaby@kernel.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        'Hector Martin' <marcan@marcan.st>,
        'Jaewon Kim' <jaewon02.kim@samsung.com>,
        'Vincent Whitchurch' <vincent.whitchurch@axis.com>,
        =?UTF-8?Q?=27Ilpo_J=c3=a4rvinen=27?= 
        <ilpo.jarvinen@linux.intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <000001d89588$936d14c0$ba473e40$@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djPc7oqdWeTDKb9MrB4MG8bm8Xl/doW
        zYvXs1l07uhhsdjRcITV4t1cGYu9r7eyW2x6fI3VYsb5fUwWZxb3slucvraA3eL8Nn8HHo/r
        6wI8Nq3qZPO4c20Pm8e8k4Ee++euYffYvKTeY/GynWwefVtWMXp83iQXwBnFZZOSmpNZllqk
        b5fAldG14gRLwUOOihOtTSwNjK/Zuhg5OSQETCTavj9m7GLk4hASWMEocXLuY3aQhJDAF0aJ
        H4vrIezPjBIHD0XDNPxddZ0NomE5o8TOmZ0sEM5HRonFd7YAdXNw8ArYSayf7QnSwCKgKrG6
        7yQjiM0rIChxcuYTFhBbVCBZ4tzZq2BXCAu4S3TOaGUFsZkFxCVuPZnPBDJTRGAWo8TbLdvA
        FjALdDBLzP+2BKyKTcBQouttF1g3p4CVxNzGb4wQ3fIS29/OYQZpkBCYzSmxf/ZUJoi7XST+
        v9vBDGELS7w6voUdwpaROD25hwXkagmBfIm/M4whwhUS116vgSq3lrhz7hcbSAmzgKbE+l36
        EGFHiTM961ghOvkkbrwVhLiAT2LStunMEGFeiY42IYhqNYlZx9fB7Tx44RLzBEalWUihMgvJ
        97OQ/DILYe8CRpZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgcns9L/jn3Ywzn31Ue8Q
        IxMH4yFGCQ5mJRHeP2dPJQnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQ
        WgSTZeLglGpgsnqzynoFS9HTTVezq6q2fXx1IOGT5jr90LwHF0TenUsuWevvmbpuVhZfXlTw
        cb2sCrNpJXyb1xpbK/bFN5nysOaenK+oIGP6SVhEYNXMI4f9l85eXZsrZtqY5dfGYW14qor9
        jWhg5KWjsa+mXniQsjRTQaq593N39f/ad0rCAW3pVxlv8OSe0l3x4LLJkyen735lTlFY/+Id
        R9zT/y5zG1h2rz3T+GjZtUlaJkt59r6R09u5wPvz+T1HO5+nLFx1hjvO66CQi1Xehp/RzUvL
        b6Soz+m3nBaUMZkrV9VIsV3r1SyB2QZRu96kLLvAo79S201lg9qFuycXCfDY/53QESMv2Hnr
        uPrG2WmTRG3jlFiKMxINtZiLihMBTg96ptUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7oqdWeTDCa/F7B4MG8bm8Xl/doW
        zYvXs1l07uhhsdjRcITV4t1cGYu9r7eyW2x6fI3VYsb5fUwWZxb3slucvraA3eL8Nn8HHo/r
        6wI8Nq3qZPO4c20Pm8e8k4Ee++euYffYvKTeY/GynWwefVtWMXp83iQXwBmlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9G14gRLwUOOihOtTSwN
        jK/Zuhg5OSQETCT+rroOZHNxCAksZZQ4tK2HFSIhI3FyWgOULSzx51oXVNF7RokHL3axdzFy
        cPAK2Emsn+0JUsMioCqxuu8kI4jNKyAocXLmExYQW1QgWaJ5yyEmEFtYwF2ic0Yr2ExmAXGJ
        W0/mM4HMFBGYxShx/dNTdhCHWaCLWeLI4y5miG3fGSUmnDoKdiubgKFE19suMJtTwEpibuM3
        RohRZhJdW7ugbHmJ7W/nME9gFJqF5JJZSDbOQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIFxvO3Yzy07GFe++qh3iJGJg/EQowQHs5II75+zp5KEeFMSK6tSi/Lji0pzUosP
        MZoCg2Mis5Rocj4wkeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTB55L0SUb6XEuy/82Qzw/m78XlBn+qWr90U9sZx6bua9c32pkJ99SraJpqPpRQ2sE1f9upf
        0dmTkWUZNxVFZmtGXrjqJDeloWrNfv8z6zTvPCrSmSfu93eVWd31Nx9KlyRUCZaw9HHd6Fv+
        rTTtUelRkwzWKpdE5e2+XyonJrs90m5L7hDiYuO+9u599druR+cu7HtwIuj2R2aT04c++97U
        unZQuMRUsch5m+yn9dGd3VarrSPLlVz3/LY9+fbyozYNw5f3tvxODjSb8namf97CK7bnuvym
        7+7oPFyQ7sW6atGcnwGdUzaF8l8yFv4veLE1Vf/TphUt+65t33yEQf70SbbvP991z74698a2
        OtsnSizFGYmGWsxFxYkAc9ZqpWwDAAA=
X-CMS-MailID: 20220712135900eucas1p284595bf0268f06396e7dba21fa6eb244
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
References: <CGME20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc@epcas2p4.samsung.com>
        <20220629004141.51484-1-chanho61.park@samsung.com>
        <4fb8c922-08aa-2ee3-8073-95b8a26bf5db@samsung.com>
        <000001d89588$936d14c0$ba473e40$@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12.07.2022 02:44, Chanho Park wrote:
>>> +	if (mctrl & TIOCM_LOOP)
>>> +		ucon |= S3C2410_UCON_LOOPBACK;
>>> +	else
>>> +		ucon &= ~S3C2410_UCON_LOOPBACK;
>>> +
>>> +	wr_regl(port, S3C2410_UCON, ucon);
>> S3C2410_UCON must be modified at least under the local_irq_save() or port
>> lock, otherwise it breaks kernel console operation on older Exynos SoCs
>> (especially when DMA mode is used).
>>
>> The above read-modify-write sequence should be replaced with the following
>> pattern:
>>
>>           if (mctrl & TIOCM_LOOP)
>>                   s3c24xx_set_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_UCON);
>>           else
>>                   s3c24xx_clear_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_UCON);
> All the set_mctrl() call can be protected by spin_[un]lock_irq[save/restore] with port->lock.
> So, I think it is not required.

Right. The problem is elsewhere. You used rd_reg(port, S3C2410_UCON) 
instead of rd_regl(port, S3C2410_UCON) what always zeroed upper bits. I 
will send a fix in a few minutes.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

