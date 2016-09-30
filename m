From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Fri, 30 Sep 2016 13:45:47 +0200
Message-ID: <CACQ1gAg21UEeyT_yGed58HB1gkwfg4LA8u5AVMkKsY=d5-EbMQ@mail.gmail.com>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
 <20160930085801.21497-3-richard.genoud@gmail.com> <20160930091230.qzd42qnelylmkqxe@pengutronix.de>
 <CACQ1gAgE+BvteH9y62PcRx_tA9_e2X11RCJ12PC98FK+5z98QQ@mail.gmail.com> <20160930111606.zcain6i4nsujsg5s@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930111606.zcain6i4nsujsg5s@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2016-09-30 13:16 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 30/09/2016 at 13:04:28 +0200, Richard Genoud wrote :
>> Anyway, the problematics setups are all the setups with USMODE_HWHS
>> enabled on platform without Fifos or PDC,
>> i.e. all platforms but sama5d2 (Cyrille, correct me if I'm wrong).
>>
>
> This is a wrong assumption, at91rm9200 to at91sam9g45 all have a pdc.
> Please, don't break those platforms.
>
> The only affected platforms are sam9x5, sama5d3 and sama5d4.
Have you tested them ?

And why are you saying that rm9200 and g45 will be broken with this patch ?
If they have a pdc, they will fall in the case:
(atmel_use_pdc_rx(port) || atmel_use_fifo(port))
and thus use:
mode |= ATMEL_US_USMODE_HWHS;

won't they ?
