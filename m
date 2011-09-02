From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Hardware flowcontrol on XR17D154
Date: Fri, 2 Sep 2011 13:28:38 +0100
Message-ID: <20110902132838.5481f302@lxorguk.ukuu.org.uk>
References: <201108301217.07468.sgh@sgh.dk>
	<201108301327.04542.sgh@sgh.dk>
	<20110830133221.304b27f0@lxorguk.ukuu.org.uk>
	<201109021220.50339.sgh@sgh.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44459 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860Ab1IBM3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Sep 2011 08:29:35 -0400
In-Reply-To: <201109021220.50339.sgh@sgh.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?U8O4cmVu?= holm <sgh@sgh.dk>
Cc: linux-serial@vger.kernel.org

On Fri, 2 Sep 2011 12:20:50 +0200
S=C3=B8ren holm <sgh@sgh.dk> wrote:

> Hi
>=20
> Here is my patch to add EFR-support for XR17D15x
> Do you have any comments, since this is my first patch to the kernel =
?


Codewise it looks fine

Two things though - run changes through scripts/checkpatch.pl (and it'l=
l
tell you off for the // comment...) and actually inline the patch rathe=
r
than attach it so it is easy for people to comment on.

The important bits of it however  - the actual implementation looks rig=
ht
to me and sensibly implemented.

Possibly it should instead override serial_out/in to use the different =
EFR
that way but given this is one spot only I don't think its worth the ex=
tra
complexity - and if other changes later make it worth doing it's easy t=
o
change.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
