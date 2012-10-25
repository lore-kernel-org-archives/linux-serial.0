From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] staging: dgrp: remove use of real_raw and read_cnt
Date: Thu, 25 Oct 2012 11:23:40 -0700
Message-ID: <20121025182340.GA24533@kroah.com>
References: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42901 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab2JYSXo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 14:23:44 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so907318dak.19
        for <linux-serial@vger.kernel.org>; Thu, 25 Oct 2012 11:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-serial@vger.kernel.org

On Thu, Oct 25, 2012 at 12:46:20PM -0400, Bill Pemberton wrote:
> 
> Patches for tty-next to fix dgrp breakage when real_raw and and
> read_cnt where removed from tty_struct.

Now applied, thanks.

greg k-h
