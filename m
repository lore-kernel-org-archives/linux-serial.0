From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC v2 1/9] serdev: implement parity configuration
Date: Wed, 3 Jan 2018 13:37:29 +0100
Message-ID: <046E5A40-D66C-4965-B8D4-E5CE6B44571F@holtmann.org>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-2-martin.blumenstingl@googlemail.com>
 <4FDCB65A-641A-4134-BAF1-4A777012FDE7@holtmann.org>
 <CAFBinCCq9mYBhzoL1XBVQNGxALg8oK5GB7Md9HJf_mchEMu3-A@mail.gmail.com>
 <CAFBinCD=iuE+ho22kihCFG=AJV5t+JtjRww8PLuq-cAJ2RkAHQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFBinCD=iuE+ho22kihCFG=AJV5t+JtjRww8PLuq-cAJ2RkAHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Martin,

>>>> Some Bluetooth modules (for example the ones found in Realtek RTL8723BS
>>>> and RTL8723DS) want to communicate with the host with even parity
>>>> enabled.
>>>> Add a new function and the corresponding internal callbacks so parity
>>>> can be configured. This supports enabling and disabling parity as well
>>>> as setting the type to odd or even.
>>>> 
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>> ---
>>>> drivers/tty/serdev/core.c           | 12 ++++++++++++
>>>> drivers/tty/serdev/serdev-ttyport.c | 21 +++++++++++++++++++++
>>>> include/linux/serdev.h              |  5 +++++
>>>> 3 files changed, 38 insertions(+)
>>>> 
>>>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>>>> index 1bef39828ca7..d327b02980f5 100644
>>>> --- a/drivers/tty/serdev/core.c
>>>> +++ b/drivers/tty/serdev/core.c
>>>> @@ -225,6 +225,18 @@ void serdev_device_set_flow_control(struct serdev_device *serdev, bool enable)
>>>> }
>>>> EXPORT_SYMBOL_GPL(serdev_device_set_flow_control);
>>>> 
>>>> +void serdev_device_set_parity(struct serdev_device *serdev, bool enable,
>>>> +                           bool odd)
>>>> +{
>>>> +     struct serdev_controller *ctrl = serdev->ctrl;
>>>> +
>>>> +     if (!ctrl || !ctrl->ops->set_parity)
>>>> +             return;
>>>> +
>>>> +     ctrl->ops->set_parity(ctrl, enable, odd);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(serdev_device_set_parity);
>>>> +
>>> 
>>> this really needs Rob’s ACK before I take the patch.
>> sure
>> 
>> I could even live with a NACK in case these two bool parameters are
>> considered to be ugly
>> in that case I would propose an enum with three values: DISABLED,
>> EVEN, ODD so the arguments would look like this:
>> void serdev_device_set_parity(struct serdev_device *serdev, enum parity)
> I just discovered: such a patch was already posted by Ulrich Hecht: [0]
> 
> 
> [0] https://patchwork.kernel.org/patch/9903787/

any idea what the status of this one is? It would be good if we get an ACK from Rob and you just include it in your patch series. I do not see it currently in Linus’ tree or net-next. If it goes via a different path to Linus, we will have a bit of a problem getting this all merged for the next kernel.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
