Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C43331
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4728D208E0
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585732802;
	bh=bZgzelA3UaTi5U8XMpF6gpsu/Vu2uMmzpccgocPvsVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWEgx1MtjSXBf63NNNHLOEFI+5pO+e7ONRJhVSct1apSidk3rRUPuHYA444vjdnMJ
	 LsI6FufcccoM3205IohMrq1tT43TJ1iU+UAZixO/4WTuktKYr1Jqx0NVxwfK9/8Pdp
	 HFStTVKu5Orz9urL/JwEgBkclbZYMBupO8fW2U7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgDAJT7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:19:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38350 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDAJT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 05:19:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5so28782225edq.5;
        Wed, 01 Apr 2020 02:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oiXWCfIsx4h3K5MebDggs1yLqhBWHjw9GlgqdZt4chM=;
        b=EFspn04Dw6kDgs+6Fptn5RhSVJ5UlCnR+NZzW2BOEYJrOGUBa4wqM65ysM0LJWW+Bz
         wIfUXZ2Tt7GYeZaKWg2ay8L5Co/NvKn/KSjokyCwJX1hsld0lXq7URHCiP2Y45/R2VQN
         vDm1ECv7p7YPw3QL81VRagKwMxMs0oSlyoYmmv9KzsU5ksJjaXrZbHiY/DUx0lbccY6s
         z3DYLMw+jXnIa8rWujKCLI3tW8KqtTwG9+/b2HaufWP0hdzo91zD83JvrhJA3UXaIKlI
         8OPGlQuJlQOYNUwYY3WT9M/IFxBhFcuAEPQwfbF8PMoLsO/9PA4Ajxb8rUqUbTM4Fxmt
         ckxg==
X-Gm-Message-State: ANhLgQ2TDWxdFKcCEbNb0SdpsJabDVOQSdOt18Nm4UHTXHTCiAKJhq3F
        JG8lSp1pZe/iaab8JAwHA20=
X-Google-Smtp-Source: ADFU+vtXO8qJ6/LomWoqPFo16aC2m31U0bjGq/5iuPLC69+YRJjCpnuSsVEXZGXdraHuzjQo5VWJNg==
X-Received: by 2002:a17:906:50e:: with SMTP id j14mr18523296eja.300.1585732794952;
        Wed, 01 Apr 2020 02:19:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id w4sm393813ejz.44.2020.04.01.02.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 02:19:54 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:19:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>, hyunki00.koo@gmail.com,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: samsung_tty: 32-bit access for TX/RX hold registers
Message-ID: <20200401091952.GA14425@kozik-lap>
References: <CGME20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2@epcas2p2.samsung.com>
 <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <20200401085548.GC2026666@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401085548.GC2026666@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 01, 2020 at 10:55:48AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 01, 2020 at 05:27:20PM +0900, Hyunki Koo wrote:
> > -	if (np)
> > +	if (np) {
> >  		of_property_read_u32(np,
> >  			"samsung,uart-fifosize", &ourport->port.fifosize);
> >  
> > +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> > +			switch (prop) {
> > +			case 1:
> > +				ourport->port.iotype = UPIO_MEM;
> > +				break;
> > +			case 4:
> > +				ourport->port.iotype = UPIO_MEM32;
> > +				break;
> > +			default:
> > +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> > +						prop);
> > +				ret = -EINVAL;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> 
> Does this mean that reg-io-width is now a required property for all
> samsung uarts?  Does this break older dts files?  Or should you
> fall-back to the previous operation if the attribute is not there?

Yes, it looks like silently breaking all boards.  Since
of_property_read_u32() will return errno, the warning message won't be
printed and all register reads will fail (return 0).

This looks like not tested on real HW.

Best regards,
Krzysztof
