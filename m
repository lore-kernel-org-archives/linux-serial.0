Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91263C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4878164F08
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhBXQ6V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236047AbhBXQ6J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 11:58:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B55A64F04;
        Wed, 24 Feb 2021 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614185847;
        bh=Hy5dPjf0+Vk3tQipNAqBIMu+GJJIqEe1zsbcDtM0J40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCWReqDv90DST5/wTV96RP88hQyun59V6pAd1BBrNrlgvsb+KXjLtGN8uDbaq1m37
         NEZ3DyGp1/0puv+0GaP62+TSJLcVAvtTFsjWatiC1OpbINopBH35akPn7NoyfVI/tF
         vzNv9YYjYQuQ5qZy69mpyDhPuh8pw32YFN4okMHJvNoQzooZjwtQVkljNKlq21cwit
         SyVc+h+PKyXC45v7HxLVkMGA8ufKJaplUg8UDwcNm5FolHZH4LmLU0NGBTXa7Gvea/
         +VUPPKA/vkIo1NBC7XLwi1pw6m5+YwhEmszohIdrWA33t5Xs0NaC9VjiySEMYN0Vkm
         zG37wUoYQ24Rg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lExTu-0006k2-B7; Wed, 24 Feb 2021 17:57:47 +0100
Date:   Wed, 24 Feb 2021 17:57:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: closing serial device dumps data in buffer
Message-ID: <YDaFiotE0OxCE4JF@hovoldconsulting.com>
References: <23e9e8aa-1f6f-47d3-6ad4-97057e4975f1@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e9e8aa-1f6f-47d3-6ad4-97057e4975f1@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 24, 2021 at 09:23:45AM -0500, Michael G. Katzmann wrote:
> I've noticed that when the serial device is closed, the USB serial
> device dumps any buffered data. Is this expected behavior?
> 
> i.e ls -l >/dev/ttyUSB0 will not print everything (I'm missing some at
> the end) but
> 
> (ls -l; sleep 30) >/de/ttyUSB0 will print everything.
> 
> (this is at 110bd so it's probably longer than most people will see to
> drain the buffer)

Depends on the driver unfortunately. I guess this is with your PL2303
for which we don't know how to determine when the FIFO has emptied.

For speeds >1200 Bd we instead wait for the full 256 bytes to clear, but
we don't add 23 seconds to every close at 110 Bd for example and instead
cap the drain delay at 2 s (see tty_port_drain_delay()).

Johan
