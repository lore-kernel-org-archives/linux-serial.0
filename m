From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
Date: Sun, 24 Jan 2016 21:37:21 +0100
Message-ID: <20160124203720.GA29010@samfundet.no>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124200959.GA15633@samfundet.no>
 <yw1xsi1mlogt.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xsi1mlogt.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Around Sun 24 Jan 2016 20:19:46 +0000 or thereabout, M=E5ns Rullg=E5rd =
wrote:
> Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> writes:
>> Around Sun 24 Jan 2016 19:21:50 +0000 or thereabout, Mans Rullgard w=
rote:
>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>=20
>>> The source and destination masters are reflecting buses or their la=
yers to
>>> where the different devices can be connected. The patch changes the=
 master
>>> names to reflect which one is related to which independently on the=
 transfer
>>> direction.
>>>=20
>>> The outcome of the change is that the memory data width is now alwa=
ys limited
>>> by a data width of the master which is dedicated to communicate to =
memory.
>>>=20
>>> The patch will not break anything since all current users have the =
same data
>>> width for all masters. Though it would be nice to revisit avr32 pla=
forms to
>>> check what is the actual hardware topology is used there. It seems =
that it has
>>> one bus and two masters on it as stated by Table 8-2, that's why ev=
erything
>>> works independently on the master in use. The purpose of the sequen=
tial patch
>>> is to fix the driver for configuration of more that one bus.
>>
>> Not entirely sure what you want to have confirmed here. There are mu=
ltiple
>> masters and slaves on the HMATRIX internal bus on AVR32, and the DMA
>> controller supports up to three simultaneous configurations.
>>
>> Sounds good to support configuration of more than one bus. I thought=
 we
>> always did support that? Perhaps it was a non-standard avr32 impleme=
ntation.
>=20
> The DW DMA controller on the AT32AP7000 serves the MCI, AC97, and ABD=
AC
> peripherals.  It appears to work regardless of the values put in the
> various master select fields.  Perhaps the topology is hardwired in t=
he
> DMA controller and those fields are ignored.  The AVR32 works both
> before and after this patch series, the main purpose of which (at lea=
st
> my patches) is to fix the SATA driver on 460EX.

DEST_PER and SRC_PER in the DMA controller selects this, numbers placed=
 here
should match the table you most likely found, 9-3.

Wiring the handshake connections is done with the struct dw_dma_slave s=
rc_id
or dst_id member, depending on data direction. Configured in the at32ap=
700x.c
machine code.

It is not hard wired on avr32, as there are not one-to-one configuratio=
ns and
masters.

>>> The change is done in the assumption that src_master and dst_master=
 are
>>> reflecting a connection to the memory and peripheral correspondentl=
y on all
>>> platforms except 460ex.

OK, I have no knowledge about the 460ex.

>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>
>> For the avr32 related stuff:
>>
>> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>>
>>> ---
>>>  Documentation/devicetree/bindings/dma/snps-dma.txt |  4 ++--
>>>  arch/avr32/mach-at32ap/at32ap700x.c                | 16 ++++++++--=
------
>>>  drivers/ata/sata_dwc_460ex.c                       |  4 ++--
>>>  drivers/dma/dw/core.c                              | 15 +++++++---=
-----
>>>  drivers/dma/dw/platform.c                          | 12 ++++++----=
--
>>>  drivers/dma/dw/regs.h                              |  4 ++--
>>>  drivers/spi/spi-pxa2xx-pci.c                       |  8 ++++----
>>>  drivers/tty/serial/8250/8250_pci.c                 |  8 ++++----
>>>  include/linux/platform_data/dma-dw.h               |  8 ++++----
>>>  9 files changed, 39 insertions(+), 40 deletions(-)
>>
>> <snipp diff>
--=20
Best regards, Hans-Christian Egtvedt
