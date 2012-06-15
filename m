From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 09:13:57 -0300
Message-ID: <CAOMZO5BKKwg-E3=vx8C3GKD7NbwZKBfy8SBZBU-W3vYuU4sAJQ@mail.gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
	<1339759950-5507-2-git-send-email-festevam@gmail.com>
	<201206151349.27261.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38564 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab2FOMN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 08:13:58 -0400
Received: by bkcji2 with SMTP id ji2so2332365bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 05:13:57 -0700 (PDT)
In-Reply-To: <201206151349.27261.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, kernel@pengutronix.de, matt@grid-net.com, snijsure@grid-net.com, rob.herring@calxeda.com, Fabio Estevam <fabio.estevam@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Fri, Jun 15, 2012 at 8:49 AM, Marek Vasut <marex@denx.de> wrote:

>> +/*
>> + * This function returns 1 if pdev isn't a device instatiated by dt=
, 0 if
>> it + * could successfully get all information from dt or a negative =
errno.
>> + */
>> +static int serial_mxs_probe_dt(struct mxs_auart_port *s,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_device *=
pdev)
>> +{
>> + =C2=A0 =C2=A0 struct device_node *np =3D pdev->dev.of_node;
>> + =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 if (!np)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no device tree device=
 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>> +
>> + =C2=A0 =C2=A0 ret =3D of_alias_get_id(np, "serial");
>> + =C2=A0 =C2=A0 if (ret < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "fai=
led to get alias id: %d\n", ret);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 s->port.line =3D ret;
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +#else
>> +static inline int serial_mxs_probe_dt(struct mxs_auart_port *s,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_device *=
pdev)
>> +{
>> + =C2=A0 =C2=A0 return 1;
>> +}
>> +#endif
>
> So drop this whole ifdef stuff ...

Yes, you are right. We can safely remove it. Just tested and it worked =
fine.

I will drop the ifdef in the next revision.

Thanks,

=46abio Estevam
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
