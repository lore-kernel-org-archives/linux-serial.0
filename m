Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55BC3F2C6
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566320578
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mMmigeNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIQXe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:23:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45025 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCIQXe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 12:23:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200309162332euoutp01a21308151026dcfe33fea6867a0ab5da~6r1hAsT2e2592825928euoutp01m
        for <linux-serial@vger.kernel.org>; Mon,  9 Mar 2020 16:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200309162332euoutp01a21308151026dcfe33fea6867a0ab5da~6r1hAsT2e2592825928euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583771012;
        bh=mVaSzErXXr6NkeK167F1lomH4Gm8JqQhQ+aVHg2/4o8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mMmigeNknFMFtAV13UVky5lBOLNbmelucHrz+0NJhlJPELLZggyQssSJ8Xxbfjwhi
         hjy7kTh/RXLEpWJA6F8XJOFd7g8toZtp30n+TIO1Rsz4gdf/DWH9NFwi+IyLP04CRx
         z2/rnOBp4Gz6TlaCy6zMkYczNZ6RG7OY96OhIGw0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200309162332eucas1p2bae9eb1d7c08ded75beb0d3730f212d6~6r1gq3ZkH1251512515eucas1p2g;
        Mon,  9 Mar 2020 16:23:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DA.C2.61286.48D666E5; Mon,  9
        Mar 2020 16:23:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200309162331eucas1p206c78f3ed49cccd2f401980b158654ab~6r1gW2pe-1255312553eucas1p2o;
        Mon,  9 Mar 2020 16:23:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200309162331eusmtrp2298c3dcb041eef344c24c03f4d890f10~6r1gWKkqI3143831438eusmtrp2I;
        Mon,  9 Mar 2020 16:23:31 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-96-5e666d849f15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.FC.07950.38D666E5; Mon,  9
        Mar 2020 16:23:31 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200309162331eusmtip1e47cac4268bd201db6e9c36373ef8856~6r1f3cI341492714927eusmtip12;
        Mon,  9 Mar 2020 16:23:31 +0000 (GMT)
Subject: Re: [PATCH] Revert
 "tty: serial: samsung_tty: build it for any platform"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6ec29c9d-4a59-77fc-6cb4-38b86d62d22f@samsung.com>
Date:   Mon, 9 Mar 2020 17:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200306130314.GA3778623@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGeXfOzjlai7dp+KRWMCIy0LSsDpVhILZ+GQQlZeqyk0puyo5a
        +qPsA51CmlMpZ2a10mWlY4qmqdEmWvlVlhYmJPiBZiNTS3JpeTxK/rve+7lvnvuBlyHkbVJ3
        JlaTyGk1qjgF5UzWtPzu8r6mPhvuO+Ag2Tl9C82O9DVK2KvGSorNN09I2JzBcYIdrhqUsF1d
        Zpq1DPZK2VtdTRK23XidZt98nKICVykds3qktJRnUkqrTYeUL4qf0MqqB5eUH15dkSorq3tI
        5ZRl4xHmhPP+M1xcbDKn3X4g0jmm3/GUSviy/kJFTlgaGnHNQk4MYH/ov5tGZyFnRo5NCEwv
        66XiYxpBkSmTFFxyPIXgqnnzcmKks5gQTWUI5od1hGiyL5gmQgR2wUdBP2eTCOyKI6F52kgJ
        AQLPSKCn5jMSBhTeC7kZ5Ysswwcge/TPwjaGIfFmqDZ5CfI6HAqTAzapaFkLrwuHFgs5YT+o
        NFsWmcBu0DdUIhF5E9Taby+WAzxGQ07Ne0psHQQPa+tokV3ga2v1EnvC3zohLAQqEMzpRpfS
        tQjK8uaX0vugv3OWEtoR2Asq67eL8kFoKPxNCzLgNfDJvlYssQb0NTcJUZaBLl0uureAudRM
        La/NqntE3EAKw4rTDCvOMaw4x/B/711EliM3LolXR3O8n4Y778Or1HySJtonKl5tQQtfrG2+
        dfIZ+tl92oowgxSrZTHeZ8PlUlUyn6K2ImAIhavs8raocLnsjColldPGR2iT4jjeijwYUuEm
        23l/7JQcR6sSuXMcl8Bpl6cSxsk9DTWtM/fn9myKSJ9qCHwcUtbxw7+gPKyxMGB/tuMQb5zt
        oNvHjaVlu96S777d6Z5pj325p+DkbcOE7vvuoDl9QLTNmuGZGpp43MnUYnqkmW4t8ShKe55i
        ts00/DIG74joPfbL3nduQ2P3vaats0d0zXZL30Uu7ylUSPOD93k7ug/7Kkg+RuW3jdDyqn8P
        Zu1sXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7rNuWlxBuvmGVr8nXSM3eLZrb1M
        Fs2L17NZTNnwgcmi//FrZounmx8zWZw/v4HdYtPja6wWM87vY7I4s7iX3eLU9c9sDtwev39N
        YvTYtKqTzePQ4Q5Gj/1z17B7bF5S73HlRBOrx/otV1k8Pm+SC+CI0rMpyi8tSVXIyC8usVWK
        NrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu483stW8F9yYp1/TENjM9Euhg5
        OSQETCSenZvL3MXIxSEksJRRYs7qN6xdjBxACRmJ4+vLIGqEJf5c62IDsYUEXjNKPPvKC1Ii
        LBAsceaHFkhYRCBB4kbHVCaQMcwCP5kkFj6ewwo1k0li/Z/fYM1sAlYSE9tXMYLYvAJ2En0v
        /rCADGIRUJHYskITJCwqECFxeMcsqBJBiZMzn7CA2JwChhLrN2wCs5kF1CX+zLvEDGGLS9x6
        Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3
        MQJjdtuxn1t2MHa9Cz7EKMDBqMTDK6CdFifEmlhWXJl7iFGCg1lJhLdRKzlOiDclsbIqtSg/
        vqg0J7X4EKMp0G8TmaVEk/OB6SSvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFq
        EUwfEwenVAPjmj1O5tuMyx0Z5Hk29nyNSn0WsNbsYoDlhNqQI5wC8zgTlNnnqJYe9D20gMG1
        jKHD2qJxXvjnSysOK9Xqv7a4vSj6xpWW/VdvnJ+xvP/QSZ45pSEdetWG/A/ik3Zv6oh5fdjg
        oGzyjIXZmx++mHP85UUvSWbBCUnTVR/W3FjK/GXSH9kvv7rWKbEUZyQaajEXFScCAIf8/0fv
        AgAA
