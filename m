From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement
 register diverson for ZTE UART
Date: Thu, 5 Nov 2015 17:54:05 +0800
Message-ID: <CABymUCM-NG4S-2Jfq5xenzVDVCRE9DDkFBVdU4k-QJ-7zhK_Bw@mail.gmail.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
 <20151103134605.GW8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103134605.GW8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2015-11-03 21:46 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Nov 02, 2015 at 12:24:02PM +0000, Andre Przywara wrote:
>> +int reg_table_zte[] = {
>> +     [UART01x_DR]    = ZX_UART01x_DR,
>
> No entry for RSR, so the value will be zero.  That means when we read
> the RSR, we'll be reading the register at offset 0.  Maybe that's
> intentional, maybe it isn't, but it's totally screwy.
>
> Someone needs to document what the register layout for the ZTE UART
> is.  Better still, point to where the spec can be found.

I am checking ZTE engineer to make their UART spec public. Before
that, we can also make ZTE UART work from existing code. Just some
register offset and bit offset are different with PL011.

>
>> +     [UART011_LCRH]  = ZX_UART011_LCRH_TX,
>> +     [UART011_CR]    = ZX_UART011_CR,
>> +     [UART01x_FR]    = ZX_UART01x_FR,
>> +     [UART011_ICR]   = ZX_UART011_ICR,
>> +     [UART011_IBRD]  = UART011_IBRD,
>> +     [UART011_FBRD]  = UART011_FBRD,
>> +     [UART011_IFLS]  = ZX_UART011_IFLS,
>> +     [UART011_IMSC]  = ZX_UART011_IMSC,
>> +     [UART011_RIS]   = ZX_UART011_RIS,
>> +     [UART011_MIS]   = ZX_UART011_MIS,
>> +     [UART011_DMACR] = ZX_UART011_DMACR,
>> +};
>>  static unsigned int pl011_read(struct uart_amba_port *uap, int offset)
>>  {
>> +#ifdef CONFIG_SOC_ZX296702
>> +     if (uap->vendor->reg_table)
>> +             offset = uap->vendor->reg_table[offset];
>> +#endif
>>       return readw(uap->port.membase + offset);
>>  }
>>
>>  static void pl011_write(struct uart_amba_port *uap, int val, int offset)
>>  {
>> +#ifdef CONFIG_SOC_ZX296702
>> +     if (uap->vendor->reg_table)
>> +             offset = uap->vendor->reg_table[offset];
>> +#endif
>>       writew(val, uap->port.membase + offset);
>>  }
>>
>> diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
>> index 0ddb5c0..1c71b83 100644
>> --- a/include/linux/amba/serial.h
>> +++ b/include/linux/amba/serial.h
>> @@ -31,6 +31,7 @@
>>   *  UART Register Offsets.
>>   */
>>  #define UART01x_DR           0x00    /* Data read or written from the interface. */
>> +#define ZX_UART01x_DR                0x04    /* Different offset in the ZTE UART. */
>>  #define UART01x_RSR          0x04    /* Receive status register (Read). */
>>  #define UART01x_ECR          0x04    /* Error clear register (Write). */
>>  #define UART010_LCRH         0x08    /* Line control register, high byte. */
>> @@ -39,6 +40,7 @@
>>  #define ST_UART011_TIMEOUT   0x0C    /* Timeout period register. */
>>  #define UART010_LCRL         0x10    /* Line control register, low byte. */
>>  #define UART010_CR           0x14    /* Control register. */
>> +#define ZX_UART01x_FR                0x14    /* Different offset in the ZTE UART. */
>>  #define UART01x_FR           0x18    /* Flag register (Read only). */
>>  #define UART010_IIR          0x1C    /* Interrupt identification register (Read). */
>>  #define UART010_ICR          0x1C    /* Interrupt clear register (Write). */
>> @@ -48,14 +50,22 @@
>>  #define UART011_FBRD         0x28    /* Fractional baud rate divisor register. */
>>  #define UART011_LCRH         0x2c    /* Line control register. */
>>  #define ST_UART011_LCRH_TX   0x2c    /* Tx Line control register. */
>> +#define ZX_UART011_LCRH_TX   0x30    /* Different offset in the ZTE UART. */
>>  #define UART011_CR           0x30    /* Control register. */
>>  #define UART011_IFLS         0x34    /* Interrupt fifo level select. */
>> +#define ZX_UART011_CR                0x34    /* Different offset in the ZTE UART. */
>> +#define ZX_UART011_IFLS              0x38    /* Different offset in the ZTE UART. */
>>  #define UART011_IMSC         0x38    /* Interrupt mask. */
>>  #define UART011_RIS          0x3c    /* Raw interrupt status. */
>>  #define UART011_MIS          0x40    /* Masked interrupt status. */
>> +#define ZX_UART011_IMSC              0x40    /* Different offset in the ZTE UART. */
>>  #define UART011_ICR          0x44    /* Interrupt clear register. */
>> +#define ZX_UART011_RIS               0x44    /* Different offset in the ZTE UART. */
>>  #define UART011_DMACR                0x48    /* DMA control register. */
>> +#define ZX_UART011_MIS               0x48    /* Different offset in the ZTE UART. */
>> +#define ZX_UART011_ICR               0x4c    /* Different offset in the ZTE UART. */
>>  #define ST_UART011_XFCR              0x50    /* XON/XOFF control register. */
>> +#define ZX_UART011_DMACR     0x50    /* Different offset in the ZTE UART. */
>>  #define ST_UART011_XON1              0x54    /* XON1 register. */
>>  #define ST_UART011_XON2              0x58    /* XON2 register. */
>>  #define ST_UART011_XOFF1     0x5C    /* XON1 register. */
>> --
>> 2.5.1
>>
>
> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
