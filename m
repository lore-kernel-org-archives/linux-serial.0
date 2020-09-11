Return-Path: <SRS0=dMzY=CU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BB0C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EA72076D
	for <linux-serial@archiver.kernel.org>; Fri, 11 Sep 2020 01:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcBeXrVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgIKBAd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBAc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Sep 2020 21:00:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CEC061573;
        Thu, 10 Sep 2020 18:00:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so5347250pgm.11;
        Thu, 10 Sep 2020 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8vElMG7rEAelCeSO5KkK1BZJe+z+ZlZT2B98OvglQOo=;
        b=IcBeXrVaP4EsP0HrA9+ROO7rhXmG78X1vXTViI+Rd2iyCwoUfEknPSHviTK3nXeIpJ
         tGW2NWIUdZGWK0sbo4V9pJmOvczBrLnBQHLl1VTQnVaR1YTrAELgRHHARkMPl3evQThl
         eqdOA/b4xiSgBG3clLDL7Mrqb/ng+ScC5dNLANNUoy6EJhNJWsmBqOwRWE2Iit4CFS3v
         aUE6+Ib5pTl/bS62nsfuODN0833w1vBp8oA5sMavOdl+7RK6/3PtVhf38L/BzjzAoKie
         uwy1e2Q+ZemJWoHNUf5nyzvKhTdd9jXp2k3+kjjpgGQHs7otGS/kACphdVqie+T+MO/1
         JiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vElMG7rEAelCeSO5KkK1BZJe+z+ZlZT2B98OvglQOo=;
        b=tH5yOz7q1dvQQP0t/8Ez5dFHaRt481nzPsRZNbozqJFCgb6Lrf3SJhVqmmvySDvzTv
         kW6EsqYdOJV5k+CwBVRwGPsMGxkqn+02JQ1FvIyY2xrGIWV+ZEfXWJo+0Di766INea2L
         BHqFgmU3pVLsiyLLnnciTP6wSJdUjPU2Dl2xh/Rp81iFSTUp7udu0zC38Kh48aJzSXlT
         2Ry5W5jZkfCuwYH3Heag3ub06V0Q15xMjtiStb0ImOZ0q9NqNLPascEMjB9bCWkjUJPK
         uRCmtFhnXnA25MKzJMblMC/8XZYpQv65DkXwqvSVNlFZifiB7cPMZZkDaVxdLdp3yQDY
         Oyaw==
X-Gm-Message-State: AOAM531s55WQwdnjDnpXxJbqaC8GzTf0M6xk6nDANA4xXGXf3XSMA26/
        8zHxUbFNSKvKDFf/6bdu8cZ6XzfyWDm3Zg==
X-Google-Smtp-Source: ABdhPJzyykw0tjPQgOGTfsn47Q+1TsLlbukbor9bi3JAr18Rei2ufl+ITDUCMq4AAt6tRopL5i8H9Q==
X-Received: by 2002:a17:902:7c03:b029:d0:cbe1:e71b with SMTP id x3-20020a1709027c03b02900d0cbe1e71bmr8244598pll.41.1599786031325;
        Thu, 10 Sep 2020 18:00:31 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id a27sm292341pfk.52.2020.09.10.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 18:00:30 -0700 (PDT)
Date:   Fri, 11 Sep 2020 10:00:28 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH v10 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200911010028.GO3562056@lianli.shorne-pla.net>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 02:33:46PM +0200, Mateusz Holenko wrote:
> This patchset introduces support for LiteX SoC Controller
> and LiteUART - serial device from LiteX SoC builder
> (https://github.com/enjoy-digital/litex).
> 
> In the following patchset I will add
> a new mor1kx-based (OpenRISC) platform that
> uses this device.
> 
> Later I plan to extend this platform by
> adding support for more devices from LiteX suite.

Hello, as discussed offline I am planning to merge these via the OpenRISC tree
during 5.10.  If anyone has an issues let me know.

The patches all have their reviews and look fine to me other than a few nit's on
the soc controller patch.

-Stafford
