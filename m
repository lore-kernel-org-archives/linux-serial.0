From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] serial/mxs-auart: only wake up tty layer once
Date: Wed, 23 Nov 2011 11:40:33 +0000
Message-ID: <20111123114033.62639253@bob.linux.org.uk>
References: <1321968177-16039-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1321968177-16039-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8613 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab1KWL27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Nov 2011 06:28:59 -0500
In-Reply-To: <1321968177-16039-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Tue, 22 Nov 2011 14:22:56 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> There is no need to call uart_write_wakeup after each character send.
> Once at the end of the write sequence is enough.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Both parts

Acked-by: Alan Cox <alan@linux.intel.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
