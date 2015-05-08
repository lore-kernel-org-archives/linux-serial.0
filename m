From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Fri, 8 May 2015 08:30:45 -0300
Message-ID: <CAOMZO5Cu1AG7xYN+uCKnueiwBzBVDhXmqX3FkF3u03Faju4thw@mail.gmail.com>
References: <20150507202439.GA4717@breakpoint.cc>
	<CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
	<20150508071340.GA2603@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150508071340.GA2603@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 8, 2015 at 4:13 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:

> +
> +                       /*
> +                        * Can we enable the DMA support? Be aware that
> +                        * at least IMX6 needs to load external SDMA firmware in
> +                        * order work properly. The in-ROM firmware is not
> +                        * wokring properly.
> +                        */

On my tests:

Prior to this patch: with the internal ROM SDMA firmware I got UART
issues when communicating through a Bluetooth module. With external
SDMA firmware (version 3.1) it worked fine.

With your patch applied: Bluetooth worked fine even with no external
SDMA firmware, which does not match the comments you added.

Can't you just remove these comments?

Thanks
