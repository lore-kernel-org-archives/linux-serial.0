From: Elen Song <elen.song@atmel.com>
Subject: Re: [PATCH 1/6] DMA: AT91: Serial: Add parameter for serial dma use
Date: Thu, 22 Nov 2012 15:40:59 +0800
Message-ID: <50ADD70B.6070801@atmel.com>
References: <1351501754-25028-1-git-send-email-elen.song@atmel.com>
 <1351501773-29024-1-git-send-email-elen.song@atmel.com>
 <20121029114221.GA31214@game.jcrosoft.org> <508F7629.2040905@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <508F7629.2040905@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, nicolas.ferre@atmel.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2012-10-30 14:39, Elen Song wrote:
> On 2012-10-29 19:42, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 17:09 Mon 29 Oct     , Elen Song wrote:
>>> Signed-off-by: Elen Song <elen.song@atmel.com>
>>> ---
>>>   arch/arm/mach-at91/include/mach/board.h |    2 ++
>>>   drivers/tty/serial/atmel_serial.c       |    1 +
>>>   include/linux/platform_data/dma-atmel.h |   10 ++++++++++
>>>   3 files changed, 13 insertions(+)
>> you will have to rebase this over a clean if the platofrm_data I'll 
>> send today
>> or tomorrow that will move all the platform_data to inclide/linux
>
> ok, please cc me in the mail list.
Hi JC:

     any more feedback ?
>>
>> btw your patch broke the avr32
>
> You mean compile error, driver crash, or I need  a macro to 
> distinguish avr32 to at91sam9 ?
> I only add a few variables that avr32 will not use, it seems no 
> affection to avr32, you think?
>>
>> Best Regards.
>> J.
>>> diff --git a/arch/arm/mach-at91/include/mach/board.h 
>>> b/arch/arm/mach-at91/include/mach/board.h
>>> index c55a436..a2188a6 100644
>>> --- a/arch/arm/mach-at91/include/mach/board.h
>>> +++ b/arch/arm/mach-at91/include/mach/board.h
>>> @@ -129,6 +129,8 @@ struct atmel_uart_data {
>>>       short            use_dma_tx;    /* use transmit DMA? */
>>>       short            use_dma_rx;    /* use receive DMA? */
>>>       void __iomem        *regs;        /* virt. base address, if 
>>> any */
>>> +    struct at_dma_slave     *dma_tx_slave;
>>> +    struct at_dma_slave     *dma_rx_slave;
>>>       struct serial_rs485    rs485;        /* rs485 settings */
>>>   };
>>>   extern void __init at91_add_device_serial(void);
>>> diff --git a/drivers/tty/serial/atmel_serial.c 
>>> b/drivers/tty/serial/atmel_serial.c
>>> index 3d7e1ee..1b1bd4f 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -45,6 +45,7 @@
>>>     #include <asm/mach/serial_at91.h>
>>>   #include <mach/board.h>
>>> +#include <linux/platform_data/dma-atmel.h>
>>>     #ifdef CONFIG_ARM
>>>   #include <mach/cpu.h>
>>> diff --git a/include/linux/platform_data/dma-atmel.h 
>>> b/include/linux/platform_data/dma-atmel.h
>>> index cab0997..bb05302 100644
>>> --- a/include/linux/platform_data/dma-atmel.h
>>> +++ b/include/linux/platform_data/dma-atmel.h
>>> @@ -26,11 +26,21 @@ struct at_dma_platform_data {
>>>   /**
>>>    * struct at_dma_slave - Controller-specific information about a 
>>> slave
>>>    * @dma_dev: required DMA master device
>>> + * @tx_reg: physical address of data register used for
>>> + *      memory-to-peripheral transfers
>>> + * @rx_reg: physical address of data register used for
>>> + *      peripheral-to-memory transfers
>>> + * @reg_width: peripheral register width
>>>    * @cfg: Platform-specific initializer for the CFG register
>>> + * @ctrla: Platform-specific initializer for the CTRLA register
>>>    */
>>>   struct at_dma_slave {
>>>       struct device        *dma_dev;
>>> +    dma_addr_t              tx_reg;
>>> +    dma_addr_t              rx_reg;
>>> +    u32            reg_width;
>>>       u32            cfg;
>>> +    u32                     ctrla;
>>>   };
>>>     --
>>> 1.7.9.5
>>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
