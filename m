From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V2 1/6] tty: serial: lpuart: introduce lpuart_soc_data to
 represent SoC property
Date: Mon, 15 May 2017 16:35:05 +0300
Message-ID: <CAHp75VejaaBPvO3qBxwBTDR9bq_nr0bT7uSKi66tnA=_S96W5Q@mail.gmail.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com> <1494834539-17523-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494834539-17523-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, fugang.duan@nxp.com, Stefan Agner <stefan@agner.ch>, dongas86@gmail.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On Mon, May 15, 2017 at 10:48 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> This is used to dynamically check the SoC specific lpuart properies.
> Currently only the checking of 32 bit register width is added which
> functions the same as before. More will be added later for supporting
> new chips.

For the rest it might be okay, but don't we have specific properties
for register width and offset for UART? I think I saw something like
that in other drivers.

-- 
With Best Regards,
Andy Shevchenko
