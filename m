From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] serial: imx: enable the clocks only when the uart is
 used
Date: Tue, 4 Jun 2013 10:12:43 +0800
Message-ID: <51AD4D1B.5020106@freescale.com>
References: <1370245331-12501-1-git-send-email-b32955@freescale.com> <20130603095014.GJ18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:41328
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759322Ab3FDCJ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:09:57 -0400
In-Reply-To: <20130603095014.GJ18614@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B406=E6=9C=8803=E6=97=A5 17:50, Russell King - ARM=
 Linux =E5=86=99=E9=81=93:
> You should check the return value.  I've a good mind to mark these
> functions with __must_check...
yes, that's a good idea to add the __must_check.

thanks
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
