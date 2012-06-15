From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 13:11:12 -0300
Message-ID: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
	<1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
	<20120615160635.GP31565@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43146 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042Ab2FOQLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 12:11:14 -0400
Received: by bkcji2 with SMTP id ji2so2543228bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 09:11:12 -0700 (PDT)
In-Reply-To: <20120615160635.GP31565@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, linux-serial@vger.kernel.org, matt@grid-net.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote=
:

>> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .id_table =3D mxs_auart_=
devtype,
>
> I do not think we need these.

WIthout this, the non-dt kernel does not probe correctly.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
