Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DDC54EAA
	for <linux-serial@archiver.kernel.org>; Sat, 28 Jan 2023 00:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjA1Ayd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjA1Ayc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Jan 2023 19:54:32 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0D83278
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674867270; x=1706403270;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8HroFzcMUn53K8eqs6JLXQhk7cTtRl6khnafxvlvf58=;
  b=VVunoUzRW73PFTr+OUe6+WCXr7dQn1aH2Kki7QMTGHwg4J2uMo64R+w2
   PDexZqS1RRjcKizTtf7jhwx2VRLXgI3ZbyoMrRvRMJfgZB17GCO5N6NXF
   /Th+aQu3Jh8+LRSYD1gHYSofR94Tea0YP53bjChojz2AJ+XmNd3yH9bU9
   PT3yzyPr5kRFM19F/nira5iKZKb/vMzmX86rKIIqakqZHG4gQ0ZY/A6zZ
   869q0TGz7uQptjsPfA78cgE8E6OBQRNYCBaOJyUJX3uZwgULpiWy+Nz3u
   f9yo+Vn9jOEE+rdegPXZzDd5MR5bIx4edQ/XetYq2RTtYXXViNPHQocVx
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="221742372"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 08:54:18 +0800
IronPort-SDR: Cw2ORc4w0LheX4DL/QaJDWJXOR414izs9rTbu5NQcQqsrafoAGMMqmTbxzj3vq5EInQQlJcS2e
 OpQpTwuDDbsO8XkdG7h2ypPMOzGQPjtfo2eLJROIOnifqFDgwoCV7hH8RkVk4GirNcCdGWUWN+
 Ag96fvTyDOXFLPq0CuYfXiO2YUCdBROu2Q3FDgU320bdU4tQuggmnCbOKv1x99INRlpuaQrmYj
 EIzyuXTMv7w2PmvXgeBv6/dBcLK3F8JLo4dqQlAqK96atb3CCnLJSg34+rfkxfE78zpJTPAGBZ
 GhE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:06:03 -0800
IronPort-SDR: 17yhW25kTap6XuBPUloT+sby6MsvH7p9HUqpfBIV+S2+BWB2ivXSlWKFCIJvuNQ2GjWpjk+hAk
 AXa9fytVFXeb2SnpS51RTBbNmzLt/w08uxD5h6iArz4TWXTRX9Dyrur0iu5UfnnApOXK0ddY5m
 tdY01r6vXY0GYvIzfxtFzSWJ0h6755zg4d7LPL8C9Bn0l70d0f8P/dJ1SqY+AM9FQ6DdBLjJCe
 0Fx76uBWXCTxe/8gMFpwdktCKtg3ILYV1a+7J3eT1xx6ViRgwt64qqqbgKE/EdYovd89+ImR+x
 998=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:54:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3bYj6r87z1RwvT
        for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2023 16:54:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674867256; x=1677459257; bh=8HroFzcMUn53K8eqs6JLXQhk7cTtRl6khna
        fxvlvf58=; b=ShftbYmd37Un2N6WXeDLuDn368rIZ7rg0bPyrhOhRV4L+OujvBZ
        9t8qHFpVJ9RP9zP8FBgxqvyARvggZHlQecr5g6REKIL7iS/I5mp/zcILc1CJIDnK
        eNA5e0cb5clxhH30P9AwwNnBnpmc4eCQx23IrsUCGiFiYbpjuCzCe4nihmz/r/pb
        a40GgA7aEk2TxXGdKxBIf7R5q8nNV1GLcsTNR48eKphEVQZb3leRSAv96TRrs2Xi
        HvHLkNGrYeNxQEiJKcsmUXydBaOCiqhmUKI8Wog2rqzVCKrwuTaN1On12FtbYbv5
        aQqi/qfXflV+L3rvEVEDNsMiNU0bzwX0V8Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AXRkKoc6sFGe for <linux-serial@vger.kernel.org>;
        Fri, 27 Jan 2023 16:54:16 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3bYd1nCCz1RvLy;
        Fri, 27 Jan 2023 16:54:12 -0800 (PST)
Message-ID: <75aa04c9-e173-6a2d-6b38-d0e16f3800aa@opensource.wdc.com>
Date:   Sat, 28 Jan 2023 09:54:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] dt-bindings: reference MC peripheral properties in
 relevant devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
 <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230127093217.60818-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/27/23 18:32, Krzysztof Kozlowski wrote:
> Several devices can be attached to memory controllers (or memory-mapped
> buses), thus they can come with additional controller-specific
> properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
> intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.
> 
> Referencing Memory Controller or IXP4XX bus peripheral properties fixes
> few dtbs_check warnings like:
> 
>   intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
>     ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

