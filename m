Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDEC11D04
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148F24673
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 12:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sDy3vdnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBTMNf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:13:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38121 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBTMNf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 07:13:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200220121333euoutp02e5a9865b885ea3ec050b9f65238afd0e~1G0HZ0Y1b0313103131euoutp020
        for <linux-serial@vger.kernel.org>; Thu, 20 Feb 2020 12:13:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200220121333euoutp02e5a9865b885ea3ec050b9f65238afd0e~1G0HZ0Y1b0313103131euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582200813;
        bh=jbhbpKYjDeqrLPWjm1vmGVy9BoHZVLnyWdbkNfaXZTQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sDy3vdnFN6O56yjqBY3lNKFIfGglNvADaiRVy316f10kjiglzCbOHwgBIlqqfXk/M
         DjBfHLEf/wfSE5mwFnBR8qiYKFw2QhZ2wmfHXogP2k2j8ord10iSPvUjFPyyBwpUJK
         XJUjT6RFpnWKM8s3wp2lTSRZ/QnW/tky0vQh5fG4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200220121333eucas1p25d43d5adcb67438871c86131e9ca8baa~1G0HONc_g1263412634eucas1p26;
        Thu, 20 Feb 2020 12:13:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E9.41.61286.DE77E4E5; Thu, 20
        Feb 2020 12:13:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc~1G0Gu2tl91263412634eucas1p25;
        Thu, 20 Feb 2020 12:13:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200220121332eusmtrp17e6497b117259e170fe6f21a26e02f62~1G0GuF32d1809718097eusmtrp18;
        Thu, 20 Feb 2020 12:13:32 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-c7-5e4e77ed90e4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.A1.07950.CE77E4E5; Thu, 20
        Feb 2020 12:13:32 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200220121332eusmtip1c0fffcda8ed75f7501a0d9eaa212ecd5~1G0GIKYLq2023820238eusmtip1p;
        Thu, 20 Feb 2020 12:13:32 +0000 (GMT)
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Donghoon Yu <hoony.yu@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b04ad319-9986-c357-ad37-937bbb06bc02@samsung.com>
Date:   Thu, 20 Feb 2020 13:13:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7pvy/3iDA4+lbJoXryezeL42tes
        FquW3mC2mLLhA5NF/+PXzBadO6+yWpw/v4HdYtPja6wWl3fNYbOYcX4fk8WZxb3sFm39Dxgd
        eDw2repk89g/dw27x+Yl9R590xoYPfq2rGL0WL/lKovH501yAexRXDYpqTmZZalF+nYJXBn/
        OpuZCjbzVbzbupOtgfEfdxcjJ4eEgInEuufHGLsYuTiEBFYwShzrvcsO4XxhlHiz+y2U85lR
        4t+hhewwLddmNjKB2EICyxkljh/ihyh6yygx9+AmsISwgI/EtGe32EBsEQFjif6zs8AmMQt0
        Mkuc/viLESTBJmAlMbF9FZjNK2An0XKwAWwDi4CqREPvRFYQW1QgQuLTg8OsEDWCEidnPmHp
        YuTg4BRwkrhxVBokzCwgLnHryXwmCFteYvvbOcwguyQEXrJLTHx/hAniaheJRV82sEHYwhKv
        jm+B+kZG4vTkHhaIhnWMEn87XkB1b2eUWD75H1SHtcSdc7/YQDYzC2hKrN+lDxF2lNi27zRY
        WEKAT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LAM5gQZia6dK5knMCrNQvLZLCTvzELyziyE
        vQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJrLT/45/2sH49VLSIUYBDkYlHt4P
        6r5xQqyJZcWVuYcYJTiYlUR41Xj84oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Y
        kpqdmlqQWgSTZeLglGpg7OM0chY4teWwvKXnC/GlpYxaege+Tyy/M9FUaCuji8qe0EyndzXC
        m818nrPzBmc0fbu5X9bg6MeTk47cX8p80mLfdRuxecW/as5+dPU8FO/ewPdnvdM5vsbb375f
        9eu5/ZBjfrLT3qhT28qynq26HH8zi0/3/+y8u1xdGyN+3Vp8UvX/0sXiwkosxRmJhlrMRcWJ
        AG00gb1gAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7pvyv3iDI59sbRoXryezeL42tes
        FquW3mC2mLLhA5NF/+PXzBadO6+yWpw/v4HdYtPja6wWl3fNYbOYcX4fk8WZxb3sFm39Dxgd
        eDw2repk89g/dw27x+Yl9R590xoYPfq2rGL0WL/lKovH501yAexRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehn/OpuZCjbzVbzbupOtgfEfdxcj
        J4eEgInEtZmNTF2MXBxCAksZJR43f2TpYuQASshIHF9fBlEjLPHnWhcbiC0k8JpRYv73NBBb
        WMBHYtqzW2BxEQFjif6zs9hB5jALdDNL3Hx1ggWiwVFi98fDzCA2m4CVxMT2VYwgNq+AnUTL
        wQZ2EJtFQFWioXciK4gtKhAhcXjHLKgaQYmTM5+A3cMp4CRx46g0SJhZQF3iz7xLzBC2uMSt
        J/OZIGx5ie1v5zBPYBSahaR7FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93
        EyMwarcd+7llB2PXu+BDjAIcjEo8vDNUfeOEWBPLiitzDzFKcDArifCq8fjFCfGmJFZWpRbl
        xxeV5qQWH2I0BfptIrOUaHI+MKHklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1I
        LYLpY+LglGpgLI+ctuBH5Xo5PmcHfcm27HjuhD9TrzR+tuFn0VtxYBKr36K+9VcZjVaVB89/
        qXs4oKS/2+DfU4eWePeE+R4hSaJFU7KDXxde2Fi8WdkyuXhzGe+nF9nCN7X78rI3ypSy+dl+
        6V2RJNbPbM5z3K5Poe/2lttfX9o/WuduyJoRmXTzl0eM0iMlluKMREMt5qLiRAAQf94G8AIA
        AA==
X-CMS-MailID: 20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc
References: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
        <CGME20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc@eucas1p2.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi Greg,

On 2/20/20 11:26 AM, Greg Kroah-Hartman wrote:
> There is no need to tie this driver to only a specific SoC, or compile
> test, so remove that dependancy from the Kconfig rules.

samsung_tty driver is hardware specific driver so why should we
build it for any platform?

This change seems to defeat the whole purpose behind COMPILE_TEST
config option (which allows us to build hardware-specific drivers
without needlessly presenting the user with tons of non-relevant
config options).

Please explain this change some more, are you planing to remove
COMPILE_TEST config option?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Donghoon Yu <hoony.yu@samsung.com>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 52eaac21ff9f..a310bd22f1e2 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,7 +237,6 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> 
> base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
