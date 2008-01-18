From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] qe: add support for Freescale QUICCEngine UART
Date: Fri, 18 Jan 2008 00:47:37 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801180047260.16260@blarg.am.freescale.net>
References: <11999217062265-git-send-email-timur@freescale.com>
 <11999217072674-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47336 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYARGuE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2008 01:50:04 -0500
In-Reply-To: <11999217072674-git-send-email-timur@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

On Wed, 9 Jan 2008, Timur Tabi wrote:

> Add support for UART serial ports using a Freescale QUICCEngine. Update
> booting-without-of.txt to define new properties for a QE UART node.  Update
> the MPC8323E-MDS device tree to add UCC5 as a UART.  Update the QE library
> to support slow UCC devices and modules.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    9 ++++-
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |   50 ++++++++++++++++++++++++++
>  arch/powerpc/sysdev/qe_lib/Kconfig           |    2 +-
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c        |   10 +++++-
>  4 files changed, 68 insertions(+), 3 deletions(-)
>

applied.

- k
