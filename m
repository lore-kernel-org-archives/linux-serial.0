From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 17:22:38 -0500
Message-ID: <6afb0a98-0973-33ec-0b76-fc6378e64309@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <bd4a0127-0f32-a8be-c8ee-34c1cccc6d5d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd4a0127-0f32-a8be-c8ee-34c1cccc6d5d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
Cc: Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 02/07/2017 11:05 PM, Timur Tabi wrote:
> Christopher Covington wrote:
>> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
>> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
>> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
>> and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 0,
>> instead of checking that the BUSY bit is 1, works around the issue. To
>> facilitate this substitution when UART AMBA Port (UAP) data is available,
>> introduce vendor-specific inversion of Feature Register bits. To keep the
>> change small, this patch only works around the full console case, where UAP
>> data is available, and does not handle the erratum for earlycon, as the UAP
>> data is not available then.

>> +#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
>> +static struct vendor_data vendor_qdt_qdf2400_e44 = {
>> +    .reg_offset        = pl011_std_offsets,
>> +    .fr_busy        = UART011_FR_TXFE,
>> +    .fr_dsr            = UART01x_FR_DSR,
>> +    .fr_cts            = UART01x_FR_CTS,
>> +    .fr_ri            = UART011_FR_RI,
>> +    .inv_fr            = UART011_FR_TXFE,
>> +    .access_32b        = true,
>> +    .oversampling        = false,
>> +    .dma_threshold        = false,
>> +    .cts_event_workaround    = false,
>> +    .always_enabled        = true,
>> +    .fixed_options        = true,
>> +};
>> +#else
>> +#define vendor_qdt_qdf2400_e44 vendor_sbsa
>> +#endif
> 
> Instead of the #else, just put the #ifdef inside qdf2400_e44(). That
> way, the function always returns False if
> CONFIG_QCOM_QDF2400_ERRATUM_44 is not defined.

I'll consolidate the #ifdefery around qdf2400_e44().

> Also, don't you need to add a definition of .inv_fr in vendor_sbsa
> and the other vendor_xxx structures?

The current struct definitions appear to (ab)use implicit
zero-initialization, so I did too.

>> +
>>  static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
>>      [REG_DR] = UART01x_DR,
>>      [REG_ST_DMAWM] = ST_UART011_DMAWM,
>> @@ -1518,7 +1538,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>>  {
>>      struct uart_amba_port *uap =
>>          container_of(port, struct uart_amba_port, port);
>> -    unsigned int status = pl011_read(uap, REG_FR);
>> +    unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
>>      return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
>>                              0 : TIOCSER_TEMT;
>>  }
>> @@ -2218,7 +2238,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>>       *    Finally, wait for transmitter to become empty
>>       *    and restore the TCR
>>       */
>> -    while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>> +    while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
>> +                        & uap->vendor->fr_busy)
> 
> I really think the XOR logic needs to be documented wherever it's
> used. It's just too confusing.

References such as the following for basic bit operations like
setting, clearing, and toggling are easy enough to come by.

http://stackoverflow.com/questions/47981/how-do-you-set-clear-and-toggle-a-single-bit-in-c-c

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
