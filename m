Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4729C4332B
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1420658
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lovelett.me header.i=@lovelett.me header.b="bmd3/9rY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9xMPSrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCWNAV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:00:21 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58377 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgCWNAU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 09:00:20 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C4435C0260;
        Mon, 23 Mar 2020 09:00:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Mar 2020 09:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lovelett.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        y5dyV9Jkel23wanPa8CEp8yp24Kh75DKcIFeFIRvmAI=; b=bmd3/9rYvbiJte6c
        wQACmM/qVscbjbjmgWZEbuw8W2R76Xzm2ubpIvGFjYdJSowq1r3hr8h6sIQGjsjz
        vVa8YtT01wjrA+vf/c3bJB/aiFd4lO1bSpWz5PDsxNaAMTlBGclXHTXhR/Jma6rx
        /RLtExB5vozG/f+BRkABNEYdd+KIJ4EN5PTdWcVCLOT/MQFx2wx6hyjawqvPdLRe
        jPMANR4r1MceVwYFEMtd2lsLGrI2myTQBzes5VgbgMs8WqB56Fd59vNsTTlzhR6r
        4ugLn3BIYaAxMeYhPao7fUfvMucbhlbd50KWuT/LyP74Vr/3BpXCCBtvcsCBmlV7
        CQ2ndg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=y5dyV9Jkel23wanPa8CEp8yp24Kh75DKcIFeFIRvm
        AI=; b=R9xMPSrIllpODp+lfMzH6S7ryunkAbzQkXFAR23YP12Dy4uDASWzxvBOD
        kthc9IpQhHv2WvOWxPVeb+goGFJoxzwRDJM4/qP+Cxb9n9z1Wqn2z4kljqjovRqv
        tX5iBSxEE9WzzliVMR4QkCirpF9BbEUy+2hNj67gjsf9K3XeUyZzxkIixaJM4HO9
        6mE5Z2Oiq21mxdaTzwAHQmFJWeYrKHLBTOr9aX6vCl/ruK4/K2z7X6inwGD4cPnn
        +WYX/dSB0Bvvrx+iumwj8tG7phqBqUALUbbKOF7MV9qYOdhUbVZqjGISZZc4PO7a
        /SVwjBJGvObfltk9QvB14l9iKVYtA==
X-ME-Sender: <xms:47J4XqYMPdFACJ_AmxoIq2nc3VqNVw1o9T5E_HKJlQpdtgxvGqVXNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfihrghn
    ucfnohhvvghlvghtthcuoehrhigrnheslhhovhgvlhgvthhtrdhmvgeqnecukfhppedutd
    ejrddugeehrdduheejrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprhihrghnsehlohhvvghlvghtthdrmhgv
X-ME-Proxy: <xmx:47J4XvZMAFEQIkY0fafMTIRQJ4D1slG5hn9EnI1Jtj9UD1F0qqONVg>
    <xmx:47J4XtwfQsoW3dxVzarGlp051D89i5THwEIvabvfXVXjeaRN4ZdQQg>
    <xmx:47J4XkilcG_zdx_vh9GH08JaBnfjjvH458DYIxg2T1_lDfQhR7d4yw>
    <xmx:47J4Xho3u0i8RfPf0eiEC4v5uquMZL_xa9nFONZ7tSiFamGR6ID4Cw>
Received: from linux-development (107-145-157-103.res.spectrum.com [107.145.157.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA4043280067;
        Mon, 23 Mar 2020 09:00:18 -0400 (EDT)
Message-ID: <f61ed3ec22676bd6580f9c7adae5504c8e8bc115.camel@lovelett.me>
Subject: Re: FT232H user space GPIO device
From:   Ryan Lovelett <ryan@lovelett.me>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Date:   Mon, 23 Mar 2020 09:00:17 -0400
In-Reply-To: <20200323065211.GD129571@kroah.com>
References: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
         <20200323065211.GD129571@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 2020-03-23 at 07:52 +0100, Greg KH wrote:
> So it sounds like you have the wrong device type.

What makes it sound that way to you? The priv->chip_type is returning 8
which according to the ftdi_chip_type enum in ftdi_sio.h is the case
for FT232H. My layperson understanding of that would say that the
chip_type is being detected correctly.

I want to be clear, I do not think your wrong. Clearly I am wrong and
drawing the wrong conclusion. I am just trying to understand how you
know I am getting the wrong device type because it is not obvious to
me.

> Can you make sure you use the latest kernel release (5.5) and if you
> have problems with this, email the linux-usb mailing list as the
> driver maintainers for that driver are there.

I am cloning the kernel source now and am going to start compiling it
shortly.

