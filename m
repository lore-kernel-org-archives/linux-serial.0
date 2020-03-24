Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F6C43331
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3CB2080C
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 12:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lovelett.me header.i=@lovelett.me header.b="cxi3UFkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tncce4ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCXMiH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:38:07 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41253 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbgCXMiH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 08:38:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D82DBF42;
        Tue, 24 Mar 2020 08:38:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Mar 2020 08:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lovelett.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        zxmQtJEy3onbx60uqi63IpXsNE7j+ulY57PIY0yRJXc=; b=cxi3UFkDWeyMw8f5
        fswDU+FNFd1e2bRucdeoCG2AiuXl2z3eCKzmnz4D5HiAwKKGuIpGjMhuwN5dl4WC
        dd6oTDGuJ5D3XrOjfYyWph3Lv5GgTC6x2cEwjwy4Zh74L5bCT3/wBBtYIGb0Vptf
        /m6dUbHBdh2MwdvORYTtyL3eiO/opB/Fwz4FzgwvD7GxJbr9RGPVPYdY3507xTwx
        NKUPc33lEdw7sDnUJnd+Vf5uVGIUguS1pbeH9xoQPCu/ioA0A8vCXEQw/e1DTlnN
        E6fcysyDFn4tppMYQynwFyqpYdJkZF2sWmT9ohB76NneKWDS0M8tzH0b6pZPTqjS
        qdzYlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=zxmQtJEy3onbx60uqi63IpXsNE7j+ulY57PIY0yRJ
        Xc=; b=tncce4ranQjQtBrMCHjphoLRIDI56vMTvx1cax0tnohf39LyqXVLsCGYC
        KP6/zrrzf0l2CDnodeMQkbbHzDxspEt2oK+7dPiUnJjESWgtrlO8B0fWzruP1bOj
        PL2hlPiZfghIr+LsHb8QtNBv6w77oeYIUyMkKYpGbiqbQ0tYxTdh+OIdFFFiR3Td
        GZU7SdQcSeFUy/ZfdgWDNQYOYvYNGU3flYicEBzHzsdANXDdUW5hk6Rn4EA6sRPn
        200DeHPP9OT4qcLuxjewpZUDBWOqJiFaJHh/5CUdWMsd7NB3QgL8rNaCBEAetmI8
        FhcVFlXlgKTZPx5OHlkQubx6x+aWA==
X-ME-Sender: <xms:Lf95XrEIwnwALzWt-hLF2-L97yOKHXWXs9P4NkxQpgWRMpCNrT1-Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfihrghn
    ucfnohhvvghlvghtthcuoehrhigrnheslhhovhgvlhgvthhtrdhmvgeqnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhenucfkphepuddtjedrudeghedrudehjedruddtfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrhigrnheslh
    hovhgvlhgvthhtrdhmvg
X-ME-Proxy: <xmx:Lf95Xm33HtOL5BUoW2ezPJx-5jQ_2TZPVeofopq2MedR3JIgIXFUJw>
    <xmx:Lf95Xj9j88rBXss9ZEdwyfQEEA_fqi7fW5RlT9WeDcf5Or2PUHosjA>
    <xmx:Lf95XpEnRga3CaCuAjInyld40U8ISMIUJ2WK9K72Gj74RlUDqr288w>
    <xmx:Lf95Xky7LpJkWq0GNyqSQJaZPi8k2MwV9tflZiJUsCnxXTSLrn7diQ>
Received: from linux-development (107-145-157-103.res.spectrum.com [107.145.157.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9C7F328005E;
        Tue, 24 Mar 2020 08:38:04 -0400 (EDT)
Message-ID: <c06292e8112544883f8da59f473854fa0b880644.camel@lovelett.me>
Subject: Re: FT232H user space GPIO device
From:   Ryan Lovelett <ryan@lovelett.me>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Date:   Tue, 24 Mar 2020 08:38:04 -0400
In-Reply-To: <20200324092839.GC5810@localhost>
References: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
         <20200323065211.GD129571@kroah.com> <20200324092839.GC5810@localhost>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2020-03-24 at 10:28 +0100, Johan Hovold wrote:
> As Greg suggested you need to update your kernel as GPIO support for
> FT232H went into 5.4.

I did as Greg suggested and went to 5.5 and everything was working. But
with this hint I was able to find the actual commit that added support
[1].

Thank you all.

[1] 
https://github.com/torvalds/linux/commit/7a786b84790789eff5bad49e3f6c15f75b7bf691

