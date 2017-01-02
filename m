From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: atmel: RS485 half duplex w/DMA: enable RX
 after TX is done
Date: Mon, 2 Jan 2017 12:53:26 +0100
Message-ID: <20170102115326.mfly6w5k3dllfpur@piout.net>
References: <20161206120533.14505-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161206120533.14505-1-richard.genoud@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Gil Weber <webergil@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/12/2016 at 13:05:33 +0100, Richard Genoud wrote :
> When using RS485 in half duplex, RX should be enabled when TX is
> finished, and stopped when TX starts.
> 
> Before commit 0058f0871efe7b01c6 ("tty/serial: atmel: fix RS485 half
> duplex with DMA"), RX was not disabled in atmel_start_tx() if the DMA
> was used. So, collisions could happened.
> 
> But disabling RX in atmel_start_tx() uncovered another bug:
> RX was enabled again in the wrong place (in atmel_tx_dma) instead of
> being enabled when TX is finished (in atmel_complete_tx_dma), so the
> transmission simply stopped.
> 
> This bug was not triggered before commit 0058f0871efe7b01c6
> ("tty/serial: atmel: fix RS485 half duplex with DMA") because RX was
> never disabled before.
> 
> Moving atmel_start_rx() in atmel_complete_tx_dma() corrects the problem.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Gil Weber <webergil@gmail.com>
> Tested-by: Gil Weber <webergil@gmail.com>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
