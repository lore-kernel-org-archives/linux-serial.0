From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Tue, 19 May 2015 09:18:37 -0300
Message-ID: <CAOMZO5BLeKyeOFd8=VTM_44KEGeVVxYOz2_XX0XQcGSwCS7Xkg@mail.gmail.com>
References: <20150507202439.GA4717@breakpoint.cc>
	<CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
	<20150508071340.GA2603@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150508071340.GA2603@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Sebastian,

On Fri, May 8, 2015 at 4:13 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> This basically reverts commit 068500e08dc8 ("serial: imx: initialized
> DMA w/o HW flow enabled") simply because it does not work.
> I tested it on various IMX6 boards and the default SDMA firmware, that is
> included in ROM, does not work properly. The SDMA interrupt counter does
> not stop increment (which means the SDMA does not stop working) and I see
> a lot of 0x00 (sometimes other bytes) which are added to the tty buffer
> which are not part of the data transfer.
> Jiada claimed that there is a firmware which makes it work but failed to
> provide me a link to the firmware. All he said was that it can not be
> shipped as part of the kernel due to license issues. I've found one
> firmware in the FSL-tree but this firmware causes only TTY-overflows and
> *no* data is transmitted.
>
> Currently I see no other way out.

Could you please test Philipp's patch?
http://marc.info/?l=linux-serial&m=143202566332128&q=raw

It worked on my tests and DMA still works with his patch, so I would
prefer his solution.

Thanks,

Fabio Estevam
