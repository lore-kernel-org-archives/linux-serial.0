From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/4] sh-mobile SCIFB support
Date: Sat, 22 May 2010 17:40:25 +0900
Message-ID: <20100522084025.GH17814@linux-sh.org>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:42690 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab0EVIka (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 May 2010 04:40:30 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org

On Fri, May 21, 2010 at 05:49:02PM +0200, Guennadi Liakhovetski wrote:
> This patch series fixes support for SCIFA ports on sh7372 and adds SCIFB 
> support to sh-sci.c
> 
This series no longer applies, so please give it a respin. Also, to save
me from having to mangle all of the patch subjects, for anything impacted
arch/arm/mach-shmobile we use 'ARM: mach-shmobile:', for sh-sci we use
'serial: sh-sci:', etc, etc. The sh prefixes here are really misleading
since they're either all ARM or serial specific.
