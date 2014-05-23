From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
Date: Fri, 23 May 2014 10:09:01 -0300
Message-ID: <537F486D.9060900@elopez.com.ar>
References: <1400831485-28576-1-git-send-email-wens@csie.org> <1400831485-28576-8-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yotta.elopez.com.ar ([31.220.24.173]:33405 "EHLO
	yotta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaEWNJu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 May 2014 09:09:50 -0400
In-Reply-To: <1400831485-28576-8-git-send-email-wens@csie.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>

Hi,

El 23/05/14 04:51, Chen-Yu Tsai escribi=F3:
> The N factor for PLL6 counts from 1 to 32, as specified in the A23
> manual, and shown in Allwinner's original code.

Are you sure about this? The A23 manual I'm looking at has a 5-bit fiel=
d=20
(so 0-31) on 12:8, and the examples count from 0 (eg Factor=3D0 N=3D1 .=
=2E.=20
=46actor=3D31 N=3D32).

Cheers,

Emilio
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
