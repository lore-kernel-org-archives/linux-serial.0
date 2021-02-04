Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785EC433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F6764F51
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 15:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhBDPv7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237462AbhBDPuj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 10:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B682764DA5;
        Thu,  4 Feb 2021 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612453795;
        bh=Q7NOkrxsLwfOICWsHM+eOh5lMOeFEXRUlWX9aCa9VtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mq1YrEEPrJX6l5tirF5uA8MEZnR4KnPuVyc3F0a8xKQCwGq4WmEO7qzoJD00/XaN7
         3P4ByIM0mW60/xLM6gOItEYBXq2byWQ8RoO2afPt6RXQBADpZ98z4uQTIV6DcdWmcG
         dY5WUcpnN/vRhvZaVaS3Q409KhV6VfXuTTgfBmpk=
Date:   Thu, 4 Feb 2021 16:49:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YBwXoCwKwkcMPYvy@kroah.com>
References: <1612425530-20483-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612425530-20483-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 03, 2021 at 11:58:47PM -0800, Alex Nemirovsky wrote:
> +static uintptr_t *cortina_uart_ports;

Note, "uintptr_t" is not a valid kernel type.

Please use a pointer to a real thing, no void pointers please.

thanks,

greg k-h
