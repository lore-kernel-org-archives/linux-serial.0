From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: parse the SPCR table
Date: Mon, 01 Feb 2016 00:46:20 -0500
Message-ID: <56AEF12C.7060801@redhat.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>	<56A6494E.3090303@hurleysoftware.com>	<56A8B570.2060501@linaro.org> <20160127134559.1065a45f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160127134559.1065a45f@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 01/27/2016 08:45 AM, One Thousand Gnomes wrote:
> On Wed, 27 Jan 2016 15:17:52 +0300
> Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
>=20
>> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote: =20
>>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>>
>>>> 'ARM Server Base Boot Requirements' [2] mention SPCR=20
>>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>>> ACPI table that specifies the configuration of serial console.
>>>>
>>>> Licensing concerns have prevented implementing it in the past, but=
 as of
>>>> 10 August 2015, these tables have both been released also under=20
>>>> OWF 1.0 [4]. =20
>>>
>>> This license has a patent retaliation provision, which makes it
>>> incompatible with GPLv2.
>>>
>>> *If the license applies to this code*, then this patch set does not
>>> meet the criteria for submission. =20
>>
>> The license applies not to this code but to the document describing =
the tables.
>>
>> Here is an excerpt from it:
>>
>>   Patent Notice:
>>   Microsoft is making certain patent rights available for implementa=
tions of this specification under two options:
>>   1)  Microsoft=E2=80=99s Community Promise, available at
>>   http://www.microsoft.com/openspecifications/en/us/programs/communi=
ty-promise/default.aspx; or
>>   2)  The Open Web Foundation Final Specification Agreement Version =
1.0 ("OWF 1.0")
>>   as of October 1, 2012, available at http://www.openwebfoundation.o=
rg/legal/the-owf-1-0-agreements/owfa-1-0.=20
>>
>> I believe that it means that the patch set meets the criteria for su=
bmission.  Am I right?
>=20
> This is not a forum for legal advice. I would suggest that Linaro
> discusses it privately with the Linux Foundation and Linus and does s=
o
> under attorney-client privilege. The Linux Foundation does have some
> reasons to exist.

Thanks for the reply, Alan. Can folks discuss and let me know off list
if another license change is subsequently requested for this table? I
spoke with Microsoft about this and they graciously made the previous
license change. I am willing to connect additional dots off-list.

Jon.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
