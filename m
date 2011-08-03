From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SERIAL: Lantiq: Set timeout in uart_port
Date: Wed, 3 Aug 2011 16:10:29 +0100
Message-ID: <20110803161029.1d46865f@lxorguk.ukuu.org.uk>
References: <20110803143724.GB8673@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40384 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754579Ab1HCPHS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Aug 2011 11:07:18 -0400
In-Reply-To: <20110803143724.GB8673@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, greg@kroah.com

On Wed, 3 Aug 2011 15:37:24 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> From: John Crispin <blogic@openwrt.org>
> 
> Without this patch apps using readline hang.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Signed-off-by: Alan Cox <alan@linux.intel.com>
