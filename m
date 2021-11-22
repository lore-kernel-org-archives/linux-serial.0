Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE7C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhKVNBT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhKVNBT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 08:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 898B660F70;
        Mon, 22 Nov 2021 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637585890;
        bh=FyL6e1EMnnbM5ZD7KGNgpswjs0+cixjU2G7leVNLGPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCrGnd94JYhWSTCKxNYY45uXgskT0p9o4qy48FxcA5wWcaYgkKkkecw3NMFDFQiPH
         Jn94wjOlzir3kyc8acEHkYtLt6BvKqf/7x3kCUwMvvdiGOY3xc5Y2INQK91ZP5WxZ7
         BelJFEd8GxRd/crvQG1umMmJMCmXMpxERi4MRB6ZkmdCINLtn8LN0OG3CQlDSVVxST
         JMG4eecLupuN6azjdFLbCO8kiAC9YZsajfK+zunc0ZvDO0bq7M2iA94YazpefKPUmT
         CsoKKfRKGmAVm10C+I/Kr+no581A5vLtrOCiHDF5QUe4CtMLIHnV55E7rFsk/G9Dcw
         tz7+dfnOLu17w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mp8tL-0003l6-UN; Mon, 22 Nov 2021 13:57:52 +0100
Date:   Mon, 22 Nov 2021 13:57:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tty: drop tty_schedule_flip()
Message-ID: <YZuTz/inB7RJq6gi@hovoldconsulting.com>
References: <20211122111648.30379-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122111648.30379-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 12:16:45PM +0100, Jiri Slaby wrote:
> There are two identical functions: tty_schedule_flip and
> tty_flip_buffer_push. Remove the former.
> 
> This is [v2] as [v1] was dropping tty_flip_buffer_push. And
> tty_flip_buffer_push is spread wider, so remove the less used one as
> proposed by Johan.
>
> Jiri Slaby (3):
>   tty: drivers/tty/, stop using tty_schedule_flip()
>   tty: the rest, stop using tty_schedule_flip()
>   tty: drop tty_schedule_flip()

Thanks for the v2, looks good. For the series:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
