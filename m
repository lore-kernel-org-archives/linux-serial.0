From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty/serial: make early console depend on SERIAL_CORE=y
Date: Mon, 19 Oct 2015 15:37:07 -0400
Message-ID: <56254663.4000601@hurleysoftware.com>
References: <1445206009-12275-1-git-send-email-paul.gortmaker@windriver.com>
 <4727600.4io7e2HWRP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4727600.4io7e2HWRP@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/19/2015 08:56 AM, Arnd Bergmann wrote:
> On Sunday 18 October 2015 18:06:48 Paul Gortmaker wrote:
[...]
>> [A google shows this cropped up in April of this year; I guess it wasn't
>>  completely fixed?
>>  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336954.html
>>  FWIW, I was testing on tty/tty-testing pulled today, from Greg  ]
> 
> The new problem was clearly caused by 1d59b382f1c4 ("serial: fsl_lpuart:
> add earlycon support"), which selects SERIAL_EARLYCON but not
> SERIAL_CORE_CONSOLE.
> 
> However, the way I read Peter's patch from the URL you provided,
> it seems that it is supposed to work without my patch, so I'm not
> sure.

Looks like my patch never got applied; I'll resend it.

Regards,
Peter Hurley
