Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A865C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0DC610C8
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 12:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1Mvy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:51:54 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:35310 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhJ1Mvx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Oct 2021 08:51:53 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9E7339200B4; Thu, 28 Oct 2021 14:49:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 973BA92009E;
        Thu, 28 Oct 2021 13:49:22 +0100 (BST)
Date:   Thu, 28 Oct 2021 13:49:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Johan Hovold <johan@kernel.org>
cc:     cgel.zte@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, fancer.lancer@gmail.com, andrew@aj.id.au,
        pali@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: tty: replace snprintf in show functions with
 sysfs_emit
In-Reply-To: <YXqV9V0eWhqFTc+i@hovoldconsulting.com>
Message-ID: <alpine.DEB.2.21.2110281342290.61663@angie.orcam.me.uk>
References: <20211028101350.14172-1-yao.jing2@zte.com.cn> <YXqV9V0eWhqFTc+i@hovoldconsulting.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 28 Oct 2021, Johan Hovold wrote:

> Where's the commit message?

 Or to put it explicitly: please always include a full description of any 
change submitted, where you explain what your change is needed for and why 
you have made it like this.

 Please refer to Documentation/process/submitting-patches.rst in the 
source tree for a full recipe for submitting patches, which says, among 
others:

"[...] The text should be written in such detail so that when read
weeks, months or even years later, it can give the reader the needed
details to grasp the reasoning for **why** the patch was created."

 Thanks,

  Maciej
