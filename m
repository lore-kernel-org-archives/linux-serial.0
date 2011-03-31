From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/n_gsm: fix bug in CRC calculation for gsm1 mode
Date: Thu, 31 Mar 2011 13:11:44 +0100
Message-ID: <20110331131144.74a579db@lxorguk.ukuu.org.uk>
References: <1301184300-9158-1-git-send-email-mikhail.kshevetskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40792 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751552Ab1CaMLU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Mar 2011 08:11:20 -0400
In-Reply-To: <1301184300-9158-1-git-send-email-mikhail.kshevetskiy@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, stable@kernel.org, linux-kernel@vger.kernel.org

On Sun, 27 Mar 2011 04:05:00 +0400
Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com> wrote:

> Problem description:
>   gsm_queue() calculate a CRC for arrived frames. As a last step of
>   CRC calculation it call
> 
>     gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
> 
>   This work perfectly for the case of GSM0 mode as gsm->received_fcs
>   contain the last piece of data required to generate final CRC.
> 
>   gsm->received_fcs is not used for GSM1 mode. Thus we put an
>   additional byte to CRC calculation. As result we get a wrong CRC
>   and reject incoming frame.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

(This wants cleaning up better as Mikhael also says but this patch is
clear and unlike a big clean up a better base point for a stable fix and
can be reworked further)
