From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: parse the SPCR table
Date: Wed, 10 Feb 2016 16:39:27 -0700
Message-ID: <56BBCA2F.3020604@redhat.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com> <56A8B570.2060501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56A8B570.2060501@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 01/27/2016 05:17 AM, Aleksey Makarov wrote:
> 
> 
> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>
>>> 'ARM Server Base Boot Requirements' [2] mention SPCR 
>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>> ACPI table that specifies the configuration of serial console.
>>>
>>> Licensing concerns have prevented implementing it in the past, but as of
>>> 10 August 2015, these tables have both been released also under 
>>> OWF 1.0 [4].
>>
>> This license has a patent retaliation provision, which makes it
>> incompatible with GPLv2.
>>
>> *If the license applies to this code*, then this patch set does not
>> meet the criteria for submission.
> 
> The license applies not to this code but to the document describing the tables.

Just for the record, the SPCR table struct definition has been part
of the Linux kernel since at least commit b24aad44 on 2009-07-24
(line 1112 of include/acpi/actbl2.h) -- or so git blame tells me.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
