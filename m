From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] [RFC] tty/serial: imx: make use of format specifier %dE
Date: Thu, 29 Aug 2019 19:19:40 +0200
Message-ID: <4f20fbee-db57-5db6-eddb-7e22647423b6@kleine-koenig.org>
References: <20190829043716.5223-1-uwe@kleine-koenig.org>
 <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TMR6u8im72eYSCShEMtiHt1FAiuY5cipI"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jani Nikula <jani.nikula@linux.intel.com>, Enrico Weigelt <lkml@metux.net>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMR6u8im72eYSCShEMtiHt1FAiuY5cipI
Content-Type: multipart/mixed; boundary="pLErzazZJatJFSZc5KxPtwYzLkL1zAfoI";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Enrico Weigelt <lkml@metux.net>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Documentation List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4f20fbee-db57-5db6-eddb-7e22647423b6@kleine-koenig.org>
Subject: Re: [PATCH] [RFC] tty/serial: imx: make use of format specifier %dE
References: <20190829043716.5223-1-uwe@kleine-koenig.org>
 <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>
In-Reply-To: <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>

--pLErzazZJatJFSZc5KxPtwYzLkL1zAfoI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/29/19 3:43 PM, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 7:40 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koeni=
g.org> wrote:
>>
>> I created a patch that teaches printk et al to emit a symbolic error
>> name for an error valued integer[1]. With that applied
>>
>>         dev_err(&pdev->dev, "failed to get ipg clk: %dE\n", ret);
>>
>> emits
>>
>>         ... failed to get ipg clk: EPROBE_DEFER
>>
>> if ret is -EPROBE_DEFER. Petr Mladek (i.e. one of the printk
>> maintainers) had concerns if this would be well received and worth the=

>> effort. He asked to present it to a few subsystems. So for now, this
>> patch converting the imx UART driver shouldn't be applied yet but it
>> would be great to get some feedback about if you think that being able=

>> to easily printk (for example) "EIO" instead of "-5" is a good idea.
>=20
>> Would it help you? Do you think it helps your users?
>=20
> No, it makes sense only for debug where the user is supposed to be
> developer and thus needs anyway to know code base better than average.

Would you go so far as to claim that

	... failed to get ipg clk: -517

is better sometimes than the same message with a named error? I'd say it
is never better and in some cases worse because readers who don't
understand what -EPROBE_DEFER means won't understand -517 either. So
there is net win.

Best regards
Uwe


--pLErzazZJatJFSZc5KxPtwYzLkL1zAfoI--

--TMR6u8im72eYSCShEMtiHt1FAiuY5cipI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl1oCSwACgkQwfwUeK3K
7AnB+Af/YOXi02psCmkUympK1Pvep54r+CHsOl5j8kaw4oHirKDCbCpjPrZdM8Ud
FpzWE9hwPej1pZe9g3fgSCAaCxPnH6Ep+rbwI00QDtkCpFDDZPbRKrGm/BsCC1Qn
TiGuL+afSLtxm5A/kCO81JItJZynrhbZY+SLL4c1c1xd4CwxMU367IjhYs4dO2FJ
bfktrrY8EfRjqkIGV5GNBYB86FF8AQZGL+DSQZpYtnFbNobhbsyT7vqN0bFQUV0/
fJ/Bm6kc1hElJ15zeS2XxIsddd5Gnp6GuSfGvWUUQ4BIfWhgLfTociNaIvLsZIJt
CDTGnL1O5OASP3OFOJ+h2dXSFo8WVA==
=/87R
-----END PGP SIGNATURE-----

--TMR6u8im72eYSCShEMtiHt1FAiuY5cipI--
