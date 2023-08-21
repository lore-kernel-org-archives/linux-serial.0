Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D1FEE4993
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjHUQZs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjHUQZs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 12:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9AFE4
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 09:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A200961CB1
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 16:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FFAC433C7;
        Mon, 21 Aug 2023 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692635146;
        bh=3UO+z78ptHRLZ1tXSVeri9gfPcYBoNYDYFY3dbZLpZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eexYYT5kclO/3+Io/o2amHPmuORpMjnQOW0r1Hbk1EMY1cCD5M/J32x3xeYDN33JW
         vjFOAb4P/bzDTLKtf0fDpUlXLt4u/q/UcJVdQjJX+Aeo3L8eMKzbwcZL/kcCl69ftI
         7GYPqPL6At8RQmAl2f/uMO/3DZZXEtSnE7vhbWkc=
Date:   Mon, 21 Aug 2023 18:25:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH 1/2] serial: exar: Remove Sealevel 7xxxC IDs
Message-ID: <2023082147-deduct-absently-186f@gregkh>
References: <687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 21, 2023 at 12:06:17PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> These Sealevel 7xxxC IDs are no longer needed because we (Sealevel) will
> be releasing the cards with the standard Exar hardware IDs. This is due
> to the selected IDs causing unexpected behaviors on some Windows systems.
> 
> Reverts: 14ee78d ("Add support for Sealevel 7xxxC serial cards")

If this is a real "revert", then perhaps just do that revert instead?

Also, as per our documentation, you need a sha1 a bit longer than that
:)

And "Reverts:" isn't a valid tag, perhaps "Fixes:"?

And meta-note, your patch series was not linked together, how did you
send them?

thanks,

greg k-h
