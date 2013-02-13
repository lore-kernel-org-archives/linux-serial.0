From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] serial/arc-uart: Urgent DT related update
Date: Wed, 13 Feb 2013 18:07:12 +0530
Message-ID: <511B88F8.6010907@synopsys.com>
References: <201302090928.43929.arnd@arndb.de> <1360572101-12744-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:40987 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3BMMh1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 07:37:27 -0500
In-Reply-To: <1360572101-12744-1-git-send-email-vgupta@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org

On Monday 11 February 2013 02:11 PM, Vineet Gupta wrote:
> Hi Greg,
>
> Here's an update to arc-uart driver given Grant's recent review comments.
> As discussed in the thread, can you consider this a bug fix and apply to
> tty-next for 3.9. If you don't, please let me know as the corresponding DT file
> change would have to be to be seperately applied to arch/arc/boot/*.
>
> Patch is Based off linux-next of today.
>
> Thx,
> -Vineet
>
> Vineet Gupta (1):
>   serial/arc-uart: Miscll DT related updates (Grant's review comments)
>
>  .../devicetree/bindings/tty/serial/arc-uart.txt    |    4 ++--
>  drivers/tty/serial/arc_uart.c                      |   10 ++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>

Greg, I'm assuming this won't make into tty until 3.9-rc1 and hence I need to drop
the platform patch from arc-next.

Thx,
-Vineet
