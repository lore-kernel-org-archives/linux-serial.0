Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B13BC43332
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B2F64EEE
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbhCDAAE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233490AbhCCTSU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 14:18:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7124464EBB;
        Wed,  3 Mar 2021 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614799053;
        bh=tj5m3R+yaUCFYWFWuC4a9lbcrfRPXKaV+3s37fFm3lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKP2dFCqgmeFyOPLQB8fR6xw02fQU0JJfOA7Uz+mv+aViCVyE7mhRMI3ICqg2Tnwt
         4fb0GUfMjPPofN5aDQukGgjwT4wxyEGj5c0LYueSWbPxTYDYs/hXWjJKHHULnzTEVp
         49uZ47AqEULXgJqE/Rz3POI1CFIWJ76LK8ofFqmY=
Date:   Wed, 3 Mar 2021 20:17:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 38/44] USB: serial/io_edgeport, drop unneeded forward
 declarations
Message-ID: <YD/gyquzbYEs1QuQ@kroah.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-38-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-38-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 07:22:08AM +0100, Jiri Slaby wrote:
> Forward declarations make the code larger and rewrites harder. Harder as
> they are often omitted from global changes. Remove forward declarations
> which are not really needed, i.e. the definition of the function is
> before its first use.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/io_edgeport.c | 41 --------------------------------
>  1 file changed, 41 deletions(-)

I'll let Johan take this through his tree:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
