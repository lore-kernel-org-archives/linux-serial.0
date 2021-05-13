Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D424DC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905B161435
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhEMQVi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 12:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235054AbhEMQVf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 12:21:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C7E761435;
        Thu, 13 May 2021 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620922825;
        bh=QVkrX7mN2/40RLW8Kgds/Fa/Z5rjabrfG+EbU64Cj6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7sVpCuHd9iAV5tZcOfo7vjxhWts3zezaAhVYNNXWqC1xLVeO2P4M/dvvYmYnClfg
         7AteXdvNRZ6hS1utiCUN6+u1DjqXHzoXajQ+IGcAYyhF6vH9EJ+EGM1zSIXpHZdhBP
         2SSxEh8j15F3ibpKZ/0x253+UdHj8ELfEhO+twA7oGhClLwNoN16iot3arusSNv/Cr
         sXU+odJj8iIXjUG952T1WamigpVWbZrllhTB/nbr61fkUmr++ni+eUnIpvRRBwI5W9
         BkP1SgaWzLoBkh7MhbQ4q/whuzE21XlgkiWx8I0KZTSaSI3tQFO97j0q1vh+MVs6VP
         OBChNSPmrBFjg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lhE4Y-0007Q2-Dx; Thu, 13 May 2021 18:20:26 +0200
Date:   Thu, 13 May 2021 18:20:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/35] tty cleanup for 5.14
Message-ID: <YJ1RyscrL2bNYXou@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <YJ1ACSO+JKRhZZ0/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1ACSO+JKRhZZ0/@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 13, 2021 at 05:04:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 05, 2021 at 11:18:53AM +0200, Jiri Slaby wrote:
> > Hi,
> > 
> > this is again a series of various TTY cleanups. The stats say: 116 files
> > changed, 661 insertions, 2602 deletions. The major part of the removal
> > is a drop of BROKEN r3964 ldisc. The rest is mostly removal of dead
> > code, or adaption to the current tty core state.
> 
> I've applied the first 33 patches in this series.  Can you resend the
> last two after you have revised them based on the review?

Greg, could you consider dropping the three USB-serial patches from
tty-testing? They don't have any dependency on the tty changes and we
can avoid unnecessary merge conflicts if I take them through through my
tree instead.

	USB: serial: make usb_serial_driver::write_room return uint
	serial: make usb_serial_driver::chars_in_buffer return uint
	USB: serial: digi_acceleport, simplify digi_chars_in_buffer

Johan
