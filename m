Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559BC433EF
	for <linux-serial@archiver.kernel.org>; Sun, 17 Apr 2022 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiDQXE6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Apr 2022 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDQXE5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Apr 2022 19:04:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900B5186DF;
        Sun, 17 Apr 2022 16:02:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C1F8C92009E; Mon, 18 Apr 2022 01:02:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B41BC92009C;
        Mon, 18 Apr 2022 00:02:17 +0100 (BST)
Date:   Mon, 18 Apr 2022 00:02:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 Here's v4 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  

 In this update I have factored out base baud rate correction for EndRun 
devices as well as changes made to drivers/tty/serial/8250/8250_port.c 
required for the OxSemi update.  Please see individual change logs and 
change descriptions for details.

 Please apply.

  Maciej
