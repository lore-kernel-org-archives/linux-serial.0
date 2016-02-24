From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH] tty/serial: at91: restore dynamic driver binding
Date: Wed, 24 Feb 2016 15:09:49 +0100
Message-ID: <CAGkQfmNGwUqw=0AdjFugrKUCvEks2oZ=XKJY8a_-3isUin_hmw@mail.gmail.com>
References: <1456246781-19606-1-git-send-email-romain.izard.pro@gmail.com> <20160223191823.GN9766@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223191823.GN9766@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

2016-02-23 20:18 GMT+01:00 Paul Gortmaker <paul.gortmaker@windriver.com>:
> [[PATCH] tty/serial: at91: restore dynamic driver binding] On 23/02/2016 (Tue 17:59) Romain Izard wrote:
>
>> In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular support
>> code for atmel_serial was removed, as the driver cannot be built as a
>> module. Because no use case was proposed, the dynamic driver binding
>> support was removed as well.
>>
>> The atmel_serial driver can manage up to 7 serial controllers, which are
>> multiplexed with other functions. For example, in the Atmel SAMA5D2, the
>> Flexcom controllers can work as USART, SPI or I2C controllers, and on
>> all Atmel devices serial lines can be reconfigured as GPIOs.
>>
>> My use case uses GPIOs to transfer a firmware update using a custom
>> protocol on the lines used as a serial port during the normal life of
>> the device. If it is not possible to unbind the atmel_serial driver, the
>> GPIO lines remain reserved and prevent this case from working.
>>
>> This patch reinstates the atmel_serial_remove function, and fixes it as
>> it failed to clear the "clk" field on removal, triggering an oops when
>> a device was bound again after being unbound.
>
> I'd suggest that you add a comment above the remove fcn that gives the
> executive summary of the above; i.e. an unbind allows a fw update via
> blah blah and hence the .remove makes sense even though the driver is
> not modular.
>
OK, I'll send a v2.


Best regards,
