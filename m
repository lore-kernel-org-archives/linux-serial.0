From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Enabling auto RS485 half-duplex control
Date: Wed, 17 Dec 2008 22:24:13 +0100
Message-ID: <200812172224.13608.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:58927 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbYLQVYU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Dec 2008 16:24:20 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 64801183613
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2008 22:24:18 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 4CE4C23D2F3
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2008 22:24:18 +0100 (CET)
Received: from bunny.home (dslb-088-070-062-165.pools.arcor-ip.net [88.70.62.165])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 2D35A1BF572
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2008 22:24:15 +0100 (CET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 4E66525104CB
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2008 22:24:11 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

some Exar UARTs like the XR16C2850 support a feature
called auto RS485 half-duplex control. In this mode the
RTS line has a special role when using the UART for 
RS485 communication.

I did not find a way to enable this mode through the 
standard serial driver. The UART is is detected correctly
but there seems to be no way to enable this mode
out of the box.

So what's the best way to implement this?
A new ioctl? Any idea?

Matthias



