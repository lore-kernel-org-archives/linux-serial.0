From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serdev: fix serdev_device_write return value
Date: Wed, 3 May 2017 20:44:07 +0300
Message-ID: <CAHp75Vc+pK5cMkO=1dHR-Xx8zhe4RR0Zv5KDvChZE6MUfVQwcQ@mail.gmail.com>
References: <20170502001714.11576-1-robh@kernel.org> <20170502092527.GC2973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170502092527.GC2973@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 2, 2017 at 12:25 PM, Johan Hovold <johan@kernel.org> wrote:
> On Mon, May 01, 2017 at 07:17:14PM -0500, Rob Herring wrote:

>> -     return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
>> +     return ret < 0 ? ret : (count ? -ETIMEDOUT : wr_cnt);
>
> That's some nasty use of the ternary operator. Ditching it completely
> would be more readable.
>
>         if (ret < 0)
>                 return ret;
>
>         if (count)
>                 return -ETIMEDOUT;
>
>         return wr_count;


While I agree on the first part, I would go still with one ternary at the end:

            return count ? -ETIMEDOUT : wr_count;

-- 
With Best Regards,
Andy Shevchenko
