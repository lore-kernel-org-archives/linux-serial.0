Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65ADC43381
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808BB2255F
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 13:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbhAENVE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbhAENVE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 08:21:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4547F2255F;
        Tue,  5 Jan 2021 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609852823;
        bh=zA5DtIeOvG2pZAiWgUaakzH1u5nm6GWCrS33DADbJaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVLGxHqlEXiK/KmyjD08kFUQx3n1OM/MrRg+P1ZzeqdbgAdIVxEgQXzNgqYTvknlX
         fOJu+f2LcbJ8RAfFGyfafEr9WV/nu+/yPtxdM6flmGsXSi+WelAatjBqpiI3q/fqB8
         vToF07UEUrd4LP+K9J+VvtB5AIETSXuZdx2020qg=
Date:   Tue, 5 Jan 2021 14:21:47 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,2/2] Serial: silabs si4455 serial driver
Message-ID: <X/Rn62w/IpMHit5j@kroah.com>
References: <20210105104347.GA18688@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105104347.GA18688@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 05, 2021 at 10:43:49AM +0000, József Horváth wrote:
> This is a device tree schema for serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Guide: https://github.com/dministro/linux-serial-si4455
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>
> ---

Your subject line is incorrect here :(

Please fix up and resend the series properly threaded (git send-email
will do it for you.)

thanks,

greg k-h
