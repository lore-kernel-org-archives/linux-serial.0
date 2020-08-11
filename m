Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2EC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0402078E
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 09:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JQh6iZKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHKJj7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:39:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55501 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgHKJj6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 05:39:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200811093956euoutp01ce9b85eea9a30d43075b22781b557d80~qLUX8iGIE1792217922euoutp01L
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 09:39:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200811093956euoutp01ce9b85eea9a30d43075b22781b557d80~qLUX8iGIE1792217922euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597138796;
        bh=O5mZfhYIBQgBLoLmmbBqXMrRZHtfg9MG1ofEN/3JM84=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JQh6iZKJ5PIDwq46rFBZpyCBD8oQO+BeLqsAWTGLhqqHzVlZbtaWL5R8d+pb0zanf
         NcOjROpldnOR6NbBJCmwB+bmAkFo6eZidvI4EAumo6YmgHH/SsxOpzkqg2LNxL9I7M
         Y0k4Hht9koSg9ItdfpT8CxygsKJFBD+PKyhfoK0o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200811093956eucas1p2e1a4d9d0ce26a232692ddc6fecb54283~qLUXwJ7dc2564325643eucas1p2L;
        Tue, 11 Aug 2020 09:39:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.95.06318.C67623F5; Tue, 11
        Aug 2020 10:39:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200811093955eucas1p14647fdf5933c6bed5e087e49ba1c3a43~qLUXbMrJp3021430214eucas1p1I;
        Tue, 11 Aug 2020 09:39:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200811093955eusmtrp2b4fde24831e4dd4798053b83ab389c21~qLUXagebL1982919829eusmtrp2H;
        Tue, 11 Aug 2020 09:39:55 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-14-5f32676c7a77
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.02.06314.B67623F5; Tue, 11
        Aug 2020 10:39:55 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200811093955eusmtip216a0bd93cde373c85a5f1b321b54995e~qLUW0sH_F1722517225eusmtip2k;
        Tue, 11 Aug 2020 09:39:55 +0000 (GMT)
Subject: Re: [RFT PATCH v5] serial: samsung: Removes the IRQ not found
 warning
To:     Tamseel Shams <m.shams@samsung.com>, kgene@kernel.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8a28be2a-e523-563c-b80a-19508b739b46@samsung.com>
Date:   Tue, 11 Aug 2020 11:39:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810030021.45348-1-m.shams@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGfXe3e6+rW6/T8GRaNso+IG0acsOwL6MbQQgSlKRz6WVG25TN
        zwgyzSyxj2XgWrMyjUIyZZqZ5sxBWThnKEqNgkqhsixjlWiiud0s//u9zznnfZ4DhyZkbZIg
        +ogui9frVBo5KRU3P51wbtCoI5UbGwsZ9u21ZpItqq4n2csNYyL2wtBngu3tbaBY69CghO1v
        tZCsqdcmYh3V5yj2TXE1tU3KWWvPklxH5V2Ka6w5wZ1vqkVcfdOAmHNbl8eTidItabzmSA6v
        j4hNkaaX2GaIzEYyz+IeFxWgckkp8qUBbwKzvU/sYRm+g+Bcj6IUSWf5B4Ky4i+kUHAjuOBQ
        zA3MmEdEgn4bwbAzReBvCIyDWz3sj+PB/cyEPByA86H3exXl+ZTANQge/+rzOpNYAaWjpbMG
        NM3gWOj8wXlkMV4NFY4WysNLcDLc7xrwejHYD55fGfYG9cWbwfbI5e0h8Ap4MGohBA4E1/B1
        kccLsJOCkuYCUggdB8Y7ViSwP4x0NVECB8PMw7mBIgTvnHWU8ChD0F9o+jsRA6+dk96kBF4H
        9a0Rgrwd2l0O5JEBL4KXo35CiEVwqbmCEGQGzpyWCd1hYO6698+280UfcRHJzfNWM89bxzxv
        HfN/3xtIXIsC+WyDVs0bonR8brhBpTVk69ThqRlaK5o9qe7prp8tyDZ12I4wjeQLmcwYhVIm
        UeUY8rV2BDQhD2B29HQny5g0Vf4xXp+h1GdreIMdLaPF8kAm6uanJBlWq7L4ozyfyevnqiLa
        N6gAwdePWQ32Q6kK//HfkZY1oT73pMWvJq7eOPnUaBxMfG/ZuSDklqtyJnox3zFdZR/dazu4
        9IOZ0yUUWkMOJOzekNS2W5lf/mTffnefMk8iWmlapXEkx4dK9qKWhLU/J03q8j0+u+rCcoNb
        XGMH28X90Xcrx7OnxrmAwbrA8FPHv8bJxYZ0lWI9oTeo/gBmb0J6TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7rZ6UbxBs8/GFk8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slvcbV3M7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZbTv+89csJmtYs7n70wNjJNZuxg5OSQETCT+z3rF1MXIxSEk
        sJRRom3yVyaIhIzEyWkNUEXCEn+udbFBFL1llLg9ayVYQljAT2LK8ctsILaIQKXE/auTwSYx
        CyxhlDiy8DHYJCGBHqCO+XYgNpuAoUTXW5BJHBy8AnYSB794gIRZBFQlpp/ZwQ5iiwrESTzu
        /c8MYvMKCEqcnPmEBcTmFLCU2LfnFlgNs4CZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7
        LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgbG479nPzDsZLG4MPMQpw
        MCrx8BZYG8YLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPz
        gWkjryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY8NSvpmsuRXl
        f6ZP2rLvvC1/Sfsfof1NnV+KVk5y3LMt8nPN8Xkveh33KEqyHFJuu6z20qaz2M7JKzTW+2LW
        tVtbN/+cLL+sLWTjnfuCdyzcPKtyT1/cYXgqoUiy8Pa3ZjGfbv1Lk2o8W5+UHdZ7lcP4c9lM
        /+CAwke35Q9Eck7gif766PskdyWW4oxEQy3mouJEAOq+pOXjAgAA
X-CMS-MailID: 20200811093955eucas1p14647fdf5933c6bed5e087e49ba1c3a43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c
References: <CGME20200810032514epcas5p1140fe0e44f3727953480ff0531c76b0c@epcas5p1.samsung.com>
        <20200810030021.45348-1-m.shams@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi

On 10.08.2020 05:00, Tamseel Shams wrote:
> In few older Samsung SoCs like s3c2410, s3c2412
> and s3c2440, UART IP is having 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210,
> exynos5433, and exynos4210 UART is having only 1
> interrupt line. Due to this, "platform_get_irq(platdev, 1)"
> call in the driver gives the following false-positive error:
> "IRQ index 1 not found" on newer SoC's.
>
> This patch adds the condition to check for Tx interrupt
> only for the those SoC's which have 2 interrupt lines.
>
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>

Indeed, it removes the warning on various Exynos{3,4,5} based boards.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

