From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH 2/3] ACPI: parse SPCR and enable matching console
Date: Mon, 25 Jan 2016 21:07:12 +0600
Message-ID: <56A63A20.4040602@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-3-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VeosA-54-G1oSo3cBo2KRO+rK=Q4DJxmz93WxUPORqf1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeosA-54-G1oSo3cBo2KRO+rK=Q4DJxmz93WxUPORqf1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org


On 25.01.2016 20:14, Andy Shevchenko wrote:
> On Mon, Jan 25, 2016 at 1:45 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> 'ARM Server Base Boot Requiremets' [1] mention SPCR
>> (Serial Port Console Redirection Table) [2] as a mandatory ACPI table
>> that specifies the configuration of serial console.
>>
>> Parse this table and check if any registered console match
>> the description.  If it does, enable that console.
>>
>> To implement that, introduce a new member
>> int (*acpi_match)(struct console *, struct acpi_table_spcr *)
>> of struct console.  It allows drivers to check if they provide
>> a matching console device.
>>
>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>> [2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
>
> Can you split this to several patches?

I am not sure I should.

> I see preparatory patch in console code, i.e.
> delete_from_console_list(), adding SPCR support to ACPI, enabling it.

It would be difficult to justify delete_from_console_list() in a 
separate patches before the rest of the changes. And enabling SPCR in a 
separate patch also looks oddly for me.

It would be great to have other comments on this before I fix this in 
the next version.

Thank you
