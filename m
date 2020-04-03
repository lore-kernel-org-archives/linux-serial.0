Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86734C2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3AB2078C
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585915719;
	bh=DP/d3tf5UZ0A0xxK0Qi6SkXGf4aA3PWieTSQjlZJmcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LIwUrhtImH7ubBeVxJ7edsC/rs0NjEA6xNBFfyAuXNTtCgTTz33naBjyiP+dolSgd
	 BiEZATsmQO2yTVRYTlRPLY391E4waQ3oEGcPeH8PQ2s6tYwpjZRIk2Sib6JhIntWu3
	 813Qe9DLtXWyqxp0iDSRJtEZoz+RnL8t9LT15OIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbgDCMIj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:08:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgDCMIi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 08:08:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so8996886edb.4;
        Fri, 03 Apr 2020 05:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTb1rr50ADmCz5IrPDEklCKRPMu9csBSo16UOelGpMs=;
        b=JOLjmxEn93wG0Ap3DVRx9dtOfGLGHo0s1mZqMF65A1bHJOBcvOrq03yhLmU0tJTTr3
         BmOeHCcjnYx8qGjwz6Ouwpqq4UjVS/+iFzJ5RXKSIWtc9l/9qWINs2I6ALV+2+hgH7I2
         /ajUb0JdX/dY8k2K1GJSA6qgLupbsdMYeILvi3XiIl6IjC7AuxN3jmyWh5rvYR07Dgaa
         Un+aUquhsi6nhH7i3fvrN30bZDTSPe9btQ2fGjq8uGMiCvWdfhnk3zji063PZ56k0lA5
         W+e7bM9kWYnd5f8lqkWF93h7GltJamRl/Vni5qlqpZD1QsWptzQLoTk5jIeCgTxQLobo
         3uyw==
X-Gm-Message-State: AGi0PuYEdc3vcpLIpGW1Me5yAm+gXfxyt2rqZnuzydTPMWRRXsGqS3RC
        wUGw9jDXdJpJXuZkQ/eGqKY=
X-Google-Smtp-Source: APiQypKSaTXk0j+WTDpvn86z+TkgbukqvVq3ZioNTe2LrhUK9WK3TUoVpoM4Oj6vjSB7L0KfO/P70w==
X-Received: by 2002:a17:906:5e52:: with SMTP id b18mr8324983eju.160.1585915717334;
        Fri, 03 Apr 2020 05:08:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id y3sm1608850ejo.27.2020.04.03.05.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 05:08:36 -0700 (PDT)
Date:   Fri, 3 Apr 2020 14:08:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200403120828.GA30617@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
 <20200403111511.10598-1-hyunki00.koo@samsung.com>
 <20200403114237.GA3797881@kroah.com>
 <20200403115313.GA29484@kozik-lap>
 <20200403115715.GA3846995@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403115715.GA3846995@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 01:57:15PM +0200, Greg KH wrote:
> > > If the property is not there, the type will be uninitialized and no
> > > warning will be spit out, are you sure you want to do that?
> > 
> > The default value from initial ourport will be used, which is UPIO_MEM.
> > This way it is backward compatible.
> 
> Where is iotype set to UPIO_MEM as a default?

Here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/samsung_tty.c?h=v5.6#n1626
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/samsung_tty.c?h=v5.6#n1989

Best regards,
Krzysztof

