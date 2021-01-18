Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6352C43381
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB122CA2
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 17:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407198AbhARRqi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436750AbhARRqX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jan 2021 12:46:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74654223E8;
        Mon, 18 Jan 2021 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610991943;
        bh=PxZnb05HTKc7phbqlzZ9vyX035cxxIXYPNqdElwC3d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A26gK0njOQOg59yYJ5ZXgqgTi/ovza0RVqybG/YrHuOWgpym/e4VUOUfjt11fIRRx
         huy5iOyW5O5OQmbNPZi4Jb1krmpJwL9lY1TJgxMZojtynOOdfyJPBI4Nk+sZ+H5NNZ
         atio4lMbzScIE7IJLJuyM8WX/GrfyVIP2hwu1Vis=
Date:   Mon, 18 Jan 2021 18:45:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YAXJRDhS1HXeYaZz@kroah.com>
References: <20210115211543.33563-1-alcooperx@gmail.com>
 <20210115211543.33563-3-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115211543.33563-3-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 15, 2021 at 04:15:43PM -0500, Al Cooper wrote:
> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> UART is backward compatible with the standard 8250, but has some
> additional features. The new features include a high accuracy baud
> rate clock system and DMA support.
> 
> The driver will use the new optional BAUD MUX clock to select the best
> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> the baud rate selection logic for any requested baud rate.  This allows
> for more accurate BAUD rates when high speed baud rates are selected.
> 
> The driver will use the new UART DMA hardware if the UART DMA registers
> are specified in Device Tree "reg" property. The DMA functionality can
> be disabled on kernel boot with the argument:
> "8250_bcm7271.disable_dma=Y".

Shouldn't that be on a per-device basis, and not a per-driver basis?

And why would you want to disable this, if you have support for this in
the DT?  Why not just rely on the DT setting?

thanks,

greg k-h
