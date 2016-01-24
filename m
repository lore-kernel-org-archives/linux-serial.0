From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual topology
Date: Sun, 24 Jan 2016 20:57:35 +0000
Message-ID: <yw1xoacalmps.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
	<1453663322-14474-4-git-send-email-mans@mansr.com>
	<20160124200959.GA15633@samfundet.no>
	<yw1xsi1mlogt.fsf@unicorn.mansr.com>
	<20160124203720.GA29010@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160124203720.GA29010-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org> (Hans-Christian Noren
	Egtvedt's message of "Sun, 24 Jan 2016 21:37:21 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
Cc: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org> writes:

> Around Sun 24 Jan 2016 20:19:46 +0000 or thereabout, M=E5ns Rullg=E5r=
d wrote:
>> Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org> writes:
>>> Around Sun 24 Jan 2016 19:21:50 +0000 or thereabout, Mans Rullgard =
wrote:
>>>> From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>>=20
>>>> The source and destination masters are reflecting buses or their l=
ayers to
>>>> where the different devices can be connected. The patch changes th=
e master
>>>> names to reflect which one is related to which independently on th=
e transfer
>>>> direction.
>>>>=20
>>>> The outcome of the change is that the memory data width is now alw=
ays limited
>>>> by a data width of the master which is dedicated to communicate to=
 memory.
>>>>=20
>>>> The patch will not break anything since all current users have the=
 same data
>>>> width for all masters. Though it would be nice to revisit avr32 pl=
aforms to
>>>> check what is the actual hardware topology is used there. It seems=
 that it has
>>>> one bus and two masters on it as stated by Table 8-2, that's why e=
verything
>>>> works independently on the master in use. The purpose of the seque=
ntial patch
>>>> is to fix the driver for configuration of more that one bus.
>>>
>>> Not entirely sure what you want to have confirmed here. There are m=
ultiple
>>> masters and slaves on the HMATRIX internal bus on AVR32, and the DM=
A
>>> controller supports up to three simultaneous configurations.
>>>
>>> Sounds good to support configuration of more than one bus. I though=
t we
>>> always did support that? Perhaps it was a non-standard avr32 implem=
entation.
>>=20
>> The DW DMA controller on the AT32AP7000 serves the MCI, AC97, and AB=
DAC
>> peripherals.  It appears to work regardless of the values put in the
>> various master select fields.  Perhaps the topology is hardwired in =
the
>> DMA controller and those fields are ignored.  The AVR32 works both
>> before and after this patch series, the main purpose of which (at le=
ast
>> my patches) is to fix the SATA driver on 460EX.
>
> DEST_PER and SRC_PER in the DMA controller selects this, numbers plac=
ed here
> should match the table you most likely found, 9-3.
>
> Wiring the handshake connections is done with the struct dw_dma_slave=
 src_id
> or dst_id member, depending on data direction. Configured in the at32=
ap700x.c
> machine code.
>
> It is not hard wired on avr32, as there are not one-to-one configurat=
ions and
> masters.

This is about the SMS (Source Master Select) and DMS (Destination Maste=
r
Select) fields in the CTLxL register and the LMS (List Master Select)
field in the LLPx register.

>>>> The change is done in the assumption that src_master and dst_maste=
r are
>>>> reflecting a connection to the memory and peripheral correspondent=
ly on all
>>>> platforms except 460ex.
>
> OK, I have no knowledge about the 460ex.
>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>> Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
>>>
>>> For the avr32 related stuff:
>>>
>>> Acked-by: Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
>>>
>>>> ---
>>>>  Documentation/devicetree/bindings/dma/snps-dma.txt |  4 ++--
>>>>  arch/avr32/mach-at32ap/at32ap700x.c                | 16 ++++++++-=
-------
>>>>  drivers/ata/sata_dwc_460ex.c                       |  4 ++--
>>>>  drivers/dma/dw/core.c                              | 15 +++++++--=
------
>>>>  drivers/dma/dw/platform.c                          | 12 ++++++---=
---
>>>>  drivers/dma/dw/regs.h                              |  4 ++--
>>>>  drivers/spi/spi-pxa2xx-pci.c                       |  8 ++++----
>>>>  drivers/tty/serial/8250/8250_pci.c                 |  8 ++++----
>>>>  include/linux/platform_data/dma-dw.h               |  8 ++++----
>>>>  9 files changed, 39 insertions(+), 40 deletions(-)
>>>
>>> <snipp diff>
> --=20
> Best regards, Hans-Christian Egtvedt

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
