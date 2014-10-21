From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: of-serial: fix uninitialized kmalloc variable
Date: Tue, 21 Oct 2014 12:11:08 +0200
Message-ID: <2601201.5ptAsr65zc@wuerfel>
References: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63812 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbaJUKLN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 06:11:13 -0400
In-Reply-To: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jingchang Lu <jingchang.lu@freescale.com>, gregkh@linuxfoundation.org, peter@hurleysoftware.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, josephl@nvidia.com

On Tuesday 21 October 2014 16:50:21 Jingchang Lu wrote:
> The info pointer points to an uninitialized kmalloced space.
> If a device doesn't have clk property, then info->clk may
> have unpredicated value and cause call trace. So use kzalloc
> to make sure it is NULL initialized.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de
