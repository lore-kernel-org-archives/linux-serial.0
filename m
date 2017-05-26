From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] serial: 8250_of: Add reset support
Date: Fri, 26 May 2017 11:54:26 +1000
Message-ID: <CACPK8Xc_JOGJRF6-w9XrBGuaYist9y1d=RroiJWxc9wJAtoySg@mail.gmail.com>
References: <20170524045319.29926-1-joel@jms.id.au> <1495613916.3840.16.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495613916.3840.16.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 24, 2017 at 6:18 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Joel,
>
> On Wed, 2017-05-24 at 14:53 +1000, Joel Stanley wrote:
>> @@ -132,6 +134,18 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>               }
>>       }
>>
>> +     info->rst = devm_reset_control_get_optional(&ofdev->dev, NULL);
>
> Please use devm_reset_control_get_optional_shared instead.
>
> This looks like shared (clock-like) reset use, where you just have to
> make sure that the reset is deasserted while the module is in use, but
> you don't care whether it is actually asserted all the time otherwise.

Thanks for the review. The new reset API is much nicer, and it worked
for me once I realised the changes came in for 4.11 (my test setup is
based on 4.10).

Cheers,

Joel
