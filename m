From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Support the EFR-register of XR1715x uarts.
Date: Sat, 3 Sep 2011 11:47:35 +0100
Message-ID: <20110903114735.374db25f@lxorguk.ukuu.org.uk>
References: <20110902132838.5481f302@lxorguk.ukuu.org.uk>
	<1314996937-2994-1-git-send-email-sgh@sgh.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35384 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752988Ab1ICKsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 3 Sep 2011 06:48:33 -0400
In-Reply-To: <1314996937-2994-1-git-send-email-sgh@sgh.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?U8O4cmVu?= Holm <sgh@sgh.dk>
Cc: linux-serial@vger.kernel.org, greg@kroah.com

On Fri,  2 Sep 2011 22:55:37 +0200
S=C3=B8ren Holm <sgh@sgh.dk> wrote:

> The EFR (Enhenced-Features-Register) is located at a different offset
> than the other devices supporting UART_CAP_EFR. This change add a spe=
cial
> setup quick to set UPF_EXAR_EFR on the port. UPF_EXAR_EFR is then use=
d to
> the port type to PORT_XR17D15X since it is for sure a XR17D15X uart.
>=20
> Signed-off-by: S=C3=B8ren Holm <sgh@sgh.dk>

Acked-by: Alan Cox <alan@linux.intel.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
