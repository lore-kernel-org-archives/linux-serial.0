From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
Date: Fri, 5 Jan 2018 15:57:53 +0100
Message-ID: <EC216531-81EC-4EE8-BAC4-C6954C222092@holtmann.org>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org>
 <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org>
 <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
 <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw@mail.gmail.com>
 <CAL9uMOFyfr_qGf5BeTojkMeWeH8LqPoKj=LrdgEMB2wmhGBxmA@mail.gmail.com>
 <CAFBinCAFsDRpp=4We1hQPiutM1Q0MrqebPLyS3e2_e+JcBoSmg@mail.gmail.com>
 <CAL9uMOGkZefjD_JNxjf4yJ0ATFtOG5Cm_XQq1fy0VQDjiMFBmg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL9uMOGkZefjD_JNxjf4yJ0ATFtOG5Cm_XQq1fy0VQDjiMFBmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Carlo,

>>> As Marcel suggested we can assume that the information in the DSDT is
>>> correct so that we can get rid of the config blob also for x86
>>> platforms (assuming that the only useful information in the config
>>> blobs is the UART configuration).
>> in my tests I tried to send only the firmware without the config to my
>> RTL8723BS. unfortunately the last firmware chunk (sent to the
>> controller) times out in that case (even if I set a proper baudrate
>> before or if I specify no baudrate at all and keep the serdev at
>> 115200)
> 
> What's in the config blobs besides UART configuration?

is anybody writing a rtlfw.c tool (like nokfw.c) so that we can print out what we actually have in these config files?

> It's odd because reading into hciattach_rtk.c it seems that the config
> file is actually only used by the userspace tools (hciattach) to
> retrieve the UART configuration and nothing else, whereas in the
> kernel driver the config blob is appended to the firmware.

Frankly, I am inclined to not use the config file even for DT based system and just allow specifying the UART settings via normal DT properties like we do for Broadcom and others.

>> have you tested this (= uploading the firmware without the config
>> blob) on your x86 board before?
> 
> No, on the cherry-trail I have I'm using hciattach to upload the
> firmware and AFAICT only the firmware is uploaded and (as written
> before) the config blob is only used to get the UART configuration.
> 
>> so far the following solutions for the config blob were discussed:
>> 1) put the config blob in userspace (/lib/firmware/...) -> not good
>> because it makes the rootfs board-specific
>> 2) auto-generate the config blob -> didn't work for me, last firmware
>> chunk times out (just as if I had no config at all)
>> 3) putting the config blob in DT -> possible but not very nice to read
>> 
>> I had another idea:
>> what if we mix solution 1) and 2)?
>> the idea: load the config blob from userspace (/lib/firmware/...) and
>> update it's settings with the values we got from devicetree-properties
>> / DSDT
> 
> If you are shipping already the config blob in userspace I don't see
> why you would do the update since you have already all the info you
> need.
> I would rather check why (2) didn't work fine. Have you any
> documentation how the config blobs are generated? The code in
> hciattach_rtk.c seems a good starting point.

I would almost bet it needs a HCI commands or some HCI command is embedded in the config blob somewhere that essentially tells the firmware it is done and ready. Hence my ask above, we need to know what is in these config file.

Even settings like crystal timing or some RF pieces or even enabled/disabled features are board specific and should be in DT rather than a config blob on the general purpose filesystem.

Regards

Marcel
