Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC48C25B08
	for <linux-serial@archiver.kernel.org>; Sat, 20 Aug 2022 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiHTVYd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVYc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 20 Aug 2022 17:24:32 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1273C2A270;
        Sat, 20 Aug 2022 14:24:27 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1F6C292009C; Sat, 20 Aug 2022 23:24:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1022192009B;
        Sat, 20 Aug 2022 22:24:23 +0100 (BST)
Date:   Sat, 20 Aug 2022 22:24:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 3/8] serial: dz: Assume previous baudrate is valid
In-Reply-To: <20220816115739.10928-4-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208202119090.36368@angie.orcam.me.uk>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com> <20220816115739.10928-4-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 16 Aug 2022, Ilpo Järvinen wrote:

> Assume previously used termios has a valid baudrate and use
> it directly.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

 LGTM, thanks!  Indeed current code seems unnecessarily complex.

  Maciej
