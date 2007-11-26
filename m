From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: questions regarding function autoconfig(); drivers/serial/8250.c
Date: Mon, 26 Nov 2007 18:40:38 +0100
Message-ID: <474B0516.9020103@tiscali.nl>
References: <4747575E.80501@tiscali.nl> <20071126124646.GA11351@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:34010 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXKZRko (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Nov 2007 12:40:44 -0500
In-Reply-To: <20071126124646.GA11351@informatik.uni-freiburg.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>, Roel Kluin <12o3l@tiscali.nl>, linux-serial@vger.kernel.org

Uwe Kleine-K=F6nig wrote:
> Roel Kluin wrote:
>> In drivers/serial/8250.c:995 it reads:
>>
>> if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
>> 	return;
>>
>> As you can see the test !up->port.mapbase is duplicated, which makes=
 no sense.
>> maybe a different test was intended here?
> Looking twice exposes that the second mapbase is actually a membase. =
 So
> it looks right to me.
>=20
> Best regards
> Uwe

Thanks for the regards, clearly I need some glasses to improve mine.

Roel
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
