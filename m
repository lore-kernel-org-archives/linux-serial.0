From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: serial: custom baud rate
Date: Mon, 14 May 2018 20:24:15 +0300
Message-ID: <CAHp75Ve8DF=CUV7XLdKScdjyOJUs9fWTn3o4_7TKFmOxONqDdw@mail.gmail.com>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <20180503175401.GD29205@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503175401.GD29205@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Muni Sekhar <munisekharrms@gmail.com>, linux-serial <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 3, 2018 at 8:54 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, May 03, 2018 at 06:09:13PM +0530, Muni Sekhar wrote:

> See the setserial man page:t
>
>         https://linux.die.net/man/8/setserial
>
> Not all serial devices support the spd_cust and divisor, however.  In
> general

Oh, please, do not advertise this old hack.

We have BOTHER that what people should use in new code.

-- 
With Best Regards,
Andy Shevchenko
