From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: add 32-bit register interface
 support
Date: Thu, 10 Jul 2014 16:03:53 -0700
Message-ID: <20140710230353.GA25661@kroah.com>
References: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60259 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaGJW71 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2014 18:59:27 -0400
Content-Disposition: inline
In-Reply-To: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 01, 2014 at 04:43:46PM +0800, Jingchang Lu wrote:
> This add the big-endian 32-bit register version LPUART support.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 652 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 643 insertions(+), 9 deletions(-)

This patch fails to apply to my tree :(

Can you refresh it against the tty-next branch of the tty.git tree on
git.kernel.org and resend?

thanks,

greg k-h
