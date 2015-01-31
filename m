From: "Michael Doswald" <michael.doswald@gmx.net>
Subject: Re: [PATCH] 3.19-rc4: Fix race condition in i.MX serial port driver
Date: Sat, 31 Jan 2015 15:03:29 +0100
Message-ID: <trinity-9d19a383-9282-48e7-bcaf-2da48e937031-1422713009062@3capp-gmx-bs71>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 31.01.2015 00:25, Greg KH wrote:
>> Under pressure, the imx.c device driver may transfer the same data m=
ultiple
>> times.=20
>>
>> Reason:=20
>> Function imx_dma_tx checks for an active DMA transfer by calling
>> dmaengine_tx_status. The return value may indicate that no transfer =
is=20
>> running while the dma_tx_callback function is still being executed. =
In=20
>> this case the xmit->tail pointer may not be updated to the correct v=
alue=20
>> when imx_dma_tx initiates a new DMA transfer, which will result in a=
 DMA
>> transfer with the same base address as the previous one.
>>
>> Patch:
>> Use existing dma_is_txing variable to guard DMA transfer initiation =
instead
>> of dmaengine_tx_status. Clear dma_is_txing at the end of the DMA cal=
lback
>> function therefore extending the critical section where the port loc=
k is
>> held. Critical section extension is in line with the callback functi=
on=20
>> of other drivers, e.g. serial-tegra.c (tegra_uart_tx_dma_complete).
>> =20
>> =20
>> Signed-off-by: Michael Doswald <michael.doswald@gmx.net>
>> ---
>>  drivers/tty/serial/imx.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> Fails to apply to my tree :(
>

Hi,

I'm sorry, it seems I made the mistake to create the patch against 3.19=
-rc3 instead of rc4. I just saw that the rc4 tree already contains a pa=
tch which fixes the exact same problem (commit 42f752b3fbcfee9c27e4f6f6=
216e60e130ba98c8 by Dirk Behme).

Thank you for notifying me.

Regards,
Michael
=C2=A0
