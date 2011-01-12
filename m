From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH resend 2] Add sc16is7x2 driver
Date: Wed, 12 Jan 2011 13:01:56 +0100
Message-ID: <4D2D9834.5000309@iis.fraunhofer.de>
References: <4D272DDA.6010007@iis.fraunhofer.de> <4D2D8B12.2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090209060809090206090005"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay03-haj2.antispameurope.com ([83.246.65.53]:36091 "EHLO
	relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756014Ab1ALMC3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Jan 2011 07:02:29 -0500
In-Reply-To: <4D2D8B12.2@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Weber <weber@corscience.de>, Johannes Reif <reif@corscience.de>, changgx <changgx@163.com>, miguelangel@nbee.es

This is a multi-part message in MIME format.
--------------090209060809090206090005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.01.2011 12:05, Thomas Weber wrote:
> Am 07.01.2011 16:14, schrieb Manuel Stahl:
>> IRQ is now implemented with work queue (like max3100).
>> The problem is, that the sc16is7x2 has a low active irq. But with active
>> low threaded_irqs, shared irqs are not allowed.
>>
>> Please try this one and report errors.
>>
>> Regards,
>> Manuel Stahl
>>
>> PS: sorry that the patch is not inline, not sure how to configure
>> thunderbird correctly
>
> Hello Manuel,
>
> There is a re-definition of PORT_SC16IS7X2 in serial_core.h
> First time it is 20, second time it is 98.

A sorry, forgot to delete the line with 20.

Can someone already confirm that the this version works more reliably 
than the last one?

Regards,
Manuel Stahl

--------------090209060809090206090005
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

YmVnaW46dmNhcmQNCmZuOk1hbnVlbCBTdGFobA0KbjpTdGFobDtNYW51ZWwNCmVtYWlsO2lu
dGVybmV0Om1hbnVlbC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZQ0KdGVsO3dvcms6KzQ5IDkx
MSA1ODA2MS02NDE5DQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdmVyc2lvbjoyLjENCmVuZDp2
Y2FyZA0KDQo=
--------------090209060809090206090005--
