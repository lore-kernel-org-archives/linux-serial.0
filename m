From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Fri, 29 Jan 2016 13:50:00 +0800
Message-ID: <56AAFD88.2060505@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453982106.2521.279.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453982106.2521.279.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 07:55 =E5=AF=AB=E9=
=81=93:
>> +        default y
>
> I'm not sure we have to have this always y. Perhaps
> default SERIAL_8250_PCI

Your comment is right, this device major function is serial port.
GPIO maybe not enabled by H/W manufacturer.

I'll set it default with SERIAL_8250_PCI.

>> +obj-$(CONFIG_MFD_FINTEK_F81504_CORE)	+=3D f81504-core.o
>
> I think '_' is better than '-'. What I saw and usually do is '_' for
> regular source modules and '-' for the resulting objects when they ha=
ve
> more than one file.

I used f81504_core.c originally, but I found most of files are named
xxx-ooo.c when I try to modify makefile. Should I change it to
f81504_core.c ??


>> +#define F81504_DEV_DESC		"Fintek F81504/508/512 PCIE-
>> to-UART core"
>
> Do you need this definition? Is it used more than once?

ok, I'll direct use the string without define.


>> +static int f81504_port_init(struct pci_dev *dev)
>> +{
>> +	size_t i, j;
>> +	u32 max_port, iobase, gpio_addr;
>> +	u32 bar_data[3];
>> +	u16 tmp;
>> +	u8 config_base, gpio_en, f0h_data, f3h_data;
>> +	bool is_gpio;
>> +	struct f81504_pci_private *priv =3D pci_get_drvdata(dev);
>
> I would suggest to rearrange definition block here (and in the rest o=
f
> the functions in entire series) to somehow follow the following patte=
rn
>
> 1) assignments go first, especially container_of() based ones;
> 2) group variables by meaning and put longer lines upper;
> 3) return value variable, if exists, goes last.
>
> Besides that choose types carefully. If there is known limit for
> counters, no need to define wider type than needed. Use proper types
> for corresponding values.

I'll try to rearrange the definition blocks.
=46or the counter issue, some senior recommend me to change count from =
int
to size_t for performance. In this case, should I use u8 to replace
i & j ? It should be less than 12 & 6.

>> +
>> +	/* Init GPIO IO Address */
>> +	pci_read_config_dword(dev, 0x18, &gpio_addr);
>> +	gpio_addr &=3D 0xffffffe0;
>
>
>> +	pci_write_config_byte(dev, F81504_GPIO_IO_LSB_REG, gpio_addr
>> & 0xff);
>> +	pci_write_config_byte(dev, F81504_GPIO_IO_MSB_REG,
>> (gpio_addr >> 8) &
>> +			0xff);
>
> Could it be written at once as a word?

I tested with writing a word to "F81504_GPIO_IO_LSB_REG", but
it'll failed, so I'll remain it.