X-CMS-MailID: 20200309162331eucas1p206c78f3ed49cccd2f401980b158654ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200306130320eucas1p18bda7b5cdf613e1a811bda6eb99a5847
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200306130320eucas1p18bda7b5cdf613e1a811bda6eb99a5847
References: <20200306102301.16870-1-geert+renesas@glider.be>
        <20200306103652.GA3634389@kroah.com>
        <CAMuHMdUy8RjkY+0gBv-=mpcuamNQgB=k4rvNsiaj2s4uUDc5UA@mail.gmail.com>
        <CGME20200306130320eucas1p18bda7b5cdf613e1a811bda6eb99a5847@eucas1p1.samsung.com>
        <20200306130314.GA3778623@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 3/6/20 2:03 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 06, 2020 at 01:53:01PM +0100, Geert Uytterhoeven wrote:
>> Hi Greg,
>>
>> On Fri, Mar 6, 2020 at 1:29 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Fri, Mar 06, 2020 at 11:23:01AM +0100, Geert Uytterhoeven wrote:
>>>> This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
>>>>
>>>> When the user configures a kernel without support for Samsung SoCs, it
>>>> makes no sense to ask the user about enabling "Samsung SoC serial
>>>> support", as Samsung serial ports can only be found on Samsung SoCs.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> ---
>>>>  drivers/tty/serial/Kconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>> index 880b962015302dca..932ad51099deae7d 100644
>>>> --- a/drivers/tty/serial/Kconfig
>>>> +++ b/drivers/tty/serial/Kconfig
>>>> @@ -237,6 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>>>>
>>>>  config SERIAL_SAMSUNG
>>>>       tristate "Samsung SoC serial support"
>>>> +     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
>>>>       select SERIAL_CORE
>>>>       help
>>>>         Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
>>>
>>> {sigh}

[...]

>> Dropping those dependencies is similar to always having a simple PCI
>> core without any host PCI bridges, dropping "depends on PCI" from all
>> PCI drivers, and building an all*config kernel for your old i386 that
>> predates PCI (you can replace PCI by ACPI to modernize the example).
>>
>> What am I missing?!?
> 
> "depends on PCI" describes the hardware bus that a driver depends on.
> 
> PLAT_FOO is just trying to somehow classify that this type of driver
> only shows up on this vendor's devices.  It is not defining the hardware
> at all.  We try to always describe functionality of hardware, not try to
> declare specific vendor's hardware choices, right?
> 
> PLAT_FOO is interesting, but given that a specific driver is really not
> tied to that platform logically, only by virtue that no one else might
> not happen to have that hardware, it seems odd to have that.

Your particular patch is not about removing PLAT_FOO dependency but
about removing actual architecture/platform specific dependencies.

Please look at your patch and note that in addition to removing
PLAT_SAMSUNG dependency (even ignoring for a moment that it can be
replaced by a few ARCH_* dependencies and PLAT_SAMSUNG was used only
because it was shorter) has also removed ARCH_EXYNOS dependency.

How do you explain this?

> Yes, asking lots of questions is tough, but we passed that problem so
> long ago.  Are we now trying to add PLAT_FOO entries to all hardware
> drivers in order to make this type of selection easier?  I thought we

We are not going to add anything because for the vast majority of
the drivers the needed entries are already there:

$ find drivers/ -name 'Kconfig*'|xargs cat|grep "depends on"|grep ARCH_|wc -l
1310

> were just doing that by providing defconfig files to make the initial
> selection saner.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
