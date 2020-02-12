Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058AC352A4
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEA2217F4
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537551;
	bh=tvK+Gituvhn3DVzQ8aoIo4fnc5H+XzTeQOtZjep35Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wk9FkGHHyov27mCORWwYu7pA1+8vnksutlfG2aMuU3A+lFs/ulGeoVNLPJz18yrmg
	 5G8HMuLCNHy7/uW5jeqgvETiuY02BAmzi5kaipeZC3E9ug8YX2KkGUAFQtUr6P98IE
	 w9S1jV578ez65UvgvCeAf+pfasEaBB4GTLQrKSfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLT7K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLT7K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 14:59:10 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923CD21739;
        Wed, 12 Feb 2020 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581537549;
        bh=tvK+Gituvhn3DVzQ8aoIo4fnc5H+XzTeQOtZjep35Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZfH0P+thgjWGU3eVHKCGofWOZKJ0Rxlltt/aS+rjuNfK2bfTq6R9oy/zYkp9GAjQ
         1KDqx3DHcflKr22Nnf3wNw1seq1AuNfOzQMqPCOv+1oLsEmy0neQeakA4XAcYPWFyw
         ge2EvGpldjmYiNwR7VjbflX65gfWyu9260FgK8hc=
Date:   Wed, 12 Feb 2020 11:59:09 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vt: selection, close sel_buffer race
Message-ID: <20200212195909.GA2081344@kroah.com>
References: <20200210081131.23572-1-jslaby@suse.cz>
 <20200210081131.23572-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210081131.23572-2-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 10, 2020 at 09:11:31AM +0100, Jiri Slaby wrote:
> syzkaller reported this UAF:
> BUG: KASAN: use-after-free in n_tty_receive_buf_common+0x2481/0x2940 drivers/tty/n_tty.c:1741
> Read of size 1 at addr ffff8880089e40e9 by task syz-executor.1/13184
> 
> CPU: 0 PID: 13184 Comm: syz-executor.1 Not tainted 5.4.7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Call Trace:
> ...
>  kasan_report+0xe/0x20 mm/kasan/common.c:634
>  n_tty_receive_buf_common+0x2481/0x2940 drivers/tty/n_tty.c:1741
>  tty_ldisc_receive_buf+0xac/0x190 drivers/tty/tty_buffer.c:461
>  paste_selection+0x297/0x400 drivers/tty/vt/selection.c:372
>  tioclinux+0x20d/0x4e0 drivers/tty/vt/vt.c:3044
>  vt_ioctl+0x1bcf/0x28d0 drivers/tty/vt/vt_ioctl.c:364
>  tty_ioctl+0x525/0x15a0 drivers/tty/tty_io.c:2657
>  vfs_ioctl fs/ioctl.c:47 [inline]
> 
> It is due to a race between parallel paste_selection (TIOCL_PASTESEL)
> and set_selection_user (TIOCL_SETSEL) invocations. One uses sel_buffer,
> while the other frees it and reallocates a new one for another
> selection. Add a mutex to close this race.
> 
> The mutex takes care properly of sel_buffer and sel_buffer_lth only. The
> other selection global variables (like sel_start, sel_end, and sel_cons)
> are protected only in set_selection_user. The other functions need quite
> some more work to close the races of the variables there. This is going
> to happen later.
> 
> This likely fixes (I am unsure as there is no reproducer provided) bug
> 206361 too. It was marked as CVE-2020-8648.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reported-by: syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com
> References: https://bugzilla.kernel.org/show_bug.cgi?id=206361

This needs patch 1 in order to work properly, right?

thanks,

greg k-h
