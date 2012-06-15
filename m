From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] serial: imx: Remove unneeded '#ifdef CONFIG_OF'
Date: Fri, 15 Jun 2012 15:33:33 -0300
Message-ID: <CAOMZO5Cj_YaO+sn+wRzb-uRBcFDc75gsJ1AeuTEPc2a8YRpEVA@mail.gmail.com>
References: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62949 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab2FOSdf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 14:33:35 -0400
Received: by bkcji2 with SMTP id ji2so2643699bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 11:33:33 -0700 (PDT)
In-Reply-To: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, shawn.guo@linaro.org, Alan Cox <alan@linux.intel.com>

On Fri, Jun 15, 2012 at 2:23 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> CONFIG_OF is always selected for imx SoCs so it is safe
> to drop the '#ifdef CONFIG_OF'.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Please discard this series.
