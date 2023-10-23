Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C9CDB474
	for <linux-serial@archiver.kernel.org>; Mon, 23 Oct 2023 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWKGm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Oct 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJWKGl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Oct 2023 06:06:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EACD6B;
        Mon, 23 Oct 2023 03:06:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3B0C433C7;
        Mon, 23 Oct 2023 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698055597;
        bh=AQNhSTR8luMNdFbi19jmEP89ynstGqXZXjlBzU2HiRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/dzY+9+MGKAiTbTsk02xn5lLWM4NaCQQtknGcu46YHBwBoWWsObQvkljtWmBQr4P
         NmHj7Gb9iRWzWsXwCjegTqmXecVKrfyVhJMEz5xjUpSa7/PUp2bydhbpQDtG9Fg75d
         hzXxA+VHMBg44TMx35Bvi9axK/I5fR7WX/etBu5w=
Date:   Mon, 23 Oct 2023 12:06:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tty: add new helper function tty_get_tiocm
Message-ID: <2023102327-rename-kosher-bf03@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023094205.2706812-2-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 23, 2023 at 11:42:04AM +0200, Florian Eckert wrote:
> There is no in-kernel function to get the status register of a tty device
> like the TIOCMGET ioctl returns to userspace. Create a new function,
> tty_get_tiocm(), to obtain the status register that other portions of the
> kernel can call if they need this information, and move the existing
> internal tty_tiocmget() function to use this interface.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
