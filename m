From: "Jongsung Kim" <neidhard.kim@lge.com>
Subject: RE: [PATCH] ARM: bcm2835: override the HW UART periphid
Date: Wed, 22 May 2013 10:52:22 +0900
Message-ID: <013101ce568f$002d6490$00882db0$@lge.com>
References: <519AD82A.6090809@wwwdotorg.org> <1369116149-2361-1-git-send-email-neidhard.kim@lge.com> <519BA209.6050407@wwwdotorg.org> <519C22CB.5040009@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lgeamrelo01.lge.com ([156.147.1.125]:58915 "EHLO
	LGEAMRELO01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab3EVBwZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 May 2013 21:52:25 -0400
In-Reply-To: <519C22CB.5040009@wwwdotorg.org>
Content-Language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Stephen Warren' <swarren@wwwdotorg.org>
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Stephen Warren <swarren@wwwdotorg.org> :
> Looking at the TRM, it seems this is really the only change, according
> to the changelog in the documentation (although it's a little difficult
> to tell since the document seems to have a bunch of changes that
presumably
> don't affect behaviour). So, faking the periphid seems OK.
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> Let's apply for 3.10.

Thank you, Stephen.


