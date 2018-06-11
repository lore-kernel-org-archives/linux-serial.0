From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
Date: Mon, 11 Jun 2018 15:39:13 +0300
Message-ID: <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-8-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-8-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Allow creating and deleting devices via sysfs. Devices created will be
> matched to serdev drivers via modalias (the string provided by the user)
> and deleted via their name. Eg:

> +       nline = strchr(buf, '\n');

...

> +       if (nline)
> +               len = nline - buf;
> +       else

> +               len = strlen(buf);
> +       len = min(SERDEV_NAME_SIZE - 1, len);

If buf is guaranteed to have '\0', the strlen() is not needed.

I'm not sure about this entire dances with first line and so on.
When it's possible to get more, than two lines on input?

Would it be just as simple as strstrip() call followed by strscpy()?

> +       strncpy(serdev->modalias, buf, len);
> +       serdev->modalias[len] = '\0';

strspcy() ?

-- 
With Best Regards,
Andy Shevchenko
