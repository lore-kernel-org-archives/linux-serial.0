Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E4CC43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 12:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGLMVV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiGLMVV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 08:21:21 -0400
X-Greylist: delayed 1275 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 05:21:17 PDT
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323617AB1E
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 05:21:16 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26CBxvkd020196
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 21:29:58 +0930
Date:   Tue, 12 Jul 2022 21:29:57 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     linux-serial@vger.kernel.org
Subject: [Regression] CH341 USB-serial converter passes data in 32 byte chunks
Message-ID: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all

For many years I have been using a CH341 USB-serial converter (VID:PID
4348:5523) to drive a microcontroller programming dongle.  This was under
kernel 4.4.14.  When I recently upgraded the machine to a 5.15.27 kernel the
programmer stopped working, reporting timeouts.  Using a loopback cable and
minicom I discovered that under 5.15.27 data was only delivered back to
minicom in blocks of 32 characters.  This explains why the programming
software reported timeouts.  It seems that either outgoing data is blocked
until 32 bytes are ready for transmission, or receive data is only reported
in blocks of 32 bytes.

Under 4.4.14 (and all kernels prior to 4.10.0), individual characters are
echoed back by minicom as soon as they hare pressed on the keyboard.

As far as I can tell, the regression affects all kernels since 4.10.0.

I have done a git bisect which identified the following commit as the source
of the problem.

commit 55fa15b5987db22b4f35d3f0798928c126be5f1c
Author: Johan Hovold <johan@kernel.org>
Date:   Fri Jan 6 19:15:16 2017 +0100

    USB: serial: ch341: fix baud rate and line-control handling

    Revert to using direct register writes to set the divisor and
    line-control registers.

    A recent change switched to using the init vendor command to update
    these registers, something which also enabled support for CH341A
    devices. It turns out that simply setting bit 7 in the divisor register
    is sufficient to support CH341A and specifically prevent data from being
    buffered until a full endpoint-size packet (32 bytes) has been received.

    Using the init command also had the side-effect of temporarily
    deasserting the DTR/RTS signals on every termios change (including
    initialisation on open) something which for example could cause problems
    in setups where DTR is used to trigger a reset.

    Fixes: 4e46c410e050 ("USB: serial: ch341: reinitialize chip on
    reconfiguration")
    Signed-off-by: Johan Hovold <johan@kernel.org>


It would be great if this regression could be addressed.  At present I must
boot a pre-4.10 kernel whenever I need to use the programming dongle with
this converter.

Please let me know if there is anything I can do to help resolve the
problem.

Regards
  jonathan
