From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 13:18:30 -0300
Message-ID: <CAOMZO5AFaWGEfEhVs1TVc0c_Wp6aB7FT5zKHEoiucLnuWGg8zA@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
	<20120615160635.GP31565@S2101-09.ap.freescale.net>
	<CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
	<201206151816.55567.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45680 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab2FOQSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 12:18:31 -0400
Received: by bkcji2 with SMTP id ji2so2549020bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 09:18:30 -0700 (PDT)
In-Reply-To: <201206151816.55567.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, linux-serial@vger.kernel.org, matt@grid-net.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Fri, Jun 15, 2012 at 1:16 PM, Marek Vasut <marex@denx.de> wrote:
> Dear Fabio Estevam,
>
>> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wr=
ote:
>> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
>> >
>> > ...
>> >
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .id_table =3D mxs_aua=
rt_devtype,
>> >
>> > I do not think we need these.
>>
>> WIthout this, the non-dt kernel does not probe correctly.
>
> But we don't support non-DT kernel anymore.

but I don't want my patch to break something that has been working for
a long time.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
