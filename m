Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F0C433E1
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94F820702
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pbWZz4Uj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBaCFEQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGANX0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:23:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49867 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729429AbgGANXZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 09:23:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1258E930;
        Wed,  1 Jul 2020 09:23:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Jul 2020 09:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=6
        rNUI5M2oHvYYxJu4ZtiQM3bf36JJktzvLBcnLGssk8=; b=pbWZz4UjYj51fQuRG
        DNBikQM0IbHnF4MFdLnABLW+LA62kHXMhVR56Z48sbbJ0V1icgWY3ncXz9NFpFa0
        nk0/KCAXU3Hwuz9HfCgrunVSQS7/e04qZg7mV7ZwyEP4GaP4YaF7ivBoiieM0j6P
        rKnxQ2f6QyD+CXIBlj4Dyd2jSqvE4iyQIcaq6fmC70Bxf5Nnod8df95h8aCZS2Mr
        UVPW5CRQDAC0Ea2U/4U6gH0xpjMq52f1ExpUTI7MjdDg+xH6hfHEPCEyjJJtAPO9
        D3/17Q8wwOsUdPqCHzYUEwXVl/PfeQon8dOT3zK6G9g/OSCMbRFT71Y+cxJh7gL5
        RsMYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=6rNUI5M2oHvYYxJu4ZtiQM3bf36JJktzvLBcnLGss
        k8=; b=SBaCFEQ+1gD14GaOw0QaVZUUucZz2JlBJv6MK6/8lbTRGuIT2F2sLfNi0
        BaKErW7RGE/UCCir1XNB9DedSmqu2M74vLQg6G/5Mmqgga9KowFHD5FYezBLOiTi
        mYyWrvvoFTHEAWYEHWxQ6zlezCWZzVcaMsgGLP3zr4COEwFIFFa9cndnMl/WpEiV
        uTL4ZyS3uOm62BaKPsk2u9uJsA9NZZ3YIhQKZjLwBTZ1WEkLhRKjsXVxNGg4PcuH
        jmGazWs3plbdZB6ggC94UAcex4nvVyBc0QkvOJsS1Kg8xf1pU8G+4hMEYFdJUd2i
        t0fdpsiZ1xnYNPTL8zvhcaBAniN2Q==
X-ME-Sender: <xms:S478XnlXgAf5Wqwsj_Yr1dMxLjrs8IjXI9zmrqEezL9Nlsry3VL7cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuheekhe
    elffefieduteefkeejffdvueehjeejffehledugfetkedvleekudduvdenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:S478Xq0Qvlkc8x5Rroze6XETho-4u-EK7ktSIRxYizofP3zaeWho4w>
    <xmx:S478XtrfxFUSOjyn41xsL0D4JoCr56Tpm6DYtbrg1p4PrgvLYYqmwA>
    <xmx:S478XvmXzBPTPAdNBMXa3KqdiRK0WCyQtPKPtl7u97gPH1rNxa4iAw>
    <xmx:S478XmDYrAX62097yMWwgADcMLYN3MXB8fMsL1_VdTTG-NoiacDKtw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D2293060069;
        Wed,  1 Jul 2020 09:23:23 -0400 (EDT)
Date:   Wed, 1 Jul 2020 15:23:09 +0200
From:   Greg KH <greg@kroah.com>
To:     Egmont Koblinger <egmont@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: PROBLEM: tty devices with future timestamps
Message-ID: <20200701132309.GA2362785@kroah.com>
References: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
 <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 27, 2020 at 10:33:38AM +0200, Egmont Koblinger wrote:
> Hi,
> 
> An active terminal line (/dev/pts/N), in about 6% of the cases, has a
> future timestamp.
> 
> I noticed that the command
>   ls -l $(tty)
> occasionally prints the timestamp in "month day year" format, rather
> than "month day hour:minute". This is what coreutils's "ls" does when
> the timestamp is either 6+ months back in the past, or is in the
> future. Let's test the "in the future" hypothesis:
> 
>   ls -l --full-time $(tty); date +%H:%M:%S.%N
> occasionally produces something like
>   crw--w---- 1 egmont tty 136, 8 2020-06-27 09:57:28.686473296 +0200 /dev/pts/8
>   09:57:28.170717548
> Yep, the timestamp of the tty line is a slightly higher value than the
> system date at a later point.
> 
> Running
>   ls -l --full-time $(tty)
> in an endless loop causes the seconds to increment in steps of 8, but
> the subseconds part remains unchanged, like:
> crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:12.686473296 +0200 /dev/pts/8
> crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:12.686473296 +0200 /dev/pts/8
> crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:20.686473296 +0200 /dev/pts/8
> crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:20.686473296 +0200 /dev/pts/8
> 
> drivers/tty/tty_io.c : tty_update_time() seems to be responsible for
> this jump in 8 seconds, leaving the milliseconds intact.

Yes, that is way on purpose, as the comment states, this is a security
issue that we had to add.

> I think zeroing out the milliseconds in this method would solve the
> problem – although then it's maybe inconsistent that at creation time
> the device would have subsecond precision which would be gone soon
> afterwards. Maybe it's better to create the device with no subseconds
> right away? I'll leave it to you guys to decide.

What is this "problem" causing today?

> I'm experiencing this on two different machines with Ubuntu 20.04,
> using their 5.4.0 kernel. The method setting the seconds but not the
> nanoseconds is still present in latest kernel git.

Yes, this has been fixed for a while now, it should be present on all
modern systems so that shows they are working properly :)

thanks,

greg k-h
