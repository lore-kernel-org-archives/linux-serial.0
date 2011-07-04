From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: USB console broken in -next ?
Date: Mon, 4 Jul 2011 17:19:59 +0100
Message-ID: <20110704171959.0aa2cafa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42274 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755695Ab1GDQRZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 12:17:25 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

I'm seeing the USB console hang part way through the boot up. It looks as
if it hangs the box solid about the point the standard USB setup/binding
would occur for the serial driver it is using in console mode

Any ideas - not sure how old the problem is as I've not needed USB
console for a long time.

Alan
