From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] tty/serial: RS485 bindings for device tree
Date: Tue, 11 Oct 2011 20:41:04 +0200
Message-ID: <3289709.mzRgbAUyPT@wuerfel>
References: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com> <4E947CA6.9010703@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61366 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1JKSl0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Oct 2011 14:41:26 -0400
In-Reply-To: <4E947CA6.9010703@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, claudio@evidence.eu.com, jesper.nilsson@axis.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tuesday 11 October 2011 19:28:06 Nicolas Ferre wrote:
> 
> > +Optional properties:
> > +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> > +  feature at boot time. It can be disabled later with proper ioctl.
> 
> +- linux,rs485-rx-during-tx: empty property that enable the receiving of data
> +  even whilst sending data.


This does not sound too linux specific. If it's a hardware property, don't
use the 'linux,' prefix and just make it 'rs484-full-duplex' or such.

	Arnd
