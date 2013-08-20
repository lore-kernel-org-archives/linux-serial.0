From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Tue, 20 Aug 2013 05:48:54 +0530
Message-ID: <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
	<52123A44.9090608@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39473 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab3HTASz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 20:18:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id l10so2111663oag.19
        for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2013 17:18:55 -0700 (PDT)
In-Reply-To: <52123A44.9090608@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

Hi Peter,

On 19 August 2013 21:01, Peter Hurley <peter@hurleysoftware.com> wrote:

> Please review commit 677fe555cbfb188af58cce105f4dae9505e58c31
> 'serial: imx: Fix recursive locking bug' to see if that is actually the
> problem
> you're having with the samsung serial driver.

No, this doesn't seem to be the same issue... The issue here is:

s3c24xx_serial_rx_chars()
-> spin_lock_irqsave(&port->lock, flags);
-> tty_flip_buffer_push()
  -> flush_to_ldisc()
    -> n_tty_receive_buf2()
      -> __receive_buf()
         -> uart_start()
            -> spin_lock_irqsave(&port->lock, flags);

This seems to be a generic enough problem as many drivers are already
doing the right thing. They release lock before calling
tty_flip_buffer_push()..

And that's why my patchset had only 25 patches :)
