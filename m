From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] uartlite: Fix crash when using as console
Date: Thu, 28 Jan 2010 14:32:43 +0100
Message-ID: <87zl3ynymc.fsf@macbook.be.48ers.dk>
References: <4B619100.5080602@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38550 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab0A1Ncs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jan 2010 08:32:48 -0500
Received: by ewy19 with SMTP id 19so745596ewy.21
        for <linux-serial@vger.kernel.org>; Thu, 28 Jan 2010 05:32:47 -0800 (PST)
In-Reply-To: <4B619100.5080602@pelagicore.com> ("Richard =?utf-8?Q?R=C3=B6?=
 =?utf-8?Q?jfors=22's?= message of
	"Thu, 28 Jan 2010 14:28:32 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors@pelagicore.com>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

>>>>> "Richard" =3D=3D Richard R=C3=B6jfors <richard.rojfors@pelagicore=
=2Ecom> writes:

 Richard> This patch moves the ulite_console_setup to the .devinit
 Richard> section since it might be called on probe, which is in
 Richard> devinit. Fixes the crash below where the uartlite hw is probe=
d
 Richard> after the .init section is freed from the kernel.

Having the platform device for the console registerred so late doesn't
strike me as very useful, but ok ..

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

--=20
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
