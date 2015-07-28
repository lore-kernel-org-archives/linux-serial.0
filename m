From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH 1/1] serial: 8250_pci: add RS485 for F81504/508/512
Date: Tue, 28 Jul 2015 09:44:21 +0800
Message-ID: <55B6DE75.8090309@gmail.com>
References: <1437717339-28881-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20150725113545.6bce8038@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150725113545.6bce8038@north>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Jakub_Kici=c5=84ski?= <moorray3@wp.pl>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Jakub Kici=C5=84ski,

Jakub Kici=C5=84ski =E6=96=BC 2015/7/25 =E4=B8=8B=E5=8D=88 05:35 =E5=AF=
=AB=E9=81=93:
> Please make sure you correct the rs485 configuration with what you ca=
n
> actually support.  Look at 8250_lpc18xx.c as an example.  In your cas=
e
> when the function returns it should have SER_RS485_ENABLED and one of
> SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND set and nothing else
> (or be completely zeroed if SER_RS485_ENABLED was not set).
>

Thanks for your advice, I'll fix it and re-send patch

--=20
With Best Regards,
Peter Hung
