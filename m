Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D1AC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Apr 2022 15:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbiDRPts (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbiDRPtj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:39 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD1B449FA4;
        Mon, 18 Apr 2022 08:27:05 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E49019200B3; Mon, 18 Apr 2022 17:27:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DD5BD92009C;
        Mon, 18 Apr 2022 16:27:04 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:27:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <alpine.DEB.2.21.2204181506000.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 Here's v5 of the outstanding fixes for Oxford Semiconductor 950 UARTs 
including most updates requested by Andy (thanks for your review!).  

 Also while looking into an unrelated issue I have come across the 
DIV_ROUND_CLOSEST macro and updated 5/5 replacing equivalent handcoded 
calculations.  I have verified that there is no change in machine code 
produced after this update with the i386 and RISC-V targets.

 Please apply.

  Maciej
