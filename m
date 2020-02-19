Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140FC34047
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FBE24670
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R1dPxReh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSOiT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:38:19 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4860 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgBSOiT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 09:38:19 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4d484c0000>; Wed, 19 Feb 2020 06:38:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Feb 2020 06:38:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Feb 2020 06:38:18 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 14:38:14 +0000
Subject: Re: [PATCH for 5.6 v2] tty: serial: tegra: Handle RX transfer in PIO
 mode if DMA wasn't started
To:     Dmitry Osipenko <digetx@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209164415.9632-1-digetx@gmail.com>
 <15b01f79-007d-09bb-03be-050c009ceff6@suse.cz>
 <4d9a2352-6daa-4dcc-376b-175b1398ff6a@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <01397ba1-a738-257a-adb1-84cdcba68a57@nvidia.com>
Date:   Wed, 19 Feb 2020 14:38:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4d9a2352-6daa-4dcc-376b-175b1398ff6a@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582123084; bh=w7DzjaP66efSnxdr3Cf/Q2kn+epuTGow7yByRK1aMQk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R1dPxRehYvhXI70N/7S5SupHF72Hin1MIdm5n3VGFBjuBvyEKSxqIdx2nqx4e3hge
         En3TC0gegHZDYz7HqNFrsvLIwgFnYNFZonoQ8NB3HAq0IRwd68hXy6L3LbIOH4nSB0
         2zjFTQPUqHfGZdcKtZ0XyQfH3TrjhOzP0nNhq0a14oNCm2iCymFCNv5zQeVVd02FZI
         +T+zJu9E2tOUZPZFWfI26f7Us/jpBvK03rLKnOWSx92Xx7YI4f1BoA96UFiCpgxJU+
         YLi7cOb+bT2+rqBxrbJJLoILF3gB3W8RhCsVXXGEzgQVrOZiPSu5hFmkktA+74rvWj
         cpcBjBrsAnZvQ==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 19/02/2020 12:25, Dmitry Osipenko wrote:
> 17.02.2020 10:37, Jiri Slaby =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 09. 02. 20, 17:44, Dmitry Osipenko wrote:
>>> It is possible to get an instant RX timeout or end-of-transfer interrup=
t
>>> before RX DMA was started, if transaction is less than 16 bytes. Transf=
er
>>> should be handled in PIO mode in this case because DMA can't handle it.
>>> This patch brings back the original behaviour of the driver that was
>>> changed by accident by a previous commit, it fixes occasional Bluetooth=
 HW
>>> initialization failures which I started to notice recently.
>>>
>>> Fixes: d5e3fadb7012 ("tty: serial: tegra: Activate RX DMA transfer by r=
equest")
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v2: - Corrected commit's title by adding the accidentally missed "tegra=
: "
>>>       to the prefix.
>>>
>>>  drivers/tty/serial/serial-tegra.c | 35 ++++++++++++++-----------------
>>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/ser=
ial-tegra.c
>>> index 33034b852a51..8de8bac9c6c7 100644
>>> --- a/drivers/tty/serial/serial-tegra.c
>>> +++ b/drivers/tty/serial/serial-tegra.c
>>> @@ -692,11 +692,22 @@ static void tegra_uart_copy_rx_to_tty(struct tegr=
a_uart_port *tup,
>>>  				   count, DMA_TO_DEVICE);
>>>  }
>>> =20
>>> +static void do_handle_rx_pio(struct tegra_uart_port *tup)
>>> +{
>>> +	struct tty_struct *tty =3D tty_port_tty_get(&tup->uport.state->port);
>>> +	struct tty_port *port =3D &tup->uport.state->port;
>>> +
>>> +	tegra_uart_handle_rx_pio(tup, port);
>>> +	if (tty) {
>>
>> What's the tty good for here, actually?
>>
>>> +		tty_flip_buffer_push(port);
>>> +		tty_kref_put(tty);
>>> +	}
>>> +}
>=20
> I'm not really a TTY expert..
>=20
> Jon, maybe you have any clue whether TTY could disappear while port is
> opened?

Nothing specific that I am aware of. The function tty_kref_get() appears
to check that the tty pointer is valid and so it would seem logical to
check here as well. But happy to be corrected :-)

Jon

--=20
nvpublic
