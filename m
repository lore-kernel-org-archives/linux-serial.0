From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Tue, 4 Nov 2008 17:41:42 +0000
Message-ID: <20081104174142.360a964a@lxorguk.ukuu.org.uk>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53225 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224AbYKDRlg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 12:41:36 -0500
In-Reply-To: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kosaki.motohiro@jp.fujitsu.com

On Wed, 5 Nov 2008 02:26:00 +0900 (JST)
KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:

> 
> fix following warnings.
> 
> drivers/serial/8250.c: In function ‘serial8250_shutdown’:
> drivers/serial/8250.c:1612: warnings: ‘i’ may be used uninitialized in this function

NAK

This is an incorrect compiler warning. It's also one that current gcc
does not emit warnings for.

Alan
