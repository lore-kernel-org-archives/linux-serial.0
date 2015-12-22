From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: amba bus probing support
Date: Tue, 22 Dec 2015 11:47:15 +0200
Message-ID: <CAHp75VfiUJymwxxHxr-Cw3cSBDfVBm1aj=T5o+=1G4CcACq5kw@mail.gmail.com>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
	<1450716100-13688-2-git-send-email-aleksey.makarov@linaro.org>
	<56789147.8070602@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56789147.8070602@mleia.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shannon Zhao <shannon.zhao@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 22, 2015 at 1:54 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> On 21.12.2015 18:41, Aleksey Makarov wrote:

>> +static int amba_handler_attach(struct acpi_device *adev,
>> +                             const struct acpi_device_id *id)
>> +{
>> +     struct amba_device *dev = NULL;
>> +     struct acpi_device *acpi_parent;
>> +     struct resource_entry *rentry;
>> +     struct list_head resource_list;
>> +     struct resource *resources = NULL;
>> +     bool address_found = false;
>> +     int ret, count, irq_no = 0;
>> +
>> +     /* If the ACPI node already has a physical device attached, skip it. */
>> +     if (adev->physical_node_count)
>> +             return 0;
>> +
>> +     amba_register_dummy_clk();
>
> Since it is a single time dummy clock registration, may be it is better
> to move it to acpi_amba_init() or somewhere else? I understand that
> "apb_pclk" is wanted, but I'm not sure that this driver should serve as
> a clock provider.

Depends on actual hardware topology. Intel HW has few drivers that are
clock providers because they are really ones.

-- 
With Best Regards,
Andy Shevchenko
