From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH 0/3] ACPI: parse the SPCR table
Date: Wed, 27 Jan 2016 15:17:52 +0300
Message-ID: <56A8B570.2060501@linaro.org>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56A6494E.3090303@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org



On 01/25/2016 07:11 PM, Peter Hurley wrote:
> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>> This patchset is based on the patchset by Leif Lindholm [1]
>>
>> 'ARM Server Base Boot Requirements' [2] mention SPCR=20
>> (Serial Port Console Redirection Table) [3] as a mandatory
>> ACPI table that specifies the configuration of serial console.
>>
>> Licensing concerns have prevented implementing it in the past, but a=
s of
>> 10 August 2015, these tables have both been released also under=20
>> OWF 1.0 [4].
>=20
> This license has a patent retaliation provision, which makes it
> incompatible with GPLv2.
>=20
> *If the license applies to this code*, then this patch set does not
> meet the criteria for submission.

The license applies not to this code but to the document describing the=
 tables.

Here is an excerpt from it:

  Patent Notice:
  Microsoft is making certain patent rights available for implementatio=
ns of this specification under two options:
  1)  Microsoft=E2=80=99s Community Promise, available at
  http://www.microsoft.com/openspecifications/en/us/programs/community-=
promise/default.aspx; or
  2)  The Open Web Foundation Final Specification Agreement Version 1.0=
 ("OWF 1.0")
  as of October 1, 2012, available at http://www.openwebfoundation.org/=
legal/the-owf-1-0-agreements/owfa-1-0.=20

I believe that it means that the patch set meets the criteria for submi=
ssion.  Am I right?

Thank you
Aleksey Makarov

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
