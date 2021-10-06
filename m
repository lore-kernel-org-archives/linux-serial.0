Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694EC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 10:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB46610C7
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 10:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhJFKyV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:54:21 -0400
Received: from phobos.denx.de ([85.214.62.61]:33464 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJFKyT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 06:54:19 -0400
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A699D801B2;
        Wed,  6 Oct 2021 12:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633517545;
        bh=HMb4bIeDgFpYBqwvWEUi3CqKEZsaRf7KKO09N6gANrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdikxxREPz8VNRR+istSllerrjDAe+djniO/Zjn/Xpm/QSsGE64zawHYqnmhs2V02
         VdyDlIzQr9I1OnvKYhSGKMpLKTN2B5sXiMzokuLH/XXAhfMSKH1196j5CmBZSCHhUb
         dtEuxwbcNHnON56M77ItoKzkoAhgPDM3D6OQQXiEPd9DQ6qVEgGtKYa+nMCB7lriH5
         HLcjHCP7tFPb+NGZTPqZGd2DvxtdxXTyBjIjj/npz/7SaIxQthUy6qm/m4Bi9ZVpDS
         YE547/djrWyNw5476mi3VQD15w+6waFRQsf61YUMt3LUyaFcS72ANufuvgB1z8j9+a
         Y9Tog5enmelEA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Oct 2021 07:52:25 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  serial: imx: Suppress false positive sysrq lockdep
 warning
In-Reply-To: <YV1Z8JslFiBSFGJF@hovoldconsulting.com>
References: <20211001101815.729648-1-festevam@denx.de>
 <YVcTluYb6XOiOXZn@hovoldconsulting.com>
 <0bbe2832eb2dc3a7c32f3d484ab42208@denx.de>
 <YV1Z8JslFiBSFGJF@hovoldconsulting.com>
Message-ID: <c774fe18362b4cc19111078f2cd9ae82@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 06/10/2021 05:10, Johan Hovold wrote:

> Ok, thanks for testing. The above is what I meant and it does fix the
> false-positive lockdep splat which motivated
> uart_unlock_and_check_sysrq() to be added in the first place.
> 
> Looking closer at the splat you reported (which you've edited quite
> heavily), it becomes apparent that you are now hitting a different
> locking issue. And it's not a false positive this time.
> 
> There a problem with the workqueue debugging code, which unless fixed 
> at
> the source, would prevent any console driver from queueing work while
> holding a lock also taken in their write paths. And
> tty_flip_buffer_push() is just one example of many.
> 
> I can easily reproduce the splat with another serial driver, and I've
> also been able to trigger the actual deadlock.
> 
> I've prepared a patch that takes care of the workqueue state dumping,
> which I'll send as a reply to this mail. Would you mind giving it a 
> spin
> with the imx driver as well?

Yes, after applying only your patch I no longer get the lockdep
splat. I have replied with my Tested-by, thanks.
