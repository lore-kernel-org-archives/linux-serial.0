From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Fri, 08 May 2015 13:50:47 +0200
Message-ID: <554CA317.8050303@linutronix.de>
References: <20150507202439.GA4717@breakpoint.cc>	<CAOMZO5Dvv2oMujUqtXg0QXZ-VNbwKuRTCOVfcfNYzgWLkHZ1NA@mail.gmail.com>	<20150508071340.GA2603@breakpoint.cc> <CAOMZO5Cu1AG7xYN+uCKnueiwBzBVDhXmqX3FkF3u03Faju4thw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5Cu1AG7xYN+uCKnueiwBzBVDhXmqX3FkF3u03Faju4thw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On 05/08/2015 01:30 PM, Fabio Estevam wrote:
> On Fri, May 8, 2015 at 4:13 AM, Sebastian Andrzej Siewior
> <sebastian@breakpoint.cc> wrote:
> 
>> +
>> +                       /*
>> +                        * Can we enable the DMA support? Be aware that
>> +                        * at least IMX6 needs to load external SDMA firmware in
>> +                        * order work properly. The in-ROM firmware is not
>> +                        * wokring properly.
>> +                        */
> 
> On my tests:
> 
> Prior to this patch: with the internal ROM SDMA firmware I got UART
> issues when communicating through a Bluetooth module. With external
> SDMA firmware (version 3.1) it worked fine.
> 
> With your patch applied: Bluetooth worked fine even with no external
> SDMA firmware, which does not match the comments you added.

Why doesn't it match the comment? The patch disables DMA so the SDMA
firmware does not matter.

> Can't you just remove these comments?
> 
> Thanks

Sebastian
