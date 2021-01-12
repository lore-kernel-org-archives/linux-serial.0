Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD3C4332D
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D67D23109
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392988AbhALK1P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbhALK1O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:27:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA0123109;
        Tue, 12 Jan 2021 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610447194;
        bh=ryhCQv8eVrVNeqK5clAMBRFTzJ4fSC4rPww2yGJmDSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmdVOqNnKfjR4p1cC+yIibA4jrFc6UxE983zY5Zc1KnzLGwHkiChODRcmvamELmlI
         x5dkKVIi4fG7WTia4rKVgfiWry3bQOdmrZBff407TX80ShCfH9BwtusXqk/YL5zMuR
         9Uuu/uFaK5x0RPvz9dLnRZHjaWn7HWadx8n8z2RA=
Date:   Tue, 12 Jan 2021 11:27:43 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Jozsef Horvath <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] Serial: silabs si4455 serial driver
Message-ID: <X/15n3lOU6F0GMPw@kroah.com>
References: <20210112101857.GA13976@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112101857.GA13976@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 12, 2021 at 10:19:00AM +0000, Jozsef Horvath wrote:
> This is a device tree schema for serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Guide: Documentation/driver-api/serial/si4455.rst
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>

You sent 2 different patches, that do different things, with the exact
same subject line.  Please make your commit messages unique, we can't
take this as-is.

thanks,

greg k-h
