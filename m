From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/15] serial: sh-sci: Restrict non-COMPILE_TEST
 compilation
Date: Tue, 3 Dec 2013 10:45:37 -0800
Message-ID: <20131203184537.GE23280@kroah.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53044 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab3LCSof (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Dec 2013 13:44:35 -0500
Content-Disposition: inline
In-Reply-To: <1385515117-23664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Nov 27, 2013 at 02:18:25AM +0100, Laurent Pinchart wrote:
> Hardware supported by the driver is only found on SUPERH or
> ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/tty/serial/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
