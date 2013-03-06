From: Vincent Deffontaines <vincent@gryzor.com>
Subject: Re: [PATCH] =?UTF-8?Q?tty/=38=32=35=30=5Fpnp=3A=20serial=20port?=
 =?UTF-8?Q?=20detection=20regression=20since=20v=33=2E=37?=
Date: Wed, 06 Mar 2013 15:42:29 +0100
Message-ID: <5f8a2a7219eccbf1a848a774635d9ec2@raceme.org>
References: <1361550439-23504-1-git-send-email-sean@mess.org>
 <20130304132839.GA6965@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ombos.raceme.org ([212.85.152.43]:41616 "EHLO idril.raceme.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758444Ab3CFOua (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Mar 2013 09:50:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by idril.raceme.org (Postfix) with ESMTP id 65B0122F36
	for <linux-serial@vger.kernel.org>; Wed,  6 Mar 2013 15:42:37 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by localhost (ombos.raceme.org [127.0.0.1]) (amavisd-new, port 1024)
	with SMTP id Mqt1TWQ6K7Si for <linux-serial@vger.kernel.org>;
	Wed,  6 Mar 2013 15:42:37 +0100 (CET)
In-Reply-To: <20130304132839.GA6965@pequod.mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, stable@vger.kernel.org

Le 2013-03-04 14:28, Sean Young a =C3=A9crit=C2=A0:
> Greg,
>
> On Fri, Feb 22, 2013 at 04:27:19PM +0000, Sean Young wrote:
>> The InsydeH2O BIOS (version dated 09/12/2011) has the following in
>> its pnp resouces for its serial ports:
>>
>> $ cat /sys/bus/pnp/devices/00:0b/resources
>> state =3D active
>> io disabled
>> irq disabled
>>
>> We do not check if the resources are disabled, and create a bogus
>> ttyS* device. Since commit 835d844d1a28e (8250_pnp: do pnp probe
>> before legacy probe) we get a bogus ttyS0, which prevents the legacy
>> probe from detecting it.
>
> Would you mind accepting this patch please -- it fixes a regression I
> introduced in 3.7.


Hi Sean,

Thanks for the patch, and thanks for re-pushing it :)
This is to inform you that the BIOS update referenced :
Version: SC24 BIOS V1.01
Release Date: 01/11/2013

Seems to fix "my" tty detection problem on 3.7 (tested on a 3.7.6=20
=46edora kernel, with success).
I don't think the patch will hurt anyway - I believe it still will=20
prevent other users from a regression.
I also confirm that the patched 3.8.0 detects its ttys fine on a=20
BIOS-updated system.

Regards,

Vincent


--
Stop chasing shadows, just enjoy the ride
Morcheeba

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
