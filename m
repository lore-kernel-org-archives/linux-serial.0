From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Fri, 8 May 2015 09:24:45 -0300
Message-ID: <CAOMZO5AW-6bVbaqGX3G5LakF5My+BWdkP7GT=uJaULRe6umHAg@mail.gmail.com>
References: <20150507202439.GA4717@breakpoint.cc>
	<CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>
	<20150508071340.GA2603@breakpoint.cc>
	<CAOMZO5Cu1AG7xYN+uCKnueiwBzBVDhXmqX3FkF3u03Faju4thw@mail.gmail.com>
	<554CA317.8050303@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554CA317.8050303@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 8, 2015 at 8:50 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> Why doesn't it match the comment? The patch disables DMA so the SDMA
> firmware does not matter.

Got it. It is clear now, thanks.
