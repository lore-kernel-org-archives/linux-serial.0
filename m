From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/3] ACPI: parse the SPCR table
Date: Thu, 3 Mar 2016 12:08:36 -0800
Message-ID: <56D899C4.5050802@hurleysoftware.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com> <56A8B570.2060501@linaro.org>
 <56BBCA2F.3020604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56BBCA2F.3020604@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi Al,

Somehow your email was filtered. Apologies for that.

On 02/10/2016 03:39 PM, Al Stone wrote:
> On 01/27/2016 05:17 AM, Aleksey Makarov wrote:
>>
>>
>> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>>
>>>> 'ARM Server Base Boot Requirements' [2] mention SPCR=20
>>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>>> ACPI table that specifies the configuration of serial console.
>>>>
>>>> Licensing concerns have prevented implementing it in the past, but=
 as of
>>>> 10 August 2015, these tables have both been released also under=20
>>>> OWF 1.0 [4].
>>>
>>> This license has a patent retaliation provision, which makes it
>>> incompatible with GPLv2.
>>>
>>> *If the license applies to this code*, then this patch set does not
>>> meet the criteria for submission.
>>
>> The license applies not to this code but to the document describing =
the tables.
>=20
> Just for the record, the SPCR table struct definition has been part
> of the Linux kernel since at least commit b24aad44 on 2009-07-24
> (line 1112 of include/acpi/actbl2.h) -- or so git blame tells me.

Just to be clear here:

The Microsoft specification, which defines the SPCR table struct and wh=
ich
this patch series relies on, notes that patents apply. Specifically, it
says:

Patent Notice:
Microsoft is making certain patent rights available for implementations=
 of this specification under two options:
1)  Microsoft=E2=80=99s Community Promise, available at http://www.micr=
osoft.com/openspecifications/en/us/programs/community-promise/default.a=
spx; or
2)  The Open Web Foundation Final Specification Agreement Version 1.0 (=
"OWF 1.0") as of October 1, 2012, available at http://www.openwebfounda=
tion.org/legal/the-owf-1-0-agreements/owfa-1-0.=20
Version 1.03 =E2=80=94 August 10, 2015

I don't believe either of those patent licenses are GPL compatible.

Unless you're saying Red Hat is signing off on this?

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
