Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE763C1B0E3
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B38A22C7D
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbgLIOaB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732852AbgLIO35 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 09:29:57 -0500
Date:   Wed, 9 Dec 2020 15:30:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607524157;
        bh=tGb2bsihTlzyOAC5cT78Tgjia37FE/zrr0cFrYwkh+A=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFTxMXqtvwtq2lG6Y9UwA7UCRNt/AA7XzOy6nK/WxCqIj+JEUlQ76Ee1KcosDHtCN
         IUtXCFkQL2MKqiWgc+WCXFPS9brJeRzrrp8/VuHLDXm9nGTm4LtoO84gkGkvWBE0j6
         t32Dsd4eZrxthi9J3pmx8oPhf4mRr3+3OaYgLKLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9Dficb8sQGRut+S@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 02, 2020 at 12:39:35PM +0100, Johan Hovold wrote:
> This series adds a new NORDY port flag to suppress raising the
> modem-control lines on open to signal DTE readiness.
> 
> This can be used to implement a NORDY termios control flag to complement
> HUPCL, which controls lowering of the modem-control lines on final
> close.
> 
> Initially drivers can export the flag through sysfs, which also allows
> control over the lines on first open. Such an interface is implemented
> for serial core and USB serial.
> 
> The motivation for this is to allow for applications where the DTR and
> RTS lines are used for non-standard purposes (e.g. generating power-on
> and reset pulses) to open the port without undesirable side effects.
> 
> The final patches enables this flag by default for such a USB serial
> device.
> 
> Other examples include HAM-radio devices where DTR and RTS is used for
> push-to-talk and continuous-wave control and various Arduino boards
> which are reset on open unless a jumper is physically removed.
> 
> Greg, are you ok we me taking this through my tree? I'm planning on some
> follow ups to the ftdi driver and the tty/serial changes are fairly
> self-contained.
> 
> Also let me know if you prefer to hold this off for 5.12. The change is
> minimal, self-contained and low-risk, but it is a new interface and late
> in the release cycle as Andy pointed out.

I took the first 2 patches now, that was easy :)

I think we need more review for the rest of the series.  This does
change the way serial ports work in a non-traditional way (i.e. using
sysfs instead of terminal settings).  So I want to get a bunch of people
to agree that this is ok to do things this way now before taking this
new user-visible api.

thanks,

greg k-h
