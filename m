Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B7C54EBE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjALSYN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjALSWG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 13:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245458D03
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 09:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07EAD620E6
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 17:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D08C433D2;
        Thu, 12 Jan 2023 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673546243;
        bh=4fREWKs39x0OpV+BpNa4fj8zgSJ2BT7scxPi54dQkTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0s9aydO4tD6/ABWiCyVNGM4KqorjqMLHeaViHcQfFOQ6QW2lXyPq5BeUf1WVhla8
         p+rJFycJ1MmhO4qVkHN8Ih0lIrCbpn/OKKUhpuZDourB5XoTYdmqg2VlzRL38edNqE
         iirymmiTilxdy9EsNz9iZWTZL8DKzp6oTZq256B8VBGyptJb+UGyDWFyFeFOQgmsE9
         yPOaCpKwL9756Zj2/NPD67y7Gb9WU/qinc6n+nymLg1smJPN0zXmysNJwzCPqM7j6b
         duxgEysI6+6Q/JjiNOO5ZhdvR/JFFaYX0s/Ov75kIXL788t/Eft4KXKIB905bLkWzA
         NcmDn6uibGOWQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG1pS-0005ef-6w; Thu, 12 Jan 2023 18:57:30 +0100
Date:   Thu, 12 Jan 2023 18:57:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y8BKCka8vZocuz65@hovoldconsulting.com>
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
 <Y7vou3wAeLP4X+TY@linutronix.de>
 <Y8AHaJIttNga68q4@hovoldconsulting.com>
 <78e3f61f-4f87-9ac5-7c7c-172714da69d3@denx.de>
 <Y8A+1wUUNCU+3Kry@hovoldconsulting.com>
 <c2f69d59-7c10-53a2-44d3-e3d274da0892@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f69d59-7c10-53a2-44d3-e3d274da0892@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 12, 2023 at 06:50:34PM +0100, Marek Vasut wrote:
> On 1/12/23 18:09, Johan Hovold wrote:

> > Fair enough. And it's not obvious that the stable team should backport
> > patches that only concern PREEMPT_RT either (e.g. as parts of it are
> > still out-of-tree).
> > 
> > The stable tag is still missing from the final revision though.
> 
> Please pardon my ignorance, which stable tag is missing ?
> 
> Can you maybe just comment on the V4 and point this out to me ? I'll 
> send a V5 then.

It's gone from my inbox.

But as per Documentation/process/stable-kernel-rules.rst:

    To have the patch automatically included in the stable tree, add the tag
    
    .. code-block:: none
    
         Cc: stable@vger.kernel.org
    
    in the sign-off area. Once the patch is merged it will be applied to
    the stable tree without anything else needing to be done by the author
    or subsystem maintainer.

A Fixes tag only indicates which commit introduced a bug, not
necessarily that the patch should be backported to stable (even if
autosel is likely to pick it up these days).

Johan
