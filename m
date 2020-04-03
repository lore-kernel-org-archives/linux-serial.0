Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81CC2BA17
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7BE20BED
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585915209;
	bh=hkh5FQklEbWFEOwnlBdvoKUZrHbWYX9RqG5B+tKkr54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aFZFH6B/5Ogy7fHBElG9ndm9iakTZ2IZt7l09WepHe98JzZFoxh79kcOKBe71woS2
	 Hb5SRT+9x9ojlqkQ7MTgAz+TjI/oj+bjSRv7XY/LLIRdEpceGhyyBnjfoc6bfbqatA
	 8zih3vGYYDA8IZbMDFFrkWh0TqSMjCBmluWHERCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbgDCMAI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:00:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43977 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403836AbgDCMAI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 08:00:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so8928365edb.10;
        Fri, 03 Apr 2020 05:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wc7UveTdPZFYH0ZRbje1TaqQfrS6AXkhVJ3giRnWQg=;
        b=ZoO4biaj8ulqOx5ItHluH705aZy4umwVDJRpNVyrAqmAK9b5X8p86SiL8qP17FUBI1
         YMgXNkRYZNNSBoEfZkb0Go0VroKleyG7DQrkyRlaD+KQQlwdFXjOORPMc2YPefih7KTf
         AIFQMAG2roIiapY2d3n2Grs7jn5PG/VyO3r4ss5yIklVbvzyir20VdDFqgCC2hpB7bsQ
         Au5+2S6raJQzr/2b2FCcf0jPaUnBYNYP/l3OdCCYvNxWMBHq5GReHccQW0kFZoNdq+kG
         7k75Zu1M4JIsQgRvEw5cEHKJnejZzAou1cJXH2LLp4tCQo0YYbdSi5ZJFMc4E08R401j
         jrxg==
X-Gm-Message-State: AGi0PuaTzYHdFlkgFrIM1KrLkfFUPOKx+c/ZrWujxFmTJ9aQmsaBDAu2
        kvxw1qttX6M60fg+0AuRwC4=
X-Google-Smtp-Source: APiQypLIn4dLIkqkA1s1CVJ9ujO0XsacXjWEzmUXeV58UH95EkaFLEmKyju+jLq5Vt5LYBy6dVckcA==
X-Received: by 2002:a50:a743:: with SMTP id h61mr7322529edc.84.1585915204852;
        Fri, 03 Apr 2020 05:00:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id p25sm1662881ejw.49.2020.04.03.04.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 05:00:04 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:59:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Kukjin Kim <kgene@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403115941.GB29484@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
 <20200403111511.10598-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403111511.10598-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 08:15:10PM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v2: 
> line 954 : change rd_regl to rd_reg in for backward compatibility.

I did not see any change around line 954 in v1... so what was it?

Rest looks good for me, although you should address Greg's comments.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid HC1 (Exynos5422):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

