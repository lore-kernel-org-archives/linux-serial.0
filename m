Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A49C43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DB52074D
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585820897;
	bh=tQn980VNVD2NF8f3vV6R1mgERuk6VHI+6dEM25XXfqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ylAccX2CyA/jgiOpnbEflyG0H2iQAUTeh130KLIycgXjFdx6HMLUr2YBTvNBLiVgI
	 tCOr4leI25ZgQ4SJnMBGDcLMBMOcy8km7jkqmUnRZ9YS/vv4qPxVO26cMtFsls4oiN
	 WujNyiPcPA91+SNiV+J/1f4Ae0Mn0ee7BmFek8vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgDBJsO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:48:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44705 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJsO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 05:48:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16so3301937edy.11;
        Thu, 02 Apr 2020 02:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EebgA10aQonHAdiMTRoJOB7z11b/IU502qlsS+rdf6o=;
        b=HQjEdUKPZeSEOI8knQyUZQUexZP58MzcnenQuTu7L5Ea9Qsk5uPlEba7VWaq2ybhN+
         oXm4P8J+OckTV691brK5BNdpwXDhBjCcr9i7RmifNbb3Y70TmZ7MTxopEguf88kyrrjR
         BxLG4/J6jIf60XJP6OGBPeld8RwLFbiEUZPDXtMlfRr/3nNmmu7QJjOAM/jU+MTgNK26
         3qpCLx4jr0T0ABTIFAV1Bv0JkiXRC80Jyofzct2JuGUJOFBAzxxTJKah9S3xlXWE7IWT
         wJXiTaaBspvcYlBZl1cD9A/L5dSXtIGNz4hTNAb2QU6dnAt41c7mw82df82vQnMAf853
         HOiQ==
X-Gm-Message-State: AGi0PubhvGdIxpIvMKbWtpbWQE96Ceegv+wAIIhMnkzDnBxSua9nsUPP
        r//ieJ2+Y68aXLjL4Hro6O+7EGzi
X-Google-Smtp-Source: APiQypIF74oGksjMDueJN1n5kxiy+DMCIipIZolflLnnlWIJFFfGO84ldJuhdl2ALOj87wiqKoQ0fQ==
X-Received: by 2002:a17:906:9ca:: with SMTP id r10mr2262131eje.151.1585820891869;
        Thu, 02 Apr 2020 02:48:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id qk2sm1008399ejb.80.2020.04.02.02.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 02:48:11 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:48:08 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        hyunki00.koo@gmail.com, 'Kukjin Kim' <kgene@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: samsung_tty: 32-bit access for TX/RX hold registers
Message-ID: <20200402094808.GA21903@kozik-lap>
References: <CGME20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2@epcas2p2.samsung.com>
 <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <20200401085548.GC2026666@kroah.com>
 <20200401091952.GA14425@kozik-lap>
 <000001d608d3$5faa8260$1eff8720$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d608d3$5faa8260$1eff8720$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 06:44:58PM +0900, Hyunki Koo wrote:
> On Wed, Apr 01, 2020 at 6:20:20PM +0900, Krzysztof Kozlowski
> wrote:
> > On Wed, Apr 01, 2020 at 10:55:48AM +0200, Greg Kroah-Hartman
> > wrote:
> > > On Wed, Apr 01, 2020 at 05:27:20PM +0900, Hyunki Koo wrote:
> > > > -	if (np)
> > > > +	if (np) {
> > > >  		of_property_read_u32(np,
> > > >  			"samsung,uart-fifosize", &ourport->port.fifosize);
> > > >
> > > > +		if (of_property_read_u32(np, "reg-io-width", &prop) ==
> > 0) {
> > > > +			switch (prop) {
> > > > +			case 1:
> > > > +				ourport->port.iotype = UPIO_MEM;
> > > > +				break;
> > > > +			case 4:
> > > > +				ourport->port.iotype = UPIO_MEM32;
> > > > +				break;
> > > > +			default:
> > > > +				dev_warn(&pdev->dev, "unsupported
> > reg-io-width (%d)\n",
> > > > +						prop);
> > > > +				ret = -EINVAL;
> > > > +				break;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > >
> > > Does this mean that reg-io-width is now a required property for all
> > > samsung uarts?  Does this break older dts files?  Or should you
> > > fall-back to the previous operation if the attribute is not there?
> > 
> > Yes, it looks like silently breaking all boards.  Since
> > of_property_read_u32() will return errno, the warning message won't be
> > printed and all register reads will fail (return 0).
> > 
> > This looks like not tested on real HW.
> > 
> > Best regards,
> > Krzysztof
> 
> [Hyunki Koo] 
> reg-io-width =4 is required for Samsung uart
> To do not break older dts files, I will set default value in else of of_property_read_u32 like below.
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> + ...
> +		} else {
> +			ourport->port.iotype = UPIO_MEM;
> +		}

Thanks. Also, please test your patch on available Exynos boards, e.g.
Odroid XU4 or HC1.

Best regards,
Krzysztof
