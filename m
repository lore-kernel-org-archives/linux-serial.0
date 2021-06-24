Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDEC48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C9C613F7
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFXNJw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFXNJv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 09:09:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4D03613F6;
        Thu, 24 Jun 2021 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624540051;
        bh=nik1xFcO54CLXrylWhRVNwQOg1iEtMgXWsXyd08Z8ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2Po7VQ2CLXrr8Hz0Eai4V6b2W0orVBH2NO2vkx9Cyl31ci67koMJ9ItY9Z5a9rzY
         34w/MJJUV+b6RrnrGJeoZSI9n0lJ9gErwqr7JO5vNAhRyjUb23WaI2lDfwaal7N35I
         t9vx3saYgtN0rlvVN8wnBgJZ2tMyIxtE/1y/6/N4=
Date:   Thu, 24 Jun 2021 15:07:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     vgupta@synopsys.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Pavel Andrianov <andrianov@ispras.ru>
Subject: Re: [question] De-registration does not remove port
Message-ID: <YNSDkDnrI38/+VAZ@kroah.com>
References: <3e131267-e1b3-1b83-f8be-0577da479223@gmail.com>
 <YNLfcKFL1LkJgXAR@kroah.com>
 <7af6c0a5-c990-5a40-104e-13f44b1cb4c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af6c0a5-c990-5a40-104e-13f44b1cb4c5@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 24, 2021 at 06:33:01PM +0530, Saubhik Mukherjee wrote:
> On 6/23/21 12:44 PM, Greg KH wrote:
> > On Wed, Jun 23, 2021 at 11:42:36AM +0530, Saubhik Mukherjee wrote:
> > > In drivers/tty/serial/arc_uart.c, arc_serial_remove always returns 0,
> > > instead of calling uart_remove_one_port to remove uart port from serial
> > > core. The comment says "This will be never be called". In my understanding,
> > > a port added using uart_add_one_port should be removed during
> > > de-registration.
> > > 
> > > Is there a reason for this behavior?
> > 
> > Did you test the code to see if that function will ever be called?
> 
> I would like to reformulate the question: Suppose arc_serial_remove is never
> called. Then I would like to know how the driver de-registration is
> organized since the UART port is never removed?

I would like to reiterate my original question, have you tested this?
