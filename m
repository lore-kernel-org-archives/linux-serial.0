Return-Path: <SRS0=Q4jN=7I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A9C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721F6206D5
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgEZQFi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 May 2020 12:05:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49773 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgEZQFi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 12:05:38 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0868A2000E;
        Tue, 26 May 2020 16:05:33 +0000 (UTC)
Date:   Tue, 26 May 2020 09:05:30 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Enable 16550A variants by default on
 non-x86
Message-ID: <20200526160530.GA467000@localhost>
References: <d32bdbf9fed2719c1180228464ba84dfcdeb5aa5.1590482037.git.josh@joshtriplett.org>
 <20200526094744.GB2735879@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526094744.GB2735879@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 26, 2020 at 11:47:44AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 26, 2020 at 01:40:06AM -0700, Josh Triplett wrote:
> > Some embedded devices still use these serial ports; make sure they're
> > still enabled by default on architectures more likely to have them, to
> > avoid rendering someone's console unavailable.
> > 
> > Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> > 
> > Based on user reports from embedded devices that need these variants.
> 
> No "reported-by:" lines for these people?  Not even the author of the
> other competing patch for this issue?

Genuinely forgot that the "Reported-by" tag existed; thank you for the
reminder. Will fix.

- Josh Triplett
