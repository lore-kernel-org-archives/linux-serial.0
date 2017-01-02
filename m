From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: atmel: RS485 half duplex w/DMA: enable RX
 after TX is done
Date: Mon, 2 Jan 2017 15:14:37 +0100
Message-ID: <CACQ1gAifm3nWOyfGbugHf4pFDQ7NCks+H+cjZcwEhjPqfJ=5Mw@mail.gmail.com>
References: <20161206120533.14505-1-richard.genoud@gmail.com> <20170102115326.mfly6w5k3dllfpur@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102115326.mfly6w5k3dllfpur@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gil Weber <webergil@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "#4 . 4+" <stable@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

2017-01-02 12:53 GMT+01:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 06/12/2016 at 13:05:33 +0100, Richard Genoud wrote :
>> When using RS485 in half duplex, RX should be enabled when TX is
>> finished, and stopped when TX starts.
>>
>> Before commit 0058f0871efe7b01c6 ("tty/serial: atmel: fix RS485 half
>> duplex with DMA"), RX was not disabled in atmel_start_tx() if the DMA
>> was used. So, collisions could happened.
>>
>> But disabling RX in atmel_start_tx() uncovered another bug:
>> RX was enabled again in the wrong place (in atmel_tx_dma) instead of
>> being enabled when TX is finished (in atmel_complete_tx_dma), so the
>> transmission simply stopped.
>>
>> This bug was not triggered before commit 0058f0871efe7b01c6
>> ("tty/serial: atmel: fix RS485 half duplex with DMA") because RX was
>> never disabled before.
>>
>> Moving atmel_start_rx() in atmel_complete_tx_dma() corrects the problem.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Gil Weber <webergil@gmail.com>
>> Tested-by: Gil Weber <webergil@gmail.com>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
Greg, could you take this patch in your tree ?
