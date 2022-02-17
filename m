Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60FFC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 17 Feb 2022 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiBQPd0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiBQPd0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 10:33:26 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 07:33:11 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7147562F
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 07:33:09 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1nKihR-0002Nn-GV
        for linux-serial@vger.kernel.org; Thu, 17 Feb 2022 16:28:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Opening already open serial port now sets RTS and DTR?
Date:   Thu, 17 Feb 2022 15:28:00 -0000 (UTC)
Message-ID: <sulpi0$85i$1@ciao.gmane.io>
User-Agent: slrn/1.0.3 (Linux)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It used to be that opening a serial port only set RTS and DTR if it
was a "first open". If the port was already open, subsequent opens
didn't mess up RTS and DTR. This was a very useful behavior in the
embedded world where RTS and DTR are often used to power and or
control things (reset lines, mode controls, line driver enables,
etc.).

This seems to have changed, and now _every_ open sets RTS and DTR even
if the port was already open and RTS and DTR had already been put in
the desired state.

Is there no longer any way to open an already-open serial port without
changing the state of RTS and DTR?

What was the reasoning for breaking user-application backwards
compatiblity like that?

--
Grant


