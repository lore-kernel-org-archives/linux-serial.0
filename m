From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v5] serial: 8250: add gpio support to exar
Date: Sun, 07 Feb 2016 19:24:15 +0530
Message-ID: <56B74C87.3080301@gmail.com>
References: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com> <20160207064407.GA24131@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160207064407.GA24131@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, andy.shevchenko@gmail.com, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Sunday 07 February 2016 12:14 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 19, 2016 at 11:36:35AM +0530, Sudip Mukherjee wrote:
>> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
>> can be controlled using gpio interface.
>> Add support to use these pins.
>>
>> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
>> ---
>
> I need an ack from the gpio maintainer before I can take this.
>
> Or was it going to be reworked again?

I have not yet started with the rework, but Andy wants me to split out 
the exar related code from 8250_pci and create its own driver. But at 
the initial discussion you were against having a separate driver for it.
what will you suggest?

regards
sudip
