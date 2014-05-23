From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
Date: Fri, 23 May 2014 22:43:42 +0800
Message-ID: <CAGb2v64+UBUZeqsy02K2x+HCh=YAAVz_wLaPVRhdD=F5zT+Ccw@mail.gmail.com>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-8-git-send-email-wens@csie.org> <537F486D.9060900@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:62138 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbaEWOoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 May 2014 10:44:03 -0400
In-Reply-To: <537F486D.9060900@elopez.com.ar>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>

Hi,

On Fri, May 23, 2014 at 9:09 PM, Emilio L=C3=B3pez <emilio@elopez.com.a=
r> wrote:
> Hi,
>
> El 23/05/14 04:51, Chen-Yu Tsai escribi=C3=B3:
>
>> The N factor for PLL6 counts from 1 to 32, as specified in the A23
>> manual, and shown in Allwinner's original code.
>
>
> Are you sure about this? The A23 manual I'm looking at has a 5-bit fi=
eld (so
> 0-31) on 12:8, and the examples count from 0 (eg Factor=3D0 N=3D1 ...=
 Factor=3D31
> N=3D32).

=46rom the A23 manual:

=46actor =3D 0, N =3D 1
=46actor =3D 1, N =3D 2
=46actor =3D 2, N =3D 3
 and so on


=46rom the A20 manual:

=46actor =3D 0, N =3D 0
=46actor =3D 1, N =3D 1
=46actor =3D 2, N =3D 2

The "N factor" I referred to in my commit message is the N used in the
calculation,
not what is stored in the bit field.

Hope this makes it clear. :)

Cheers
ChenYu
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
