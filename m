From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] tty: serial: msm: fix checkpatch warnings
Date: Mon, 04 Aug 2014 14:42:02 -0700
Message-ID: <53DFFE2A.7010002@gmail.com>
References: <1407162046-29729-1-git-send-email-kiran.padwal@smartplayin.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56217 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbaHDVmR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2014 17:42:17 -0400
In-Reply-To: <1407162046-29729-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, sboyd@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/4/2014 7:20 AM, Kiran Padwal wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: braces {} are not necessary for any arm of this statement
> 
> WARNING: Missing a blank line after declarations
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> WARNING: else is not generally useful after a break or return
> 
> WARNING: void function return statements are not generally useful
> 
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/tty/serial/msm_serial.c |   26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)

Kiran,

I have a series of fix patches against this file that is going to collide
with your cleanups.  Would you mind waiting until after I send my patches
to do your clean up?

Thanks,

Frank

