Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3781CC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 06:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A8E61139
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 06:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349104AbhDNGUd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:20:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59995 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232405AbhDNGUc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Apr 2021 02:20:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 43F485C019A;
        Wed, 14 Apr 2021 02:20:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 14 Apr 2021 02:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=H
        0U03xK5NRaZr/bZBdPoyVzgRiytQYFFtvFpXb78Sj0=; b=EytgMTAkG0+RMusSR
        /Hl7Kn/rC0MmCG5cJBMumZDZOAbnIELqSi3ABI/lru0XJAq+Y2cdpSpxPFsGm11X
        IKVfKu6RIR5iyN5T0t7qj5jxnrVywEeX+ZUVMQlRNODhieMN7LhiG0hd9+igjrBZ
        q9bDSnu+UxGxbQkQyRHPsQ4+e1vA888+xg6MTNKUEFLBYxKPoe6mjRGht0+ad4ha
        4SBqvcw/CL3D7vTqZXSu8quOfszmAHP47h69yuwo82oZzmnGP1Z71UsbZXSVf9Qe
        Ia82ch0qFawW5ncU/aeDhvpg95YbkVgQk4MQ+SF54wWnPgodt/u2emS+pQB+KLOt
        F3GWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=H0U03xK5NRaZr/bZBdPoyVzgRiytQYFFtvFpXb78S
        j0=; b=GeQAh0Gk6o17yxB9koiUP9DPNZdQaQw5K8OLSWX2uMtgc0GLWZH348mXc
        MDoD2auoZCjNrrjyhFDH0CilX7v447DO0VCLHDwKvDRx3JmCCf7W6YubhWow8/G/
        VfyFewW3bcYqokm9ETVil5o5E6J/AwmaG8kalgfKrmbav4RVBFKKOQpn48xdAY93
        qSTZjU4xMc8GWyJF03yuJJG2+Kn8GGNbAGAQ4IPJ2aPqwQI3i4Z+rrpkKjPYqFUO
        ysBXAWkM2DPOsQYBvGv19NsXyfz1+l85JqQwH2gKmHK1UExQ40ZJg/+Zm7zaJnL6
        QGKwZNt+D5Z3LwP22B0S3jWLOCuAA==
X-ME-Sender: <xms:mYl2YJl6oS1W0WzLQEqYxRRvsGGFtrqNops_NPmgdozd5dzPPDOIsg>
    <xme:mYl2YEwqaJ1s7xQw_wMTH7jKK6cr5xScv3OertwfgHWhGZr3m7uL-H-9nURlivRxy
    YJaq7gDLiidbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeltddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhe
    ekheelffefieduteefkeejffdvueehjeejffehledugfetkedvleekudduvdenucfkphep
    keefrdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:mYl2YMg_jyLCrJRSeujLB1CwsnsCnVSIH4la6YePhGaRoiaQyHa6YA>
    <xmx:mYl2YBXFVmgyiZbtutKdNFqOwzuut_RDW4rLxK5svHKKZx87RRxSrA>
    <xmx:mYl2YG3RXVbEjFGk22hLac5SVngzmZz8IqRXGd3GJ3aJb-e3E7uOxw>
    <xmx:m4l2YMCM_i650-VdpxTLG6BVdQZvRo66TtRynmsAhecprTnhZzLdKg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82BF3240054;
        Wed, 14 Apr 2021 02:20:09 -0400 (EDT)
Date:   Wed, 14 Apr 2021 08:20:07 +0200
From:   Greg KH <greg@kroah.com>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "a.darwish@linutronix.de" <a.darwish@linutronix.de>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: A data race between tty_port_open() and uart_do_autoconfig()
Message-ID: <YHaJl8vwvE1FsV2T@kroah.com>
References: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 14, 2021 at 12:17:54AM +0000, Gong, Sishuai wrote:
> Hi,
> 
> We found a data race between two tty functions tty_port_open() and uart_do_autoconfig() in linux-5.12-rc3 and we are able to reproduce it under x86. In general, when tty_port_open() and uart_do_autoconfig() are running in parallel, uart_do_autoconfig() may fetch an out-of-date value of port->count and enter into a different execution path, as shown below.
> 
> Currently, we haven’t found any explicit errors due to this data race but we noticed the developer has used lock to read port->count, so we want to point out this data race in case this is unexpected.
> 
> ------------------------------------------
> Execution interleaving
> 
> Thread 1					Thread 2
> tty_port_open()			uart_do_autoconfig()
> 
> spin_lock_irq(&port->lock);
> 						if (mutex_lock_interruptible(&port->mutex))
> 						…
> 						if (tty_port_users(port) == 1) {
> 							uart_shutdown(tty, state);
> 
> ++port->count;
> spin_unlock_irq(&port->lock);
> 
> 
> 

Can you send a proposed patch for this to fix the issue as you sem to
have a reproducer for this that you can test if the change resolves the
issue or not?

thanks,

greg k-h
