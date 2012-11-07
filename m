From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: Re: [PATCH 00/10] serial: sh-sci fixes - console PM, SCIFB,
 SMP lockup, etc.
Date: Wed, 07 Nov 2012 16:18:38 +0900
Message-ID: <509A0B4E.1030801@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:53209 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab2KGHSq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 02:18:46 -0500
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, rjw@sisk.pl, alan@linux.intel.com, gregkh@linuxfoundation.org, takashi.yoshii.zj@renesas.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org

On 11/7/2012 3:57 PM, Shinya Kuribayashi wrote:
> Hi Paul and serial forks,
[...]
> Takashi YOSHII (4):
>       serial: sh-sci: fix condition test to set SCBRR
>       serial: sh-sci: support lower baud rate
>       serial: sh-sci: mask SCTFDR/RFDR according to fifosize
>       serial: sh-sci: fix common SCIFB regmap definition
> 
> Teppei Kamijou (1):
>       serial: sh-sci: console runtime PM support (revisit)
> 
>  drivers/tty/serial/sh-sci.c | 140 ++++++++++++++++++--------------------------
>  1 file changed, 56 insertions(+), 84 deletions(-)

Oops, I forgot to append proper From: author lines in five commits
(patch 04/10 to 09/10).  Didn't mean to supersede your authoship.

I'd respin the patchset later, waiting for some feedback.
--
Shinya Kuribayashi
Renesas Electronics
