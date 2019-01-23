From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL early console
Date: Wed, 23 Jan 2019 15:58:43 -0800 (PST)
Message-ID: <mhng-2f2fd42e-7dc1-4a21-9105-e129d55f1e5b@palmer-si-x1c4>
References: <CAAhSdy07AeWeMxQJvzRGzMQ84Sxc6O899T0dWO1vz0LB89ORyw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAhSdy07AeWeMxQJvzRGzMQ84Sxc6O899T0dWO1vz0LB89ORyw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: anup@brainfault.org
Cc: schwab@suse.de, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>, robh@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 11 Jan 2019 03:13:30 PST (-0800), anup@brainfault.org wrote:
> On Thu, Jan 10, 2019 at 10:41 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> This enables proper NLCR processing.
>>
>> Suggested-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>  drivers/tty/serial/earlycon-riscv-sbi.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
>> index e1a551aae3..ce81523c31 100644
>> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
>> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
>> @@ -10,13 +10,16 @@
>>  #include <linux/serial_core.h>
>>  #include <asm/sbi.h>
>>
>> -static void sbi_console_write(struct console *con,
>> -                             const char *s, unsigned int n)
>> +static void sbi_putc(struct uart_port *port, int c)
>>  {
>> -       int i;
>> +       sbi_console_putchar(c);
>> +}
>>
>> -       for (i = 0; i < n; ++i)
>> -               sbi_console_putchar(s[i]);
>> +static void sbi_console_write(struct console *con,
>> +                             const char *s, unsigned n)
>> +{
>> +       struct earlycon_device *dev = con->data;
>> +       uart_console_write(&dev->port, s, n, sbi_putc);
>>  }
>>
>>  static int __init early_sbi_setup(struct earlycon_device *device,
>> --
>> 2.20.1
>>
>> --
>> Andreas Schwab, SUSE Labs, schwab@suse.de
>> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
>> "And now for something completely different."
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup

Thanks.  I'm going to include this in my next PR, as it's pretty self contained 
and is necessary to actually use this sanely.
