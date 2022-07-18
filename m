Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78302CCA487
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jul 2022 14:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiGROQX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiGROQM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jul 2022 10:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2738BE;
        Mon, 18 Jul 2022 07:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FBFC60A5B;
        Mon, 18 Jul 2022 14:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B314FC341CB;
        Mon, 18 Jul 2022 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658153769;
        bh=enx8mInxZehWuply8x2Bfea4HxGgwGZeH0Vaz5tQzdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkMQw4Db9y35qqBBul2/4ID2kreLQo1VXySvkFInutplGNpGVgBJDCWkpNdMNmv6y
         SwSran9JseFoRmXfv8CPWfS3kdkXDDLFNpsekmA9RZa71lNdJzx30VKmgp8yOP+VKm
         9VVhoXHBP/V/anyOXcKks+5GCHv9YvIWHqwPRYwEJprQzCVxgnap83W1UPj3eEbd8P
         J3M7qBduJJzVRNKnSPp8DgkclsHMi0LvjiqPAYXweO83IumcGh0I/gTwKrp7SCRKN2
         GCFu57H2R/TR+uQ5rTsgRSqEw6TymjjcOK7RBMl+Dwpfj8oupIvWngDlVWrd1Y9He5
         h9Nl7R4QCQkYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDRXX-0005Jo-Uq; Mon, 18 Jul 2022 16:16:04 +0200
Date:   Mon, 18 Jul 2022 16:16:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtVrI6FRZRKKALPN@hovoldconsulting.com>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 18, 2022 at 10:53:06AM +0200, Johan Hovold wrote:

> From 82faf260d13c9f01e4af664f31231e5d88d7e4f1 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Mon, 18 Jul 2022 10:21:41 +0200
> Subject: [PATCH] USB: serial: ch341: fix disabled tx timer on older devices
> 
> At least one older CH341 appears to have the TX timer enable bit
> inverted so that setting it disables the TX timer and prevents the FIFO
> from emptying until it is full.
> 
> Only set the TX timer enable bit for devices with version newer than
> 0x27.
> 
> Also try restoring an older init command before updating the line
> settings to see if it has any effect on a lost first byte after
> initialisation.
> 
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Link: https://lore.kernel.org/r/Ys1iPTfiZRWj2gXs@marvin.atrad.com.au
> Not-Signed-off-yet-by: Johan Hovold <johan@kernel.org>

s/TX/RX/ ...

Johan
