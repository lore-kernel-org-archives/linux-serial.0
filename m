From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
Date: Fri, 27 Jul 2018 14:06:46 +0530
Message-ID: <CABe79T5Mi3A7dVBuZVkYSYtY-U5cCvd4b088mSjhkcCANbrwQg@mail.gmail.com>
References: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com> <3e17e519a59e2a23669be054a44ded9ea90de088.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e17e519a59e2a23669be054a44ded9ea90de088.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Thank you very much for quick review.
I will address your comment and send next patch set.

Regards,
Srinath.

On Fri, Jul 27, 2018 at 2:04 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2018-07-27 at 09:31 +0530, Srinath Mannam wrote:
>> Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
>> to match the HID passed through ACPI tables to enable
>> UART controller.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com
>> >
>> Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>
> One comment below, after addressing it,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c
>> b/drivers/tty/serial/8250/8250_dw.c
>> index aff04f1..7ea94ec 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -708,6 +708,7 @@ static const struct acpi_device_id
>> dw8250_acpi_match[] = {
>>       { "AMD0020", 0 },
>>       { "AMDI0020", 0 },
>>       { "HISI0031", 0 },
>> +     { "BRCM2032", 0 },
>
> Let's keep this in order (yes, I know about INT* ones above, but that is
> not related to this patch right now)
>
>>       { },
>>  };
>>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
