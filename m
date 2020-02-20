Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D21C11D05
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489F62465D
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582196979;
	bh=5jznYIffxvU6eZSgRtNjQDXxHiq8x9que/YSIcqNoO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wmEtyTZiNJmYQXeUGoKqExXB14XnttmPWq3ZQ8yJ3NmgFoge93Vb0Jb7itg7JpQv1
	 npYOWK3VUgz7hGF0hc2pXoLp/AQyyvRLL7gTiyj1oOCywBmqr0W9oDrYQV9ZbmyHb+
	 qP22UmftfWUkZaC56ZWQJeZ/5nMxi7999oWt6BuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTLJi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTLJi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 06:09:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C722024654;
        Thu, 20 Feb 2020 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582196977;
        bh=5jznYIffxvU6eZSgRtNjQDXxHiq8x9que/YSIcqNoO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnQATuvonnFZRK8jNgZHTiyoH2pbNcWyCMPwZlxxY0d+PlUlNftiRhrnDM8c/m3he
         bA+vX8Z+3LGvDvrnOgBIw0C9VyjpbpqYkPJ+sUJCrEJFapbygLBeuS4cf/jgYeeJ2W
         Hzom6XFfHM6e+Qt2Szygw+IeF9/RooxD5rwKLWm0=
Date:   Thu, 20 Feb 2020 12:09:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Donghoon Yu <hoony.yu@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: remove SERIAL_SAMSUNG_DEBUG
Message-ID: <20200220110934.GA3374196@kroah.com>
References: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
 <20200220102628.3371996-2-gregkh@linuxfoundation.org>
 <20200220105541.GB24587@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220105541.GB24587@pi3>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 20, 2020 at 11:55:41AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Feb 20, 2020 at 11:26:28AM +0100, Greg Kroah-Hartman wrote:
> > Since a05025d0ce72 ("tty: serial: samsung_tty: use standard debugging
> > macros") this configuration option is not used at all, so remove it from
> > the Kconfig file.
> > 
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Donghoon Yu <hoony.yu@samsung.com>
> > Cc: Hyunki Koo <kkoos00@naver.com>
> > Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> > Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/Kconfig | 9 ---------
> >  1 file changed, 9 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the quick review of both of these!

greg k-h
