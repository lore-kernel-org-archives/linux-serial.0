From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Hardware flowcontrol on XR17D154
Date: Tue, 30 Aug 2011 11:34:33 +0100
Message-ID: <20110830113433.618b2486@lxorguk.ukuu.org.uk>
References: <201108301217.07468.sgh@sgh.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44486 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752546Ab1H3Kfe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 06:35:34 -0400
In-Reply-To: <201108301217.07468.sgh@sgh.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?U8O4cmVu?= holm <sgh@sgh.dk>
Cc: linux-serial@vger.kernel.org

On Tue, 30 Aug 2011 12:17:07 +0200
S=C3=B8ren holm <sgh@sgh.dk> wrote:

> Hi
>=20
> I have hacked hardware flowcontrol into 8250.c for the XR17D154. I ha=
ve=20
> attached the patch. The fix just uses another address for the EFR-reg=
ister.
>=20
> I would like to have some adwise as to how to do this the right way.=20

Can you explain what the underlying differences are first of all ?

If you just need to adjust a register differently then override
serial_in/serial_out methods and figure out how to detect your device
against others (or a way to probe it somehow).

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
