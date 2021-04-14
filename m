Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF8C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72569611B0
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 15:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDNPJe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:09:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38915 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348330AbhDNPJT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Apr 2021 11:09:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 019575C0110;
        Wed, 14 Apr 2021 11:08:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Apr 2021 11:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rWfc6JJc2pOLKMfFdnZ/P3aSKVa
        D6tf1BqNFFrl/ZWI=; b=gYyxk5qgtg7ngvRl6aNkTWHhI/8TCHYpM6imZYlncLK
        rRBcwxEOzCq2woxUfLKFN+/+VIefM6uSvns3GNfkWawlH4YaewpazCEPvcTEx6WE
        RElQ8dCHa63bLe9+mGZN3eGaoH1mJZq7eGx7ra/4eFpK7qmGQXl1pDsGA8VWEfRI
        /Lo9Xd02HiB+nr8Ebp5X929yLsxy6nv5gTt2AWTn/Gr0X6+RYxKr+BGCwsQqXASQ
        7lpTERyTGRZBuSJzYzT6Ryz9KY/Pth6R/sga8ZSMYLuSTpt97XDakvoc47Ab877b
        D+Szd71XPSRi6wRIxizmsr0Kf8laQmYIfdA6+YGA/dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rWfc6J
        Jc2pOLKMfFdnZ/P3aSKVaD6tf1BqNFFrl/ZWI=; b=d1tKrGCMHuxKAeyj9jHHxR
        TphTThteRDbX0VZSn08ZQh+93IsEK7auLXn3zhg8TNtsoknpCVJojXfRWpUeEmgb
        HDoHMHW82FrnwhGp0nfiXfXTtBA3EdqwIXDTnCZrquu4EKa4LwmcHIjk/udOcgcl
        NgLMn6jHrAqrTqyH65mE9sqbNUmjVmRaSXaV7zYKgTIUP2yOtpSC4oq/0rtf1OnF
        s0vw+FaRV8R8BdJdQv8x4L6jiVqniin+SJbwL38KHamLYEaWLT0rL4rixNji5KBp
        TX13KCN6ZrgnjrrQeZdT782VyVigzMr7exPKxt9Y+VMH6P7DmkfD955Qly008myw
        ==
X-ME-Sender: <xms:hgV3YMnHD3DfWviPOpnDKfJUQxKpTxR6GW8AgCCwpRNnVZx10SSHfg>
    <xme:hgV3YL3CeKeacP6h5krgS2RvEkGk5OQ5U3z7yhMTnus46hAtuHrZLHre8QWDwB86v
    60XfMkd8HQBtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeefueejle
    dtheekueevheehudelgeelkeetiefgffellefgfedtiefhteejfeduteenucffohhmrghi
    nhepfihikhhiphgvughirgdrohhrghdpuggrrhhinhhgfhhirhgvsggrlhhlrdhnvghtne
    cukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:hgV3YKoQ_TBgy-E8Bd3RDliAp5r6380KUpK7comgndxQUWtf6c4pUA>
    <xmx:hgV3YIlAVEbosfwiz0drGZU4x84tNXvbTUuwA9X9zNuWx43EiVPMng>
    <xmx:hgV3YK1UaixlMU1DEtw9MAAahcu8-rIBtejDVe6Ta7QrC4H_U6q8_g>
    <xmx:hwV3YPxhExSY1HMwn1YoRvJGuhoEdA0PRVP7xvPRnDfqAS5voqhgIw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 870F9108005B;
        Wed, 14 Apr 2021 11:08:54 -0400 (EDT)
Date:   Wed, 14 Apr 2021 17:08:52 +0200
From:   Greg KH <greg@kroah.com>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "a.darwish@linutronix.de" <a.darwish@linutronix.de>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: A data race between tty_port_open() and uart_do_autoconfig()
Message-ID: <YHcFhJ1EEs9F4As9@kroah.com>
References: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
 <YHaJl8vwvE1FsV2T@kroah.com>
 <26D4F25A-5AED-43B0-8527-54A1C1E1F35F@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26D4F25A-5AED-43B0-8527-54A1C1E1F35F@purdue.edu>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Apr 14, 2021 at 02:35:24PM +0000, Gong, Sishuai wrote:
> For now we are not sure about if this is a harmful data race or not.

Can you please work to determine that?

> A potential fix could be using the same mutex lock port->mutex instead
> of port->lock, to protect every write on port->count so the reader can
> get a consistent view. However, this seems to be a big change so we
> are wondering it is worthy of this change.

Try it out and see!

thanks,

greg k-h
