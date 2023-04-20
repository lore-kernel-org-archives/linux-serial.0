Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F8C77B72
	for <linux-serial@archiver.kernel.org>; Thu, 20 Apr 2023 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjDTLit (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDTLis (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Apr 2023 07:38:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4CEAD
        for <linux-serial@vger.kernel.org>; Thu, 20 Apr 2023 04:38:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 921345C0184;
        Thu, 20 Apr 2023 07:38:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Apr 2023 07:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681990723; x=1682077123; bh=J+
        606rOXxsuiMhT8G+OyCiSalvoR/fuvBBQJvB3Dksk=; b=WRiTk6gXmPdAIabhaQ
        fmx+xSqnM8c0HOcMUzxkcMnwaqCiO4dsmqdGdv1Zupz1uuYtry2s0g/25NkxMZjK
        /Ym0HgPn+E/7IK0KVIECfyoMPmDe8VWXQg/PSW2txPVJM09rJNP17A5GSD7oOMYC
        RSyF4rcaxd46429eN6+K9VZLSth1xUabN2tpjrB0wAByTpXukEzJcctEWuDK656f
        CoJ2KX5LdHk++sbL2v1sMyocXV4TY+//goJgk/duei1vD6V/sd92K2rgpN/Xrdt1
        z0Dms07/vFKNNHwLb2zMAjYLO61JUYuKUDAk7310A8Aevr1edcpqoD/NVug18nNT
        yM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681990723; x=1682077123; bh=J+606rOXxsuiM
        hT8G+OyCiSalvoR/fuvBBQJvB3Dksk=; b=DjhYu4fjco8DsPAlx0vykcxyAjnUS
        h6jqBpwnOrDpkUxlVJ1W0ngJ8Pam20nvvJcnK6LLaqnArMP8E2NGoh4mwK8rBkAS
        3SFLLCljd2P1J/zQpm8I8AHd8eDj6dB/oWEKHQ0oPTXv2VYmddkn1mcL9AFU0nxE
        fwmHZAcpsvAuMP2PXbmrgH7vtvSPafv7Nahemh+oDnSLc7zEoTwHSnUPjqOmPTdL
        M7/zUXMN2iU5mRFwLZ0WwHvP6Q3TK2p5zGVQdQbYvr4l90B9PqpUrpIoZyBJELO+
        siatOp1VUps6hvVWbVpbtWohhSEutTCgfBxKjLTgBs0vCypvHo4mEOReQ==
X-ME-Sender: <xms:QiRBZLQjXxSfLqqZAwxbEfffA6dycodLLqKp2sAimxCIB_NjgPFGEw>
    <xme:QiRBZMwHfHCX3Bemp28dXI1qgeZLJZBkg8xXOUTcrqxouK-QeKzZrGARKaPDSv0Q_
    Wxnupj3vr8m1w>
X-ME-Received: <xmr:QiRBZA3yQGMBkm6bHLWm656GFVrJrQAxHGJaldvDGEWiscBiqDuRv7BPNP3W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeglefgjeelgfevfeduvedtheethfehtddthedtfedtte
    dvieffffdvkeduudeuudenucffohhmrghinheprgguvhgrnhhtvggthhdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskh
    hrohgrhhdrtghomh
X-ME-Proxy: <xmx:QiRBZLAp_kqaWxxqxgYPHVlbb1jN58MvaFAAhLWB_kjTK29cOjbSXQ>
    <xmx:QiRBZEikL5IvqPeKA3t0LtdA2WJXqPFxE3Hdfr-qPNa5qukvOLdV3Q>
    <xmx:QiRBZPo-KG9Fw0dQ0b4lH6dqbc7dHONuneL7nx4khdK2QBXONpulNA>
    <xmx:QyRBZHvyX6KI1kcJ82vh5t5O8nzHdxeZqIi3l_fuvQ9xQHGzo5k3zw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 07:38:42 -0400 (EDT)
Date:   Thu, 20 Apr 2023 13:38:40 +0200
From:   Greg KH <greg@kroah.com>
To:     tomin@iszf.irk.ru
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: Add support for Advantech PCI-1611U card
Message-ID: <ZEEkQDdvEU060_zv@kroah.com>
References: <20230412055622.3787514-1-tomin@iszf.irk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412055622.3787514-1-tomin@iszf.irk.ru>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 12, 2023 at 01:56:22PM +0800, tomin@iszf.irk.ru wrote:
> From: Vitaliy Tomin <tomin@iszf.irk.ru>
> 
> Add support for Advantech PCI-1611U card
> 
> Advantech provides opensource drivers for this and many others card
> based on legacy copy of 8250_pci driver called adv950
> 
> https://www.advantech.com/emt/support/details/driver?id=1-TDOIMJ
> 
> It is hard to maintain to run as out of tree module on newer kernels.
> Just adding PCI ID to kernel 8250_pci works perfect.
> ---
>  drivers/tty/serial/8250/8250_pci.c | 5 +++++
>  1 file changed, 5 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
