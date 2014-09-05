From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] tty: xuartps: Fix tx_emtpy() callback
Date: Fri, 5 Sep 2014 08:52:03 -0700
Message-ID: <25273d4b-b1dd-4bff-af60-376c6019d308@BN1AFFO11FD023.protection.gbl>
References: <1409903117-22021-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:29704
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750772AbaIEPw1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Sep 2014 11:52:27 -0400
Content-Disposition: inline
In-Reply-To: <1409903117-22021-1-git-send-email-lars@metafoo.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org

On Fri, 2014-09-05 at 09:45AM +0200, Lars-Peter Clausen wrote:
> The tx_empty() callback currently checks the TXEMPTY bit in the inter=
rupt
> status register to decided whether the FIFO should be reported as emp=
ty or
> not. The bit in this register gets set when the FIFO state transition=
s from
> non-empty to empty but is cleared again in the interrupt handler. Thi=
s means
> it is not suitable to be used to decided whether the FIFO is currentl=
y empty
> or not. Instead use the TXEMPTY bit from the status register which wi=
ll be
> set as long as the FIFO is empty.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
