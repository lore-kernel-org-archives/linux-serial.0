From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC v1 5/8] Bluetooth: btrtl: add support for the RTL8723BS and
 RTL8723DS chips
Date: Sun, 26 Nov 2017 23:23:03 +0100
Message-ID: <CAFBinCD+P6kBOXjp9YZf8DbsetvF+q6yfp3X+OTRfN_Pv8R88w@mail.gmail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-6-martin.blumenstingl@googlemail.com>
 <109FA59C-9875-4EAA-9DA5-EC811BAA77AE@holtmann.org> <CAFBinCCtHUFMbbSOeKWYSJZKvFbNqhaMOrS-xgzr3E9hbkpnnw@mail.gmail.com>
 <4B23C5B4-DCB8-4B1C-B1BF-A99B1E5E10B0@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B23C5B4-DCB8-4B1C-B1BF-A99B1E5E10B0-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

On Sun, Nov 19, 2017 at 10:17 PM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wro=
te:
> Hi Martin,
>
>>>> The Realtek RTL8723BS and RTL8723DS chipsets are SDIO wifi chips. They
>>>> also contain a Bluetooth module which is connected via UART to the hos=
t.
>>>>
>>>> Realtek's userspace initialization tool (rtk_hciattach) differentiates
>>>> these two via the HCI version and revision returned by the
>>>> HCI_OP_READ_LOCAL_VERSION command.
>>>> Additionally we apply these checks only the for UART devices. Everythi=
ng
>>>> else is assumed to be a "RTL8723B" which was originally supported by t=
he
>>>> driver (communicating via USB).
>>>>
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org=
>
>>>> ---
>>>> drivers/bluetooth/btrtl.c | 32 ++++++++++++++++++++++++++++++--
>>>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>>>> index 45b872f5ad22..d896f9421250 100644
>>>> --- a/drivers/bluetooth/btrtl.c
>>>> +++ b/drivers/bluetooth/btrtl.c
>>>> @@ -418,9 +418,33 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev)
>>>>              has_rom_version =3D false;
>>>>              break;
>>>>      case RTL_ROM_LMP_8723B:
>>>> -             fw_name =3D "rtl_bt/rtl8723b_fw.bin";
>>>> -             cfg_name =3D "rtl_bt/rtl8723b_config.bin";
>>>> +             /* all variants support reading the ROM version */
>>>>              has_rom_version =3D true;
>>>> +
>>>> +             /*
>>>> +              * RTL8723 devices exist in different variants:
>>>> +              * - RTL8723BS (SDIO chip with UART Bluetooth)
>>>> +              * - RTL8723DS (SDIO chip with UART Bluetooth)
>>>> +              * - for backwards-compatibility everything else is assu=
med to
>>>> +              *   be an RTL8723B communicating over USB
>>>> +              *
>>>> +              * Only UART devices really need the config because that
>>>> +              * contains the UART speed / flow control settings.
>>>> +              */
>>>> +             if (hdev->bus =3D=3D HCI_UART && resp->hci_ver =3D=3D 6 =
&&
>>>> +                 le16_to_cpu(resp->hci_rev) =3D=3D 0xb) {
>>>> +                     fw_name =3D "rtl_bt/rtl8723bs_fw.bin";
>>>> +                     cfg_name =3D "rtl_bt/rtl8723bs_config.bin";
>>>> +                     cfg_needed =3D true;
>>>> +             } else if (hdev->bus =3D=3D HCI_UART && resp->hci_ver =
=3D=3D 8 &&
>>>> +                        le16_to_cpu(resp->hci_rev) =3D=3D 0xd) {
>>>> +                     fw_name =3D "rtl_bt/rtl8723ds_fw.bin";
>>>> +                     cfg_name =3D "rtl_bt/rtl872ds_config.bin";
>>>> +                     cfg_needed =3D true;
>>>> +             } else {
>>>> +                     fw_name =3D "rtl_bt/rtl8723b_fw.bin";
>>>> +                     cfg_name =3D "rtl_bt/rtl8723b_config.bin";
>>>> +             }
>>>
>>> so the main question is why is this a config file in the first place? S=
o far all other drivers have expressed UART settings via DT (or even via AC=
PI). If we are just getting the baudrates, then better have this in DT. Sin=
ce otherwise we end up with board specific filesystems again where differen=
t config files need to be installed. That is really not useful in the end.
>> this is an excellent question (and also the reason why it's an "RFC" pat=
ch)!
>> I'll try to figure out whether:
>> a) we can skip the config file completely
skipping the config blob causes it to time out at the end of the
firmware download (where the config seems to be applied internally)

>> b) we can generate the config file in-memory
I tried this as well with a very minimal version (where only the
"known" bits are used)
unfortunately this shows the same symptoms as skipping the config blob
I'll try experimenting with this to see if I can get it to work somehow

>> c) we have to stick with this config file
I'm afraid this would be our last option if I can't get b) working
a datasheet for these chips or some advice from someone who has access
to the datasheet/knowledge about the internals would be of great help

>>
>>> What is actually in these config files? Can we have some parsing and fr=
iendly display tool in bluez.git like we have for other manufactures.
>> to my knowledge this config file contains:
>> - the baudrate
>> - whether flow control is enabled or disabled
>
> these two are better done as part of the DT.
agreed, I'd also rather have this in DT than some blob

>> - (in some cases) the local-bd-address
>
> There is essentially DT support for that as well, but we also have Set Pu=
blic Address mgmt command to handle this. Then again, first of all the hdev=
->set_bdaddr callback needs to be supported for that.
>
>> do you mean a tool that is similar to bluez.git tools/nokfw.c?
>
> Yes.
>
>> [0] https://github.com/NextThingCo/rtl8723ds_bt/blob/f56ef37217665070e57=
4253d23a595ee1ca5ca23/rtk_hciattach/hciattach_rtk.c#L1781
>
> Please never ever make me look at code that defined struct sk_buff in use=
rspace ;)
sorry for not putting a huge warning/disclaimer in front of that link!
as bad as it sounds: this is all I have as reference :(


Regards
Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
