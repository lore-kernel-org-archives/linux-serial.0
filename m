Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D792C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 14:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C54E61A2D
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZOTP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 10:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhCZOTF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 10:19:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3A5760190;
        Fri, 26 Mar 2021 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616768345;
        bh=tfNIe4//8+r1CwXYQDUxEyprnoIfc5khzzoSiAZ9fbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sV+2c+UoZkzTKM4GtvJVgpoR+tm+DNstT/pLPJaZjy02CvNoUB5WsIk4jPp9G+xIG
         dTssGtWfCz+5+GVa/JQuc7eydLDXf27e2KrP20Atw1OPv4WUbHAnj9zlQRkoQYdNET
         /67jNJ9Mvm46YEQ6+dvTibHfMsqnSpsCdAvXuYn8=
Date:   Fri, 26 Mar 2021 15:18:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 0/2] 8250: Add driver for Broadcom UART
Message-ID: <YF3tT7OrDeZEcO69@kroah.com>
References: <20210325185256.16156-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325185256.16156-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 25, 2021 at 02:52:54PM -0400, Al Cooper wrote:
> v7 - Change Kconfig for SERIAL_8250_BCM7271 from "bool" to "tristate"
>      so the driver can be built as a module.

Much better, thanks for sticking with this, now queued up.

greg k-h
