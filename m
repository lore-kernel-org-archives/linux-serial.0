From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 8/8] serial: tegra: Correct error handling on DMA setup
Date: Wed, 13 May 2015 13:56:41 +0900
Message-ID: <CAAVeFuLUVHJMPjy3y6bw9J7iQHb+is-SR_5H-=TCe4yoyEGRqQ@mail.gmail.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
 <1430835479-6613-9-git-send-email-jonathanh@nvidia.com> <CAAVeFuL=z-xbGT1e_L6+_GQ8aZ0BvNBfmoi65u_7qVHv=tpTbA@mail.gmail.com>
 <5551CD25.4030206@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5551CD25.4030206@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 12, 2015 at 6:51 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 12/05/15 09:39, Alexandre Courbot wrote:
>> On Tue, May 5, 2015 at 11:17 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Function tegra_uart_dma_channel_allocate() does not check that
>>> dma_map_single() mapped the DMA buffer correctly. Add a check for this
>>> and appropriate error handling.
>>>
>>> Furthermore, if dmaengine_slave_config() (called by
>>> tegra_uart_dma_channel_allocate()) fails, then memory allocated/mapped
>>> is not freed/unmapped. Therefore, call tegra_uart_dma_channel_free()
>>> instead of just dma_release_channel() if  dmaengine_slave_config() fails.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>  drivers/tty/serial/serial-tegra.c | 51 +++++++++++++++++++++------------------
>>>  1 file changed, 28 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
>>> index 96378da9aefc..3b63f103f0c9 100644
>>> --- a/drivers/tty/serial/serial-tegra.c
>>> +++ b/drivers/tty/serial/serial-tegra.c
>>> @@ -949,6 +949,28 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>>>         return 0;
>>>  }
>>>
>>> +static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
>>> +               bool dma_to_memory)
>>> +{
>>> +       if (dma_to_memory) {
>>> +               dmaengine_terminate_all(tup->rx_dma_chan);
>>> +               dma_release_channel(tup->rx_dma_chan);
>>> +               dma_free_coherent(tup->uport.dev, TEGRA_UART_RX_DMA_BUFFER_SIZE,
>>> +                               tup->rx_dma_buf_virt, tup->rx_dma_buf_phys);
>>> +               tup->rx_dma_chan = NULL;
>>> +               tup->rx_dma_buf_phys = 0;
>>> +               tup->rx_dma_buf_virt = NULL;
>>> +       } else {
>>> +               dmaengine_terminate_all(tup->tx_dma_chan);
>>> +               dma_release_channel(tup->tx_dma_chan);
>>> +               dma_unmap_single(tup->uport.dev, tup->tx_dma_buf_phys,
>>> +                       UART_XMIT_SIZE, DMA_TO_DEVICE);
>>> +               tup->tx_dma_chan = NULL;
>>> +               tup->tx_dma_buf_phys = 0;
>>> +               tup->tx_dma_buf_virt = NULL;
>>> +       }
>>> +}
>>> +
>>>  static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>>>                         bool dma_to_memory)
>>>  {
>>> @@ -981,6 +1003,11 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>>>                 dma_phys = dma_map_single(tup->uport.dev,
>>>                         tup->uport.state->xmit.buf, UART_XMIT_SIZE,
>>>                         DMA_TO_DEVICE);
>>> +               if (dma_mapping_error(tup->uport.dev, dma_phys)) {
>>> +                       dev_err(tup->uport.dev, "dma_map_single tx failed\n");
>>> +                       dma_release_channel(dma_chan);
>>> +                       return -ENOMEM;
>>
>> Is -ENOMEM the error code we want to return here?
>
> I think that it is appropriate as we are unable to map the memory we are
> requesting. I did look at a few other drivers and several return -ENOMEM
> here. I saw others return -EFAULT, but given this is memory related,
> seems ok, unless you have a better suggestion.
>
>> IIUC dma_buf will be leaked if an error occurs here because it has not
>> been assigned to your structure and will therefore be ignored when
>> tegra_uart_dma_channel_free() is called.
>
> In the original code, if dmaengine_slave_config() failed, then yes there
> would be a memory leak. That should no longer be the case.

Mmm I am pretty sure that even after your patch the memory allocated
through the DMA API will not be freed if we hit an error there,
because dma_buf/dma_phys are not yet affected to your tegra_uart_port
structure when you call dma_release_channel(). Or maybe I am missing
something?

>
>> Since we have a "scrub" label at the end of this function, I think I'd
>> also prefer if this block and the one before could jump to error
>> labels as well for consistency.
>
> Yes I see. I wondered if it would be better to just get rid of the
> "scrub" label since it is only used in one place instead?

I am fine with whichever makes the most sense, although I am biased
towards having all error handing at the end of the function. But your
call.

>
> By the way, I got a notification from Greg that these are now queued in
> his tty-testing branch [1]. Assuming these are ok, may be I could fix
> that up in a follow-up patch?

Sounds good!
