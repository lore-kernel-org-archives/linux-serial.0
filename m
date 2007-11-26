From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [UPDATED PATCH] IP22ZILOG: fix lockup and sysrq
Date: Mon, 26 Nov 2007 16:19:31 +0000
Message-ID: <20071126161931.GA22879@linux-mips.org>
References: <20071126160538.507EAC2B22@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:50837 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbXKZQUV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Nov 2007 11:20:21 -0500
Content-Disposition: inline
In-Reply-To: <20071126160538.507EAC2B22@solo.franken.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Mon, Nov 26, 2007 at 04:58:03PM +0100, Thomas Bogendoerfer wrote:

> - fix lockup when switching from early console to real console
> - make sysrq reliable
> - fix panic, if sysrq is issued before console is opened
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Several Indy users have reported the issues fixed by this patch so it's
2.6.24 material.

  Ralf
