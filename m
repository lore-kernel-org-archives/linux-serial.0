Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C20C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC2C6121F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhDPOTp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244534AbhDPOTn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 10:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0BF8610FC;
        Fri, 16 Apr 2021 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618582758;
        bh=A9Vvto/6OhGROCoV+7ZsOSkuzEhZQRWE4HQRxbVwIu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQc4JsQ7f/SPtT6OtR3zGEJgP+yxum31zvmgJhgUCkZ7vpCApDe5lKQNQWaVWRwfz
         HW8MO7qMQW6PU6avCC/2934Aa2WCx0zSGDjyr+ZpjEfgotKnqdgXNxXSH/L6vLn+Ka
         uXTy5tUA7NRYGksChP6Q3usNPjcpYnq8UkmBkTZR4o2P35OzlKKbYILzvALUMFICpT
         Hxn6z1a7OuXYg6mBsiweyG42RLdGHqyF5yBZ+ALBJb3dCuF/1ChnEPdUnmN/xztYm1
         J09DAWxdhyaV6V8sWFm9NQmdsdL1rmunX3YmpTzlF9sFdDjNsa20lEuANWl0PlwS6e
         gcqr03oEz/Z9Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXPJW-0006bT-D0; Fri, 16 Apr 2021 16:19:19 +0200
Date:   Fri, 16 Apr 2021 16:19:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dillon.minfei@gmail.com, Erwan Le Ray <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>
Subject: Re: [PATCH 2/3] serial: stm32: fix threaded interrupt handling
Message-ID: <YHmc5jkAXC95HVIp@hovoldconsulting.com>
References: <20210416140557.25177-1-johan@kernel.org>
 <20210416140557.25177-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416140557.25177-3-johan@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 16, 2021 at 04:05:56PM +0200, Johan Hovold wrote:
> When DMA is enabled the receive handler runs in a threaded handler, but
> the primary handler up until very recently neither disabled interrupts

Scratch the "up until very recently" bit here since the driver still
doesn't disable interrupt in the device (it just disables all interrupts
in the threaded handler). The rest stands as is.

> in the device or used IRQF_ONESHOT. This would lead to a deadlock if an
> interrupt comes in while the threaded receive handler is running under
> the port lock.
> 
> Commit ad7676812437 ("serial: stm32: fix a deadlock condition with
> wakeup event") claimed to fix an unrelated deadlock, but unfortunately
> also disabled interrupts in the threaded handler. While this prevents
> the deadlock mentioned in the previous paragraph it also defeats the
> purpose of using a threaded handler in the first place.
> 
> Fix this by making the interrupt one-shot and not disabling interrupts
> in the threaded handler.
> 
> Note that (receive) DMA must not be used for a console port as the
> threaded handler could be interrupted while holding the port lock,
> something which could lead to a deadlock in case an interrupt handler
> ends up calling printk.

Johan
