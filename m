From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v13 2/5] uart: pl011: Introduce register accessor
Date: Sat, 19 Sep 2015 14:46:28 +0800
Message-ID: <CABymUCPKqevt9tBEqLnxT-fen2PLy48QMkCfO+nm7-16wHQ8Og@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-3-git-send-email-jun.nie@linaro.org>
 <55FBECCD.2080906@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55FBECCD.2080906@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jason.liu@linaro.org" <jason.liu@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2015-09-18 18:51 GMT+08:00 Andre Przywara <andre.przywara@arm.com>:
> Hi Jun,
>
> (CC:ing linux-arm-kernel to catch a broader audience)
>
> I assume this is the latest version on the list? If I got the outcome of
> the discussion right, we do more review on this and merge an improved
> version later on.

Yes, version 13 is the latest version patch. Thanks for you comments
and I add reply inline.

>
> On 31/07/15 08:49, Jun Nie wrote:
>> Introduce register accessor to ease loop up table access
>> in later patch.
>
> Wouldn't it make sense to make this the first patch? Then you could get
> rid of patching your own previous patch, possibly also joining patch 1/5
> and 3/5 into a new 2/4.

The previous patch rename register to general name so that register
table can hide the vendor specific offset related name difference. If
get rid of it, you want to use current name and just change specific
names and join it into later patch?

>
> More comments inline ...
>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 263 +++++++++++++++++++++-------------------
>>  1 file changed, 141 insertions(+), 122 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index ee57e2b..29a291d 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -85,23 +85,26 @@ struct vendor_data {
>>         unsigned int (*get_fifosize)(struct amba_device *dev);
>>  };
>>
>> +/* Max address offset of register in use is 0x48 */
>> +#define REG_NR         (0x48 >> 2)
>> +#define IDX(x)         (x >> 2)
>>  enum reg_idx {
>> -       REG_DR          = UART01x_DR,
>> -       REG_RSR         = UART01x_RSR,
>> -       REG_ST_DMAWM    = ST_UART011_DMAWM,
>> -       REG_FR          = UART01x_FR,
>> -       REG_ST_LCRH_RX  = ST_UART011_LCRH_RX,
>> -       REG_ILPR        = UART01x_ILPR,
>> -       REG_IBRD        = UART011_IBRD,
>> -       REG_FBRD        = UART011_FBRD,
>> -       REG_LCRH        = UART011_LCRH,
>> -       REG_CR          = UART011_CR,
>> -       REG_IFLS        = UART011_IFLS,
>> -       REG_IMSC        = UART011_IMSC,
>> -       REG_RIS         = UART011_RIS,
>> -       REG_MIS         = UART011_MIS,
>> -       REG_ICR         = UART011_ICR,
>> -       REG_DMACR       = UART011_DMACR,
>> +       REG_DR          = IDX(UART01x_DR),
>> +       REG_RSR         = IDX(UART01x_RSR),
>> +       REG_ST_DMAWM    = IDX(ST_UART011_DMAWM),
>> +       REG_FR          = IDX(UART01x_FR),
>> +       REG_ST_LCRH_RX  = IDX(ST_UART011_LCRH_RX),
>> +       REG_ILPR        = IDX(UART01x_ILPR),
>> +       REG_IBRD        = IDX(UART011_IBRD),
>> +       REG_FBRD        = IDX(UART011_FBRD),
>> +       REG_LCRH        = IDX(UART011_LCRH),
>> +       REG_CR          = IDX(UART011_CR),
>> +       REG_IFLS        = IDX(UART011_IFLS),
>> +       REG_IMSC        = IDX(UART011_IMSC),
>> +       REG_RIS         = IDX(UART011_RIS),
>> +       REG_MIS         = IDX(UART011_MIS),
>> +       REG_ICR         = IDX(UART011_ICR),
>> +       REG_DMACR       = IDX(UART011_DMACR),
>>  };
>>
>>  static unsigned int get_fifosize_arm(struct amba_device *dev)
>> @@ -203,6 +206,24 @@ struct uart_amba_port {
>>  #endif
>>  };
>>
>> +static unsigned int pl011_readw(struct uart_amba_port *uap, int index)
>> +{
>> +       WARN_ON(index > REG_NR);
>> +       return readw_relaxed(uap->port.membase + (index << 2));
>> +}
>> +
>> +static void pl011_writew(struct uart_amba_port *uap, int val, int index)
>> +{
>> +       WARN_ON(index > REG_NR);
>> +       writew_relaxed(val, uap->port.membase + (index << 2));
>> +}
>
> I wonder if you could rename those to pl011_{read,write}, respectively
> (loosing the "w" suffix).
> The SBSA UART spec reads as the registers are actually accessible via
> 32-bit accesses and rumour has it that there are implementations which
> rely on that and don't work with ldrh/strh.
> I am still waiting for reports about actual hardware to fail, but we
> might be forced to change the access width to 32-bit for the SBSA subset
> in the future. So having wrapper functions would make that change much
> easier, but having them without a suffix from the beginning would even
> be better, as I wouldn't be bothered to rename them later on.

