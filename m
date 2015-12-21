From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v2 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Mon, 21 Dec 2015 21:02:34 +0000
Message-ID: <CAGCh1+mVXSPPPuFOC-F+JMvd2NUNgwKg_rThYS=VyLDT3jSyug@mail.gmail.com>
References: <1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org>
	<1450709399-7246-4-git-send-email-aleksey.makarov@linaro.org>
	<CAHp75VcLGTMemaDyezgtxjtPa+tEUGm8ULJE8feY8FX4FEqU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcLGTMemaDyezgtxjtPa+tEUGm8ULJE8feY8FX4FEqU6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 21 December 2015 at 18:11, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 21, 2015 at 4:49 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> In ACPI this device is only defined in SBSA mode so
>> if we are coming from ACPI use this mode.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 37 ++++++++++++++++++++++++++-----------
>>  1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 899a771..766ce4f 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -2368,18 +2368,33 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>         if (!uap)
>>                 return -ENOMEM;
>>
>> -       uap->clk = devm_clk_get(&dev->dev, NULL);
>> -       if (IS_ERR(uap->clk))
>> -               return PTR_ERR(uap->clk);
>> -
>> -       uap->vendor = vendor;
>> -       uap->lcrh_rx = vendor->lcrh_rx;
>> -       uap->lcrh_tx = vendor->lcrh_tx;
>> -       uap->fifosize = vendor->get_fifosize(dev);
>> -       uap->port.irq = dev->irq[0];
>> -       uap->port.ops = &amba_pl011_pops;
>> +       /* ACPI only defines SBSA variant */
>> +       if (ACPI_COMPANION(&dev->dev)) {
>
> has_acpi_companion()
>
>> +               /*
>> +                * According to ARM ARMH0011 is currently the only mapping
>> +                * of pl011 in ACPI and it's mapped to SBSA UART mode
>> +                */
>> +               uap->vendor     = &vendor_sbsa;
>> +               uap->fifosize   = 32;
>> +               uap->port.ops   = &sbsa_uart_pops;
>> +               uap->fixed_baud = 115200;
>
> Shouldn't you match by ID and provide the custom values if any?
> On the other hand have you checked if it's possible to use _DSD in this case?
>
So far I have not seen any use of SBSA UART other than this in real
life. I am a little opposed to providing complexity people are not
going to use.

Graeme
