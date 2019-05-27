From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Date: Mon, 27 May 2019 21:56:30 +0200
Message-ID: <5c7e21b6-3701-a685-02c6-a584996aa811@metux.net>
References: <87bm05mpmx.fsf@haabendal.dk> <20190514104741.GO4319@dell>
 <20190514122618.GA18859@kroah.com> <87imudky2o.fsf@haabendal.dk>
 <20190521100904.GA13612@kroah.com> <87pnocm59v.fsf@haabendal.dk>
 <20190521111817.GA24911@kroah.com> <87lfz0m3ge.fsf@haabendal.dk>
 <20190521125651.GA6264@kroah.com> <87h89nnajr.fsf@haabendal.dk>
 <20190521144319.GA28747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521144319.GA28747@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 21.05.19 16:43, Greg Kroah-Hartman wrote:

Hi,

> Sometimes you need to go tell the hardware/firmware people not to do
> foolish things.  You can not always fix their problems in software.
> Please push back on this.

I've often been in the same situation. It's hopeless with those folks.
Even worse: you give'em a clear spec on how the register interface
shall look like, and they make something really weird out of it
(shuffled byte orders, multiplexing irqs over a single gpio line and
leave the other's empty instead of just one gpio per irq, ...)

The kernel is full of buggy hardware, because hw folks seem not really
capable of doing their homework :(

Actually, the whole existance of these hundreds of different uart
devices, IMHO, is a clear sing of hw folks not doing the homework.


By the way: I've somewhat lost track of what the patch was actually
about ... :o


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
