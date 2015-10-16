From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/3] misc: Add w2sg0004 gps receiver driver
Date: Fri, 16 Oct 2015 22:07:21 +0200
Message-ID: <4580CBE3-344F-446D-90B7-B01CE8932CAC@goldelico.com>
References: <cover.1445018912.git.hns@goldelico.com> <3951119.loGSTxYIZb@wuerfel> <35C9DA36-55B3-44BC-8553-FCBEA2799B7D@goldelico.com> <7172120.hIQmygRF8G@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <7172120.hIQmygRF8G@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Am 16.10.2015 um 21:38 schrieb Arnd Bergmann <arnd@arndb.de>:

> On Friday 16 October 2015 21:27:11 H. Nikolaus Schaller wrote:
>> Am 16.10.2015 um 21:06 schrieb Arnd Bergmann <arnd@arndb.de>:
>> 
>>> On Friday 16 October 2015 20:08:35 H. Nikolaus Schaller wrote:
>>>> +
>>>> +static int w2sg_data_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct w2sg_pdata *pdata = dev_get_platdata(&pdev->dev);
>>>> +       struct w2sg_data *data;
>>>> +       struct rfkill *rf_kill;
>>>> +       int err;
>>>> +
>>>> +       pr_debug("%s()\n", __func__);
>>>> +
>>>> +       if (pdev->dev.of_node) {
>>>> +               struct device *dev = &pdev->dev;
>>>> +               enum of_gpio_flags flags;
>>>> +
>>>> +               pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>>> +               if (!pdata)
>>>> 
>>> 
>>> Why is this a platform_device and not a serio_device?
>> 
>> I can't find a struct serio_device. What is that?
>> 
> 
> Sorry, I meant 'struct serio', see drivers/input/serio/
> 
> This is an existing infrastructure that is used for devices attached
> to a dumb serial device (rs232 or 8042/psaux usually). They have
> a user interface for connecting a driver to a port, but you should
> be able to do it all in the kernel as well if DT has the information
> what device is connected.

Ah, I understand. But it is for a different purpose. E.g. making a
serial device (mouse/touch) an input device. So it is a driver sitting
"on top" of tty/uart drivers.

The problem to be solved here is a different one. The only task for
the driver is to do power control of the device. I.e. turn it on by
open("/dev/ttyX") or asserting DTR.

So we are on a much lower level.

Please see also the patch 0/3 I have resent (the BLURB defined
by git --edit-description was apparently eaten by my git send-email).

BR and thanks,
Nikolaus

