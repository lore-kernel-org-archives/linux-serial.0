From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] serial: earlycon: keep earlycon symbols for non-module and driver clean-ups
Date: Mon, 06 Jun 2016 12:25:36 +0200
Message-ID: <3280512.PAaBGkzban@wuerfel>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Paul Burton <paul.burton@imgtec.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathieu OTHACEHE <m.othacehe@gmail.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Anton Wuerfel <anton.wuerfel@fau.de>, Scott Wood <scottwood@freescale.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

On Monday, June 6, 2016 6:40:59 PM CEST Masahiro Yamada wrote:
> 1/4: keep earlycon symbols only when CONFIG_SERIAL_EARLYCON is defined
>      and the driver is built-in.
> 
> 2/4 thru 4/4: driver clean-ups.
>               (partially reverts build fixes by Arnd Bergmann)
> 
> 
> 


Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
