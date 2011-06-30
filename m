From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] tty/serial: change of_serial to use new
 of_property_read_u32() api
Date: Thu, 30 Jun 2011 15:01:45 -0600
Message-ID: <BANLkTikw_102PfPtUKhoDrAKnwuJRCtYdg@mail.gmail.com>
References: <20110630185921.13784.3823.stgit@ponder> <4E0CE332.4040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45013 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1F3VCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Jun 2011 17:02:06 -0400
In-Reply-To: <4E0CE332.4040102@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Thu, Jun 30, 2011 at 2:57 PM, Rob Herring <robherring2@gmail.com> wr=
ote:
> Grant,
>
> On 06/30/2011 02:00 PM, Grant Likely wrote:
>> Simplifies the code a bit and drops a few lines.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> I've only actually build tested this, but this shows some of the cle=
anup
>> achieved using the of_property_read_u32() API. =A0If this gets merge=
d in the
>> v3.1 merge window then it will need to go via the devicetree/next br=
anch.
>>
>> g.
>
> You can't give yourself bonus points. ;)
>
>>
>> =A0drivers/tty/serial/of_serial.c | =A0 37 +++++++++++++++----------=
------------
>> =A01 files changed, 15 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_=
serial.c
>> index 36038ed..dbfbfda 100644
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -32,17 +32,17 @@ static int __devinit of_platform_serial_setup(st=
ruct platform_device *ofdev,
>> =A0{
>> =A0 =A0 =A0 struct resource resource;
>> =A0 =A0 =A0 struct device_node *np =3D ofdev->dev.of_node;
>> - =A0 =A0 const __be32 *clk, *spd;
>> - =A0 =A0 const __be32 *prop;
>> - =A0 =A0 int ret, prop_size;
>> + =A0 =A0 u32 clk, spd, prop;
>> + =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 memset(port, 0, sizeof *port);
>> - =A0 =A0 spd =3D of_get_property(np, "current-speed", NULL);
>> - =A0 =A0 clk =3D of_get_property(np, "clock-frequency", NULL);
>> - =A0 =A0 if (!clk) {
>> + =A0 =A0 if (of_property_read_u32(np, "clock-frequency", &clk)) {
>
> s/clk/port->uartclk/
>
> And below, then remove clk.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev, "no clock-frequenc=
y property set\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>> + =A0 =A0 /* If current-speed was set, then try not to change it. */
>> + =A0 =A0 if (of_property_read_u32(np, "current-speed", &spd) =3D=3D=
 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 port->custom_divisor =3D clk / (16 * spd);
>>
>> =A0 =A0 =A0 ret =3D of_address_to_resource(np, 0, &resource);
>> =A0 =A0 =A0 if (ret) {
>> @@ -54,20 +54,17 @@ static int __devinit of_platform_serial_setup(st=
ruct platform_device *ofdev,
>> =A0 =A0 =A0 port->mapbase =3D resource.start;
>>
>> =A0 =A0 =A0 /* Check for shifted address mapping */
>> - =A0 =A0 prop =3D of_get_property(np, "reg-offset", &prop_size);
>> - =A0 =A0 if (prop && (prop_size =3D=3D sizeof(u32)))
>> - =A0 =A0 =A0 =A0 =A0 =A0 port->mapbase +=3D be32_to_cpup(prop);
>> + =A0 =A0 if (of_property_read_u32(np, "reg-offset", &prop) =3D=3D 0=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 port->mapbase +=3D prop;
>>
>> =A0 =A0 =A0 /* Check for registers offset within the devices address=
 range */
>> - =A0 =A0 prop =3D of_get_property(np, "reg-shift", &prop_size);
>> - =A0 =A0 if (prop && (prop_size =3D=3D sizeof(u32)))
>> - =A0 =A0 =A0 =A0 =A0 =A0 port->regshift =3D be32_to_cpup(prop);
>> + =A0 =A0 if (of_property_read_u32(np, "reg-shift", &prop) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 port->regshift =3D prop;
>
> Can be further simplified:
>
> of_property_read_u32(np, "reg-shift", &port->regshift);

Hey Rob, thanks for the review.

I thought about that, but the new api specifically needs to be passed
a u32 pointer, not an unsigned char pointer which is what is in the
port structure.  That goes for the clk value too.  Even for unsigned
int values, i need the u32 bounce variable because it would break on
64 bit platforms.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
