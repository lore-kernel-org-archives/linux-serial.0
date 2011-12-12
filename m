From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH 2/2] serial: bfin-uart: Remove ASYNC_CTS_FLOW flag for
 hardware automatic CTS.
Date: Mon, 12 Dec 2011 13:20:29 +0800
Message-ID: <CAJxxZ0OPPHeusg-u89i5SOsSeVTH44jP3_x5BbJ8w=nB-Qh5Pw@mail.gmail.com>
References: <1323410421-10465-1-git-send-email-sonic.adi@gmail.com>
	<1323410421-10465-2-git-send-email-sonic.adi@gmail.com>
	<20111209111205.04780196@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111209111205.04780196@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-serial@vger.kernel.org

Hi Alan,


On Fri, Dec 9, 2011 at 7:12 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
>> +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->port.flags |=3D AS=
YNC_CTS_FLOW;
>> +#endif
>
> As an aside could the cts/hard cts etc be passed as properties to the
> platform device rather than ifdeffed ?
>
> Alan

As Mike mentioned, these Macros are used to keep the code smaller when
user doesn't want to enable UART flow control feature.

I will sent out V2 against the latest kernel next tree.


Sonic
