From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 8/8] serial: tegra: Correct error handling on DMA setup
Date: Wed, 20 May 2015 12:57:58 +0900
Message-ID: <CAAVeFuL8XoQUykpVbzgJiYNkoXA0e7c1k95nvB6Q+wZUHjOjSw@mail.gmail.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
 <1430835479-6613-9-git-send-email-jonathanh@nvidia.com> <CAAVeFuL=z-xbGT1e_L6+_GQ8aZ0BvNBfmoi65u_7qVHv=tpTbA@mail.gmail.com>
 <5551CD25.4030206@nvidia.com> <CAAVeFuLUVHJMPjy3y6bw9J7iQHb+is-SR_5H-=TCe4yoyEGRqQ@mail.gmail.com>
 <555309F4.1080306@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555309F4.1080306@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 13, 2015 at 5:23 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 13/05/15 05:56, Alexandre Courbot wrote:
>> On Tue, May 12, 2015 at 6:51 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>> On 12/05/15 09:39, Alexandre Courbot wrote:
>>>> On Tue, May 5, 2015 at 11:17 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>> Function tegra_uart_dma_channel_allocate() does not check that
>>>>> dma_map_single() mapped the DMA buffer correctly. Add a check for this
>>>>> and appropriate error handling.
>>>>>
>>>>> Furthermore, if dmaengine_slave_config() (called by
>>>>> tegra_uart_dma_channel_allocate()) fails, then memory allocated/mapped
>>>>> is not freed/unmapped. Therefore, call tegra_uart_dma_channel_free()
>>>>> instead of just dma_release_channel() if  dmaengine_slave_config() fails.
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>>  drivers/tty/serial/serial-tegra.c | 51 +++++++++++++++++++++------------------
>>>>>  1 file changed, 28 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
>>>>> index 96378da9aefc..3b63f103f0c9 100644
>>>>> --- a/drivers/tty/serial/serial-tegra.c
>>>>> +++ b/drivers/tty/serial/serial-tegra.c
>>>>> @@ -949,6 +949,28 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>>>>>         return 0;
>>>>>  }
>>>>>
>>>>> +static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
>>>>> +               bool dma_to_memory)
>>>>> +{
>>>>> +       if (dma_to_memory) {
>>>>> +               dmaengine_terminate_all(tup->rx_dma_chan);
>>>>> +               dma_release_channel(tup->rx_dma_chan);
>>>>> +               dma_free_coherent(tup->uport.dev, TEGRA_UART_RX_DMA_BUFFER_SIZE,
>>>>> +                               tup->rx_dma_buf_virt, tup->rx_dma_buf_phys);
>>>>> +               tup->rx_dma_chan = NULL;
>>>>> +               tup->rx_dma_buf_phys = 0;
>>>>> +               tup->rx_dma_buf_virt = NULL;
>>>>> +       } else {
>>>>> +               dmaengine_terminate_all(tup->tx_dma_chan);
>>>>> +               dma_release_channel(tup->tx_dma_chan);
>>>>> +               dma_unmap_single(tup->uport.dev, tup->tx_dma_buf_phys,
>>>>> +                       UART_XMIT_SIZE, DMA_TO_DEVICE);
>>>>> +               tup->tx_dma_chan = NULL;
>>>>> +               tup->tx_dma_buf_phys = 0;
>>>>> +               tup->tx_dma_buf_virt = NULL;
>>>>> +       }
>>>>> +}
>>>>> +
>>>>>  static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>>>>>                         bool dma_to_memory)
>>>>>  {
>>>>> @@ -981,6 +1003,11 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
>>>>>                 dma_phys = dma_map_single(tup->uport.dev,
>>>>>                         tup->uport.state->xmit.buf, UART_XMIT_SIZE,
>>>>>                         DMA_TO_DEVICE);
>>>>> +               if (dma_mapping_error(tup->uport.dev, dma_phys)) {
>>>>> +                       dev_err(tup->uport.dev, "dma_map_single tx failed\n");
>>>>> +                       dma_release_channel(dma_chan);
>>>>> +                       return -ENOMEM;
>>>>
>>>> Is -ENOMEM the error code we want to return here?
>>>
>>> I think that it is appropriate as we are unable to map the memory we are
>>> requesting. I did look at a few other drivers and several return -ENOMEM
>>> here. I saw others return -EFAULT, but given this is memory related,
>>> seems ok, unless you have a better suggestion.
>>>
>>>> IIUC dma_buf will be leaked if an error occurs here because it has not
>>>> been assigned to your structure and will therefore be ignored when
>>>> tegra_uart_dma_channel_free() is called.
>>>
>>> In the original code, if dmaengine_slave_config() failed, then yes there
>>> would be a memory leak. That should no longer be the case.
>>
>> Mmm I am pretty sure that even after your patch the memory allocated
>> through the DMA API will not be freed if we hit an error there,
>> because dma_buf/dma_phys are not yet affected to your tegra_uart_port
>> structure when you call dma_release_channel(). Or maybe I am missing
>> something?
>
> So there are two paths through the tegra_uart_dma_channel_allocate()
> function, one for RX and one for TX. In the RX case, a buffer is
> allocated via dma_alloc_coherent() and if this fails, then we simply
> call dma_release_channel(). So there should not be any memory leaked in
> this path and we should not need to worry about dma_buf/dma_phys here.
>
> In the TX case, the xmit.buf (allocated by the serial_core driver) is
> mapped to physical space for DMA. If the mapping fails, the xmit.buf is
> not freed here and we simply call dma_release_channel().
>
> If you are concerned about the xmit.buf, then this is part serial core
> and allocated when uart_open() is called. It uart_open() fails, because
> the tegra_uart_dma_channel_allocate() fails, then uart_close() will be
> called (according the to kernel-doc for uart_open) and should be freed
> when uart_shutdown() is called. So I don't see a problem here.
>
> Let me know if I am misunderstanding you.

You are right - I overlooked the fact there were RX and TX paths.

There may still be a leak (that is not related to your patch) in the
RX path though:

    dma_buf = dma_alloc_coherent(...);
    ret = dmaengine_slave_config(...);
    if (ret < 0) {
        ...
        goto scrub;
    }

    tup->rx_dma_buf_virt = dma_buf;
    tup->rx_dma_buf_phys = dma_phys;

scrub:
    dma_release_channel(dma_chan);
    return ret;

It seems that if dmaengine_slave_config() fails, then the result of
dma_alloc_coherent() remains purely local to the function and is never
freed. Or am I missing something again?
