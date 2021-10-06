Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FCC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8269D610EA
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 12:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhJFMEU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238167AbhJFMEU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 08:04:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6600B610A3;
        Wed,  6 Oct 2021 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633521748;
        bh=2/tfgl7tE1BMYiKB5jIW2uqSM51Wly0B5OQm5nL4dSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKjDB40wkXxV/t9MG4/ltx1gUjlSCK65ufOMY2mRKLERGAYN0YvEMVQdUrE3Z+JUI
         /EiXy/zUxBUqtdcZ9S3fUTvtjijnKTn+gnv/+TTuWDgq0ZewFoMsiXFwdJ6rwTEs+N
         3UgvGEC2uSTUqUVoSJcUQDWLOBkT48xoU9KtWLYsSWDNIVE14bw7F9s0z0InE6Ttcu
         EHyPbRAzNeotQE/ZaZDt6Jg8UCdEqb4ODbZ3ecHxy49UxgHvuOJUsp0ny3j34sk3d9
         evh+tYlKTO0KNtDk2f7yeTFHIiYXwh96JVWyKdv7Q9DYwDfXJuJ+5qH3s+s+Y0Eg/N
         AOYb/vkCho1pw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mY5cv-0004Rp-V5; Wed, 06 Oct 2021 14:02:26 +0200
Date:   Wed, 6 Oct 2021 14:02:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
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
Message-ID: <YV2QUcdyMtGGq65P@hovoldconsulting.com>
References: <20211001101815.729648-1-festevam@denx.de>
 <YVcTluYb6XOiOXZn@hovoldconsulting.com>
 <0bbe2832eb2dc3a7c32f3d484ab42208@denx.de>
 <YV1Z8JslFiBSFGJF@hovoldconsulting.com>
 <c774fe18362b4cc19111078f2cd9ae82@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c774fe18362b4cc19111078f2cd9ae82@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 06, 2021 at 07:52:25AM -0300, Fabio Estevam wrote:

> On 06/10/2021 05:10, Johan Hovold wrote:

> > I've prepared a patch that takes care of the workqueue state dumping,
> > which I'll send as a reply to this mail. Would you mind giving it a 
> > spin
> > with the imx driver as well?
> 
> Yes, after applying only your patch I no longer get the lockdep
> splat. I have replied with my Tested-by, thanks.

Perfect, thanks for confirming.

Johan
