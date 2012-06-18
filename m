From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Mon, 18 Jun 2012 17:50:49 -0300
Message-ID: <CAOMZO5CHJGCE0fwh=u65gO7P8c8hT9Yd5+3__rFtmNMLstTwEQ@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
	<1340024769-7122-1-git-send-email-fabio.estevam@freescale.com>
	<4FDF929B.7000809@grid-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2FRUuu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 16:50:50 -0400
Received: by bkcji2 with SMTP id ji2so4488705bkc.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 13:50:49 -0700 (PDT)
In-Reply-To: <4FDF929B.7000809@grid-net.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <snijsure@grid-net.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, kernel@pengutronix.de, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, "Matt@grid-net.com" <Matt@grid-net.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Mon, Jun 18, 2012 at 5:42 PM, Subodh Nijsure <snijsure@grid-net.com> wrote:
>
> If one were to try run console on one of the /dev/ttyAPP* ports, as is the
> case for hardware I am working with, console output wouldn't show up without
> the following diff:
>
> Let me know if should send formal patch or we can include it as part of v5?

Please send a formal patch. Shawn has already applied my patch into his tree:
http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/mxs/for-next