OK, will change to 32-bit access in future version.
>
>> +
>> +static void pl011_writeb(struct uart_amba_port *uap, u8 val, int index)
>> +{
>> +       WARN_ON(index > REG_NR);
>> +       writeb_relaxed(val, uap->port.membase + (index << 2));
>> +}
>> +
>
> As you already know, this one can go, as we don't need it.

Right.

>
>>  /*
>>   * Reads up to 256 characters from the FIFO or until it's empty and
>>   * inserts them into the TTY layer. Returns the number of characters
>> @@ -215,12 +236,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>>         int fifotaken = 0;
>>
>>         while (max_count--) {
>> -               status = readw(uap->port.membase + REG_FR);
>> +               status = pl011_readw(uap, REG_FR);
>>                 if (status & UART01x_FR_RXFE)
>>                         break;
>>
>>                 /* Take chars from the FIFO and update status */
>> -               ch = readw(uap->port.membase + REG_DR) |
>> +               ch = pl011_readw(uap, REG_DR) |
>>                         UART_DUMMY_DR_RX;
>>                 flag = TTY_NORMAL;
>>                 uap->port.icount.rx++;
>> @@ -457,7 +478,7 @@ static void pl011_dma_tx_callback(void *data)
>>
>>         dmacr = uap->dmacr;
>>         uap->dmacr = dmacr & ~UART011_TXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>
>>         /*
>>          * If TX DMA was disabled, it means that we've stopped the DMA for
>> @@ -571,7 +592,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>>         dma_dev->device_issue_pending(chan);
>>
>>         uap->dmacr |= UART011_TXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         uap->dmatx.queued = true;
>>
>>         /*
>> @@ -607,9 +628,9 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>>          */
>>         if (uap->dmatx.queued) {
>>                 uap->dmacr |= UART011_TXDMAE;
>> -               writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +               pl011_writew(uap, uap->dmacr, REG_DMACR);
>>                 uap->im &= ~UART011_TXIM;
>> -               writew(uap->im, uap->port.membase + REG_IMSC);
>> +               pl011_writew(uap, uap->im, REG_IMSC);
>>                 return true;
>>         }
>>
>> @@ -619,7 +640,7 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>>          */
>>         if (pl011_dma_tx_refill(uap) > 0) {
>>                 uap->im &= ~UART011_TXIM;
>> -               writew(uap->im, uap->port.membase + REG_IMSC);
>> +               pl011_writew(uap, uap->im, REG_IMSC);
>>                 return true;
>>         }
>>         return false;
>> @@ -633,7 +654,7 @@ static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
>>  {
>>         if (uap->dmatx.queued) {
>>                 uap->dmacr &= ~UART011_TXDMAE;
>> -               writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +               pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         }
>>  }
>>
>> @@ -659,14 +680,12 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>>                 if (!uap->dmatx.queued) {
>>                         if (pl011_dma_tx_refill(uap) > 0) {
>>                                 uap->im &= ~UART011_TXIM;
>> -                               writew(uap->im, uap->port.membase +
>> -                                      REG_IMSC);
>> +                               pl011_writew(uap, uap->im, REG_IMSC);
>>                         } else
>>                                 ret = false;
>>                 } else if (!(uap->dmacr & UART011_TXDMAE)) {
>>                         uap->dmacr |= UART011_TXDMAE;
>> -                       writew(uap->dmacr,
>> -                                      uap->port.membase + REG_DMACR);
>> +                       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>                 }
>>                 return ret;
>>         }
>> @@ -677,9 +696,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>>          */
>>         dmacr = uap->dmacr;
>>         uap->dmacr &= ~UART011_TXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>
>> -       if (readw(uap->port.membase + REG_FR) & UART01x_FR_TXFF) {
>> +       if (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF) {
>>                 /*
>>                  * No space in the FIFO, so enable the transmit interrupt
>>                  * so we know when there is space.  Note that once we've
>> @@ -688,13 +707,13 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>>                 return false;
>>         }
>>
>> -       writew(uap->port.x_char, uap->port.membase + REG_DR);
>> +       pl011_writew(uap, uap->port.x_char, REG_DR);
>>         uap->port.icount.tx++;
>>         uap->port.x_char = 0;
>>
>>         /* Success - restore the DMA state */
>>         uap->dmacr = dmacr;
>> -       writew(dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, dmacr, REG_DMACR);
>>
>>         return true;
>>  }
>> @@ -722,7 +741,7 @@ __acquires(&uap->port.lock)
>>                              DMA_TO_DEVICE);
>>                 uap->dmatx.queued = false;
>>                 uap->dmacr &= ~UART011_TXDMAE;
>> -               writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +               pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         }
>>  }
>>
>> @@ -762,11 +781,11 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
>>         dma_async_issue_pending(rxchan);
>>
>>         uap->dmacr |= UART011_RXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         uap->dmarx.running = true;
>>
>>         uap->im &= ~UART011_RXIM;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>
>>         return 0;
>>  }
>> @@ -824,8 +843,9 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>>          */
>>         if (dma_count == pending && readfifo) {
>>                 /* Clear any error flags */
>> -               writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
>> -                      uap->port.membase + REG_ICR);
>> +               pl011_writew(uap,
>> +                            UART011_OEIS | UART011_BEIS | UART011_PEIS
>> +                            | UART011_FEIS, REG_ICR);
>>
>>                 /*
>>                  * If we read all the DMA'd characters, and we had an
>> @@ -873,7 +893,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>>
>>         /* Disable RX DMA - incoming data will wait in the FIFO */
>>         uap->dmacr &= ~UART011_RXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         uap->dmarx.running = false;
>>
>>         pending = sgbuf->sg.length - state.residue;
>> @@ -893,7 +913,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>>                 dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
>>                         "fall back to interrupt mode\n");
>>                 uap->im |= UART011_RXIM;
>> -               writew(uap->im, uap->port.membase + REG_IMSC);
>> +               pl011_writew(uap, uap->im, REG_IMSC);
>>         }
>>  }
>>
>> @@ -941,7 +961,7 @@ static void pl011_dma_rx_callback(void *data)
>>                 dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
>>                         "fall back to interrupt mode\n");
>>                 uap->im |= UART011_RXIM;
>> -               writew(uap->im, uap->port.membase + REG_IMSC);
>> +               pl011_writew(uap, uap->im, REG_IMSC);
>>         }
>>  }
>>
>> @@ -954,7 +974,7 @@ static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
>>  {
>>         /* FIXME.  Just disable the DMA enable */
>>         uap->dmacr &= ~UART011_RXDMAE;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>  }
>>
>>  /*
>> @@ -998,7 +1018,7 @@ static void pl011_dma_rx_poll(unsigned long args)
>>                 spin_lock_irqsave(&uap->port.lock, flags);
>>                 pl011_dma_rx_stop(uap);
>>                 uap->im |= UART011_RXIM;
>> -               writew(uap->im, uap->port.membase + REG_IMSC);
>> +               pl011_writew(uap, uap->im, REG_IMSC);
>>                 spin_unlock_irqrestore(&uap->port.lock, flags);
>>
>>                 uap->dmarx.running = false;
>> @@ -1060,7 +1080,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
>>  skip_rx:
>>         /* Turn on DMA error (RX/TX will be enabled on demand) */
>>         uap->dmacr |= UART011_DMAONERR;
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>
>>         /*
>>          * ST Micro variants has some specific dma burst threshold
>> @@ -1068,9 +1088,9 @@ skip_rx:
>>          * be issued above/below 16 bytes.
>>          */
>>         if (uap->vendor->dma_threshold)
>> -               writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
>> -                               uap->port.membase + REG_ST_DMAWM);
>> -
>> +               pl011_writew(uap,
>> +                            ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
>> +                            REG_ST_DMAWM);
>>
>>         if (uap->using_rx_dma) {
>>                 if (pl011_dma_rx_trigger_dma(uap))
>> @@ -1095,12 +1115,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
>>                 return;
>>
>>         /* Disable RX and TX DMA */
>> -       while (readw(uap->port.membase + REG_FR) & UART01x_FR_BUSY)
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_BUSY)
>>                 barrier();
>>
>>         spin_lock_irq(&uap->port.lock);
>>         uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
>> -       writew(uap->dmacr, uap->port.membase + REG_DMACR);
>> +       pl011_writew(uap, uap->dmacr, REG_DMACR);
>>         spin_unlock_irq(&uap->port.lock);
>>
>>         if (uap->using_tx_dma) {
>> @@ -1201,7 +1221,7 @@ static void pl011_stop_tx(struct uart_port *port)
>>             container_of(port, struct uart_amba_port, port);
>>
>>         uap->im &= ~UART011_TXIM;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>         pl011_dma_tx_stop(uap);
>>  }
>>
>> @@ -1211,7 +1231,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>>  {
>>         uap->im |= UART011_TXIM;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>         pl011_tx_chars(uap, false);
>>  }
>>
>> @@ -1231,7 +1251,7 @@ static void pl011_stop_rx(struct uart_port *port)
>>
>>         uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
>>                      UART011_PEIM|UART011_BEIM|UART011_OEIM);
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>
>>         pl011_dma_rx_stop(uap);
>>  }
>> @@ -1242,7 +1262,7 @@ static void pl011_enable_ms(struct uart_port *port)
>>             container_of(port, struct uart_amba_port, port);
>>
>>         uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>  }
>>
>>  static void pl011_rx_chars(struct uart_amba_port *uap)
>> @@ -1262,7 +1282,7 @@ __acquires(&uap->port.lock)
>>                         dev_dbg(uap->port.dev, "could not trigger RX DMA job "
>>                                 "fall back to interrupt mode again\n");
>>                         uap->im |= UART011_RXIM;
>> -                       writew(uap->im, uap->port.membase + REG_IMSC);
>> +                       pl011_writew(uap, uap->im, REG_IMSC);
>>                 } else {
>>  #ifdef CONFIG_DMA_ENGINE
>>                         /* Start Rx DMA poll */
>> @@ -1283,10 +1303,10 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
>>                           bool from_irq)
>>  {
>>         if (unlikely(!from_irq) &&
>> -           readw(uap->port.membase + REG_FR) & UART01x_FR_TXFF)
>> +           pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>                 return false; /* unable to transmit character */
>>
>> -       writew(c, uap->port.membase + REG_DR);
>> +       pl011_writew(uap, c, REG_DR);
>>         uap->port.icount.tx++;
>>
>>         return true;
>> @@ -1333,7 +1353,7 @@ static void pl011_modem_status(struct uart_amba_port *uap)
>>  {
>>         unsigned int status, delta;
>>
>> -       status = readw(uap->port.membase + REG_FR) & UART01x_FR_MODEM_ANY;
>> +       status = pl011_readw(uap, REG_FR) & UART01x_FR_MODEM_ANY;
>>
>>         delta = status ^ uap->old_status;
>>         uap->old_status = status;
>> @@ -1361,15 +1381,15 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
>>                 return;
>>
>>         /* workaround to make sure that all bits are unlocked.. */
>> -       writew(0x00, uap->port.membase + REG_ICR);
>> +       pl011_writew(uap, 0x00, REG_ICR);
>>
>>         /*
>>          * WA: introduce 26ns(1 uart clk) delay before W1C;
>>          * single apb access will incur 2 pclk(133.12Mhz) delay,
>>          * so add 2 dummy reads
>>          */
>> -       dummy_read = readw(uap->port.membase + REG_ICR);
>> -       dummy_read = readw(uap->port.membase + REG_ICR);
>> +       dummy_read = pl011_readw(uap, REG_ICR);
>> +       dummy_read = pl011_readw(uap, REG_ICR);
>>  }
>>
>>  static irqreturn_t pl011_int(int irq, void *dev_id)
>> @@ -1381,15 +1401,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>>         int handled = 0;
>>
>>         spin_lock_irqsave(&uap->port.lock, flags);
>> -       imsc = readw(uap->port.membase + REG_IMSC);
>> -       status = readw(uap->port.membase + REG_RIS) & imsc;
>> +       imsc = pl011_readw(uap, REG_IMSC);
>> +       status = pl011_readw(uap, REG_RIS) & imsc;
>>         if (status) {
>>                 do {
>>                         check_apply_cts_event_workaround(uap);
>> -
>> -                       writew(status & ~(UART011_TXIS|UART011_RTIS|
>> -                                         UART011_RXIS),
>> -                              uap->port.membase + REG_ICR);
>> +                       pl011_writew(uap, status & ~(UART011_TXIS|UART011_RTIS|
>> +                                    UART011_RXIS), REG_ICR);
>>
>>                         if (status & (UART011_RTIS|UART011_RXIS)) {
>>                                 if (pl011_dma_rx_running(uap))
>> @@ -1406,7 +1424,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>>                         if (pass_counter-- == 0)
>>                                 break;
>>
>> -                       status = readw(uap->port.membase + REG_RIS) & imsc;
>> +                       status = pl011_readw(uap, REG_RIS) & imsc;
>>                 } while (status != 0);
>>                 handled = 1;
>>         }
>> @@ -1420,7 +1438,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>>  {
>>         struct uart_amba_port *uap =
>>             container_of(port, struct uart_amba_port, port);
>> -       unsigned int status = readw(uap->port.membase + REG_FR);
>> +       unsigned int status = pl011_readw(uap, REG_FR);
>>         return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
>>  }
>>
>> @@ -1429,7 +1447,7 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
>>         struct uart_amba_port *uap =
>>             container_of(port, struct uart_amba_port, port);
>>         unsigned int result = 0;
>> -       unsigned int status = readw(uap->port.membase + REG_FR);
>> +       unsigned int status = pl011_readw(uap, REG_FR);
>>
>>  #define TIOCMBIT(uartbit, tiocmbit)    \
>>         if (status & uartbit)           \
>> @@ -1449,7 +1467,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>             container_of(port, struct uart_amba_port, port);
>>         unsigned int cr;
>>
>> -       cr = readw(uap->port.membase + REG_CR);
>> +       cr = pl011_readw(uap, REG_CR);
>>
>>  #define        TIOCMBIT(tiocmbit, uartbit)             \
>>         if (mctrl & tiocmbit)           \
>> @@ -1469,7 +1487,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>         }
>>  #undef TIOCMBIT
>>
>> -       writew(cr, uap->port.membase + REG_CR);
>> +       pl011_writew(uap, cr, REG_CR);
>>  }
>>
>>  static void pl011_break_ctl(struct uart_port *port, int break_state)
>> @@ -1480,12 +1498,12 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
>>         unsigned int lcr_h;
>>
>>         spin_lock_irqsave(&uap->port.lock, flags);
>> -       lcr_h = readw(uap->port.membase + uap->lcrh_tx);
>> +       lcr_h = pl011_readw(uap, uap->lcrh_tx);
>>         if (break_state == -1)
>>                 lcr_h |= UART01x_LCRH_BRK;
>>         else
>>                 lcr_h &= ~UART01x_LCRH_BRK;
>> -       writew(lcr_h, uap->port.membase + uap->lcrh_tx);
>> +       pl011_writew(uap, lcr_h, uap->lcrh_tx);
>>         spin_unlock_irqrestore(&uap->port.lock, flags);
>>  }
>>
>> @@ -1495,9 +1513,8 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>>  {
>>         struct uart_amba_port *uap =
>>             container_of(port, struct uart_amba_port, port);
>> -       unsigned char __iomem *regs = uap->port.membase;
>>
>> -       writew(readw(regs + REG_MIS), regs + REG_ICR);
>> +       pl011_writew(uap, pl011_readw(uap, REG_MIS), REG_ICR);
>>         /*
>>          * There is no way to clear TXIM as this is "ready to transmit IRQ", so
>>          * we simply mask it. start_tx() will unmask it.
>> @@ -1511,7 +1528,7 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>>          * (including tx queue), so we're also fine with start_tx()'s caller
>>          * side.
>>          */
>> -       writew(readw(regs + REG_IMSC) & ~UART011_TXIM, regs + REG_IMSC);
>> +       pl011_writew(uap, pl011_readw(uap, REG_IMSC) & ~UART011_TXIM, REG_IMSC);
>>  }
>>
>>  static int pl011_get_poll_char(struct uart_port *port)
>> @@ -1526,11 +1543,11 @@ static int pl011_get_poll_char(struct uart_port *port)
>>          */
>>         pl011_quiesce_irqs(port);
>>
>> -       status = readw(uap->port.membase + REG_FR);
>> +       status = pl011_readw(uap, REG_FR);
>>         if (status & UART01x_FR_RXFE)
>>                 return NO_POLL_CHAR;
>>
>> -       return readw(uap->port.membase + REG_DR);
>> +       return pl011_readw(uap, REG_DR);
>>  }
>>
>>  static void pl011_put_poll_char(struct uart_port *port,
>> @@ -1539,10 +1556,10 @@ static void pl011_put_poll_char(struct uart_port *port,
>>         struct uart_amba_port *uap =
>>             container_of(port, struct uart_amba_port, port);
>>
>> -       while (readw(uap->port.membase + REG_FR) & UART01x_FR_TXFF)
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>                 barrier();
>>
>> -       writew(ch, uap->port.membase + REG_DR);
>> +       pl011_writew(uap, ch, REG_DR);
>>  }
>>
>>  #endif /* CONFIG_CONSOLE_POLL */
>> @@ -1566,15 +1583,15 @@ static int pl011_hwinit(struct uart_port *port)
>>         uap->port.uartclk = clk_get_rate(uap->clk);
>>
>>         /* Clear pending error and receive interrupts */
>> -       writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
>> -              UART011_RTIS | UART011_RXIS, uap->port.membase + REG_ICR);
>> +       pl011_writew(uap, UART011_OEIS | UART011_BEIS | UART011_PEIS |
>> +                    UART011_FEIS | UART011_RTIS | UART011_RXIS, REG_ICR);
>>
>>         /*
>>          * Save interrupts enable mask, and enable RX interrupts in case if
>>          * the interrupt is used for NMI entry.
>>          */
>> -       uap->im = readw(uap->port.membase + REG_IMSC);
>> -       writew(UART011_RTIM | UART011_RXIM, uap->port.membase + REG_IMSC);
>> +       uap->im = pl011_readw(uap, REG_IMSC);
>> +       pl011_writew(uap, UART011_RTIM | UART011_RXIM, REG_IMSC);
>>
>>         if (dev_get_platdata(uap->port.dev)) {
>>                 struct amba_pl011_data *plat;
>> @@ -1588,7 +1605,7 @@ static int pl011_hwinit(struct uart_port *port)
>>
>>  static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>>  {
>> -       writew(lcr_h, uap->port.membase + uap->lcrh_rx);
>> +       pl011_writew(uap, lcr_h, uap->lcrh_rx);
>>         if (uap->lcrh_rx != uap->lcrh_tx) {
>>                 int i;
>>                 /*
>> @@ -1596,14 +1613,14 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>>                  * to get this delay write read only register 10 times
>>                  */
>>                 for (i = 0; i < 10; ++i)
>> -                       writew(0xff, uap->port.membase + REG_MIS);
>> -               writew(lcr_h, uap->port.membase + uap->lcrh_tx);
>> +                       pl011_writew(uap, 0xff, REG_MIS);
>> +               pl011_writew(uap, lcr_h, uap->lcrh_tx);
>>         }
>>  }
>>
>>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>>  {
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>
>>         return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
>>  }
>> @@ -1618,12 +1635,11 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
>>         spin_lock_irq(&uap->port.lock);
>>
>>         /* Clear out any spuriously appearing RX interrupts */
>> -       writew(UART011_RTIS | UART011_RXIS,
>> -              uap->port.membase + REG_ICR);
>> +       pl011_writew(uap, UART011_RTIS | UART011_RXIS, REG_ICR);
>>         uap->im = UART011_RTIM;
>>         if (!pl011_dma_rx_running(uap))
>>                 uap->im |= UART011_RXIM;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>>         spin_unlock_irq(&uap->port.lock);
>>  }
>>
>> @@ -1642,21 +1658,21 @@ static int pl011_startup(struct uart_port *port)
>>         if (retval)
>>                 goto clk_dis;
>>
>> -       writew(uap->vendor->ifls, uap->port.membase + REG_IFLS);
>> +       pl011_writew(uap, uap->vendor->ifls, REG_IFLS);
>>
>>         spin_lock_irq(&uap->port.lock);
>>
>>         /* restore RTS and DTR */
>>         cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
>>         cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
>> -       writew(cr, uap->port.membase + REG_CR);
>> +       pl011_writew(uap, cr, REG_CR);
>>
>>         spin_unlock_irq(&uap->port.lock);
>>
>>         /*
>>          * initialise the old status of the modem signals
>>          */
>> -       uap->old_status = readw(uap->port.membase + REG_FR) &
>> +       uap->old_status = pl011_readw(uap, REG_FR) &
>>                         UART01x_FR_MODEM_ANY;
>>
>>         /* Startup DMA */
>> @@ -1696,11 +1712,11 @@ static int sbsa_uart_startup(struct uart_port *port)
>>  static void pl011_shutdown_channel(struct uart_amba_port *uap,
>>                                         unsigned int lcrh)
>>  {
>> -      unsigned long val;
>> +       unsigned long val;
>>
>> -      val = readw(uap->port.membase + lcrh);
>> -      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
>> -      writew(val, uap->port.membase + lcrh);
>> +       val = pl011_readw(uap, lcrh);
>> +       val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
>> +       pl011_writew(uap, val, lcrh);
>>  }
>>
>>  /*
>> @@ -1714,11 +1730,11 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
>>
>>         uap->autorts = false;
>>         spin_lock_irq(&uap->port.lock);
>> -       cr = readw(uap->port.membase + REG_CR);
>> +       cr = pl011_readw(uap, REG_CR);
>>         uap->old_cr = cr;
>>         cr &= UART011_CR_RTS | UART011_CR_DTR;
>>         cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
>> -       writew(cr, uap->port.membase + REG_CR);
>> +       pl011_writew(uap, cr, REG_CR);
>>         spin_unlock_irq(&uap->port.lock);
>>
>>         /*
>> @@ -1735,8 +1751,8 @@ static void pl011_disable_interrupts(struct uart_amba_port *uap)
>>
>>         /* mask all interrupts and clear all pending ones */
>>         uap->im = 0;
>> -       writew(uap->im, uap->port.membase + REG_IMSC);
>> -       writew(0xffff, uap->port.membase + REG_ICR);
>> +       pl011_writew(uap, uap->im, REG_IMSC);
>> +       pl011_writew(0xffff, REG_ICR);
>>
>>         spin_unlock_irq(&uap->port.lock);
>>  }
>> @@ -1888,8 +1904,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>>                 pl011_enable_ms(port);
>>
>>         /* first, disable everything */
>> -       old_cr = readw(port->membase + REG_CR);
>> -       writew(0, port->membase + REG_CR);
>> +       old_cr = pl011_readw(uap, REG_CR);
>> +       pl011_writew(uap, 0, REG_CR);
>>
>>         if (termios->c_cflag & CRTSCTS) {
>>                 if (old_cr & UART011_CR_RTS)
>> @@ -1922,8 +1938,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>>                         quot -= 2;
>>         }
>>         /* Set baud rate */
>> -       writew(quot & 0x3f, port->membase + REG_FBRD);
>> -       writew(quot >> 6, port->membase + REG_IBRD);
>> +       pl011_writew(uap, quot & 0x3f, REG_FBRD);
>> +       pl011_writew(uap, quot >> 6, REG_IBRD);
>>
>>         /*
>>          * ----------v----------v----------v----------v-----
>> @@ -1932,7 +1948,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>>          * ----------^----------^----------^----------^-----
>>          */
>>         pl011_write_lcr_h(uap, lcr_h);
>> -       writew(old_cr, port->membase + REG_CR);
>> +       pl011_writew(uap, old_cr, REG_CR);
>>
>>         spin_unlock_irqrestore(&port->lock, flags);
>>  }
>> @@ -2073,9 +2089,9 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
>>         struct uart_amba_port *uap =
>>             container_of(port, struct uart_amba_port, port);
>>
>> -       while (readw(uap->port.membase + REG_FR) & UART01x_FR_TXFF)
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>                 barrier();
>> -       writew(ch, uap->port.membase + REG_DR);
>> +       pl011_writew(uap, ch, REG_DR);
>>  }
>>
>>  static void
>> @@ -2100,10 +2116,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>>          *      First save the CR then disable the interrupts
>>          */
>>         if (!uap->vendor->always_enabled) {
>> -               old_cr = readw(uap->port.membase + REG_CR);
>> +               old_cr = pl011_readw(uap, REG_CR);
>>                 new_cr = old_cr & ~UART011_CR_CTSEN;
>>                 new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
>> -               writew(new_cr, uap->port.membase + REG_CR);
>> +               pl011_writew(uap, new_cr, REG_CR);
>>         }
>>
>>         uart_console_write(&uap->port, s, count, pl011_console_putchar);
>> @@ -2113,10 +2129,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>>          *      and restore the TCR
>>          */
>>         do {
>> -               status = readw(uap->port.membase + REG_FR);
>> +               status = pl011_readw(uap, REG_FR);
>>         } while (status & UART01x_FR_BUSY);
>>         if (!uap->vendor->always_enabled)
>> -               writew(old_cr, uap->port.membase + REG_CR);
>> +               pl011_writew(uap, old_cr, REG_CR);
>>
>>         if (locked)
>>                 spin_unlock(&uap->port.lock);
>> @@ -2129,10 +2145,10 @@ static void __init
>>  pl011_console_get_options(struct uart_amba_port *uap, int *baud,
>>                              int *parity, int *bits)
>>  {
>> -       if (readw(uap->port.membase + REG_CR) & UART01x_CR_UARTEN) {
>> +       if (pl011_readw(uap, REG_CR) & UART01x_CR_UARTEN) {
>>                 unsigned int lcr_h, ibrd, fbrd;
>>
>> -               lcr_h = readw(uap->port.membase + uap->lcrh_tx);
>> +               lcr_h = pl011_readw(uap, uap->lcrh_tx);
>>
>>                 *parity = 'n';
>>                 if (lcr_h & UART01x_LCRH_PEN) {
>> @@ -2147,13 +2163,13 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
>>                 else
>>                         *bits = 8;
>>
>> -               ibrd = readw(uap->port.membase + REG_IBRD);
>> -               fbrd = readw(uap->port.membase + REG_FBRD);
>> +               ibrd = pl011_readw(uap, REG_IBRD);
>> +               fbrd = pl011_readw(uap, REG_FBRD);
>>
>>                 *baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
>>
>>                 if (uap->vendor->oversampling) {
>> -                       if (readw(uap->port.membase + REG_CR)
>> +                       if (pl011_readw(uap, REG_CR)
>>                                   & ST_UART011_CR_OVSFACT)
>>                                 *baud *= 2;
>>                 }
>> @@ -2225,10 +2241,13 @@ static struct console amba_console = {
>>
>>  static void pl011_putc(struct uart_port *port, int c)
>>  {
>> -       while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
>> +       struct uart_amba_port *uap =
>> +           container_of(port, struct uart_amba_port, port);
>> +
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
>>                 ;
>> -       writeb(c, port->membase + REG_DR);
>> -       while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
>> +       pl011_writeb(uap, c, REG_DR);
>> +       while (pl011_readw(uap, REG_FR) & UART01x_FR_BUSY)
>>                 ;
>>  }
>
> Just for the records, as this has been discussed before: pl011_putc() is
> called by the earlycon code, before the uart_port is actually
> initialized. So we cannot rely on the accessors, but have to use the
> old-fashioned director accessors for this.
>
> Which means you cannot use that approach to get earlycon support for the
> ZTE UART, if I get this correctly. It shouldn't be to hard to introduce
> another earlycon type specificly for that one, copying pl011_early_write
> and pl011_early_console_setup and changing pl011_putc into
> zte_uart_putc. But of course this belongs into the final patch (or a
> separate one), not in this. So I guess you just leave that function
> unchanged in this patch.

Yeah, I should not change earlycon function at all as the register
table is not initialized yet. But I miss this point as I did not
enable earlycon in my test.

>
> As a side note: I wonder why those accessors here are actually 32-bit
> wide here, and the data register 8-bits only?
> This is in contrast to the rest of the driver, which uses 16-bit
> accesses all of the time (in line with the spec).
>
I have the same wonder, but did try to change it as I not want to
introduce other topic in this patch. Hope other people have clue on
this point.

> Cheers,
> Andre.
>
>>
>> @@ -2355,8 +2374,8 @@ static int pl011_register_port(struct uart_amba_port *uap)
>>         int ret;
>>
>>         /* Ensure interrupts from this UART are masked and cleared */
>> -       writew(0, uap->port.membase + REG_IMSC);
>> -       writew(0xffff, uap->port.membase + REG_ICR);
>> +       pl011_writew(uap, 0, REG_IMSC);
>> +       pl011_writew(uap, 0xffff, REG_ICR);
>>
>>         if (!amba_reg.state) {
>>                 ret = uart_register_driver(&amba_reg);
>> --
>> 1.9.1
>>
