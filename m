From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] tty: serial: mxs-auart: possible concurrency
 use-after-free bugs in mxs_auart_dma_exit_channel()
Date: Mon, 7 Jan 2019 09:52:24 +0100
Message-ID: <20190107085224.GA26384@kroah.com>
References: <8da85649-f539-9c36-a97e-3582844e82fb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8da85649-f539-9c36-a97e-3582844e82fb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 07, 2019 at 04:47:43PM +0800, Jia-Ju Bai wrote:
> The driver functions mxs_auart_settermios(), dma_rx_callback() and dma_tx_callback() can be concurrently executed.
> 
> In Linux 4.19:
> 
> mxs_auart_settermios
>   mxs_auart_dma_exit
>     mxs_auart_dma_exit_channel
>       line 918: kfree(s->tx_dma_buf);
>       line 919: kfree(s->rx_dma_buf);
> 
> dma_rx_callback
>   line 862: tty_insert_flip_string(port, s->rx_dma_buf, count);
>   mxs_auart_dma_prep_rx
>     line 890: sg_init_one(sgl, s->rx_dma_buf, UART_XMIT_SIZE);
> 
> dma_tx_callback
>   mxs_auart_tx_chars
>     line 590: void *buffer = s->tx_dma_buf;
>     mxs_auart_dma_tx
>       line 566: sg_init_one(sgl, s->tx_dma_buf, size);
> 
> Thus, possible concurrency use-after-free bugs may occur.
> 
> These possible bugs are found by a static analysis tool written by myself and my manual code review.

Care to send a patch to fix up this issue?

thanks,

greg k-h