>> +	if (priv) {
>> +		/* Reinit from resume(), read the previous value
>> from priv */
>>
>
>> +		gpio_en =3D priv->gpio_en;
>
> I would suggest to move this line down to follow same pattern in else
> branch.

The f81504_port_init() will be called probe()/resume().

We'll initialize gpio_en =3D (f0h | ~f3h) and save it in private data
when probe(), reload gpio_en from private data when resume().

The F81504/508/512 can be used EEPROM to override F0h/F3h on power
on. Some motherboard designer will put the IC on board and want to cost
down EEPROM. They will setting F0/F3h with ASL code, but without EEPROM
, the IC back from resume() will get F0/F3h with 0x00, so we should
save gpio_en when probe(), and restore it when resume().

>> +
>> +		/* re-save GPIO IO addr for called by resume() */
>
> re-save -> Re-save
> addr -> address

ok

>> +		priv->gpio_ioaddr =3D gpio_addr;
>> +	} else {
>> +		/* Driver first init */
>> +		pci_read_config_byte(dev, F81504_GPIO_ENABLE_REG,
>> &f0h_data);
>> +		pci_read_config_byte(dev, F81504_GPIO_MODE_REG,
>> &f3h_data);
>> +
>> +		/* find the max set of GPIOs */
>
> Use one pattern for all comments, like "Capital letter first, and ful=
l
> words avoiding abbreviations".

ok

>> +	case FINTEK_F81504: /* 4 ports */
>> +		/* F81504 max 2 sets of GPIO, others are max 6
>> sets*/
>
> Space before * is needed.

ok

>> +	for (i =3D 0; i < max_port; ++i) {
>
> i++, since it's more usual pattern.

ok

>> +		/* find every port to check is multi-function port?
>> */
>> +		for (j =3D 0; j < ARRAY_SIZE(fintek_gpio_mapping);
>> ++j) {
>> +			if (fintek_gpio_mapping[j] !=3D i || !(gpio_en
>> & BIT(j)))
>> +				continue;
>> +
>> +			/*
>> +			 * This port is multi-function and enabled
>> as gpio
>> +			 * mode. So we'll not configure it as serial
>> port.
>> +			 */
>> +			is_gpio =3D true;
>> +			break;
>> +		}
>
> Looks like a separate function.
>
> func()
> {
>   for () {
>     if ()
>      return X;
>   }
>   return Y;
> }

ok.


>> +		/* Select 128-byte FIFO and 8x FIFO threshold */
>> +		pci_write_config_byte(dev, config_base + 0x01,
>> 0x33);
>> +
>> +		/* LSB UART */
>> +		pci_write_config_byte(dev, config_base + 0x04,
>> +				(u8)(iobase & 0xff));
>
> Redundant explicit casting.

ok

>> +
>> +		/* MSB UART */
>> +		pci_write_config_byte(dev, config_base + 0x05,
>> +				(u8)((iobase & 0xff00) >> 8));
>
> Ditto.
>
> And similar question, can it be written as a word?

Here can be written with a word, I'll rewrite it.

>> +
>> +		pci_write_config_byte(dev, config_base + 0x06, dev-
>>> irq);
>> +
>> +		/*
>> +		 * Force init to RS232 / Share Mode, recovery
>> previous mode
>> +		 * will done in F81504 8250 platform driver resume()
>
> Period at the end of sentences in multi-line comments.

Sorry, what this mean for ?
I cant use multi-line comments in the end ??

>> +	for (i =3D 0; i < max_port; ++i) {
>> +		/* Check UART is enabled */
>>
>
>> +		pci_read_config_byte(dev, F81504_UART_START_ADDR + i
>> *
>> +				F81504_UART_OFFSET, &tmp);
>> +		if (!tmp)
>> +			continue;
>
> So, this is the same as below, right?
>
>> +
>> +		/* Get UART IO Address */
>> +		pci_read_config_word(dev, F81504_UART_START_ADDR + i
>> *
>> +				F81504_UART_OFFSET + 4, &iobase);
>
> =E2=80=A6why not to check here?

It's a bit difference, this section will check if UART enabled (tmp).
It'll generate platform device and get IO address when tmp !=3D 0. If
tmp =3D 0, skip this idx, dont need to get current IO address and try
with next.


>> +		f81504_serial_cell.pdata_size =3D sizeof(i);
>
> This is static, can be part of definition.

ok

>> +		f81504_serial_cell.platform_data =3D &i;
>> +
>> +		status =3D mfd_add_devices(&dev->dev,
>> PLATFORM_DEVID_AUTO,
>> +					&f81504_serial_cell, 1,
>> NULL, dev->irq,
>> +					NULL);
>> +		if (status) {
>> +			dev_warn(&dev->dev, "%s: add device failed:
>> %d\n",
>> +					__func__, status);
>
> Indent _ under &.

Some senior recommend me to do at least 2-tabs to do indent when
code cross multi-line. So I'll use to 2-tabs from "dev" to do indent.
How should I do with indent ?? It seems no consensus, but Lindent
will do indent like your comments.


>
>> +		f81504_gpio_cell.pdata_size =3D sizeof(i);
>
> Static. The problem here is badly chosen type of i. Like I mentioned =
at
> the top of review=E2=80=A6

I'll try to rewrite it with pass a structure. It seems more make sense.


>> +static int f81504_probe(struct pci_dev *dev, const struct
>> pci_device_id
>> +			*dev_id)
>
> Usually drivers are using pdev, id pair in parameters. Shorter; known
> pattern.

ok.

>> +{
>> +	int status;
>> +	u8 tmp;
>> +	struct f81504_pci_private *priv;
>> +
>> +	status =3D pci_enable_device(dev);
>
> Please, pcim_, see comment below.
>> +	if (status)
>> +		return status;
>> +
>> +	/* Init PCI Configuration Space */
>> +	status =3D f81504_port_init(dev);
>> +	if (status)
>
> Device left enabled if not managed.
>> +		return status;
>> +
>> +	priv =3D devm_kzalloc(&dev->dev, sizeof(struct
>> f81504_pci_private),
>> +				GFP_KERNEL);
>> +	if (!priv)
>
> Ditto.

ok, I'll rewrite it with managed type.

>> +		return -ENOMEM;
>> +
>> +	/* Save the GPIO_ENABLE_REG after f81504_port_init() for
>> future use */
>> +	pci_read_config_byte(dev, F81504_GPIO_ENABLE_REG, &priv-
>>> gpio_en);
>> +
>> +	/* Save GPIO IO Addr to private data */
>>
>
>> +	pci_read_config_byte(dev, F81504_GPIO_IO_MSB_REG, &tmp);
>> +	priv->gpio_ioaddr =3D tmp << 8;
>> +	pci_read_config_byte(dev, F81504_GPIO_IO_LSB_REG, &tmp);
>> +	priv->gpio_ioaddr |=3D tmp;
>
> One read as word?

It can't read as word. The "F81504_GPIO_IO_LSB_REG" is 0xf1, It
seems can't be read word/dword from a odd address.

I'll remain it.


>> +	mfd_remove_devices(&dev->dev);
>
> mfd_add_devices takes care.
>
>> +	pci_disable_device(dev);
>
> pcim_ takes case.

ok

>> +	return status;
>> +}
>> +
>> +static void f81504_remove(struct pci_dev *dev)
>> +{
>
>> +	mfd_remove_devices(&dev->dev);
>> +	pci_disable_device(dev);
>
> Ditto.

ok


>> +static int f81504_resume(struct device *dev)
>> +{
>> +	int status;
>> +	struct pci_dev *pdev =3D to_pci_dev(dev);
>> +
>> +	status =3D pci_enable_device(pdev);
>> +	if (status)
>> +		return status;
>
> It's done by PCI core I believe.

ok

>> +static const struct pci_device_id f81504_dev_table[] =3D {
>> +	/* Fintek PCI serial cards */
>> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81504), .driver_data =3D 4},
>> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81508), .driver_data =3D 8},
>> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81512), .driver_data =3D 12},
>> +	{}
>
> So, if you have default y for this and 8250_pci, which one will be
> loaded?

I had tested on x86, It'll handle by 8250_pci.c when this & 8250_pci.c
all built-in mode.

BTW, due to the series patches across 3 subsystems MFD/GPIO/8250.
I make the series patches under MFD subsystem, but the buildbot
report git repository conflict with GPIO & 8250 (patch 2 & 3).

Should I split the series patches into 3 independent patch and
based on their maintainer git repository?

>> +static struct pci_driver f81504_driver =3D {
>> +	.name =3D F81504_DRIVER_NAME,
>> +	.probe =3D f81504_probe,
>> +	.remove =3D f81504_remove,
>> +	.driver		=3D {
>> +		.pm	=3D &f81504_pm_ops,
>
>
>> +		.owner	=3D THIS_MODULE,
>
> kbuild  already complained about.

ok

>> diff --git a/include/linux/mfd/f81504.h b/include/linux/mfd/f81504.h
>> new file mode 100644
>> index 0000000..13bd0ae
>> --- /dev/null
>> +++ b/include/linux/mfd/f81504.h
>> @@ -0,0 +1,52 @@
>> +#ifndef __F81504_H__
>
> __MFD_F=E2=80=A6

ok

Thanks for your advices
--=20
With Best Regards,
Peter Hung
