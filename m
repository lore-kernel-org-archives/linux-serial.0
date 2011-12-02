From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Date: Thu, 1 Dec 2011 19:05:06 -0500
Message-ID: <4ED81632.3030809@windriver.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com> <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com> <4ED812E4.60905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ED812E4.60905@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: gregkh@suse.de, alan@linux.intel.com, galak@kernel.crashing.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11-12-01 06:51 PM, Scott Wood wrote:
> On 12/01/2011 05:47 PM, Paul Gortmaker wrote:
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index 8c660af..b0f4042 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -18,6 +18,11 @@
>>  #define UART_BUG_TXEN	(1 << 1)	/* buggy TX IIR status */
>>  #define UART_BUG_NOMSR	(1 << 2)	/* buggy MSR status bits (Au1x00) */
>>  #define UART_BUG_THRE	(1 << 3)	/* buggy THRE reassertion */
>> +#ifdef CONFIG_PPC32
>> +#define UART_BUG_FSLBK	(1 << 4)	/* buggy FSL break IRQ storm */
>> +#else	/* help GCC optimize away IRQ handler errata code for ARCH != PPC32 */
>> +#define UART_BUG_FSLBK	0
>> +#endif
> 
> I believe this bug still exists on our 64-bit chips.

OK, I'll simply change the above to CONFIG_PPC then.

Thanks,
Paul.

> 
> -Scott
> 
