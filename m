From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] leds: triggers: provide led_trigger_register_format()
Date: Sun, 13 May 2018 17:34:42 +0300
Message-ID: <CAHp75VeWsbT+XuacdrKM6drzcxwx0inAUjtyU0WBX_SUTg6Lbg@mail.gmail.com>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de> <20180510112101.GD6977@amd>
 <20180510112229.GE6977@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510112229.GE6977@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 10, 2018 at 2:22 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-05-10 13:21:01, Pavel Machek wrote:

>> I know this is not your fault, but if you have a space or "[]" in
>> netdev names, confusing things will happen.
>
> Hmm. If we are doing this we really should check trigger names for
> forbidden characters. At least "[] " should be forbidden.

So, string_escape_mem() is your helper here.

-- 
With Best Regards,
Andy Shevchenko
