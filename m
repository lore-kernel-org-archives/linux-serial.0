From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Re: Migrating from Windows to LiNUX speed problems
Date: Wed, 25 Aug 2004 09:25:26 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408250925.26394.fmmarzoa@softronica.org>
References: <200408250848.17379.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:10113 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S268480AbUHYHQj
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 03:16:39 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id A31CF7DE0
	for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2004 09:08:58 +0200 (CEST)
In-Reply-To: <200408250848.17379.fmmarzoa@softronica.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Ok, I find a workaround with this, that consists in:

setserial /dev/ttyS0 low_latency

Now its really fast, but there should be a way to do the same from my program, 
perhaps some ioctl call... isn't it?...

Thanks.


On Wednesday 25 August 2004 08:48, Francisco M. Marzoa Alonso wrote:
> Hi again,
>
> I've "solved" my problems with communications under LiNUX for my program,
> but it still does not run as well as in Windows. In Windows the same
> program with the same hardware, same baudrate and same configuration
> parameters (I think...) works three or four times faster. 

[...]


