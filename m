From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH] serial: samsung: fix typo in debug code
Date: Tue, 3 Jun 2014 16:57:28 +0530
Message-ID: <CAK5sBcH8YH1+i0yBUHLqiYWAmOV3v5Dpoavxo-ZOGA8oX0OcwQ@mail.gmail.com>
References: <10455941.RzodM59Z3O@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <10455941.RzodM59Z3O@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Joe Perches <joe@perches.com>, Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Tue, Jun 3, 2014 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
> a regression in the conversion from vsprintf to vsnprintf.
>
> This fixes the build error by passing the correct variable name.

I submitted a similar patch sometime back.
http://www.spinics.net/lists/linux-serial/msg12843.html

Regards,
Sachin
