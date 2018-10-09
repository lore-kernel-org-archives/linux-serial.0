From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] of: base: Change logic in of_alias_get_alias_list()
Date: Tue, 9 Oct 2018 09:18:53 +0200
Message-ID: <2bbc70c9-21b0-dfa2-ddea-554afb2c4f89@xilinx.com>
References: <e879d07e97b7f7fc46543315e9fb1b4bc8b7a352.1539001154.git.michal.simek@xilinx.com>
 <CAL_JsqLNMM6mS1oy1voDAibRk1Srcp7i8e3pESTnM957Rxp4ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLNMM6mS1oy1voDAibRk1Srcp7i8e3pESTnM957Rxp4ow@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 8.10.2018 17:07, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 7:19 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Check compatible string first before setting up bit in bitmap to also
>> cover cases that allocated bitfield is not big enough.
>> Show warning about it but let driver to continue to work with allocated
>> bitfield to keep at least some devices (included console which
>> is commonly close to serial0) to work.
>>
>> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
>> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> I have looked at it and I don't think there should be necessary to
>> report error immediately back with partially initialized bitfield.
>> The reason is that still there could be a console device which is most
>> likely below that max limit and it is worth to return at least that nbits
>> properly filled.
>> It will also enable cases that you can still continue to use aliases
>> higher then fields prepared for devices without alias.
> 
> Seems reasonable. Plus if you had a new dtb which added an alias
> greater than what the OS version supports, you would break that
> system.

I was checking that with our uart ps driver before I send this patch and
I found out that there is no reason not to support these cases.
Driver will simply find out ids which are free and ready for devices
which don't have alias.

> 
>>
>> To be fixed patches are present in tty-next branch.
>>
>> ---
>>  drivers/of/base.c                  | 22 ++++++++++++----------
>>  drivers/tty/serial/xilinx_uartps.c |  2 +-
>>  2 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 908de45f966b..0b9611e196d1 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1953,13 +1953,15 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>   * The function travels the lookup table to record alias ids for the given
>>   * device match structures and alias stem.
>>   *
>> - * Return:     0 or -ENOSYS when !CONFIG_OF
>> + * Return:     0 or -ENOSYS when !CONFIG_OF or
>> + *             -EINVAL if alias ID is greater then allocated nbits
> 
> I think EOVERFLOW or ERANGE would be better as those are less common
> and I take EINVAL as the caller made an error.

That's a good point I was also thinking if EINVAL is good reaction on
this case. I will use EOVERFLOW if there is no issue with it.

Thanks,
Michal
