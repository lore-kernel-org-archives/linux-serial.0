From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk is
 also passed
Date: Mon, 23 Apr 2018 10:52:32 +0200
Message-ID: <85a4b544-cd1f-13c2-099b-b1d9835c0246@monstr.eu>
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
 <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
 <20180423084810.GA11893@kroah.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FTBZbx79TwlcJCvh6ZjxZVkaJlMtQt9sK"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423084810.GA11893@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FTBZbx79TwlcJCvh6ZjxZVkaJlMtQt9sK
Content-Type: multipart/mixed; boundary="eI4X3Kt9fhsTLeOfV5H6TjWJYRaZc25nN";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <85a4b544-cd1f-13c2-099b-b1d9835c0246@monstr.eu>
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk is
 also passed
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
 <20180423080641.GA20149@kroah.com>
 <ebc1b162-c5bf-3963-05ab-4b236f89966a@monstr.eu>
 <20180423084810.GA11893@kroah.com>
In-Reply-To: <20180423084810.GA11893@kroah.com>

--eI4X3Kt9fhsTLeOfV5H6TjWJYRaZc25nN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.4.2018 10:48, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 10:37:12AM +0200, Michal Simek wrote:
>> On 23.4.2018 10:06, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
>>>> Baudrate calculation depends on requested baudrate and uart clock.
>>>> This patch is checking that uartclk is also passed.
>>>>
>>>> The same logic is used 8250_early.c/init_port function.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial=
/xilinx_uartps.c
>>>> index b9b2bc76bcac..a654cda203c7 100644
>>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>>> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(str=
uct earlycon_device *device,
>>>>  	/* only set baud if specified on command line - otherwise
>>>>  	 * assume it has been initialized by a boot loader.
>>>>  	 */
>>>> -	if (device->baud) {
>>>> +	if (port->uartclk && device->baud) {
>>>>  		u32 cd =3D 0, bdiv =3D 0;
>>>>  		u32 mr;
>>>>  		int div8;
>>>> --=20
>>>> 1.9.1
>>>
>>> This patch conflicts with the previous patch you sent: Subject: [PATC=
H]
>>> serial: xuartps: Fix the early_console junk character issue
>>>
>>> So, which one should I apply?
>>>
>>> I've dropped both from my review queue now, please resend the one(s) =
you
>>> want applied, in a patch series if needed.
>>
>> First of all thanks for dropping. I forget that I have sent it in past=
=2E
>>
>> Both patches are targeting the same problem. The first one is more
>> destructive.
>>
>> And this one is what 8250 is doing.
>>
>> I have also sent
>> "[PATCH] earlycon: Initialize port->uartclk based on clock-frequency
>> property" which is filling uartclk based on DT to do proper divider
>> calculation.
>>
>> It means when patch above is applied we can keep divider calculation i=
n
>> the driver because it is using right values. If not we need to remove
>> that baudrate calculation because it is not correct (uartclk is
>> hardcoded to BASE_BAUD * 16 in of_setup_earlycon).
>> And it is really a question if "port->uartclk =3D BASE_BAUD * 16" shou=
ld
>> be in of_setup_earlycon.
>=20
> Ok, but what should I do here?  My patch queue for serial drivers is no=
w
> empty, so if you didn't get an automated email saying your patch was
> applied, please resend what you think needs to be applied.

I got that email and patch was applied. I will send proper version.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--eI4X3Kt9fhsTLeOfV5H6TjWJYRaZc25nN--

--FTBZbx79TwlcJCvh6ZjxZVkaJlMtQt9sK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrdntAACgkQykllyylKDCE5ggCePTp8OIkqXxAB49+/UG5r4DXv
q+cAnRTQ8VtZ7iQDts2I85S2s7zgalpk
=n2TL
-----END PGP SIGNATURE-----

--FTBZbx79TwlcJCvh6ZjxZVkaJlMtQt9sK--
