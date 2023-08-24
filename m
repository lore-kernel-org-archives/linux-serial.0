Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0917C71153
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 14:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbjHXOtr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbjHXOta (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 10:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C01FF6;
        Thu, 24 Aug 2023 07:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDBE66218E;
        Thu, 24 Aug 2023 14:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA2CC433C8;
        Thu, 24 Aug 2023 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888535;
        bh=L9fXQr7c4dFKYs8jRg5OKffCpoKZVVSVI9obxkzOZmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+4zOJ9Zl1uA3cjXOIEwMVdtYBVbj8qctsNEknNWV1zZW6MPhsyaDdmkuPE92sZ7y
         CPf/dRSyiumUiROg5UQ93GxP0N1KFInKCJSU0f9wQliZSPXxylX4QODBMwcVepIq7A
         W3mMILASDlKKo3MSgA2h4/94rJeLU/Sq0nT8eUcA=
Date:   Thu, 24 Aug 2023 16:48:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simon Arlott <simon@octiron.net>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Message-ID: <2023082403-masculine-scuttle-f0ad@gregkh>
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 23, 2023 at 09:37:45PM +0100, Simon Arlott wrote:
> If the serial device never reads data written to it (because it is "output
> only") then the write buffers will still be waiting for the URB to complete
> on close(), which will hang for 30s until the closing_wait timeout expires.
> 
> This can happen with the ESP32-H2/ESP32-C6 USB serial interface. Instead of
> changing all userspace applications to flush (discard) their output in this
> specific scenario it would be easier to adjust the closing_wait timeout
> with udev rules but the only available interface is the TIOCGSERIAL ioctl.

Then why not use that?

> The serial_core driver (ttySx) exposes its supported ioctl values as
> read-only sysfs attributes. Add read-write sysfs attributes "close_delay"
> and "closing_wait" to cdc-acm (ttyACMx) devices. These are the same as the
> attributes in serial_core except that the "closing_wait" sysfs values are
> modified so that "-1" is used for "infinite wait" (instead of 0) and "0"
> is used for "no wait" (instead of 65535).

Adding tty-driver-specific sysfs files for tty devices is a big no-no,
sorry.  We don't want to go down that rabbit hole at all.

If any apis are needed, let's make them for all tty devices, through the
existing ioctl api, so they work for all devices and userspace doesn't
have to try to figure out just exactly what type of tty/serial device it
is talking to (as that will not scale and is exactly the opposite of
what common apis are for.)

sorry, we can't take this, and in the end, you don't want us to as it's
not maintainable.

thanks,

greg k-h
