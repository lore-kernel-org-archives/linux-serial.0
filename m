From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] serial: pl011: add acpi_match for amba-pl011.c
Date: Mon, 25 Jan 2016 16:22:42 +0200
Message-ID: <CAHp75VftJ1eBzbL6Ch4Dtrz0f_Lnm2aaMveUjT0TcEDhjW=Uwg@mail.gmail.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
	<1453722324-22407-4-git-send-email-aleksey.makarov@linaro.org>
	<CAHp75VcnEOB8_GMwi894XJXN+CtJr_vDxGMP0GHw4JhALynDyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcnEOB8_GMwi894XJXN+CtJr_vDxGMP0GHw4JhALynDyw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Jiri Slaby <jslaby@suse.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 25, 2016 at 4:21 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jan 25, 2016 at 1:45 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> Add an implementation of acpi_match() to the pl011 driver.
>> It allows to check if the console matches one specified with
>> ACPI SPCR table.
>
> I don't know Rafael's opinion on this, but I would split it to extend
> ACPI header first with reference to newest revision of Microsoft
> document.


>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -371,6 +371,10 @@ struct acpi_dbg2_device {
>>
>>  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
>>  #define ACPI_DBG2_16550_SUBSET      0x0001
>> +#define ACPI_DBG2_ARM_PL011         0x0003
>> +#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000e
>> +#define ACPI_DBG2_ARM_DCC           0x000f
>> +#define ACPI_DBG2_DCM2835           0x0010

^^^ Exactly because of such typos. Should be BCM


-- 
With Best Regards,
Andy Shevchenko
