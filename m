From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
Date: Fri, 5 Jan 2018 21:44:32 +0100
Message-ID: <41669609-3E28-473D-8616-71B9D0EEDCDF@holtmann.org>
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
 <EC216531-81EC-4EE8-BAC4-C6954C222092@holtmann.org>
 <1F394D8B-CFB8-48BA-BC6B-15D1EE51DB08@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1F394D8B-CFB8-48BA-BC6B-15D1EE51DB08-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Carlo,

>>>>> As Marcel suggested we can assume that the information in the DSDT is
>>>>> correct so that we can get rid of the config blob also for x86
>>>>> platforms (assuming that the only useful information in the config
>>>>> blobs is the UART configuration).
>>>> in my tests I tried to send only the firmware without the config to my
>>>> RTL8723BS. unfortunately the last firmware chunk (sent to the
>>>> controller) times out in that case (even if I set a proper baudrate
>>>> before or if I specify no baudrate at all and keep the serdev at
>>>> 115200)
>>> 
>>> What's in the config blobs besides UART configuration?
>> 
>> is anybody writing a rtlfw.c tool (like nokfw.c) so that we can print out what we actually have in these config files?
>> 
>>> It's odd because reading into hciattach_rtk.c it seems that the config
>>> file is actually only used by the userspace tools (hciattach) to
>>> retrieve the UART configuration and nothing else, whereas in the
>>> kernel driver the config blob is appended to the firmware.
>> 
>> Frankly, I am inclined to not use the config file even for DT based system and just allow specifying the UART settings via normal DT properties like we do for Broadcom and others.
> 
> so I googled for a few config files and this is what this turns into:
> 
> Analyzing rtl8723d_config_1000000_noflow.dms
> Signature:   0x8723ab55
> Data length: 41
> len=1   offset=f4,{ 01 }
> len=2   offset=f6,{ 81 00 }
> len=2   offset=fa,{ 12 80 }
> len=16  offset=0c,{ 04 50 00 00 50 c5 ea 19 e1 1b fd af 5b 01 a4 0b }
> len=1   offset=d9,{ 0f }
> len=1   offset=e4,{ 08 }
> Analyzing rtl8723d_config.dms
> Signature:   0x8723ab55
> Data length: 41
> len=1   offset=f4,{ 01 }
> len=2   offset=f6,{ 81 00 }
> len=2   offset=fa,{ 12 80 }
> len=16  offset=0c,{ 02 80 92 04 50 c5 ea 19 e1 1b fd af 5f 01 a4 0b }
> len=1   offset=d9,{ 0f }
> len=1   offset=e4,{ 08 }
> Analyzing rtl8822b_config.bin
> Signature:   0x8723ab55
> Data length: 8
> len=1   offset=d9,{ 0f }
> len=1   offset=e4,{ 08 }
> 
> The first two are some UART based ones and the last one is USB based.
> 
> So the 0x3c offset seems to be the BD_ADDR and 0x0c offset is the UART configuration. It would be good to know which settings the other ones control.
> 
> Also the 16 octet UART config blob seems to be decoded like this:
> 
> 	uart_config {
> 		le32 baudrate;
> 		u8[8] reserved1;
> 		u8 flowctl;
> 		u8[3] reserved2;
> 	}
> 
> Actually hciattach_rtk just takes the baud rate and and hardware flow control bit out of this file. That is clearly two things that are better written in plain text in the DT file.

so this is actually some funny stuff if you start to understand it.

Analyzing rtl8723b_config.dms
Signature: 0x8723ab55
Data len:  38
len=8   offset=00f4,{ 01 00 00 00 05 50 00 00 }
len=16  offset=000c,{ 02 80 92 04 50 c5 ea 19 e1 1b f1 af 5f 01 a4 0b },UART_CONFIG
len=1   offset=0027,{ 63 }
len=1   offset=00fe,{ 01 }
Analyzing rtl8723d_config_1000000_noflow.dms
Signature: 0x8723ab55
Data len:  41
len=1   offset=00f4,{ 01 }
len=2   offset=00f6,{ 81 00 }
len=2   offset=00fa,{ 12 80 }
len=16  offset=000c,{ 04 50 00 00 50 c5 ea 19 e1 1b fd af 5b 01 a4 0b },UART_CONFIG
len=1   offset=00d9,{ 0f }
len=1   offset=00e4,{ 08 }

Seems like Realtek really defines memory offsets in this file and they can be defined in various different ways.

So 00f4,{ 01 00 00 00 05 50 00 00 } defines the whole PCM settings for interface 1 and 2. And 00f4,{ 01 } + 00f6,{ 81 00 } + 00fa,{ 12 80 } is the same PCM settings, but with only pieces of it defined.

This also means a 000c,{ 04 50 00 00 50 } for just setting the baud rate is as valid if flow control defaults to off and all other values are actual defaults. So code inside hciattach_rtk.c is also kind faulty on how it handles the flow control bit. It works if the config files all have offset 000c in it, but if not, then they are going funky.

Since these are efuse settings, I really wonder if there is just a HCI vendor command to read out the defaults and we use that to compare. And what I would really like to know is what these settings are suppose to change. Since even for USB, we are actually not even applying them.

Anyway, I am certain that for Realtek UART devices, we just want to specify max-speed DT property like we do with the others. And then maybe a flow-control DT property to control that one (following what nfcmrvl.txt does). We can use the rtlfw tool that I wrote to extract the values from Realtek provided config files. Frankly the PCM settings we have to deal with as well at some point. But that is also missing for Broadcom and others.

Also if there is no config file, we should be able to just assume no flow control, 115200 baud rate and H:5 as protocol. That means that almost all chips will just work. They are just slow since we do not deal with the max-speed setting.

At the end of the day, this is the same as for Broadcom and ACPI vs DT. This should be no different. The only bit nasty part is that this is H:5 as protocol and we have not really abstracted that one nicely to just have a tiny hci_rtl.c for vendor specific pieces.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
