From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: SC16IS7x2 driver
Date: Wed, 12 Jan 2011 16:04:04 +0100
Message-ID: <4D2DC2E4.3050606@iis.fraunhofer.de>
References: <1294844012.29067.4.camel@quadra>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020708080203070105010502"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay01-haj2.antispameurope.com ([83.246.65.51]:41684 "EHLO
	relay01-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab1ALPEI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Jan 2011 10:04:08 -0500
In-Reply-To: <1294844012.29067.4.camel@quadra>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708080203070105010502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

sorry I don't have a public repo for it. The latest driver will always 
be posted as a patch to linux-serial@vger.kernel.org, so please also CC 
this list in all your mails.

I'm keen to see your approach soon!
Manuel

On 12.01.2011 15:53, Steve Sakoman wrote:
> Hi Manuel!
>
> I will soon be working with some hardware that has the SC16IS7x2, but on
> i2c bus.
>
> I see that you have submitted an spi version of this driver.
>
> I would like to try modifying your work so that the driver could support
> both spi and i2c busses.
>
> Do you have a git repository available so that I can pull the most
> recent version of your patch?
>
> I will coordinated with you after I verify the feasibility of this dual
> interface support approach.  We can then decide how/if to get it
> upstream.
>
> Thanks!
>
> Best regards,
>
> Steve Sakoman

--------------020708080203070105010502
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

YmVnaW46dmNhcmQNCmZuOk1hbnVlbCBTdGFobA0KbjpTdGFobDtNYW51ZWwNCmVtYWlsO2lu
dGVybmV0Om1hbnVlbC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZQ0KdGVsO3dvcms6KzQ5IDkx
MSA1ODA2MS02NDE5DQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdmVyc2lvbjoyLjENCmVuZDp2
Y2FyZA0KDQo=
--------------020708080203070105010502--
