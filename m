Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC8ACDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 06:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJQG4W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 02:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQG4W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 02:56:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A973AB
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 23:56:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8933A8027;
        Tue, 17 Oct 2023 06:56:17 +0000 (UTC)
Date:   Tue, 17 Oct 2023 09:56:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <20231017065616.GN27774@atomide.com>
References: <ZSPQY6UYg21Z0PnN@nuoska>
 <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
 <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
 <2023101516-unmolded-otter-e3e0@gregkh>
 <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
 <20231016063501.GL27774@atomide.com>
 <ZSzjNgdCH_wmB4u2@nuoska>
 <20231016072352.GM27774@atomide.com>
 <0d86deae37877258f46322d4d727903fca12ad21.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d86deae37877258f46322d4d727903fca12ad21.camel@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Richard Purdie <richard.purdie@linuxfoundation.org> [231016 08:10]:
> The port sometimes doesn't come up properly at boot.
> 
> To be clear, the "\n\n" from the qemu side into the port doesn't seem
> to help. The "echo helloB > /dev/ttyS1" inside the image does seem to
> wake it up. 

So if I understand correctly, this issue still happens with kernel patched
with commit 81a61051e0ce ("serial: core: Fix checks for tx runtime PM
state"), and the issue now only happens sometimes.

I wonder if the following additional change might help?

I have not yet tried to reproduce with the full test case you guys have,
just with qemu and two ports but no luck so far with a minimal test case.

Regards,

Tony

8< -------------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -146,7 +146,7 @@ static void __uart_start(struct uart_state *state)
 
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
-	if (err < 0) {
+	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
 	}
