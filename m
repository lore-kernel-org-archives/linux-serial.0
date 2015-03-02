From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date: Mon, 2 Mar 2015 08:28:53 -0800
Message-ID: <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com>
 <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com> <54F48B03.5040205@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F48B03.5040205-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 2, 2015 at 8:08 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
> On 03/02/2015 09:56 AM, Kevin Cernekee wrote:
>> On Mon, Mar 2, 2015 at 5:14 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>>> These apply to newly converted drivers, like serial8250/libahci/...
>>>> The examples were adapted from the regmap bindings document.
>>>>
>>>> Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
>>>> new file mode 100644
>>>> index 0000000..21044a4
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/common-properties.txt
>>>> @@ -0,0 +1,60 @@
>>>> +Common properties
>>>> +
>>>> +The ePAPR specification does not define any properties related to hardware
>>>> +byteswapping, but endianness issues show up frequently in porting Linux to
>>>> +different machine types.  This document attempts to provide a consistent
>>>> +way of handling byteswapping across drivers.
>>>> +
>>>> +Optional properties:
>>>> + - big-endian: Boolean; force big endian register accesses
>>>> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
>>>> +   know the peripheral always needs to be accessed in BE mode.
>>>> + - little-endian: Boolean; force little endian register accesses
>>>> +   unconditionally (e.g. readl/writel).  Use this if you know the
>>>> +   peripheral always needs to be accessed in LE mode.  This is the
>>>> +   default.
>>>
>>> There is a fundamental problem with specifying the default in DT bindings.
>>> How can drivers which are currently native-endian support big-endian?
>>>
>>> If the driver is converted to support big-endian, every previous
>>> devicetree will be invalid with the new kernel (because those devicetrees
>>> don't specify 'native-endian').
>>>
>>> IOW, consider if the default were 'native-endian'. How would the 8250
>>> driver support existing devicetrees?
>>
>> Correct.  This scheme is intended for drivers like 8250 and libahci
>> which currently default to little-endian by virtue of using
>> readl/writel for MMIO accesses.  Drivers that default to native-endian
>> should specify that in their bindings documents, similar to
>> Documentation/devicetree/bindings/regmap/regmap.txt.
>
> Which effectively means if a user can't upgrade their devicetree, they
> can't upgrade their kernel. I don't think that flies.

This doesn't change the behavior of pre-existing drivers that
implement the *-endian properties in a different way.  There are not
many of these drivers and they can be documented as special cases.

> It's exactly this kind of stuff that prompted Jonathan Corbet's article,
> "Device trees as ABI"  http://lwn.net/Articles/561462
>
> Why not leave the default unspecified?

The document aims to provide a consistent way of handling DT
endianness properties across (compliant) drivers.  It is confusing if
one new driver defaults to little-endian, and another new driver
defaults to native-endian.

And since most of the commonly used drivers already implement
little-endian MMIO accesses, that is the default.  My personal
preference would have been native-endian since that seems more common
on the hardware side, but defaulting to little-endian prevents
breaking the device tree "ABI" on existing systems.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
