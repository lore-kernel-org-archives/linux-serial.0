From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V2] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 17:09:32 -0700
Message-ID: <e43e50f0-76a6-42f0-9d20-834eab80835a@VA3EHSMHS014.ehs.local>
References: <1264032399-16358-1-git-send-email-john.linn@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:11867
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752536Ab0AUAJj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 19:09:39 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <1264032399-16358-1-git-send-email-john.linn@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

> -----Original Message-----
> From: John Linn [mailto:john.linn@xilinx.com]
> Sent: Wednesday, January 20, 2010 5:07 PM
> To: linux-serial@vger.kernel.org; jacmet@sunsite.dk;
grant.likely@secretlab.ca;
> michal.simek@petalogix.com; john.williams@petalogix.com
> Cc: John Linn
> Subject: [PATCH] [V2] uartlite: move from byte accesses to word
accesses
> 
> Byte accesses for I/O devices in Xilinx IP are going to be less
> desired in the future such that the driver is being changed to
> use 32 bit accesses.
> 
> This change facilitates using the uartlite IP over a PCIe bus
> which only allows 32 bit accesses.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---

I apologize I forgot to put a note about how V2 is different.  The
commit message is the only thing that changed based on Peter's input.

Thanks,
John

>  drivers/serial/uartlite.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> index 377f271..9f83949 100644
> --- a/drivers/serial/uartlite.c
> +++ b/drivers/serial/uartlite.c
> @@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port *port, int
stat)

<snip>

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


