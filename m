From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 09:01:17 -0300
Message-ID: <CAOMZO5CWtJO6Ka0sM+ZNrK+dTLDQ9eXFj-XvFXdkZND1_F40NQ@mail.gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
	<1339759950-5507-2-git-send-email-festevam@gmail.com>
	<201206151349.27261.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44365 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab2FOMBT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 08:01:19 -0400
Received: by bkcji2 with SMTP id ji2so2322646bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 05:01:17 -0700 (PDT)
In-Reply-To: <201206151349.27261.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, kernel@pengutronix.de, matt@grid-net.com, snijsure@grid-net.com, rob.herring@calxeda.com, Fabio Estevam <fabio.estevam@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Hi Marek,

On Fri, Jun 15, 2012 at 8:49 AM, Marek Vasut <marex@denx.de> wrote:

>> +#ifdef CONFIG_OF
>
> Isn't CONFIG_OF always enabled?

Not always necessarily. You can boot mx23/mx28 via non-DT kernel.

The serial imx driver also does the same thing about this.
