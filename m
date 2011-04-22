From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2] tty/serial: add support for Xilinx PS UART
Date: Fri, 22 Apr 2011 09:46:09 -0600
Message-ID: <BANLkTim2TyamL4Q+=b-So6phTF+Ng-cBUA@mail.gmail.com>
References: <90e49570-bc82-41a9-ac79-2f5007e93a2a@VA3EHSMHS018.ehs.local> <BANLkTimhk-szP=gbZLpRrofi2EB2YbXrqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52325 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab1DVPq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Apr 2011 11:46:29 -0400
In-Reply-To: <BANLkTimhk-szP=gbZLpRrofi2EB2YbXrqg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com

On Fri, Apr 22, 2011 at 9:40 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Wed, Apr 20, 2011 at 1:03 PM, John Linn <john.linn@xilinx.com> wro=
te:
>> The Xilinx PS Uart is used on the new ARM based SoC. This
>> UART is not compatible with others such that a seperate
>> driver is required.
>>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>
> Out of curiosity, who is the vendor of this uart IP block? =A0Is it n=
ew
> hardware created by xilinx for zinq, or is it provided by a third
> party. =A0If its from a third party it is within the realm of
> possibility that a driver already exists for it.
>
> g.
>> +/********************************Register Map**********************=
**********/
>> +/** UART
>> + *
>> + * Register offsets for the UART.
>> + *
>> + */
>> +#define XUARTPS_CR_OFFSET =A0 =A0 =A00x00 =A0/* Control Register [8=
:0] */
>> +#define XUARTPS_MR_OFFSET =A0 =A0 =A00x04 =A0/* Mode Register [10:0=
] */
>> +#define XUARTPS_IER_OFFSET =A0 =A0 0x08 =A0/* Interrupt Enable [10:=
0] */
>> +#define XUARTPS_IDR_OFFSET =A0 =A0 0x0C =A0/* Interrupt Disable [10=
:0] */
>> +#define XUARTPS_IMR_OFFSET =A0 =A0 0x10 =A0/* Interrupt Mask [10:0]=
 */
>> +#define XUARTPS_ISR_OFFSET =A0 =A0 0x14 =A0/* Interrupt Status [10:=
0]*/
>> +#define XUARTPS_BAUDGEN_OFFSET 0x18 =A0/* Baud Rate Generator [15:0=
] */
>> +#define XUARTPS_RXTOUT_OFFSET =A00x1C =A0/* RX Timeout [7:0] */
>> +#define XUARTPS_RXWM_OFFSET =A0 =A00x20 =A0/* RX FIFO Trigger Level=
 [5:0] */
>> +#define XUARTPS_MODEMCR_OFFSET 0x24 =A0/* Modem Control [5:0] */
>> +#define XUARTPS_MODEMSR_OFFSET 0x28 =A0/* Modem Status [8:0] */
>> +#define XUARTPS_SR_OFFSET =A0 =A0 =A00x2C =A0/* Channel Status [11:=
0] */
>> +#define XUARTPS_FIFO_OFFSET =A0 =A00x30 =A0/* FIFO [15:0] or [7:0] =
*/
>> +#define XUARTPS_BAUDDIV_OFFSET 0x34 =A0/* Baud Rate Divider [7:0] *=
/
>> +#define XUARTPS_FLOWDEL_OFFSET 0x38 =A0/* Flow Delay [15:0] */
>> +#define XUARTPS_IRRX_PWIDTH_OFFSET 0x3C /* IR Minimum Received Puls=
e
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Width [15:0] */
>> +#define XUARTPS_IRTX_PWIDTH_OFFSET 0x40 /* IR Transmitted pulse
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Width [7:0] */
>> +#define XUARTPS_TXWM_OFFSET =A0 =A00x44 =A0/* TX FIFO Trigger Level=
 [5:0] */

After a quick search:

from include/linux/atmel_serial.h
#define ATMEL_US_CR             0x00                    /* Control Regi=
ster */
#define ATMEL_US_MR             0x04                    /* Mode Registe=
r */
#define ATMEL_US_IER            0x08                    /* Interrupt
Enable Register */
#define ATMEL_US_IDR            0x0c                    /* Interrupt
Disable Register */
#define ATMEL_US_IMR            0x10                    /* Interrupt
Mask Register */
#define ATMEL_US_CSR            0x14                    /* Channel
Status Register */
#define ATMEL_US_RHR            0x18                    /* Receiver
Holding Register */
#define ATMEL_US_THR            0x1c                    /* Transmitter
Holding Register */
#define ATMEL_US_BRGR           0x20                    /* Baud Rate
Generator Register */
#define ATMEL_US_RTOR           0x24                    /* Receiver
Time-out Register */
#define ATMEL_US_TTGR           0x28                    /* Transmitter
Timeguard Register */
#define ATMEL_US_FIDI           0x40                    /* FI DI Ratio
Register */
#define ATMEL_US_NER            0x44                    /* Number of
Errors Register */
#define ATMEL_US_IF             0x4c                    /* IrDA Filter
Register */


Not exactly the same, but worth exploring
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
