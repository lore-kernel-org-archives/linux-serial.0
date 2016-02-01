From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Mon, 1 Feb 2016 10:51:24 +0800
Message-ID: <56AEC82C.7070105@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453982106.2521.279.camel@linux.intel.com> <56AAFD88.2060505@gmail.com>
 <1454074887.2521.335.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454074887.2521.335.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/1/29 =E4=B8=8B=E5=8D=88 09:41 =E5=AF=AB=E9=
=81=93:
> On Fri, 2016-01-29 at 13:50 +0800, Peter Hung wrote:
>> Andy Shevchenko =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 07:55 =E5=AF=AB=
=E9=81=93:
>>> I would suggest to rearrange definition block here (and in the rest
>>> of
>>> the functions in entire series) to somehow follow the following
>>> pattern
>>>
>>> 1) assignments go first, especially container_of() based ones;
>>> 2) group variables by meaning and put longer lines upper;
>>> 3) return value variable, if exists, goes last.
>>>
>>> Besides that choose types carefully. If there is known limit for
>>> counters, no need to define wider type than needed. Use proper
>>> types
>>> for corresponding values.
>>
>> I'll try to rearrange the definition blocks.
>
>
>> For the counter issue, some senior recommend me to change count from
>> int
>> to size_t for performance.
>
> Wow, how come? On which arch?
>
> Also mark this as (1) to refer below.
>
>>   In this case, should I use u8 to replace
>> i & j ? It should be less than 12 & 6.
>
> At least you tell compiler that it may use any suitable type. In any
> case the last decision is by compiler if you don't do any tricks.
>
> So, I suggest to use non-fixed width type like (unsigned) int and lea=
ve
> everything else on compiler.

Sorry for my misunderstanding, not for performance.
The senior just recommend me to replace all size/count variables
to size_t.

https://lkml.org/lkml/2016/1/3/193

size_t in x86 is unsigned int, x86_64 is unsigned long, It maybe
good for prefetch or match register size I guess.

I'll make the size_t of series patches to unsigned int.

>>>> +	pci_write_config_byte(dev, F81504_GPIO_IO_LSB_REG,
>>>> gpio_addr
>>>> & 0xff);
>>>> +	pci_write_config_byte(dev, F81504_GPIO_IO_MSB_REG,
>>>> (gpio_addr >> 8) &
>>>> +			0xff);
>>>
>>> Could it be written at once as a word?
>>
>> I tested with writing a word to "F81504_GPIO_IO_LSB_REG", but
>> it'll failed, so I'll remain it.
>
> Please, add a comment line above.

ok


>>
>>>> +	if (priv) {
>>>> +		/* Reinit from resume(), read the previous value
>>>> from priv */
>>>>
>>>
>>>> +		gpio_en =3D priv->gpio_en;
>>>
>>> I would suggest to move this line down to follow same pattern in
>>> else
>>> branch.
>
> I'm talking here to make simple rearrangement like
>
> if () {
>   =E2=80=A6
>   gpio_en =3D =E2=80=A6
> } else {
> =E2=80=A6
>   gpio_en =3D =E2=80=A6
> }
>
> Thus the gpio_en assignment goes last in both branches.

ok


>>>> +
>>>> +		pci_write_config_byte(dev, config_base + 0x06,
>>>> dev-
>>>>> irq);
>>>> +
>>>> +		/*
>>>> +		 * Force init to RS232 / Share Mode, recovery
>>>> previous mode
>>>> +		 * will done in F81504 8250 platform driver
>>>> resume()
>>>
>>> Period at the end of sentences in multi-line comments.
>>
>> Sorry, what this mean for ?
>> I cant use multi-line comments in the end ??
>
> Sentences are started with capital letters and end with period '.'
> character, like this one.

ok.


>> +		if (status) {
>>>> +			dev_warn(&dev->dev, "%s: add device
>>>> failed:
>>>> %d\n",
>>>> +					__func__, status);
>>>
>>> Indent _ under &.
>>
>> Some senior recommend me to do at least 2-tabs to do indent when
>> code cross multi-line. So I'll use to 2-tabs from "dev" to do indent=
=2E
>
>> How should I do with indent ?? It seems no consensus, but Lindent
>> will do indent like your comments.
>
> I would suggest to use what is used in most recent drivers and module=
s.
> I don't remember that 2 tabs fact is somehow reflected in CodingStyle=
=2E
>
> Maybe your seniour was talkin about multi-line function definition?

ok, I'll indent multi-line statement as your comment and multi-line
function with 2 tabs.


>> +		f81504_gpio_cell.pdata_size =3D sizeof(i);
>>>
>>> Static. The problem here is badly chosen type of i. Like I
>>> mentioned at
>>> the top of review=E2=80=A6
>>
>> I'll try to rewrite it with pass a structure. It seems more make
>> sense.
>
> That's correct on one side, on the other I'm not sure you got my
> comment. size_t is arch-dependent type, sizeof() is not the same
> everywhere.

I'll change it to pass unsigned int.


>> +	pci_read_config_byte(dev, F81504_GPIO_IO_MSB_REG, &tmp);
>>>> +	priv->gpio_ioaddr =3D tmp << 8;
>>>> +	pci_read_config_byte(dev, F81504_GPIO_IO_LSB_REG, &tmp);
>>>> +	priv->gpio_ioaddr |=3D tmp;
>>>
>>> One read as word?
>>
>> It can't read as word. The "F81504_GPIO_IO_LSB_REG" is 0xf1, It
>> seems can't be read word/dword from a odd address.
>>
>> I'll remain it.
>
> Put comment about that.

ok


>>> So, if you have default y for this and 8250_pci, which one will be
>>> loaded?
>>
>> I had tested on x86, It'll handle by 8250_pci.c when this &
>> 8250_pci.c
>> all built-in mode.
>
> Yeah. here is the problem. When you introduce that you have to be sur=
e
> that no-one will try to build kernel with both included right now.

Paul had recommend me to reduce the impact of code change. I'll remove
all F81504/508/512 code in 8250_pci.c until the series patches had
applied.

The device will handle with 8250_pci.c before applide patch no4, and
handle with f81504_code.c when applied patch no4. This maybe reduce the
bisect misleading.

>>
>> BTW, due to the series patches across 3 subsystems MFD/GPIO/8250.
>> I make the series patches under MFD subsystem, but the buildbot
>> report git repository conflict with GPIO & 8250 (patch 2 & 3).
>>
>> Should I split the series patches into 3 independent patch and
>> based on their maintainer git repository?
>
> It should go via one subsystem, otherwise user may end up with non-
> working interim kernel version, i.e. when bisecting.
>
> In case if it based on some stuff which is not in upstream yet, you
> have to describe this carefully to maintainers that they may create
> immutable branches and cross-apply the stuff. But I suppose it's not
> your case and your series is quite straightforward.
>

I'll still try the series patch based on MFD subsystem.
Thanks for your advices.

--=20
With Best Regards,
Peter Hung
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
