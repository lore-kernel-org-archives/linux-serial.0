Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FCC4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA712064C
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 07:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbgLKHgv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 02:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405429AbgLKHgb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 02:36:31 -0500
Date:   Fri, 11 Dec 2020 08:35:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607672151;
        bh=8AbZCmDfqKDvHxoCuVW4WLU89B01yMKgvgl4yqkgEx4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh7yM7u5/Q06SZrRs3vMG1jOFlU3XcBMqDgVCWdOHNTwX+Tgfges+wl5RQmzQZ+jc
         ke09Jt6iYZkorOrG3ZYIOa2bBitrNK3J0kAuNvAgqEzVSv4WTb6pwakN2JvI3+P8ii
         kAzfF1xD2wDhqUt1t5RQdkCuxVo1rx36yb5plKok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] tty: serial: meson: enable console as module
Message-ID: <X9MhUoLt3O12nA5R@kroah.com>
References: <20201211005744.12855-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211005744.12855-1-khilman@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 04:57:44PM -0800, Kevin Hilman wrote:
> Enable serial driver to be built as a module.  To do so, init the
> console support on driver/module load instead of using
> console_initcall().
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Yes, I'm well aware that having the serial console as a module makes
> devices hard to debug, so I'm not changing any default behavior.  The
> goal is just to enable building as a module for environments where
> serial debug is not available or needed.

It's a good goal, I'm all for it, thanks for the patch!

greg k-h
