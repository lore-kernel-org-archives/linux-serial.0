From: liuxinliang <z.liuxinliang@hisilicon.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: Add ACPI support for uart on Hisilicon
 Hip05 soc
Date: Thu, 30 Jun 2016 09:19:31 +0800
Message-ID: <577473A3.9050808@hisilicon.com>
References: <1467083835-37750-1-git-send-email-wangkefeng.wang@huawei.com> <1467204764.30123.327.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467204764.30123.327.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-serial@vger.kernel.org

Hi,

On 2016/6/29 20:52, Andy Shevchenko wrote:
> On Tue, 2016-06-28 at 11:17 +0800, Kefeng Wang wrote:
>> Make dw8250_set_termios() as the default set_termios callback for 8250
>> dw uart, correct me
>> if I am wrong.
>>
>> Then add ACPI support for uart on Hisilicon Hip05 soc, be careful that
>> it is not 16500
>> compatible.
> You mean it has Busy Functionality implemented?

Yes, I think so.

> Is there any public specification to look at?
Sorry, our SoC manual is not that public. But we confirm with SoC guys 
that 8250dw has 16550 compatible and non 16550 compatible version.
Ours is non 16550 compatible version. And we can see the IIR register 
has busy interrupt bit:
"0x7: busy interrupt. When UART is busy (USR[0]=1) in receiving
and transmitting data and the processor operates the LCR register,
this interrupt will be generated."

Thanks,
-xinliang

>
>>   Note, the build(no ACPI) depends on
>> https://patchwork.kernel.org/patch/9141207/,
>> which was already accepted in net-next.
>>
>> Meanwhile, set dw8250_serial_out32 to keep consistent between
>> serial_out
>> and serial_in in ACPI.
>>
>> Kefeng Wang (2):
>>    serial: 8250_dw: make dw8250_set_termios as default set_termios
>>      callback
>>    serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc
>>
>>   drivers/tty/serial/8250/8250_dw.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
