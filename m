From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Date: Mon, 02 Dec 2013 14:36:32 +0100
Message-ID: <1516614.DSSr7jaai1@avalon>
References: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33068 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab3LBNg2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 08:36:28 -0500
In-Reply-To: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Greg,

On Thursday 28 November 2013 18:11:44 Laurent Pinchart wrote:
> Hello,
> 
> This patch set prepares the driver to CCF migration by replacing
> clk_enable() and clk_disable() by clk_prepare_enable() and
> clk_disable_unprepare() respectively (2/2). In order to do so it first
> ensures that the clk_enable() and clk_disable() calls will only take place
> from non-atomic context (1/2).
> 
> Greg, these patches are dependencies for a bunch of ARM patches that will go
> through Simon's tree. Would you be fine if Simon merged all sh-sci patches
> through his tree for v3.14 ?

Ping ?

> Laurent Pinchart (2):
>   serial: sh-sci: Don't enable/disable port from within break timer
>   serial: sh-sci: Convert to clk_prepare/unprepare
> 
>  drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
-- 
Regards,

Laurent Pinchart

