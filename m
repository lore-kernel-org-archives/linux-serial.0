From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/2] serial/mpc52xx_uart: prepare for adding MPC5125
 PSC UART support
Date: Fri, 24 May 2013 19:49:12 +0200
Message-ID: <20130524194912.078467c2@crub>
References: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
	<1366233702-20689-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39687 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3EXRtV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 May 2013 13:49:21 -0400
In-Reply-To: <1366233702-20689-1-git-send-email-agust@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Matteo Facchinetti <matteo.facchinetti@sirius-es.it>, Vladimir Ermakov <vooon341@gmail.com>

On Wed, 17 Apr 2013 23:21:41 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> 
> MPC5125 PSC controller has different register layout than MPC5121.
> To support MPC5125 PSC in this driver we have to provide further
> psc_ops functions for SoC specific register accesses.
> 
> Add new register access functions to the psc_ops structure and
> provide MPC52xx and MPC512x specific implementation for them.
> Then replace remaining direct register accesses in the driver by
> appropriate psc_ops function calls. The subsequent patch can now
> add MPC5125 specific set of psc_ops functions.
> 
> Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> 
> Greg, with your Acked-by I can push these patches to my mpc5xxx tree.
> But it is fine with me if you prefer to apply them to tty tree.

ping ...

Thanks,

Anatolij
