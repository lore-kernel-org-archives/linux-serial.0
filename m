Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB3ECAAA1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Aug 2022 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiH3Lhx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiH3Lhg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Aug 2022 07:37:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602ACF7B2B;
        Tue, 30 Aug 2022 04:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 651C5CE179E;
        Tue, 30 Aug 2022 11:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A539C433C1;
        Tue, 30 Aug 2022 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661859310;
        bh=4x1wLad4lxqLcbPeEX3pXTHar7BXU+tX9ogUCdd1sS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l08TrNv4ZslTuo3zNpM5NDtTTcdAPtKu64zQnnDDfiqMo6RUICldc5ojANYH7aPRT
         pN8xYy5oyeusKKIGYzK1EWG/at5VoW+uJbj7lPjAG8gop2o+oeoDTeUw6EprOQg0Va
         QmyTDvfXr89f2sznYUbZjRV7fVzxWlGnOLuBUgtI=
Date:   Tue, 30 Aug 2022 13:35:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tuo cao <91tuocao@gmail.com>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to
 spin_lock in interrupt handler
Message-ID: <Yw316/3zuIXvm/Ty@kroah.com>
References: <20220822141110.17199-1-91tuocao@gmail.com>
 <YwORy3QMbRUSlBZE@kroah.com>
 <CAEVeK2AiYFK9eopn1Uzp+osA-j22e1KbfUohJ+hRVmLNsq0gpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEVeK2AiYFK9eopn1Uzp+osA-j22e1KbfUohJ+hRVmLNsq0gpQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Aug 27, 2022 at 05:42:19PM +0800, tuo cao wrote:
> No, whether it's spin_lock_irqsave() or spin_lock(), the security is
> the same. Since this commit:e58aa3d2d0cc01ad8d6f7f640a0670433f794922,
> interrupt nesting is disabled, which means interrupts has disabled in
> the interrupt handlers. So, it is unnecessary to call
> spin_lock_irqsave in a interrupt handler. And it takes less time
> obviously to use spin_lock()，so I think this change is needed.

I have no context at all here, please never top-post :(

And have you measured the time difference?  Is it a real thing?

> Finally, I'm sorry I lacked real hardware to verify it and can't
> provide changelog text.

Try to never do changes for drivers for functionality like this where
you do not have the hardware to test for, until you get a lot more
experience.

good luck!

greg k-h
