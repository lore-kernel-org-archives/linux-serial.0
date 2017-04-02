From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/5] serial: split generic UART driver helper functions
 into a separate file
Date: Sun, 2 Apr 2017 16:16:26 +0300
Message-ID: <CAHp75Ve_O03CQQErkaHPyAbxrQFe=uWf7mmmZuJ+rVNJysqGSg@mail.gmail.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <20170401222119.25106-5-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170401222119.25106-5-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Apr 2, 2017 at 1:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> This contains code that is common between serial_core.c and the
> minitty code to come. Mainly helper functions used by UART drivers.


I have two questions:
- why minitty (what is that by the way?) can't use serial_core.c as a library?
- does -M -C help to make this diff shorter?

-- 
With Best Regards,
Andy Shevchenko
