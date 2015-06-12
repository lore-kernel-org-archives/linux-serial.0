From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Fri, 12 Jun 2015 15:30:01 +0200
Message-ID: <557ADED9.5070802@linutronix.de>
References: <20150507202439.GA4717@breakpoint.cc>	<CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>	<20150508071340.GA2603@breakpoint.cc> <CAOMZO5BLeKyeOFd8=VTM_44KEGeVVxYOz2_XX0XQcGSwCS7Xkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BLeKyeOFd8=VTM_44KEGeVVxYOz2_XX0XQcGSwCS7Xkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On 05/19/2015 02:18 PM, Fabio Estevam wrote:
> Hi Sebastian,

Hi Fabio,

> Could you please test Philipp's patch?
> http://marc.info/?l=linux-serial&m=143202566332128&q=raw
> 
> It worked on my tests and DMA still works with his patch, so I would
> prefer his solution.

It seems to work here, too. Thanks.

> 
> Thanks,
> 
> Fabio Estevam

Sebastian
