From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Date: Mon, 04 Mar 2013 17:22:49 +0100
Message-ID: <2835497.S76YK1KMLM@wuerfel>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com> <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57034 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDQWv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 11:22:51 -0500
In-Reply-To: <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
> 
> +       sci@e6c40000 {
> +               compatible = "renesas,sci-SCIFA-uart";
> +               interrupt-parent = <&intca>;
> +               reg = <0xe6c40000 0x100>;
> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
> +               cell-index = <0>;
> +               renesas,scscr = <0x30>;
> +               renesas,scbrr-algo-id = <4>;
> +               renesas,autoconf;
> +       };

The default name for a uart is "serial", I would recommend sticking to
that by convention. You may also want to add an "aliases" node
somewhere, to define which port should get which logical device number
on a given board.

	Arnd
