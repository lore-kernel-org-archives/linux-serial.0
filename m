From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 3/4] TTY: serial, fix build of some drivers
Date: Thu, 01 Sep 2011 10:29:12 +0200
Message-ID: <4E5F4258.8030008@suse.cz>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz> <1314818699-10873-3-git-send-email-jslaby@suse.cz> <20110831222850.494bf19d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab1IAI3R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Sep 2011 04:29:17 -0400
In-Reply-To: <20110831222850.494bf19d@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>

On 08/31/2011 11:28 PM, Alan Cox wrote:
> On Wed, 31 Aug 2011 21:24:58 +0200
> Jiri Slaby <jslaby@suse.cz> wrote:
>=20
>> I'm getting build errors such as:
>> .../tty/serial/max3107.c: In function =E2=80=98put_data_to_circ_buf=E2=
=80=99:
>> .../tty/serial/max3107.c:149:2: error: implicit declaration of funct=
ion =E2=80=98tty_insert_flip_string=E2=80=99
>>
>> Those drivers need to include linux/tty_flip.h. The question is
>> whether we want to fix them at all. As they are broken for some time
>> already and nobody noticed...
>=20
> Config options randomly including it ?

Ah, no, ignore that comment. I realized that I removed linux/tty_flip.h
inclusion from serial_core.h. I moved the big inlines out of the header
and the inclusion was no longer needed there.

Hence these failures. And I think there will be more. So please apply
the patch, it's correct, except the changelog.

thanks,
--=20
js
suse labs
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
