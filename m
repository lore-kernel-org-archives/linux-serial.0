From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/char/specialix.c: stop inlining largish static
 functions
Date: Tue, 8 Apr 2008 13:10:36 +0100
Message-ID: <20080408131036.243fe896@core>
References: <200804081244.53894.vda.linux@googlemail.com>
	<20080408114321.GB1236@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55470 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbYDHMS1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Apr 2008 08:18:27 -0400
In-Reply-To: <20080408114321.GB1236@bitwizard.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <vda.linux@googlemail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, R.E.Wolff@BitWizard.nl

> > Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
> 
> Ack!
> 
> Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl> 

Acked-by: Alan Cox <alan@redhat.com>

Works for me. I have other patches that touch the same file but nothing
overlapping or that will be hard to resolve.
